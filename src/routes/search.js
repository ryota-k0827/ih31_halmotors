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

    res.render("./search/list.ejs", { results });
  } catch (err) {
    next(err);
  }
});

// 絞り込み検索
router.get("/detail", (req, res) => {
  res.render("./search/detail_search.ejs");
});

module.exports = router;