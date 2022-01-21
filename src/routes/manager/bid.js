const router = require("express").Router();
const { MySQLClient, sql } = require("../../lib/database/client.js");

// オークション一覧
router.get("/", async (req, res, next) => {
  let results;

  try {
    results = await MySQLClient.executeQuery(await sql("SELECT_CAR_LIST"));
    // console.log(results);
    res.render("./manager/bid/list.ejs", { results });
  } catch (err) {
    next(err);
  }
});

// 車両詳細ページ
router.get("/:id", async (req, res, next) => {
  let id = req.params.id;

  Promise.all([
    MySQLClient.executeQuery(await sql("SELECT_CAR_BY_ID"), `%${id}%`),
    MySQLClient.executeQuery(await sql("SELECT_CAR_BID_BY_CAR_ID"), `%${id}%`),
  ])
    .then((results) => {
      let data = results[0][0];
      data.bid = results[1][0] || [];
      console.log(data);
      res.render("./manager/bid/page.ejs", data);
    })
    .catch((err) => {
      next(err);
    });
});

module.exports = router;
