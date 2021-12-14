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

// 車両登録画面表示
app.get("/admin/car_register", (req, res) => {
    res.render('manager/car_register.ejs');
});

// 車両登録処理
app.post("/admin/car_register", (req, res) => {
    let car = {
        name: req.body.name,
        maker: req.body.maker,
        evaluation: req.body.evaluation,
        outer_evaluation: req.body.outer_evaluation,
        inner_evaluation: req.body.inner_evaluation,
        model_year: req.body.model_year,
        door: req.body.door,
        shape: req.body.shape,
        grade: req.body.grade,
        history: req.body.history,
        model: req.body.model,
        engine_size: req.body.engine_size,
        fuel_type: req.body.fuel_type,
        inspection_day: req.body.inspection_day,
        mileage: req.body.mileage,
        outer_color: req.body.outer_color,
        inner_color: req.body.inner_color,
        color_number: req.body.color_number,
        identifier: req.body.identifier,
        shift_type: req.body.shift_type,
        gear_type: req.body.gear_type,
        ac_type: req.body.ac_type,
        ps: req.body.ps,
        pw: req.body.pw,
        aw: req.body.aw,
        sr: req.body.sr,
        tire: req.body.tire,
        leather_sheet: req.body.leather_sheet,
        ab: req.body.ab,
        tv: req.body.tv,
        navi: req.body.navi,
        rear_spo: req.body.rear_spo,
        manual: req.body.manual,
        warranty: req.body.warranty,
        other_option: req.body.other_option,
        information: req.body.information
    };
    for (var key in car) {
        if (car[key] === '') {
            car[key] = null;
        }
    }
    console.log(car);
    connection.query(
        'INSERT INTO car SET ?;', car,
        (err, result) => {
            if (err) {
                console.log('400 Bad Request: ' + err.stack);
                res.status(400).send('400 Bad Request'); // DBエラー
                return;
            }
            console.log("Inserted " + result.affectedRows + " rows");
        });
        res.redirect('/admin/car_register.ejs'); // 登録成功
});

// 出品登録ページ表示
app.get("/admin/listing_register", (req, res) => {
    res.render('car_listiong.ejs');
});


// 出品済車両編集


// 従業員登録

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





// サーバー起動
server.listen(config.port, () => {
    console.log("Server running on port: " + config.port);
});

