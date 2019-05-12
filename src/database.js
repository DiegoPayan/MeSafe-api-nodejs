const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host: 'bwqgrd22mrhfeiengjkd-mysql.services.clever-cloud.com',
    user: 'uzz8vvgrlmzbqnzh',
    password: 'MekUwPaZcsyEhW9nm3vP',
    database: 'bwqgrd22mrhfeiengjkd',
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