const PORT = process.env.PORT || 9000;
const path = require("path");
const logger = require("./lib/log/logger.js");
const accesslogger = require("./lib/log/accesslogger.js");
const applicationlogger = require("./lib/log/applicationlogger.js");
const express = require("express");
const app = express();
<<<<<<< HEAD
=======
const http = require("http");
const server = http.Server(app);
const passport = require("passport");
const passportLocal = require("passport-local");
const mysql = require("mysql");
const connection = mysql.createConnection(config.dbConnection);
const session = require("express-session");
const socketio = require("socket.io")(server);

app.use(session({
    secret: "secret",
    resave: true,
    saveUninitialized: true
}));

app.set('view engine', 'ejs');

app.use(passport.initialize());
// app.use(passport.session);
let LocalStrategy = passportLocal.Strategy;

connection.connect((err) => {
    if (err) {
        console.log("Error connecting to database: " + err.stack);
        return;
    }
    console.log("Connected to database as id " + connection.threadId);
});

app.use(express.static(__dirname + "/views", { index: false }));
app.use(express.static(__dirname + '/public', { index: false }));
app.use(express.urlencoded({ extended: true }));


// トップページ表示
app.get("/", (req, res) => {
    res.render('index.ejs');
});

// ユーザー登録画面表示
app.get("/signup", (req, res) => {
    res.render('client/user_register.ejs');
});

// ユーザー登録処理
app.post("/signup", (req, res) => {
    let user = {
        name: req.body.name,
        password: req.body.password,
        category: req.body.category,
        postal_code: req.body.postal_code,
        address1: req.body.address1,
        address2: req.body.address2,
        address3: req.body.address3,
        tel: req.body.tel,
        mail: req.body.mail,
        birthday: req.body.birthday
    };
    connection.query("INSERT INTO customer SET ?", user, (err, result) => {
        if (err) {
            console.log("Error: " + err.stack);
            return;
        }
        console.log("Inserted " + result.affectedRows + " rows");
    });
    res.redirect("/");
});


// ログインページ表示
app.get("/login", (req, res) => {
    res.render('client/user_login.ejs');
});

// ログイン（個人）
passport.use(new LocalStrategy(
    {
        // フィールド名の指定
        usernameField: 'mail',
        passwordField: 'password',
        session: false,
    },
    function (mail, password, done) {
        let values = [
            'customer',
            mail,
            password
        ];
        connection.query(
            'SELECT * FROM ?? WHERE mail = ? AND password = ?;', values,
            (err, results) => {
                if (err) {
                    console.log('400 Bad Request: ' + err.stack);
                    return done(err); // DBエラー
                }
                if (results.length === 0) {
                    console.log("認証失敗");
                    return done(null, false); // 認証失敗
                }
                console.log("認証成功");
                return done(null, results[0]); // 認証成功
            }
        );
    }
));

app.post("/login",
    passport.authenticate('local', {
        // successRedirect: '/',
        failureRedirect: '/login',
        session: false
    }
    ),
    function(req, res) {
        console.log(req.user);
        res.render('client/login_index.ejs', {data: req.user});
        // res.send({data: req.user});
    }
);

// app.get("/top", (req, res) => {
//     res.render('client/login_index.ejs');
// });


// ログアウト
app.get("/logout", (req, res) => {
    req.logout();
    res.redirect("/");
});

// 車両検索ページ表示
app.get("/search", (req, res) => {
    res.render('client/search.ejs');
});

// 入札・商品ページ表示
app.get("/car_bid", (req, res) => {
    res.render('client/car_bid.ejs');
});
// 車両検索
app.post("/search", (req, res) => {
    let values = [
        'car',
        req.body.name
    ];
    connection.query(
        'SELECT * FROM ?? WHERE name = ?;', values,
        (err, results) => {
            if (err) {
                console.log('400 Bad Request: ' + err.stack);
                res.status(400).send('400 Bad Request'); // DBエラー
                return;
            } else {
                res.send(results); // 車両検索成功
            }
        }
    );
});

// 車両詳細検索ページ表示
app.get("/detail", (req, res) => {
    res.render('client/detail_search.ejs');
});


//オークション登録
app.get('/car_listing', (req, res) => {
    res.render('manager/car_listing.ejs');

//
app.get("/car_bidlist", (req, res) => {
    res.render('manager/car_bidlist.ejs');

// オークション一覧
app.get("/listing", (req, res) => {
    let values = [
        'listing',
        'car',
    ];
    connection.query(
        'SELECT * FROM ?? JOIN ? ON listing.car_id = car.id;', values,
        (err, results) => {
            if (err) {
                console.log('400 Bad Request: ' + err.stack);
                res.status(400).send('400 Bad Request'); // DBエラー
                return;
            } else {
                res.render('listing_list.ejs', results); // 取得成功
            }
        }
    );
});

// オークション詳細
app.get("/listing:id", (req, res) => {
    let values = [
        'listing',
        'car',
        req.params.id
    ];
    connection.query(
        'SELECT * FROM ?? JOIN ? ON listing.car_id = car.id WHERE listing.id = ?;', values,
        (err, results) => {
            if (err) {
                console.log('400 Bad Request: ' + err.stack);
                res.status(400).send('400 Bad Request'); // DBエラー
                return;
            } else {
                res.send('listing_car.ejs', results); // 取得成功
            }
        }
    );
});

// 管理者ログイン画面表示
app.get("/admin", (req, res) => {
    res.render('manager/manager_login.ejs');
});
>>>>>>> 9ef8f5767fcce83c6aba0abc4991f28c354093c6

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

// Dynamic resources rooting.
app.use("/", require("./routes/index.js"));
app.use("/login", require("./routes/login.js"));
app.use("/signup", require("./routes/signup.js"));
app.use("/unsubscribe", require("./routes/unsubscribe.js"));
app.use("/search", require("./routes/search.js"));

<<<<<<< HEAD
// Set application log.
app.use(applicationlogger());
=======
// 従業員削除

// ユーザー登録

// ユーザー退会
app.get('/user_delete:id', (req, res) => {
    res.render('client/user_delete.ejs');
});
app.get('/user_delete:id/result', (req, res) => {
    let user_id = req.params.id;
    connection.query(
        'DELETE FROM user WHERE id = ?;', user_id,
        (err, result) => {
            if (err) {
                console.log('400 Bad Request: ' + err.stack);
                res.status(400).send('400 Bad Request'); // DBエラー
                return;
            }
            console.log("Deleted " + result.affectedRows + " rows");
        });
    res.render('client/user_delete.ejs');
});

//管理者画面
app.get('/manager_top', (req, res) => {
    res.render('manager/manager_top.ejs');
});
//オークション一覧
app.get('/car_bidlist', (req, res) => {
    res.render('manager/car_bidlist.ejs');
});
//落札画面
//車両登録
app.get('/car_register', (req, res) => {
    res.render('manager/car_register.ejs');
});
//車両登録削除
app.get('/car_delete', (req, res) => {
    res.render('manager/car_delete.ejs');
});


// サーバー起動
server.listen(config.port, () => {
    console.log("Server running on port: " + config.port);
});
>>>>>>> 9ef8f5767fcce83c6aba0abc4991f28c354093c6

// Execute web application.
app.listen(PORT, () => {
  logger.application.info(`Application listening at ${PORT}`);
});