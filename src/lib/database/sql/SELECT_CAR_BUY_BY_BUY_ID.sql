SELECT
  car.id,
  car.name,
  car.evaluation,
  car.outer_evaluation,
  car.inner_evaluation,
  car.model_year,
  car.door,
  car.grade,
  car.history,
  car.model,
  car.engine_size,
  car.fuel_type,
  car.inspection_day,
  car.mileage,
  car.outer_color,
  car.inner_color,
  car.color_number,
  car.identifier,
  car.shift_type,
  car.gear_type,
  car.ac_type,
  car.ps,
  car.pw,
  car.aw,
  car.sr,
  car.tire,
  car.leather_sheet,
  car.ab,
  car.tv,
  car.navi,
  car.rear_spo,
  user.name AS user_name,
  user.category AS user_category,
  user.postal_code AS postal_code,
  user.address1 AS address1,
  user.address2 AS address2,
  user.address3 AS address3,
  user.tel AS tel,
  user.mail AS mail,
  user.birthday AS birthday,
  user.del_flg AS user_del_flg,
  user.penalty,
  buy.status AS buy_status,
  bid.date AS bid_date,
  buy.date AS buy_date,
  bid.price AS bid_price,
  buy.pay_status AS pay_status,
  buy.pay_type AS pay_type,
  buy.memo AS buy_memo,
  buy.id AS buy_id
FROM
  car
JOIN listing ON listing.car_id = car.id
JOIN bid ON bid.listing_id = listing.id
JOIN buy ON buy.bid_id = bid.id
JOIN user ON user.id = bid.user_id
WHERE
  buy.id LIKE ?