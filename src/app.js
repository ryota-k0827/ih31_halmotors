const PORT = process.env.PORT || 3000;
const path = require("path");
const express = require("express");
const app = express();

// Express Settings.
app.set("view engine", "ejs");
app.disable("x-powered-by");

// Static resources rooting.
app.use("/public", express.static(path.join(__dirname, "/public")));

// Dynamic resources rooting.
app.use("/", require("./routes/index.js"));
app.use("/login", require("./routes/login.js"));
app.use("/signup", require("./routes/signup.js"));
app.use("/unsubscribe", require("./routes/unsubscribe.js"));
app.use("/search", require("./routes/search.js"));

// Execute web application.
app.listen(PORT, () => {
  console.log(`Application listening at ${PORT}`);
});