const IS_PRODUCTION = process.env.NODE_ENV === "production";
const appconfig = require("./config/application.config.js");
const dbconfig = require("./config/mysql.config.js");
const path = require("path");
const logger = require("./lib/log/logger.js");
const accesslogger = require("./lib/log/accesslogger.js");
const applicationlogger = require("./lib/log/applicationlogger.js");
const accesscontrol = require("./lib/security/accesscontrol.js");
const express = require("express");
const cookie = require("cookie-parser");
const session = require("express-session");
const MySQLStore = require("express-mysql-session")(session);
const flash = require("connect-flash");
const app = express();
const httpSocket = require("http").Server(app);
const ioSocket = require("socket.io")(httpSocket);

// オークションタイマー
let hours = 10;
let minutes = 0;
let seconds = 0;

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
app.use(cookie());
app.use(
  session({
    store: new MySQLStore({
      host: dbconfig.HOST,
      port: dbconfig.PORT,
      user: dbconfig.USERNAME,
      password: dbconfig.PASSWORD,
      database: dbconfig.DATABASE,
    }),
    cookie: {
      secure: IS_PRODUCTION,
    },
    secret: appconfig.security.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    name: "sid",
  })
);
app.use(express.urlencoded({ extended: true }));
app.use(flash());
app.use(...accesscontrol.initialize());

// Dynamic resources rooting.
app.use("/", require("./routes/index.js"));
app.use("/account", require("./routes/account.js"));
app.use("/search", require("./routes/search.js"));
app.use("/bid", require("./routes/bid.js"));
app.use("/manager", require("./routes/manager/manager.js"));

// Set application log.
app.use(applicationlogger());

// Execute web application.
httpSocket.listen(appconfig.PORT, () => {
  logger.application.info(`Application listening at ${appconfig.PORT}`);
});

ioSocket.on("connection", (socket) => {
  logger.application.info("A client connected.");
  // ブラウザから受信
  socket.on("c2s", (data) => {
    logger.application.info("入札: " + data.price + "円");
    // ブラウザへ送信
    ioSocket.emit("s2c/" + data.pageId, data.price);
  });
});
