SELECT
  car.id,
  car.name,
  listing.date,
  FORMAT(listing.start_price, 0) AS start_price,
  listing.flg
FROM
  car
JOIN listing ON listing.car_id = car.id
WHERE
  listing.flg = 1 AND
  car.name LIKE ?
ORDER BY listing.date ASC