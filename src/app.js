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

app.use(express.static(__dirname + "/views", {index: false}));
app.use(express.static(__dirname + '/public', {index: false}));
app.use(express.urlencoded({ extended: true }));



// トップページ
app.get("/", (req, res) => {
    res.render('index.ejs');
});

// ログイン（業者）
passport.use(new LocalStrategy(
    {
        usernameField: 'mail',
        passwordField: 'password'
    },
    function(mail, password, done) {
        let values = [
            'corporation',
            mail,
            password
        ];
        connection.query(
            'SELECT * FROM ?? WHERE mail = ? AND password = ?', values,
            (err, results) => {
                if (err) {
                    console.log('Error in query: ' + err.stack);
                    return done(err); // DBエラー
                }
                if (results.length === 0) {
                    return done(null, false); // 認証失敗
                } else {
                    return done(null, results[0]); // 認証成功
                }
            }
        );
    }
));

// ログイン（個人）
passport.use(new LocalStrategy(
    {
        usernameField: 'mail',
        passwordField: 'password'
    },
    function(mail, password, done) {
        let values = [
            'customer',
            mail,
            password
        ];
        connection.query(
            'SELECT * FROM ?? WHERE mail = ? AND password = ?', values,
            (err, results) => {
                if (err) {
                    console.log('Error in query: ' + err.stack);
                    return done(err); // DBエラー
                }
                if (results.length === 0) {
                    return done(null, false); // 認証失敗
                } else {
                    return done(null, results[0]); // 認証成功
                }
            }
        );
    }
));

// 車両検索

// オークション一覧

// オークション詳細

// 出品登録

// 出品済車両編集


// 従業員登録

// 従業員削除

// ユーザー登録（業者)

// ユーザー退会（業者)

// ユーザー登録（個人）

// ユーザー退会（個人）





// サーバー起動
server.listen(config.port, () => {
    console.log("Server running on port: " + config.port);
});

