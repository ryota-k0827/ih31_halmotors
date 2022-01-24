const router = require("express").Router();

const { adminAuthMiddleware } = require("../../lib/security/accesscontrol.js");

// 管理者ページ表示
router.get("/", adminAuthMiddleware, (req, res) => {
  res.render("./manager/index.ejs");
});

// Dynamic resources rooting.
router.use("/listing", require("./listing.js"));
router.use("/buy", require("./buy.js"));
router.use("/car", require("./car.js"));
router.use("/account", require("./account.js"));

module.exports = router;
