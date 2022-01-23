// 未使用モジュール
const { MySQLClient, sql } = require("../lib/database/client.js");
let userArray;

let userList = () => {
  Promise.all([
    MySQLClient.executeQuery(sql("SELECT_CUSTOMER_LIST")),
    MySQLClient.executeQuery(sql("SELECT_EMPLOYEES_LIST")),
  ])
    .then((results) => {
      userArray = results;
      console.log(userArray);
    })
    .catch((err) => {
      console.log(err);
    });
};

module.exports.userArray = userArray;
module.exports.userList = userList;
