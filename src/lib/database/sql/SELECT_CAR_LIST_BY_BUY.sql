SELECT
  car.name AS car_name,
  buy.status AS buy_status,
  buy.date AS buy_date,
  bid.price AS bid_price,
  buy.penalty AS buy_penalty,
  buy.id AS buy_id
FROM
  buy
JOIN bid ON bid.id = buy.bid_id
JOIN listing ON listing.id = bid.listing_id
JOIN car ON car.id = listing.car_id
ORDER BY buy.status ASC, buy.date DESC

-- 車両ID, 車両名, 取引状態, 取引完了日時, 入札id