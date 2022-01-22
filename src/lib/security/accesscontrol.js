const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
const { MySQLClient, sql } = require("../database/client.js");
const PRIVILEGE = {
  NORMAL: "normal",
};
let initialize, authenticate, authorize;

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((user, done) => {
  done(null, user);
});

passport.use(
  "local-strategy",
  new LocalStrategy(
    {
      usernameField: "username",
      passwordField: "password",
      passReqToCallback: true,
    },
    async (req, username, password, done) => {
      let results, user;
      try {
        results = await MySQLClient.executeQuery(await sql("SELECT_CUSTOMER_USER_BY_EMAIL"), [
          username,
        ]);
      } catch (err) {
        return done(err);
      }
      if (results.length === 1 && password === results[0].password) {
        user = {
          id: results[0].id,
          name: results[0].name,
          category: results[0].category,
          mail: results[0].mail,
          permissions: [PRIVILEGE.NORMAL],
        };
        req.session.regenerate((err) => {
          if (err) {
            done(err);
          } else {
            done(null, user);
          }
        });
      } else {
        done(
          null,
          false,
          req.flash("message", "メールアドレス または パスワードが間違っています。")
        );
      }
    }
  )
);

initialize = function () {
  return [
    passport.initialize(),
    passport.session(),
    function (req, res, next) {
      if (req.user) {
        res.locals.user = req.user;
      }
      next();
    },
  ];
};

authenticate = function () {
  return passport.authenticate("local-strategy", {
    successRedirect: "/",
    failureRedirect: "/login",
  });
};

module.exports = {
  initialize, //
  authenticate, //認証処理
  authorize, //認可処理
};
