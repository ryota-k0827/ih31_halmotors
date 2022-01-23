const router = require("express").Router();
// const { MySQLClient, sql } = require("../../lib/database/client.js");
const { authenticate, adminAuthMiddleware } = require("../../lib/security/accesscontrol.js");

// ログインページ
router.get("/login", (req, res) => {
  // accessPage("manager");
  res.render("./manager/account/login.ejs", { message: req.flash("message") });
});

// ログイン処理
router.post("/login", authenticate("manager"));

// マイページ表示
router.get("/mypage", adminAuthMiddleware, (req, res) => {
  res.render("./manager/account/mypage.ejs");
});

// ログアウト処理
router.get("/logout", (req, res, next) => {
  req.logout();
  res.redirect("/manager/account/login");
});

// 退会ページ
router.get("/unsubscribe", adminAuthMiddleware, (req, res) => {
  res.render("./manager/account/unsubscribe.ejs");
});

module.exports = router;
