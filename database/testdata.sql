-- customer
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "山田 忠明", "password", 1, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "aaa@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "田中 隆", "password", 2, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "bbb@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "山崎 ホウセイ", "password", 1, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "ccc@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "町田 大愛", "password", 2, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "ddd@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "竹内 杏奈", "password", 1, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "eee@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "英語 シャベル", "password", 1, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "fff@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "金子 凌大", "password", 2, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "ggg@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "村田 優真", "password", 1, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "hhh@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "木村 元保", "password", 1, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "iii@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "町田 商店", "password", 2, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "jjj@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "一蘭 次郎", "password", 1, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "kkk@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO customer( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "ラーメン JET", "password", 2, 5471111, "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "lll@sample.co.jp", "1992/3/16", 0, FALSE) ;

-- employees
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "瓜生 静香", "emp1@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "小田原 亜子", "emp2@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "東海林 良之", "emp3@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "安保 松男", "emp4@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "寺井 翔平", "emp5@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "金川 葉月", "emp6@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "新美 勝哉", "emp7@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "表 清信", "emp8@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "柏崎 辰男", "emp9@sample.com", "pass", FALSE) ;
INSERT INTO employees( name, mail, password, del_flg) VALUES ( "飯塚 昌", "emp10@sample.com", "pass", FALSE) ;

-- card
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(1, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(2, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(3, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(4, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(5, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(6, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(7, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(8, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(9, "0987654321091234", "2021/03/01", 313);
INSERT INTO card( person_id, number, expiration_date, security_code) VALUES(10, "0987654321091234", "2021/03/01", 313);

-- car
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ミライース", "4.5", "4", "4", 2021, 5, "マイクロカー", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("クラウン", "4.5", "4", "4", 2021, 5, "セダン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "C", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ロールスロイス", "4.5", "4", "4", 2021, 5, "高級サルーン", "L", 1, "LA350S", "660", "ハイオク", "2024/04/01", 731, "ブラック", "ブラック", "S28", "SDSRC-19010", 
"フロア", "AT", "AAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("アテンザワゴン", "4.5", "4", "4", 2021, 5, "ステーションワゴン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "AC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("トヨタ86", "4.5", "4", "4", 2021, 5, "クーペ", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("セレナ", "4.5", "4", "4", 2021, 5, "ミニバン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "AC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ハイエース", "4.5", "4", "4", 2021, 5, "ワンボックスカー", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "AAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("エクストレイル", "4.5", "4", "4", 2021, 5, "SUV", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ホンダフィット", "4.5", "4", "4", 2021, 5, "コンパクトカー", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ミライース", "4.5", "4", "4", 2021, 5, "ミニバン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "C", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");

-- listing 
INSERT INTO listing (car_id, start_price, date) VALUES(1, 800000, "2021/12/08");
INSERT INTO listing (car_id, start_price, date) VALUES(2, 700000, "2021/12/05");
INSERT INTO listing (car_id, start_price, date) VALUES(3, 1000000, "2021/12/02");

-- bid 
INSERT INTO bid (listing_id, person_id, price, date) VALUES(1, 3, 810000, "2021/12/08 15:21:31");
INSERT INTO bid (listing_id, person_id, price, date) VALUES(2, 3, 850000, "2021/12/08 15:22:31");
INSERT INTO bid (listing_id, person_id, price, date) VALUES(3, 3, 890000, "2021/12/08 15:23:31");
INSERT INTO bid (listing_id, person_id, price, date) VALUES(1, 3, 1000000, "2021/12/08 15:25:58");

-- buy 
INSERT INTO buy (bid_id, memo, date, status) VALUES(1, "100万になったｗｗ", "2021/12/08 15:25:58", "取引中");

-- purchase
INSERT INTO purchase (car_id, employee_id, purchase_price) VALUES(1, 1, 1000000);