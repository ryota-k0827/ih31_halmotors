SELECT
  car.id,
  FORMAT(MAX(bid.price), 0) AS price
FROM
  car
JOIN listing ON car.id = listing.car_id
JOIN bid ON listing.id = bid.listing_id
WHERE
  car.id LIKE ?
GROUP BY car.id