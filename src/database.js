const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'diego1234',
    database: 'meSafe',
    multipleStatements: true
});

mysqlConnection.connect((err) => {
    if (err) {
        console.log(err);
        return;
    } else {
        console.log("Conexion BD exitosa");
    }
});

module.exports = mysqlConnection;