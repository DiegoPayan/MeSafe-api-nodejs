const express = require('express');
const router = express.Router();

const middleware = require('../api/middleware');

const mysqlConnection = require('../database');

router.get('/', middleware, (req, res) => {
    const idUsuario = req.decoded['idUsuario'];
    const query = `SELECT u.id, concat_ws(" ",nombre,apellidoPaterno,apellidoMaterno) as nombreUsuario, 
                    u.codigoPostal,u.imagenPerfil, SUM(r.positivos) as positivos, SUM(r.negativos) as negativos FROM amigos a JOIN usuarios u ON a.idAmigo = u.id 
                    LEFT JOIN reportes r ON u.id = r.idUsuario
                    WHERE a.idUsuario = ? group by u.id`;
    mysqlConnection.query(query, [idUsuario], (error, result, field) => {
        if (!error) {
            res.json(result);
        } else {
            console.log(error);
        }
    });
});

router.post('/:id', middleware, (req, res) => {
    const idUsuario = req.decoded['idUsuario'];
    const {id} = req.params;
    const query = `INSERT INTO amigos(idUsuario, idAmigo) VALUES (?,?)`;
    mysqlConnection.query(query, [idUsuario, id], (error, result, fields) => {
        if(!error) {
            res.json({ message: "Amigo almacenado con exito" });
        } else {
            console.log(error);
        }
    });
});

module.exports = router;