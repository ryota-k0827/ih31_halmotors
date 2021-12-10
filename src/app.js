"use strict"

const config = require("./config.js");
const express = require("express");
const app = express();
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
        res.render('index.ejs', {data: req.user});
    }
);


// ログアウト
app.get("/logout", (req, res) => {
    req.logout();
    res.redirect("/");
});

// 車両検索ページ表示
app.get("/search", (req, res) => {
    res.render('search.ejs');
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

// 出品登録ページ表示
// app.get("/listing/add", (req, res) => {
//     res.render('listing_add.ejs');
// });

// // 出品登録
// app.post("/listing/add", (req, res) => {
//     let values = [
//         'listing',
//         req.body.id
//     ];
//     connection.query(
//         'INSERT INTO ?? (car_id) VALUES (?);', values,
//         (err, results) => {
//             if (err) {
//                 console.log('400 Bad Request: ' + err.stack);
//                 res.status(400).send('400 Bad Request'); // DBエラー
//                 return;
//             } else {
//                 res.send('listing_add.ejs'); // 出品登録成功
//             }
//         }
//     );
// });


// 出品済車両編集


// 従業員登録

// 従業員削除

// ユーザー登録

// ユーザー退会
app.get("/userDelete", (req, res) => {
    res.render('client/user_delete.ejs');
});





// サーバー起動
server.listen(config.port, () => {
    console.log("Server running on port: " + config.port);
});

