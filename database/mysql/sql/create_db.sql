CREATE DATABASE IF NOT EXISTS `ih31_halmotors` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ih31_halmotors`;

CREATE TABLE `user` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` char(30) NOT NULL,
  `category` ENUM('個人','法人','従業員') NOT NULL COMMENT '顧客区分',
  `postal_code` varchar(10) NOT NULL COMMENT '郵便番号',
  `address1` varchar(255) NOT NULL COMMENT '都道府県',
  `address2` varchar(255) NOT NULL COMMENT '市町村',
  `address3` varchar(255) NOT NULL COMMENT '番地',
  `tel` varchar(255) NOT NULL COMMENT '電話番号',
  `mail` varchar(255) NOT NULL COMMENT 'メールアドレス',
  `birthday` date NOT NULL COMMENT '生年月日',
  `penalty` int DEFAULT 0 COMMENT 'ペナルティ回数',
  `del_flg` boolean NOT NULL DEFAULT false COMMENT '削除フラグ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='顧客・従業員';

CREATE TABLE `card` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '顧客ID',
  `number` varchar(255) NOT NULL COMMENT 'カード番号',
  `expiration_date` date NOT NULL COMMENT '有効期限',
  `security_code` int NOT NULL COMMENT 'セキュリティコード'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='カード';

CREATE TABLE `listing` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `car_id` int NOT NULL COMMENT '車両ID',
  `start_price` int NOT NULL COMMENT '開始価格',
  `date` date NOT NULL COMMENT '出品日',
  `flg` ENUM('出品中','終了') NOT NULL DEFAULT '出品中' COMMENT '出品状態'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='出品';

CREATE TABLE `bid` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `listing_id` int NOT NULL COMMENT '出品ID',
  `user_id` int NOT NULL COMMENT '顧客ID',
  `price` int NOT NULL COMMENT '入札価格',
  `date` datetime NOT NULL COMMENT '入札日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='入札';

CREATE TABLE `buy` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `bid_id` int NOT NULL COMMENT '入札ID',
  `memo` varchar(255) NOT NULL COMMENT '取引メモ',
  `date` datetime DEFAULT NULL COMMENT '取引完了日時',
  `status` ENUM ('取引中', '取引終了') NOT NULL DEFAULT '取引中' COMMENT '取引状態',
  `pay_status` ENUM ('未入金', '受領') NOT NULL DEFAULT '未入金' COMMENT '入金状態',
  `pay_type` ENUM ('未選択', 'カード', '振込', '一括請求') NOT NULL DEFAULT '未選択' COMMENT '入金方法',
  `penalty` int DEFAULT 0 COMMENT 'ペナルティ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='落札';

CREATE TABLE `car` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '車両名',
  `maker` varchar(255) NOT NULL COMMENT 'メーカー',
  `evaluation` varchar(255) COMMENT '車両評価',
  `outer_evaluation` varchar(255) COMMENT '外装評価',
  `inner_evaluation` varchar(255) COMMENT '内装評価',
  `model_year` year NOT NULL COMMENT '年式',
  `door` int COMMENT 'ドア数',
  `shape` varchar(255) COMMENT '車体形状',
  `grade` varchar(255) COMMENT '車体グレード',
  `history` int COMMENT '車歴',
  `model` varchar(255) COMMENT '型式',
  `engine_size` int COMMENT '排気量',
  `fuel_type` ENUM ('レギュラー', 'ハイオク', '軽油') COMMENT '燃料',
  `inspection_day` date COMMENT '車検日',
  `mileage` int COMMENT '走行距離',
  `outer_color` ENUM ('ホワイト', 'レッド', 'ブラック', 'イエロー', 'ブルー', 'グリーン', 'ブラウン', 'ツートン', 'シルバー') COMMENT '外装色',
  `inner_color` ENUM ('ホワイト', 'レッド', 'ブラック', 'イエロー', 'ブルー', 'グリーン', 'ブラウン', 'ツートン', 'シルバー') COMMENT '内装色',
  `color_number` varchar(255) COMMENT '色数',
  `identifier` varchar(255) COMMENT '車体番号',
  `shift_type` ENUM ('フロア', 'コラム', 'インパネ') COMMENT 'シフトタイプ',
  `gear_type` varchar(255) COMMENT 'ギアタイプ',
  `ac_type` ENUM ('WAC', 'AAC', 'AC', 'C', '無') COMMENT 'エアコンタイプ',
  `ps` boolean DEFAULT false COMMENT 'パワーステアリング',
  `pw` boolean DEFAULT false COMMENT 'パワーウインド',
  `aw` boolean DEFAULT false COMMENT 'アルミホイール',
  `sr` boolean DEFAULT false COMMENT 'サンルーフ',
  `tire` boolean DEFAULT false COMMENT 'タイヤ',
  `leather_sheet` boolean DEFAULT false COMMENT '本革シート',
  `ab` boolean DEFAULT false COMMENT 'エアバック',
  `tv` boolean DEFAULT false COMMENT 'テレビ',
  `navi` boolean DEFAULT false COMMENT 'ナビ',
  `rear_spo` boolean DEFAULT false COMMENT 'リアスポイラー',
  `manual` boolean DEFAULT false COMMENT '取説',
  `warranty` boolean DEFAULT false COMMENT '保証書',
  `other_option` longtext COMMENT 'その他車両情報',
  `information` longtext COMMENT '検査員メモ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='車両';

CREATE TABLE `purchase` (
  `car_id` int PRIMARY KEY COMMENT '車両ID',
  `user_id` int NOT NULL COMMENT '従業員ID',
  `purchase_price` int NOT NULL COMMENT '仕入価格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='仕入管理';

ALTER TABLE `bid` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);

ALTER TABLE `bid` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

-- ALTER TABLE `bid` ADD FOREIGN KEY (`id`) REFERENCES `buy` (`bid_id`);
ALTER TABLE `buy` ADD FOREIGN KEY (`bid_id`) REFERENCES `bid` (`id`);

-- ALTER TABLE `car` ADD FOREIGN KEY (`id`) REFERENCES `listing` (`car_id`);
ALTER TABLE `listing` ADD FOREIGN KEY (`car_id`) REFERENCES `car` (`id`);

-- ALTER TABLE `car` ADD FOREIGN KEY (`id`) REFERENCES `purchase` (`car_id`);
ALTER TABLE `purchase` ADD FOREIGN KEY (`car_id`) REFERENCES `car` (`id`);

ALTER TABLE `purchase` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `card` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);


-- user
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "山田 忠明", "password", 1, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "aaa@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "田中 隆", "password", 2, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "bbb@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "山崎 ホウセイ", "password", 1, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "ccc@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "町田 大愛", "password", 2, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "ddd@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "竹内 杏奈", "password", 1, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "eee@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "英語 シャベル", "password", 1, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "fff@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "金子 凌大", "password", 2, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "ggg@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "村田 優真", "password", 1, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "hhh@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "木村 元保", "password", 1, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "iii@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "町田 商店", "password", 2, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "jjj@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "一蘭 次郎", "password", 1, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "kkk@sample.co.jp", "1992/3/16", 0, FALSE) ;
INSERT INTO user( name, password, category, postal_code, address1, address2, address3, tel, mail, birthday, penalty, del_flg) VALUES ( "ラーメン JET", "password", 2, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "lll@sample.co.jp", "1992/3/16", 0, FALSE) ;

-- user
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "瓜生 静香", "emp1@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "小田原 亜子", "emp2@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "東海林 良之", "emp3@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "安保 松男", "emp4@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "寺井 翔平", "emp5@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "金川 葉月", "emp6@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "新美 勝哉", "emp7@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "表 清信", "emp8@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "柏崎 辰男", "emp9@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;
INSERT INTO user( name, mail, password, category, postal_code, address1, address2, address3, tel, birthday, del_flg) VALUES ( "飯塚 昌", "emp10@sample.com", "pass", 3, '547-1111', "大阪府", "大阪市北区", "町田町1-1-1", "090-8416-8638", "1992/3/16", FALSE) ;

-- card
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(1, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(2, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(3, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(4, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(5, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(6, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(7, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(8, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(9, "0987654321091234", "2024/03/01", 313);
INSERT INTO card( user_id, number, expiration_date, security_code) VALUES(10, "0987654321091234", "2024/03/01", 313);

-- car
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ミライース", "ダイハツ", "4.5", "4", "4", 2021, 5, "マイクロカー", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("クラウン", "トヨタ", "4.5", "4", "4", 2021, 5, "セダン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "C", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ロールス・ロイス", "ロールス・ロイス", "4.5", "4", "4", 2021, 5, "高級サルーン", "L", 1, "LA350S", "660", "ハイオク", "2024/04/01", 731, "ブラック", "ブラック", "S28", "SDSRC-19010", 
"フロア", "AT", "AAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("アテンザワゴン", "マツダ", "4.5", "4", "4", 2021, 5, "ステーションワゴン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "AC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("トヨタ86", "トヨタ", "4.5", "4", "4", 2021, 5, "クーペ", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("セレナ", "ニッサン", "4.5", "4", "4", 2021, 5, "ミニバン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "AC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ハイエース", "トヨタ", "4.5", "4", "4", 2021, 5, "ワンボックスカー", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "AAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("エクストレイル", "ニッサン", "4.5", "4", "4", 2021, 5, "SUV", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ホンダフィット", "ホンダ", "4.5", "4", "4", 2021, 5, "コンパクトカー", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "WAC", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");
INSERT INTO car(name, maker, evaluation, outer_evaluation, inner_evaluation, model_year, door, shape, grade, history, model, engine_size, fuel_type, inspection_day, mileage,outer_color, inner_color, color_number, identifier, shift_type, gear_type,ac_type, ps, pw, aw, sr, tire, leather_sheet, ab, tv, navi, rear_spo, manual, warranty, other_option, information)
VALUES("ミライース", "ダイハツ", "4.5", "4", "4", 2021, 5, "ミニバン", "L", 1, "LA350S", "660", "レギュラー", "2024/04/01", 731, "シルバー", "シルバー", "S28", "SDSRC-19010", 
"フロア", "AT", "C", true, true, false, false, true, true, true, true, true, true, true, true, "すげーくるまやで", "ああああ");

-- listing 
INSERT INTO listing (car_id, start_price, date) VALUES(1, 800000, "2022/01/29");
INSERT INTO listing (car_id, start_price, date) VALUES(2, 700000, "2022/01/29");
INSERT INTO listing (car_id, start_price, date) VALUES(3, 1000000, "2022/01/29");
INSERT INTO listing (car_id, start_price, date) VALUES(4, 800000, "2022/01/29");
INSERT INTO listing (car_id, start_price, date) VALUES(5, 700000, "2022/01/29");
INSERT INTO listing (car_id, start_price, date) VALUES(6, 1000000, "2022/01/29");

-- bid 
INSERT INTO bid (listing_id, user_id, price, date) VALUES(1, 1, 810000, "2021/12/08 15:21:31");
INSERT INTO bid (listing_id, user_id, price, date) VALUES(2, 2, 850000, "2021/12/08 15:22:31");
INSERT INTO bid (listing_id, user_id, price, date) VALUES(3, 3, 890000, "2021/12/08 15:23:31");
INSERT INTO bid (listing_id, user_id, price, date) VALUES(4, 4, 1000000, "2021/12/08 15:25:58");
INSERT INTO bid (listing_id, user_id, price, date) VALUES(5, 5, 80000, "2021/12/08 15:27:31");
INSERT INTO bid (listing_id, user_id, price, date) VALUES(6, 6, 1000000, "2021/12/08 15:29:58");

-- buy
INSERT INTO buy (bid_id, memo, date, status, pay_status, pay_type) VALUES(1, "100万になったｗｗ", "2021/12/08 15:25:58", "取引終了", "受領", "振込");
INSERT INTO buy (bid_id, memo, date, status, pay_status, pay_type) VALUES(2, "hoge", "2021/12/08 15:25:58", "取引終了", "受領", "カード");
INSERT INTO buy (bid_id, memo, date, status, pay_status, pay_type) VALUES(3, "hoge", "2021/12/08 15:25:58", "取引終了", "受領", "振込");
INSERT INTO buy (bid_id, memo, date, status, pay_status, pay_type) VALUES(4, "hoge", "2021/12/08 15:25:58", "取引終了", "受領", "一括請求");
INSERT INTO buy (bid_id, memo, status, pay_status, pay_type) VALUES(5, "hoge", "取引中", "未入金", "未選択");
INSERT INTO buy (bid_id, memo, status, pay_status, pay_type) VALUES(6, "hogehoge", "取引中", "未入金", "振込");

-- purchase
INSERT INTO purchase (car_id, user_id, purchase_price) VALUES(1, 16, 1000000);