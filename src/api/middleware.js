const jwt = require('jsonwebtoken');
const config = require('./config');

const verifyToken = (req, res, next) => {

    const token = req.headers['x-access-token'] || req.headers['authorization'];
    if (token) {
        if (token.startsWith('Bearer')) {
            token = token.slice(7, token.length);
        }
        jwt.verify(token, config.secret, (err, decoded) => {
            if (err) {
                return res.json({
                    success: false,
                    message: 'Token Invalido'
                });
            } else {
                req.decoded = decoded;
                next();
            }
        });
    } else {
        return res.json({
            success: false,
            message: 'Requiere un token de autorizacion!'
        });
    }
}

module.exports = verifyToken;