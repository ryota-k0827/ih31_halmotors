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
  listing.id AS listing_id,
  listing.date,
  listing.start_price AS start_price,
  listing.flg
FROM
  car
JOIN listing ON listing.car_id = car.id
WHERE
  listing.flg = 1 AND
  car.id LIKE ?