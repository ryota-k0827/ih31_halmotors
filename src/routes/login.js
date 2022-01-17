const router = require("express").Router();

router.get("/", (req, res) => {
  res.render("./login/login.ejs");
});

module.exports = router;