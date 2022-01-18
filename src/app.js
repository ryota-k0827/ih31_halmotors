const PORT = process.env.PORT || 9000;
const path = require("path");
const logger = require("./lib/log/logger.js");
const accesslogger = require("./lib/log/accesslogger.js");
const applicationlogger = require("./lib/log/applicationlogger.js");
const express = require("express");
const app = express();

// Express Settings.
app.set("view engine", "ejs");
app.disable("x-powered-by");

// Static resources rooting.
app.use("/public", express.static(path.join(__dirname, "/public")));

// Set access log.
app.use(accesslogger());

// Dynamic resources rooting.
app.use("/", require("./routes/index.js"));
app.use("/login", require("./routes/login.js"));
app.use("/signup", require("./routes/signup.js"));
app.use("/unsubscribe", require("./routes/unsubscribe.js"));
app.use("/search", require("./routes/search.js"));

// Set application log.
app.use(applicationlogger());

// Execute web application.
app.listen(PORT, () => {
  logger.application.info(`Application listening at ${PORT}`);
});