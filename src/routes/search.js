const router = require("express").Router();

router.get("/", (req, res) => {
  res.render("./search/search.ejs");
});

module.exports = router;