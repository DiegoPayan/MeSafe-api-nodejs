const express = require('express');
const router = express.Router();

const middleware = require('../api/middleware');

const mysqlConnection = require('../database');

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
            res.json({success: true, data: result});
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
            res.json({success: true, data: result});
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
    mysqlConnection.query(query, [busqueda, busqueda], (error,result,fields) => {
        if(!error) {
            res.json({success: true, data: result});
        } else {
            res.json({ success: false, data: [] });
        }
    });
});

module.exports = router;