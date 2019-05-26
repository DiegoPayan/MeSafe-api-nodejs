const express = require('express');
const router = express.Router();

const middleware = require('../api/middleware');

const mysqlConnection = require('../database');

router.get('/', middleware, (req, res) => {
    const query = `SELECT ca.nombre, ca.telefono, ca.direccion, tca.nombre as tipo FROM centroAyuda ca 
                    JOIN tipoCentroAyuda tca ON ca.idTipoCentroAyuda = tca.id`;
    mysqlConnection.query(query, [], (error, result, fields) => {
        if (!error) {
            res.json(result);
        } else {
            console.log(error);
        }
    });
});

router.get('/tipo/:tipo', middleware, (req, res) => {
    const { tipo } = req.params;
    const query = `SELECT ca.nombre, ca.telefono, ca.direccion, tca.nombre as tipo FROM centroAyuda ca 
                    JOIN tipoCentroAyuda tca ON ca.idTipoCentroAyuda = tca.id WHERE ca.idTipoCentroAyuda = ?`;
    mysqlConnection.query(query, [tipo], (error, result, fields) => {
        if (!error) {
            res.json(result);
        } else {
            console.log(error);
        }
    });
});

module.exports = router;