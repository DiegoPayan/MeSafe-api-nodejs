const express = require('express');
const router = express.Router();

const middleware = require('../api/middleware');

const mysqlConnection = require('../database');

router.get('/:tipo', middleware, (req, res) => {
    const { tipo } = req.params;
    let query;
    if (tipo == 0) {
        query = "SELECT r.id, r.descripcion, r.latitud, r.longitud, r.positivos, r.negativos, u.id as idUsuario, concat_ws(' ', nombre, apellidoPaterno, apellidoMaterno) as nombreUsuario," +
            "u.imagenPerfil, ir.src FROM reportes r JOIN usuarios u ON r.idUsuario = u.id JOIN imagenesReportes ir ON ir.idReporte = r.id " +
            "ORDER BY r.id;"
        mysqlConnection.query(query, [], (error, result, fields) => {
            if (!error) {
                res.json(result);
            } else {
                console.log(error);
            }
        });
    } else {
        query = "SELECT r.id, r.descripcion, r.latitud, r.longitud, r.positivos, r.negativos, u.id as idUsuario, concat_ws(' ', nombre, apellidoPaterno, apellidoMaterno) as nombreUsuario," +
            "u.imagenPerfil, ir.src FROM reportes r JOIN usuarios u ON r.idUsuario = u.id JOIN imagenesReportes ir ON ir.idReporte = r.id " +
            "WHERE r.tipoReporte = ? ORDER BY r.id;"
        mysqlConnection.query(query, [tipo], (error, result, fields) => {
            if (!error) {
                res.json(result);
            } else {
                console.log(error);
            }
        });
    }
})

module.exports = router;