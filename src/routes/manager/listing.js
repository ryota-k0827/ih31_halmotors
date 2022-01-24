const router = require("express").Router();
const { MySQLClient, sql } = require("../../lib/database/client.js");
const { adminAuthMiddleware } = require("../../lib/security/accesscontrol.js");

// オークション一覧
router.get("/", adminAuthMiddleware, async (req, res, next) => {
  let results;

  try {
    results = await MySQLClient.executeQuery(await sql("SELECT_CAR_LIST"));
    // console.log(results);
    res.render("./manager/listing/list.ejs", { results });
  } catch (err) {
    next(err);
  }
});

// 車両詳細ページ
router.get("/:id", adminAuthMiddleware, async (req, res, next) => {
  let id = req.params.id;

  Promise.all([
    MySQLClient.executeQuery(await sql("SELECT_CAR_BY_ID"), `%${id}%`),
    MySQLClient.executeQuery(await sql("SELECT_CAR_BID_BY_CAR_ID"), `%${id}%`),
  ])
    .then((results) => {
      let data = results[0][0];
      data.bid = results[1][0] || [];
      console.log(data);
      res.render("./manager/listing/page.ejs", data);
    })
    .catch((err) => {
      next(err);
    });
});

// 出品削除
router.post("/delete/:id", adminAuthMiddleware, async (req, res, next) => {
  let id = req.params.id;

  try {
    await MySQLClient.executeQuery(await sql("DELETE_LISTING_BY_ID"), `%${id}%`);
    // console.log(results);
    res.redirect("/manager/listing");
  } catch (err) {
    next(err);
  }
});

module.exports = router;
