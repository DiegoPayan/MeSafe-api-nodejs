const express = require('express');
const router = express.Router();
const multer = require('multer');
const middleware = require('../api/middleware');
const path = require('path');
const mysqlConnection = require('../database');

const Storage = multer.diskStorage({
    destination(req, file, callback) {
        console.log("Www")
        callback(null, path.join(__dirname, '../public/uploads'))
    },

    filename: (req, file, cb) => {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
})
const uploadImage = multer({
    storage: Storage,
    limits: { fieldSize: 25 * 1024 * 1024 }
});


router.get('/', middleware, (req, res) => {
    const query = `SELECT r.id, r.descripcion, r.latitud, r.longitud, r.positivos, r.negativos, r.fecha, r.emergencia, u.id as idUsuario, concat_ws(' ', nombre, apellidoPaterno, apellidoMaterno) as nombreUsuario, 
        u.imagenPerfil, ir.src, tr.tipoReporte FROM reportes r JOIN usuarios u ON r.idUsuario = u.id JOIN imagenesReportes ir ON ir.idReporte = r.id 
        JOIN tipoReportes tr ON r.tipoReporte = tr.id ORDER BY r.id;`
    mysqlConnection.query(query, [], (error, result, fields) => {
        if (!error) {
            res.json({ success: true, data: result });
        } else {
            res.json({ success: false, data: [] });
        }
    });
});

router.get('/usuario', middleware, (req, res) => {
    const idUsuario = req.decoded['idUsuario'];
    const query = `SELECT r.id, r.descripcion, r.latitud, r.longitud, r.positivos, r.negativos, r.fecha, r.emergencia, u.id as idUsuario, concat_ws(' ', nombre, apellidoPaterno, apellidoMaterno) as nombreUsuario, 
        u.imagenPerfil, ir.src, tr.tipoReporte FROM reportes r JOIN usuarios u ON r.idUsuario = u.id JOIN imagenesReportes ir ON ir.idReporte = r.id 
        JOIN tipoReportes tr ON r.tipoReporte = tr.id WHERE r.idUsuario = ? ORDER BY r.id`;
    mysqlConnection.query(query, [idUsuario], (error, result, fields) => {
        if (!error) {
            res.json({ success: true, data: result });
        } else {
            res.json({ success: false, data: [] });
        }
    });
})

router.get('/:id', middleware, (req, res) => {
    const { id } = req.params;
    const query = `SELECT r.id, r.descripcion, r.latitud, r.longitud, r.positivos, r.negativos, r.fecha, r.emergencia, u.id as idUsuario, concat_ws(' ', nombre, apellidoPaterno, apellidoMaterno) as nombreUsuario, 
        u.imagenPerfil, ir.src, tr.tipoReporte  FROM reportes r JOIN usuarios u ON r.idUsuario = u.id JOIN imagenesReportes ir ON ir.idReporte = r.id 
        JOIN tipoReportes tr ON r.tipoReporte = tr.id WHERE r.id = ? ORDER BY r.id`;
    mysqlConnection.query(query, [id], (error, result, field) => {
        if (!error) {
            res.json({ success: true, data: result });
        } else {
            res.json({ success: false, data: [] });
        }
    })
});

router.get('/tipo/:tipo', middleware, (req, res) => {
    const { tipo } = req.params;
    const query = `SELECT r.id, r.descripcion, r.latitud, r.longitud, r.positivos, r.negativos, r.fecha, r.emergencia, u.id as idUsuario, concat_ws(' ', nombre, apellidoPaterno, apellidoMaterno) as nombreUsuario, 
        u.imagenPerfil, ir.src, tr.tipoReporte FROM reportes r JOIN usuarios u ON r.idUsuario = u.id JOIN imagenesReportes ir ON ir.idReporte = r.id 
        JOIN tipoReportes tr ON r.tipoReporte = tr.id WHERE r.tipoReporte = ? ORDER BY r.id`;
    mysqlConnection.query(query, [tipo], (error, result, fields) => {
        if (!error) {
            res.json({ success: true, data: result });
        } else {
            res.json({ success: false, data: [] });
        }
    });
});

router.get('/busqueda/:busqueda', middleware, (req, res) => {
    const { busqueda } = req.params;
    const query = `SELECT r.id, r.descripcion, r.latitud, r.longitud, r.positivos, r.negativos, r.fecha, r.emergencia, u.id as idUsuario, concat_ws(' ', nombre, apellidoPaterno, apellidoMaterno) as nombreUsuario, 
                    u.imagenPerfil, ir.src, tr.tipoReporte FROM reportes r JOIN usuarios u ON r.idUsuario = u.id JOIN imagenesReportes ir ON ir.idReporte = r.id 
                    JOIN tipoReportes tr ON r.tipoReporte = tr.id WHERE (r.descripcion LIKE '%${busqueda}%' OR concat_ws(" ",u.nombre, u.apellidoPaterno, u.apellidoMaterno) LIKE '%${busqueda}%') ORDER BY r.id`;
    mysqlConnection.query(query, [busqueda, busqueda], (error, result, fields) => {
        if (!error) {
            res.json({ success: true, data: result });
        } else {
            res.json({ success: false, data: [] });
        }
    });
});

router.post('/reporte', uploadImage.array('productImage', 10), middleware, (req, res) => {

    const { fecha, descripcion, latitud, longitud, positivos, negativos, tipoReporte, idUsuario, emergencia } = req.query;

    const query = `INSERT INTO reportes (fecha, descripcion, latitud, longitud, positivos, negativos, tipoReporte, idUsuario, emergencia) VALUES (?,?,?,?,?,?,?,?,?)`;
    mysqlConnection.query(query, [fecha, descripcion, latitud, longitud, positivos, negativos, tipoReporte, idUsuario, emergencia], (error, result, fields) => {
        if (!error) {
            console.log(result.insertId);
            insertImages(result.insertId, req.body.photos);
            res.json({ success: true, data: result });


        } else {
            console.log(error);
            res.json({ success: false, data: [] });
        }

    });



});

const insertImages = (id, files) => {
    const query = `INSERT INTO imagenesReportes (idReporte,src) VALUES (?,?)`;
    files.map((item) => {
        mysqlConnection.query(query, [id, item.filename], (error, result, fields) => {
            if (!error) {
                console.log(result);
            } else {
                console.log(error);
            }
        });
    })


}
module.exports = router;