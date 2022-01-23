const router = require("express").Router();
const { authenticate, authorize, PRIVILEGE } = require("../lib/security/accesscontrol.js");

// 新規登録画面
router.get("/signup", (req, res) => {
  res.render("./account/signup.ejs");
});

// ログインページ
router.get("/login", (req, res, next) => {
  res.render("./account/login.ejs", { message: req.flash("message") });
});

// ログイン処理
router.post("/login", authenticate());

// マイページ表示
router.get("/mypage", authorize(PRIVILEGE.NORMAL), (req, res) => {
  res.render("./account/mypage.ejs");
});

// ログアウト処理
router.get("/logout", (req, res, next) => {
  req.logout();
  res.redirect("/account/login");
});

// 退会ページ
router.get("/", (req, res) => {
  res.render("./account/unsubscribe.ejs");
});

module.exports = router;
