const router = require("express").Router();

// マイページ表示
router.get("/", (req, res) => {
  res.render("./mypage/mypage.ejs");
});

module.exports = router;
