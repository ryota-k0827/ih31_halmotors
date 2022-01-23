SELECT
  id,
  name,
  password,
  category,
  postal_code,
  address1,
  address2,
  address3,
  tel,
  mail,
  birthday,
  penalty
FROM
  user
WHERE
  del_flg = 0
  AND
  mail = ?