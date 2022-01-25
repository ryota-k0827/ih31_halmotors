const { MySQLClient, sql } = require("../database/client.js");
const cron = require("node-cron");

const auctionSchedule = () => {
  // 金曜日の19時過ぎに実行
  // cron.schedule("1 19 * * 5", async () => {
  //   // データベースからオークション情報を取得
  //   console.log("Auction Schedule");
  //   let results;
  //   try {
  //     results = await MySQLClient.executeQuery(await sql("SELECT_LISTING_DATETIME_BY_DATE"));
  //     console.log(results);
  //     // res.redirect("/manager/listing");
  //     // res.send("success");
  //   } catch (err) {
  //     // next(err);
  //   }
  // });

  // 毎秒実行（テスト）
  // eslint-disable-next-line no-constant-condition
  while (true) {
    cron.schedule("* * * * *", async () => {
      // データベースからオークション情報を取得
      console.log("Auction Schedule");
      let results;
      try {
        results = await MySQLClient.executeQuery(await sql("SELECT_LISTING_DATETIME_BY_DATE"));
        console.log(results);
        // res.redirect("/manager/listing");
        // res.send("success");
      } catch (err) {
        // next(err);
      }
    });
  }
};

module.exports = auctionSchedule;
