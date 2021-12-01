CREATE DATABASE IF NOT EXISTS `ih31_halmotors` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ih31_halmotors`;

CREATE TABLE `companies` (
  `company_id` int PRIMARY KEY AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `company_date` date NOT NULL
);

CREATE TABLE `employees` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` char(30) NOT NULL,
  `del_flg` boolean NOT NULL DEFAULT false
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

CREATE TABLE `customer` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` char(30) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `address3` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `credit_card` varchar(255),
  `birthday` date NOT NULL,
  `penalty` int DEFAULT 0,
  `del_flg` boolean NOT NULL DEFAULT false
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

CREATE TABLE `corporation` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` char(30) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `address3` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `credit_card` varchar(255),
  `penalty` int DEFAULT 0,
  `del_flg` boolean NOT NULL DEFAULT false
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

CREATE TABLE `listing` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `car_id` int NOT NULL,
  `start_price` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

CREATE TABLE `bid` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `listing_id` int,
  `person_id` int,
  `person_category` ENUM ('customer', 'corporation') NOT NULL,
  `price` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

CREATE TABLE `buy` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `bid_id` int,
  `memo` varchar(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

CREATE TABLE `car` (
  `id` int PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `evaluation` varchar(255),
  `outer_evaluation` varchar(255),
  `inner_evaluation` varchar(255),
  `model_year` date,
  `door` int,
  `shape` varchar(255),
  `grade` varchar(255),
  `history` int,
  `model` varchar(255),
  `engine_size` int,
  `fuel_type` ENUM ('レギュラー', 'ハイオク', '軽油'),
  `inspection_day` date,
  `mileage` int,
  `outer_color` ENUM ('ホワイト', 'レッド', 'ブラック', 'イエロー', 'ブルー', 'グリーン', 'ブラウン', 'ツートン', 'シルバー'),
  `inner_color` ENUM ('ホワイト', 'レッド', 'ブラック', 'イエロー', 'ブルー', 'グリーン', 'ブラウン', 'ツートン', 'シルバー'),
  `color_number` varchar(255),
  `identifier` varchar(255),
  `shift_type` ENUM ('フロア', 'コラム', 'インパネ'),
  `gear_type` varchar(255),
  `ac_type` ENUM ('WAC', 'AAC', 'AC', 'C', '無'),
  `ps` boolean DEFAULT false,
  `pw` boolean DEFAULT false,
  `aw` boolean DEFAULT false,
  `sr` boolean DEFAULT false,
  `tire` boolean DEFAULT false,
  `leather_sheet` boolean DEFAULT false,
  `ab` boolean DEFAULT false,
  `tv` boolean DEFAULT false,
  `navi` boolean DEFAULT false,
  `rear_spo` boolean DEFAULT false,
  `manual` boolean DEFAULT false,
  `warranty` boolean DEFAULT false,
  `other_option` longtext,
  `information` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

CREATE TABLE `purchase` (
  `car_id` int PRIMARY KEY AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `purchase_price` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4, COLLATE=utf8mb4_general_ci;

ALTER TABLE `bid` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);

ALTER TABLE `bid` ADD FOREIGN KEY (`person_id`) REFERENCES `customer` (`id`);

ALTER TABLE `bid` ADD FOREIGN KEY (`person_id`) REFERENCES `corporation` (`id`);

-- ALTER TABLE `bid` ADD FOREIGN KEY (`id`) REFERENCES `buy` (`bid_id`);
ALTER TABLE `buy` ADD FOREIGN KEY (`bid_id`) REFERENCES `bid` (`id`);

-- ALTER TABLE `car` ADD FOREIGN KEY (`id`) REFERENCES `listing` (`car_id`);
ALTER TABLE `listing` ADD FOREIGN KEY (`car_id`) REFERENCES `car` (`id`);

-- ALTER TABLE `car` ADD FOREIGN KEY (`id`) REFERENCES `purchase` (`car_id`);
ALTER TABLE `purchase` ADD FOREIGN KEY (`car_id`) REFERENCES `car` (`id`);

ALTER TABLE `purchase` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);
