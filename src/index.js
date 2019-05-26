const express = require('express');
const bodyParser = require('body-parser');
const appUpload = require('express-fileupload');
const app = express();

//Settings
app.set('port', process.env.PORT || 3001);

//Middleware
app.use(bodyParser.urlencoded({ extended: true}));
app.use(express.json());
app.use(appUpload());

//Routes
app.get('/', (req,res) => { res.json("Hola mundo") });
app.use('/login', require('./routes/usuarios'));
app.use('/reportes', require('./routes/reportes'));
app.use('/centro-ayuda', require('./routes/centroAyuda'));
app.use('/amigos', require('./routes/amigos'));

//Starting the server
app.listen(app.get('port'), () => {
    console.log(`Servidor iniciado en puerto ${app.get('port')}`);
});