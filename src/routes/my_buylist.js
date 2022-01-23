const router = require("express").Router();

router.get("/", (req, res) => {
  res.render("./client/my_buylist.ejs");
});

module.exports = router;