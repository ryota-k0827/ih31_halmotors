const router = require("express").Router();
const {
  authenticate,
  authorize,
  PRIVILEGE,
  // accessPage,
} = require("../lib/security/accesscontrol.js");

// 新規登録ページ
router.get("/signup", (req, res) => {
  res.render("./account/signup.ejs");
});

// 新規登録処理
router.post("/signup", (req, res) => {
  res.render("./account/signup-complete.ejs");
});

// ログインページ
router.get("/login", (req, res, next) => {
  // accessPage("general");
  res.render("./account/login.ejs", { message: req.flash("message") });
});

// ログイン処理
router.post("/login", authenticate("hogehoge"));

// マイページ表示
router.get("/mypage", authorize(PRIVILEGE.NORMAL), (req, res) => {
  res.render("./account/mypage.ejs");
});

// 入札リスト表示
router.get("/bid", authorize(PRIVILEGE.NORMAL), (req, res) => {
  res.render("./account/bidlist.ejs");
});

// 落札リスト表示
router.get("/buy", authorize(PRIVILEGE.NORMAL), (req, res) => {
  res.render("./account/buylist.ejs");
});

// カード登録ページ
router.get("/card/regist", authorize(PRIVILEGE.NORMAL), (req, res) => {
  res.render("./account/credit.ejs");
});

// 口座登録ページ
router.get("/payment/regist", authorize(PRIVILEGE.NORMAL), (req, res) => {
  res.render("./account/payment.ejs");
});

// ログアウト処理
router.get("/logout", (req, res, next) => {
  req.logout();
  res.redirect("/account/login");
});

// 退会ページ
router.get("/unsubscribe", (req, res) => {
  res.render("./account/unsubscribe.ejs");
});

module.exports = router;
