const jwt = require('jsonwebtoken');

const mysqlConnection = require('../database');
const config = require('../api/config');

let errorMessage;

async const login = (req, res) => {
    const { username, pass } = req.body;
    if (username, pass) {
        const estatus = 1;
        const query = `SELECT id FROM usuarios WHERE username = ? AND password = ? AND estatus = ?`;
        mysqlConnection.query(query, [username, pass, estatus], (error, result, fields) => {
            if (!error) {
                let idUsuario;
                typeof result[0] !== 'undefined' ? idUsuario = result[0]['id'] : idUsuario = 0;
                if (idUsuario !== 0) {
                    const token = jwt.sign({ idUsuario, username }, config.secret, { expiresIn: '1h' });
                    res.json({
                        success: true,
                        token: token
                    });
                } else {
                    errorMessage = 'Credenciales incorrectas!';
                }
            } else {
                errorMessage = 'Error en BD!';
            }
        });
    } else {
        errorMessage = "Error en la peticion!";
    }
    res.json({
        success: false,
        message: errorMessage
    });
}

module.exports = {login};