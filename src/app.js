const PORT = process.env.PORT || 9000;
const path = require("path");
const logger = require("./lib/log/logger.js");
const accesslogger = require("./lib/log/accesslogger.js");
const applicationlogger = require("./lib/log/applicationlogger.js");
// const http = require("http");
// const socketio = require("socket.io");
const express = require("express");
const app = express();
// const server = http.Server(app);
// const io = socketio.io(server);

// Express Settings.
app.set("view engine", "ejs");
app.disable("x-powered-by");

// Expose global method to view engine.
app.use((req, res, next) => {
  res.locals.moment = require("moment");
  next();
});

// Static resources rooting.
app.use("/public", express.static(path.join(__dirname, "/public")));

// Set access log.
app.use(accesslogger());

// Set middleware
app.use(express.urlencoded({ extended: true }));

// Dynamic resources rooting.
app.use("/", require("./routes/index.js"));
app.use("/login", require("./routes/login.js"));
app.use("/signup", require("./routes/signup.js"));
app.use("/unsubscribe", require("./routes/unsubscribe.js"));
app.use("/search", require("./routes/search.js"));
app.use("/bid", require("./routes/bid/bid.js"));
app.use("/mypage", require("./routes/mypage.js"));

// Set application log.
app.use(applicationlogger());

// Execute web application.
app.listen(PORT, () => {
  logger.application.info(`Application listening at ${PORT}`);
});

// ログイン処理
// const loginModule = require("./routes/login-info.js");
// loginModule.userList;
// console.log(loginModule.userArray);

// io.on("connection", (socker) => {
//   console.log("Connected is socket.");
// });
