const router = require("express").Router();
const { MySQLClient, sql } = require("../../lib/database/client.js");

// 入札確認
router.post("/confirm/:id", (req, res) => {
  let data = {
    listing_id: req.params.id,
    name: req.body.name,
    price: req.body.price,
  };

  res.render("./bid/bid-confirm.ejs", data);
});

// 入札完了
router.post("/complete", async (req, res, next) => {
  const date = new Date();
  let now_date = date.toLocaleString();

  let { listingId, price, customerId } = req.body;

  try {
    MySQLClient.executeQuery(await sql("INSERT_BID"), [listingId, customerId, price, now_date]);
    res.render("./bid/bid-complete.ejs");
  } catch (err) {
    next(err);
  }
});

module.exports = router;
