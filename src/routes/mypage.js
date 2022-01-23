const router = require("express").Router();

router.get("/", (req, res) => {
  res.render("./client/mypage.ejs");
});

module.exports = router;