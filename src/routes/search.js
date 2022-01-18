const router = require("express").Router();
const { MySQLClient, sql } = require("../lib/database/client.js");

// 車名検索
router.get("/", async (req, res, next) => {
  let keyword = req.query.keyword || "";
  let results;

  try {
    if (keyword) {
      results = await MySQLClient.executeQuery(
        await sql("SELECT_CAR_LIST_BY_NAME"),
        `%${keyword}%`
      );
    } else {
      results = await MySQLClient.executeQuery(
        await sql("SELECT_CAR_LIST")
      );
    }
    // console.log(results);
    res.render("./search/list.ejs", { results });
  } catch (err) {
    next(err);
  }
});

// 絞り込み検索
router.get("/detail", (req, res) => {
  res.render("./search/detail-search.ejs");
});

// 入札画面（車両ページ）
router.get("/bid/:id", async (req, res, next) => {
  let id = req.params.id || "";
  let results;

  try {
    if (id) {
      results = await MySQLClient.executeQuery(
        await sql("SELECT_CAR_BY_ID"),
        `%${id}%`
      );
      // console.log(results);
      res.render("./search/bid.ejs", { results });
    } else {
      res.status(404).send("404 Not Found");
    }
  } catch (err) {
    next(err);
  }
});

module.exports = router;