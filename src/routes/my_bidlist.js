const router = require("express").Router();

router.get("/", (req, res) => {
    res.render("./client/my_bidlist.ejs");
});

module.exports = router;