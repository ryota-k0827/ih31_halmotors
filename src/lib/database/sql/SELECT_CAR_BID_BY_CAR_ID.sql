SELECT
  bid.price AS price,
  bid.date AS date
FROM
  bid
JOIN listing ON listing.id = bid.listing_id
JOIN car ON car.id = listing.car_id
WHERE
  listing.flg = 1 AND
  car.id LIKE ?
-- GROUP BY bid.listing_id