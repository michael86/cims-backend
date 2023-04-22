const mysql = require("mysql");

const connection = mysql.createConnection({
  port: 3306,
  database: "cims",
  user: "root",
  password: "",
  host: "localhost",
  multipleStatements: true,
});

connection.connect();

function asyncMySQL(query, vars) {
  return new Promise((resolve, reject) => {
    connection.query(query, vars, (error, results) => {
      if (error) {
        reject(error);
      }

      resolve(results);
    });
  });
}

module.exports = asyncMySQL;
