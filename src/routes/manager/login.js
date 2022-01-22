const router = require("express").Router();
// const { MySQLClient, sql } = require("../../lib/database/client.js");

// ログインページ
router.get("/", (req, res) => {
  res.render("./manager/login/login.ejs");
});

module.exports = router;
