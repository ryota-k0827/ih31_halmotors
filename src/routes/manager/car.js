const router = require("express").Router();
const { MySQLClient, sql } = require("../../lib/database/client.js");

// 車両登録ページ
router.get("/regist", (req, res) => {
  res.render("./manager/car/regist.ejs");
});

// 車両登録確認ページ
router.post("/regist/confirm", (req, res) => {
  let data = {
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
    information: req.body.information,
  };

  res.render("./manager/car/regist-comfirm.ejs", data);
});

// 車両登録削除ページ
router.get("/delete", (req, res) => {
  res.render("./manager/car/delete.ejs");
});

module.exports = router;
