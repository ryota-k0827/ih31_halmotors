const router = require("express").Router();

router.get("/", (req, res) => {
  res.render("./unsubscribe/unsubscribe.ejs");
});

module.exports = router;