const router = require("express").Router();
const { authenticate, authorize, PRIVILEGE } = require("../lib/security/accesscontrol.js");

router.get("/", (req, res, next) => {
  res.render("./login/login.ejs", { message: req.flash("message") });
});

router.post("/", authenticate());

module.exports = router;
