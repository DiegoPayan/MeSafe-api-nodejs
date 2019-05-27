const express = require('express');
const bodyParser = require('body-parser');
const appUpload = require('express-fileupload');
const app = express();
const path = require('path');
//Settings
app.set('port', process.env.PORT || 3001);
// const storage = multer.diskStorage({
//     destination: path.join(__dirname, 'public/uploads'),
//     filename: (req, file, cb) => {
//         console.log(file, req);
//         cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
//     }
// });
// app.use(multer({ storage }).array('productImage', 10));
//Middleware
app.use(express.static(path.join(__dirname, 'public/uploads')));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json());


//Routes
app.get('/', (req, res) => { res.json("Hola mundo") });
app.use('/login', require('./routes/usuarios'));
app.use('/reportes', require('./routes/reportes'));
app.use('/centro-ayuda', require('./routes/centroAyuda'));
app.use('/amigos', require('./routes/amigos'));

//Starting the server
app.listen(app.get('port'), () => {
    console.log(`Servidor iniciado en puerto ${app.get('port')}`);
});