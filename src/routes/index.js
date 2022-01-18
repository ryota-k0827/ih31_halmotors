const router = require("express").Router();

const { MySQLClient, sql } = require("../lib/database/client.js");

router.get("/", async (req, res, next) => {
  let results;

  try {
    results = await MySQLClient.executeQuery(
      await sql("SELECT_CAR_LIST")
    );
    // console.log(results);
    res.render("./search/list.ejs", { results });
  } catch (err) {
    next(err);
  }
});

module.exports = router;