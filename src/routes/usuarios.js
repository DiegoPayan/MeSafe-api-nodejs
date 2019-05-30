const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');

const mysqlConnection = require('../database');
const config = require('../api/config');

let errorMessage;

router.post('/', (req, res) => {
  const { username, pass } = req.body;
  console.log(username, pass);
  if (username, pass) {
    const estatus = 1;
    const query = `SELECT id FROM usuarios WHERE username = ? AND password = ? AND estatus = ?`;
    mysqlConnection.query(query, [username, pass, estatus], (error, result, fields) => {
      if (!error) {
        console.log("dd")
        let idUsuario;
        typeof result[0] !== 'undefined' ? idUsuario = result[0]['id'] : idUsuario = 0;
        if (idUsuario !== 0) {
          const token = jwt.sign({ idUsuario, username }, config.secret, { expiresIn: '1h' });
          return res.json({
            success: true,
            token: token
          });

        } else {
          errorMessage = 'Credenciales incorrectas!';

          return res.json({
            success: false,
            token: errorMessage

          });
        }
      } else {
        errorMessage = 'Error en BD!';

        return res.json({
          success: false,
          token: errorMessage

        });
      }
    });
  } else {
    errorMessage = "Error en la peticion!";

    return res.json({
      success: false,
      token: errorMessage

    });
  }

});

module.exports = router;