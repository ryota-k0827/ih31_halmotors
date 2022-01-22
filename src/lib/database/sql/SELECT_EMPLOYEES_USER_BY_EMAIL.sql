SELECT
  id,
  name,
  mail
FROM
  employee
WHERE
  del_flg = 0
  AND
  mail = ?