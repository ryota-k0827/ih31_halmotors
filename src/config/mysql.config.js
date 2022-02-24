// 自分の環境に合わせてください。
module.exports = {
  HOST: process.env.MYSQL_HOST || "localhost",
  PORT: process.env.MYSQL_PORT || "3306",
  USERNAME: process.env.MYSQL_USERNAME || "root",
  PASSWORD: process.env.MYSQL_PASSWORD || "password",
  DATABASE: process.env.MYSQL_DATABASE || "ih31_halmotors",
};
