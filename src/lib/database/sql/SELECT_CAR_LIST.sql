SELECT
  car.id,
  car.name,
  listing.date,
  listing.start_price AS start_price,
  listing.flg
FROM
  car
JOIN listing ON listing.car_id = car.id
WHERE
  listing.flg = 1
ORDER BY listing.date ASC