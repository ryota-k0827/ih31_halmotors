CREATE DATABASE IF NOT EXISTS `ih31_halmotors` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ih31_halmotors`;

CREATE TABLE `employees` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` char(30) NOT NULL,
  `del_flg` boolean NOT NULL DEFAULT false
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci, COMMENT='従業員';

CREATE TABLE `customer` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` char(30) NOT NULL,
  `category` ENUM('個人','法人') NOT NULL COMMENT '顧客区分',
  `postal_code` int(7) NOT NULL COMMENT '郵便番号',
  `address1` varchar(255) NOT NULL COMMENT '都道府県',
<<<<<<< HEAD
  `address2` varchar(255) NOT NULL COMMENT '市区町村',
  `address3` varchar(255) NOT NULL COMMENT 'マンション名',
=======
  `address2` varchar(255) NOT NULL COMMENT '市町村',
  `address3` varchar(255) NOT NULL COMMENT '番地',
>>>>>>> test_data
  `tel` varchar(255) NOT NULL COMMENT '電話番号',
  `mail` varchar(255) NOT NULL COMMENT 'メールアドレス',
  `birthday` date NOT NULL COMMENT '生年月日',
  `penalty` int DEFAULT 0 COMMENT 'ペナルティ回数',
  `del_flg` boolean NOT NULL DEFAULT false COMMENT '削除フラグ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='顧客';

CREATE TABLE `card` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `person_id` int NOT NULL COMMENT '顧客ID',
  `number` varchar(255) NOT NULL COMMENT 'カード番号',
  `expiration_date` date NOT NULL COMMENT '有効期限',
  `security_code` int NOT NULL COMMENT 'セキュリティコード'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='カード';

CREATE TABLE `listing` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `car_id` int NOT NULL COMMENT '車両ID',
  `start_price` int NOT NULL COMMENT '開始価格',
  `date` datetime NOT NULL COMMENT '出品日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='出品';

CREATE TABLE `bid` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `listing_id` int NOT NULL COMMENT '出品ID',
  `person_id` int NOT NULL COMMENT '顧客ID',
  `price` int NOT NULL COMMENT '入札価格',
  `date` datetime NOT NULL COMMENT '入札日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='入札';

CREATE TABLE `buy` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `bid_id` int NOT NULL COMMENT '入札ID',
  `memo` varchar(255) NOT NULL COMMENT '取引メモ',
  `date` datetime NOT NULL COMMENT '取引日時',
  `status` ENUM ('取引中', '取引終了') NOT NULL DEFAULT '取引中' COMMENT '取引状態',
  `penalty` int DEFAULT 0 COMMENT 'ペナルティ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='落札';

CREATE TABLE `car` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '車両名',
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
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `purchase_price` int NOT NULL COMMENT '仕入価格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='仕入管理';

ALTER TABLE `bid` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);

ALTER TABLE `bid` ADD FOREIGN KEY (`person_id`) REFERENCES `customer` (`id`);

-- ALTER TABLE `bid` ADD FOREIGN KEY (`id`) REFERENCES `buy` (`bid_id`);
ALTER TABLE `buy` ADD FOREIGN KEY (`bid_id`) REFERENCES `bid` (`id`);

-- ALTER TABLE `car` ADD FOREIGN KEY (`id`) REFERENCES `listing` (`car_id`);
ALTER TABLE `listing` ADD FOREIGN KEY (`car_id`) REFERENCES `car` (`id`);

-- ALTER TABLE `car` ADD FOREIGN KEY (`id`) REFERENCES `purchase` (`car_id`);
ALTER TABLE `purchase` ADD FOREIGN KEY (`car_id`) REFERENCES `car` (`id`);

ALTER TABLE `purchase` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

ALTER TABLE `card` ADD FOREIGN KEY (`person_id`) REFERENCES `customer` (`id`);
