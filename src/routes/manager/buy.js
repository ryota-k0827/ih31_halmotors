const router = require("express").Router();
const { MySQLClient, sql } = require("../../lib/database/client.js");
const { adminAuthMiddleware } = require("../../lib/security/accesscontrol.js");

// 落札一覧
router.get("/", adminAuthMiddleware, async (req, res, next) => {
  let results;

  try {
    results = await MySQLClient.executeQuery(await sql("SELECT_CAR_LIST_BY_BUY"));
    // console.log(results);
    res.render("./manager/buy/list.ejs", { results });
  } catch (err) {
    next(err);
  }
});

// 落札詳細ページ
router.get("/:id", adminAuthMiddleware, async (req, res, next) => {
  // id = 落札ID
  let id = req.params.id;
  let results;

  try {
    results = await MySQLClient.executeQuery(await sql("SELECT_CAR_BUY_BY_BUY_ID"), `%${id}%`);
    // console.log(results[0].name);
    res.render("./manager/buy/page.ejs", results[0]);
  } catch (err) {
    next(err);
  }
});

// 取引メモ保存
router.post("/:id", adminAuthMiddleware, async (req, res, next) => {
  let id = req.params.id;
  let memo = req.body.memo;
  try {
    await MySQLClient.executeQuery(await sql("UPDATE_BUY_MEMO"), [memo, id]);
    // console.log(results);
    // res.redirect("/manager/listing");
    res.send("success");
  } catch (err) {
    next(err);
  }
});

module.exports = router;
