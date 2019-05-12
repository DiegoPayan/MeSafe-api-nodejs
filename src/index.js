const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const app = express();

//Settings
app.set('port', process.env.PORT || 3001);

//Middleware
app.use(bodyParser.urlencoded({ extended: true}));
app.use(express.json());

//Routes
app.get('/', (req,res) => { res.json("Hola Mundo") });

app.use('/login', require('./routes/usuarios'));

//Starting the server
app.listen(app.get('port'), () => {
    console.log(`Servidor iniciado en puerto ${app.get('port')}`);
});