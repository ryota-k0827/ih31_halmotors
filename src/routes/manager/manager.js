const router = require("express").Router();

// 管理者ページ表示
router.get("/", (req, res) => {
  res.render("./manager/index.ejs");
});

// Dynamic resources rooting.
router.use("/listing", require("./listing.js"));
router.use("/car", require("./car.js"));

module.exports = router;
