const router = require("express").Router();
const { authenticate, authorize, PRIVILEGE } = require("../lib/security/accesscontrol.js");

// マイページ表示
router.get("/", authorize(PRIVILEGE.NORMAL), (req, res) => {
  res.render("./mypage/mypage.ejs");
});

module.exports = router;
