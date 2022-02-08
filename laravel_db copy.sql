/*
 Navicat Premium Data Transfer

 Source Server         : datn
 Source Server Type    : MySQL
 Source Server Version : 100512
 Source Host           : 157.245.144.89:3306
 Source Schema         : laravel_db

 Target Server Type    : MySQL
 Target Server Version : 100512
 File Encoding         : 65001

 Date: 02/01/2022 20:00:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_levels
-- ----------------------------
DROP TABLE IF EXISTS `account_levels`;
CREATE TABLE `account_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `course_number` int(11) NOT NULL,
  `user_number` int(11) NOT NULL,
  `is_mutable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of account_levels
-- ----------------------------
BEGIN;
INSERT INTO `account_levels` VALUES (1, 'Người dùng mới', 'https://png.pngtree.com/png-vector/20191027/ourlarge/pngtree-bronze-medal-vector-bronze-copper-3rd-place-badge-sport-game-bronze-png-image_1887552.jpg', 'Người dùng mới', 'Inactive', 5, 0, 2, '2021-10-20 23:18:28', '2021-12-13 23:28:58');
INSERT INTO `account_levels` VALUES (2, 'Cấp độ đồng', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fcu.png?alt=media&token=38220e6b-b360-44fa-9483-a4f30737cf22', 'Cấp độ.đồng cho pt', 'Inactive', 7, 7, 2, '2021-10-20 23:18:28', '2021-12-13 23:30:16');
INSERT INTO `account_levels` VALUES (3, 'Cấp độ bạc', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fga.jpeg?alt=media&token=afa6f248-5918-4256-b976-59e8a375013e', 'Cấp độ bạc cho PT', 'Inactive', 9, 9, 2, '2021-10-20 23:18:28', '2021-12-13 23:31:45');
INSERT INTO `account_levels` VALUES (4, 'Cấp độ vàng', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fvang1.jpg?alt=media&token=11b7c756-d28b-48f2-b6a5-f40e5c20688d', 'Cấp độ vàng cho PT', 'Inactive', 12, 12, 2, '2021-10-20 23:18:28', '2021-12-13 23:34:19');
INSERT INTO `account_levels` VALUES (5, 'Cấp độ kim cương', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fimages.jpeg?alt=media&token=32f81a41-2a34-40c7-8753-4e9f33d6279c', 'Cấp độ kim cương cho PT', 'Inactive', 15, 15, 2, '2021-10-20 23:18:28', '2021-12-13 23:36:24');
COMMIT;

-- ----------------------------
-- Table structure for bill_personal_trainers
-- ----------------------------
DROP TABLE IF EXISTS `bill_personal_trainers`;
CREATE TABLE `bill_personal_trainers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code_bill` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `money` float NOT NULL,
  `money_old` float DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'anh chung minh da chuyen tien',
  `course_student_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT 'id cua PT',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of bill_personal_trainers
-- ----------------------------
BEGIN;
INSERT INTO `bill_personal_trainers` VALUES (35, '202112230443481', '2021-12-23 04:43:48', 566100, 629000, 'Đã thanh toán cho PT', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fhihihihi1.jpeg?alt=media&token=c4abc233-7455-42b3-8282-a72012ed9e6b', 117, 2, '2021-12-23 04:43:48', '2021-12-23 04:43:48');
COMMIT;

-- ----------------------------
-- Table structure for bills
-- ----------------------------
DROP TABLE IF EXISTS `bills`;
CREATE TABLE `bills` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code_bill` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `money` float NOT NULL,
  `status` enum('Wallet','Direct') COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of bills
-- ----------------------------
BEGIN;
INSERT INTO `bills` VALUES (22, '202112230338204', '2021-12-23 03:39:21', 699000, 'Direct', 21, 4, '2021-12-23 03:39:21', '2021-12-23 03:39:21');
INSERT INTO `bills` VALUES (23, '202112230425394', '2021-12-23 04:27:15', 799000, 'Direct', 1, 4, '2021-12-23 04:27:15', '2021-12-23 04:27:15');
INSERT INTO `bills` VALUES (24, '202112230432284', '2021-12-23 04:33:00', 299000, 'Direct', 14, 4, '2021-12-23 04:33:00', '2021-12-23 04:33:00');
INSERT INTO `bills` VALUES (25, '202112230439044', '2021-12-23 04:39:27', 629000, 'Direct', 12, 4, '2021-12-23 04:39:27', '2021-12-23 04:39:27');
INSERT INTO `bills` VALUES (26, '202112230825054', '2021-12-23 08:26:18', 699000, 'Direct', 21, 4, '2021-12-23 08:26:18', '2021-12-23 08:26:18');
COMMIT;

-- ----------------------------
-- Table structure for certificates
-- ----------------------------
DROP TABLE IF EXISTS `certificates`;
CREATE TABLE `certificates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `specialize_detail_id` bigint(20) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of certificates
-- ----------------------------
BEGIN;
INSERT INTO `certificates` VALUES (1, 'dlvFKiTQBeufGRNz', 'C2FhYn4sEvyQfBmS', 0, NULL, '2021-10-05 22:43:07', '2021-10-08 19:52:20', 'Active');
INSERT INTO `certificates` VALUES (2, 'HgbEoHtCqxSxXyZH', 'r6hA9uw2uMiB1noV', 1, '2021-10-13 21:45:52', '2021-10-05 22:43:07', '2021-10-13 21:45:52', 'Active');
INSERT INTO `certificates` VALUES (3, 'Computer1', '189 An Trai Hoài Đức Hà Nội', 3, '2021-11-12 13:59:36', '2021-10-05 22:43:07', '2021-11-12 13:59:36', 'Active');
INSERT INTO `certificates` VALUES (4, 'Cq3KH9eEbMkah4g6', 'OsPc0d0vpZwNAXHt', 3, '2021-11-12 13:59:31', '2021-10-05 22:43:07', '2021-11-12 13:59:31', 'Active');
INSERT INTO `certificates` VALUES (5, 'Chứng chỉ dancer', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639415647156_ch%E1%BB%A9ng%20ch%E1%BB%89.jpg?alt=media&token=17cfa5c2-42f4-4747-b92a-6977d0c28330', 4, '2021-12-22 16:38:24', '2021-10-05 22:43:07', '2021-12-22 16:38:24', 'Active');
INSERT INTO `certificates` VALUES (6, 't80CRXPoAMj2Tc2o', 'lwii3iegY0H2iWo8', 5, '2021-12-20 21:26:05', '2021-10-05 22:43:07', '2021-12-20 21:26:05', 'Active');
INSERT INTO `certificates` VALUES (7, 'WIw0qjUVwRPHiBBt', '9okR4s27vZ0sjsVn', 6, '2021-12-20 21:25:52', '2021-10-05 22:43:07', '2021-12-20 21:25:52', 'Active');
INSERT INTO `certificates` VALUES (8, 'SPRT7Hs3OGeBjpHE', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640112003008_S3new.drawio.png?alt=media&token=45491e4e-01a5-4598-a717-edacd09a6b16', 7, '2021-12-22 01:43:44', '2021-10-05 22:43:07', '2021-12-22 01:43:44', 'Active');
INSERT INTO `certificates` VALUES (9, 'myXbTlJcHfY7z8sF', 'zpJrKHGL0KETtIcz', 8, '2021-10-10 10:44:04', '2021-10-05 22:43:07', '2021-10-10 10:44:04', 'Active');
INSERT INTO `certificates` VALUES (10, 'Y4HYOxUcyQJG2yFO', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2F1fb75494a1bea9044535ea21cb09a961.jpg?alt=media&token=aa33054d-d0f3-48c8-9017-b84806c3733d', 9, '2021-10-24 11:05:35', '2021-10-05 22:43:08', '2021-10-24 11:05:35', 'Active');
INSERT INTO `certificates` VALUES (11, 'Chung chi new1', 'Anh so new1', 4, '2021-10-10 10:44:02', '2021-10-05 23:47:57', '2021-10-10 10:44:02', 'Active');
INSERT INTO `certificates` VALUES (12, 'address', '189 An Trai Hoài Đức Hà Nội', 1, '2021-10-13 21:45:53', '2021-10-05 23:52:00', '2021-10-13 21:45:53', 'Active');
INSERT INTO `certificates` VALUES (13, 'Gloves', '189 An Trai Hoài Đức Hà Nội', 3, '2021-11-12 13:59:33', '2021-10-06 00:11:47', '2021-11-12 13:59:33', 'Active');
INSERT INTO `certificates` VALUES (14, 'Tuna', '189 An Trai Hoài Đức Hà Nội', 3, '2021-11-12 13:59:35', '2021-10-06 00:42:26', '2021-11-12 13:59:35', 'Active');
INSERT INTO `certificates` VALUES (15, 'chứng chỉ đề', 'ađâsđâs', 12, '2021-10-12 20:25:21', '2021-10-11 20:25:08', '2021-10-12 20:25:21', 'Active');
INSERT INTO `certificates` VALUES (16, 'chứng chỉ đề 2', 'ađâsđâs21', 12, '2021-10-12 20:25:23', '2021-10-11 21:23:50', '2021-10-12 20:25:23', 'Active');
INSERT INTO `certificates` VALUES (17, 'demo edit1', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FHoodie%20Guy%20In%20City%20-%20IPhone%20Wallpapers.jpg?alt=media&token=9e3e4066-cffa-4048-9eec-a6ce99932394', 12, '2021-10-13 22:00:13', '2021-10-11 23:19:11', '2021-10-13 22:00:13', 'Active');
INSERT INTO `certificates` VALUES (18, 'vietanhhda', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FWallpapers%20_%20ROG%20-%20Republic%20of%20Gamers%20Global.png?alt=media&token=8614cf51-2f24-42c8-afb3-01e75bb15ba1', 12, '2021-10-13 22:01:50', '2021-10-11 23:23:08', '2021-10-13 22:01:50', 'Active');
INSERT INTO `certificates` VALUES (19, 'demoo21', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FJoker%20Cyberpunk%20Wallpapers%20_%20hdqwalls_com.jpg?alt=media&token=b8d4214e-1380-4edf-9581-18d232ab67dd', 12, '2021-10-11 23:39:07', '2021-10-11 23:27:05', '2021-10-11 23:39:07', 'Active');
INSERT INTO `certificates` VALUES (20, 'heloo', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FJoker%20Cyberpunk%20Wallpapers%20_%20hdqwalls_com.jpg?alt=media&token=b476aa82-9f39-4f06-bfc5-0f20ba902cc6', 12, '2021-10-11 23:39:04', '2021-10-11 23:29:26', '2021-10-11 23:39:04', 'Active');
INSERT INTO `certificates` VALUES (21, 'chứng chỉ nè', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FWallpapers%20_%20ROG%20-%20Republic%20of%20Gamers%20Global.png?alt=media&token=86da543f-9748-466f-8fc1-ecdf89bbe14f', 9, '2021-10-24 11:05:37', '2021-10-11 23:33:26', '2021-10-24 11:05:37', 'Active');
INSERT INTO `certificates` VALUES (22, 'test', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FJoker%20Cyberpunk%20Wallpapers%20_%20hdqwalls_com.jpg?alt=media&token=6fa53ea8-fb67-4b82-9b73-188353691c7c', 12, '2021-10-13 16:52:23', '2021-10-12 20:25:03', '2021-10-13 16:52:23', 'Active');
INSERT INTO `certificates` VALUES (23, 'demo 1', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FJoker%20Cyberpunk%20Wallpapers%20_%20hdqwalls_com.jpg?alt=media&token=c10e8f30-10ae-430f-965a-fbff1809788e', 12, '2021-10-13 16:52:22', '2021-10-12 20:47:57', '2021-10-13 16:52:22', 'Active');
INSERT INTO `certificates` VALUES (24, 'vietanhhda1', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FJoker%20Cyberpunk%20Wallpapers%20_%20hdqwalls_com.jpg?alt=media&token=f382ecb7-c277-4656-992e-0a8d9d7c5261', 12, '2021-10-13 16:52:17', '2021-10-13 16:20:49', '2021-10-13 16:52:17', 'Active');
INSERT INTO `certificates` VALUES (25, 'heloo2121', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FTigre%20De%20Feu.jpg?alt=media&token=4c99c883-5c93-4959-b7a4-fb8a633578c0', 12, '2021-10-14 00:00:59', '2021-10-13 17:01:06', '2021-10-14 00:00:59', 'Active');
INSERT INTO `certificates` VALUES (26, 'heloo8', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2F0cf195d6e64e344baddadf04fe6ed2d1.jpg?alt=media&token=831616d2-a9a2-4d8a-9762-92f9a8003350', 12, '2021-10-24 11:03:50', '2021-10-13 17:03:29', '2021-10-24 11:03:50', 'Active');
INSERT INTO `certificates` VALUES (27, 'demo edit14534', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FFuture%20Mayhem%20____.jfif?alt=media&token=39b6a4b0-ce66-4025-928f-8b76df7199c0', 12, '2021-10-14 16:27:49', '2021-10-13 22:00:27', '2021-10-14 16:27:49', 'Active');
INSERT INTO `certificates` VALUES (28, 'heloo2121121', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2F24ae5b585566da217deadd39db544e94.jpg?alt=media&token=21a53c79-beb9-4fa0-8fd3-faffb7c6d5ef', 12, '2021-10-14 00:10:12', '2021-10-14 00:01:09', '2021-10-14 00:10:12', 'Active');
INSERT INTO `certificates` VALUES (29, 'heloo2121211333', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FTigre%20De%20Feu.jpg?alt=media&token=4c99c883-5c93-4959-b7a4-fb8a633578c0', 3, '2021-12-14 00:12:39', '2021-10-24 18:21:05', '2021-12-14 00:12:39', 'Active');
INSERT INTO `certificates` VALUES (30, '21214234231312', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FJoker%20Cyberpunk%20Wallpapers%20_%20hdqwalls_com.jpg?alt=media&token=50bbf1d0-ab94-430d-9ed9-0871c949567e', 3, '2021-11-28 21:19:20', '2021-10-24 18:21:53', '2021-11-28 21:19:20', 'Active');
INSERT INTO `certificates` VALUES (31, 'heloo2121fghj', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FTigre%20De%20Feu.jpg?alt=media&token=4c99c883-5c93-4959-b7a4-fb8a633578c0', 12, '2021-12-23 00:30:44', '2021-11-02 23:20:53', '2021-12-23 00:30:44', 'Active');
INSERT INTO `certificates` VALUES (32, 'heloo21216576fghj1', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FTigre%20De%20Feu.jpg?alt=media&token=4c99c883-5c93-4959-b7a4-fb8a633578c0', 54, NULL, '2021-11-03 00:04:33', '2021-11-17 20:08:17', 'Active');
INSERT INTO `certificates` VALUES (33, '@#', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2FDoc1.docx?alt=media&token=52361de8-926d-4967-bf01-7fe018a3ca44', 56, '2021-12-07 14:55:28', '2021-11-07 01:02:51', '2021-12-07 14:55:28', 'Active');
INSERT INTO `certificates` VALUES (34, 'boxing', 'https://firebasestorage.googleapis.com/v0/b/datn-d7675.appspot.com/o/images%2F%E1%BA%A3nh.jpg?alt=media&token=1217b60d-c86e-4303-930b-8f8301daf94f', 56, NULL, '2021-11-07 15:00:43', '2021-11-07 15:00:43', 'Active');
INSERT INTO `certificates` VALUES (35, 'vietanhhda1', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1637992152717_240601734_4304514383000616_5092634091706020254_n.jpg?alt=media&token=79423af3-3b4f-46bc-9312-37b1bbdf213d', 61, NULL, '2021-11-27 12:24:54', '2021-11-27 12:49:14', 'Active');
INSERT INTO `certificates` VALUES (36, 'Chứng chỉ tin học văn phòng', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1638123584456_Screenshot%202021-11-19%20at%2000.54.24.png?alt=media&token=a0e7dd3c-0299-423a-bd0c-ee0a9e1003ea', 59, NULL, '2021-11-29 01:19:46', '2021-12-05 01:51:05', 'Active');
INSERT INTO `certificates` VALUES (37, 'Chứng chỉ tiếng anh itels 8.0', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1638643884193_Screenshot%202021-11-21%20at%2023.22.56.png?alt=media&token=3f0754e0-4a14-4410-9e00-0ae15918bf4c', 59, NULL, '2021-12-05 01:51:25', '2021-12-05 01:51:25', 'Active');
INSERT INTO `certificates` VALUES (38, 'Chứng chỉ tiếng nhật', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1638644409508_Screenshot%202021-11-19%20at%2000.45.53.png?alt=media&token=625823d1-8d1f-4cf9-8970-226595085fdb', 59, NULL, '2021-12-05 02:00:10', '2021-12-05 02:00:10', 'Active');
INSERT INTO `certificates` VALUES (39, 'Chứng chỉ gymer', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639415698579_gym.jpg?alt=media&token=c296868d-8106-4cd3-bdaf-222605d389c7', 1, NULL, '2021-12-14 00:15:06', '2021-12-14 00:15:06', 'Active');
INSERT INTO `certificates` VALUES (40, 'Chứng chỉ boxing hạng nặng', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639415757551_daiboxxing.jpeg?alt=media&token=8b1e5698-2857-456f-9344-2a8cb1f2b715', 2, NULL, '2021-12-14 00:16:00', '2021-12-14 00:16:00', 'Active');
INSERT INTO `certificates` VALUES (41, '12121', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639753418656_wallpaperflare.com_wallpaper%20(2).jpg?alt=media&token=b5be46c4-24ad-4f22-ae0f-3a0712e5e747', 4, '2021-12-17 22:03:46', '2021-12-17 22:03:40', '2021-12-17 22:03:46', 'Active');
INSERT INTO `certificates` VALUES (42, 'gym', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640020785436_Screenshot_58.png?alt=media&token=72737336-f3e1-40dd-ba4d-2c5fc7e8e9c4', 8, NULL, '2021-12-21 00:19:48', '2021-12-21 00:19:48', 'Active');
INSERT INTO `certificates` VALUES (43, 'đấm bốc', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640020821185_Screenshot_58.png?alt=media&token=4cbaa17f-4d59-4297-b3ee-c4a98096f507', 8, NULL, '2021-12-21 00:20:24', '2021-12-21 00:20:24', 'Active');
INSERT INTO `certificates` VALUES (44, 'Ăn uống', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640021754097_Screenshot_59.png?alt=media&token=3fe0a34a-2c9f-4f9b-8a53-7c578c8a1f2f', 9, NULL, '2021-12-21 00:35:57', '2021-12-21 00:35:57', 'Active');
INSERT INTO `certificates` VALUES (45, 'Chứng chỉ boxing', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640112054733_locay.png?alt=media&token=781dd603-0943-4005-a4fa-1ebcd37ebff6', 7, NULL, '2021-12-22 01:41:08', '2021-12-22 01:41:08', 'Active');
INSERT INTO `certificates` VALUES (46, 'Chứng chỉ dancer', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640164554744_chung-chi-dancer.jpg?alt=media&token=84967c2c-e442-48cd-b98d-0e53ffd3daca', 10, NULL, '2021-12-22 16:15:56', '2021-12-22 16:15:56', 'Active');
INSERT INTO `certificates` VALUES (47, 'CPT', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640166319080_Screenshot_58.png?alt=media&token=1e64c512-69f0-4d89-9f84-22336cf59f7b', 11, NULL, '2021-12-22 16:45:21', '2021-12-22 16:45:21', 'Active');
COMMIT;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_course` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_stars` int(11) NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of comments
-- ----------------------------
BEGIN;
INSERT INTO `comments` VALUES (26, 12, 4, 'Thầy giáo dạy rất là tốt và nhiệt tình.', 4, 'Active', '2021-12-23 06:56:34', '2021-12-29 10:22:18');
COMMIT;

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Process','Processed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Process',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of contacts
-- ----------------------------
BEGIN;
INSERT INTO `contacts` VALUES (33, 'Hoàng Quốc Bảo Việt', '0355755697', 'hoangviet10072011@gmail.com', 'Chúng tối muốn liên hệ với website', 'Chúng tối muốn liên hệ với website', 'Process', '2021-12-22 20:38:59', '2021-12-22 20:38:59');
INSERT INTO `contacts` VALUES (34, 'test', '0355251555', 'maiduongthanhphuong2002@gmail.com', 'Test', 'd', 'Process', '2021-12-23 01:38:29', '2021-12-23 01:38:29');
COMMIT;

-- ----------------------------
-- Table structure for course_planes
-- ----------------------------
DROP TABLE IF EXISTS `course_planes`;
CREATE TABLE `course_planes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `descreption` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stage_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `type` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of course_planes
-- ----------------------------
BEGIN;
INSERT INTO `course_planes` VALUES (121, 'Buổi học 1: Boxing là gì? Những kĩ thuật cơ bản trong boxing.', '<p>Khi tập Boxing, phần quan trọng nhất của võ thuật này chính là việc sử dụng đôi tay, đôi chân và thân người phải kết hợp ăn ý. Các động tác di chuyển, né đòn, phản công trong khi thi đấu Boxing sẽ là những yếu tố tạo nên sự hiệu quả, thành công trong các trận đấu. Điểm yếu để tấn công trong Boxing chính là mặt và bụng. Tại các trận thi đấu Boxing chuyên nghiệp, bạn có thể đấm bất kỳ các vị trí nào để khiến đối phương gục xuống là bạn chiến thắng.</p><p>Ngoài việc luôn chủ động thực hiện các cú đấm vào điểm yếu của đối phương, bạn cần che chắn các điểm dễ gây chấn thương trên cơ thể mình trong suốt quá trình thi đấu Boxing. Đây là kinh nghiệm quý báu của các vận động viên thi đấu Boxing chuyên nghiệp chia sẻ cho các bạn Boxer mới. Bạn cần thực hiện các cú đấm trong Boxing thật chuẩn xác bằng cách tính toán kỹ lưỡng trước khi tung ra, sao cho đường đi của nó đến với đối thủ ngắn nhất và có sự kết hợp độ xoáy của các múi cơ nhằm phát huy được sức mạnh các đòn đấm mạnh mẽ nhất.</p>', '<p>Khi tập Boxing, phần quan trọng nhất của võ thuật này chính là việc sử dụng đôi tay, đôi chân và thân người phải kết hợp ăn ý. Các động tác di chuyển, né đòn, phản công trong khi thi đấu Boxing sẽ là những yếu tố tạo nên sự hiệu quả, thành công trong các trận đấu. Điểm yếu để tấn công trong Boxing chính là mặt và bụng. Tại các trận thi đấu Boxing chuyên nghiệp, bạn có thể đấm bất kỳ các vị trí nào để khiến đối phương gục xuống là bạn chiến thắng.</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203610316_download%20%281%29.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639418690540_150071141449867-thuytop1.jpg?alt=media&token=9e9e67f9-2040-494d-b3a3-ef021867acb6', 1, '2021-12-14 01:06:28', '2021-12-23 03:06:52', 'Active', 1);
INSERT INTO `course_planes` VALUES (122, 'Buổi 2: Gặp gỡ PT, training ăn uống và chế độ tập luyện', '<p>Gặp gỡ PT, training ăn uống và chế độ tập luyện</p>', '<p>Gặp gỡ PT, training ăn uống và chế độ tập luyện</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1639419719577_img_9764.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639471793833_che-do-an-cho-nu-tap-gym-du-dinh-duong3.jpg?alt=media&token=aa661202-04ab-4512-9d76-e3d43359e84a', 1, '2021-12-14 01:22:18', '2021-12-14 15:50:00', 'Active', 0);
INSERT INTO `course_planes` VALUES (125, 'Buổi học 3: Kĩ thuật tự vệ trong Boxing', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(101,101,101);\">Ở cách đỡ đòn này thì khuỷu tay, cẳng tay và găng tay ép lại với nhau, tạo thành một bức tường phòng thủ vững chắc, tạo cho bạn cảm giác an toàn. Nhưng nó lại khiến cho tầm nhìn của bạn bị hạn chế. Bạn khó có thể quan sát được đối thủ và thậm chí bạn có thể bị tấn công bất ngờ khi rào chắn kia được tháo xuống.</span></p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(101,101,101);\">Ở cách đỡ đòn này thì khuỷu tay, cẳng tay và găng tay ép lại với nhau, tạo thành một bức tường phòng thủ vững chắc, tạo cho bạn cảm giác an toàn. Nhưng nó lại khiến cho tầm nhìn của bạn bị hạn chế. Bạn khó có thể quan sát được đối thủ và thậm chí bạn có thể bị tấn công bất ngờ khi rào chắn kia được tháo xuống.</span></p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203599188_download%20%283%29.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639486551016_boxing.jpg?alt=media&token=4a69aa03-10e2-42a5-a736-7b60ffb07d61', 2, '2021-12-14 19:56:49', '2021-12-23 03:06:41', 'Active', 1);
INSERT INTO `course_planes` VALUES (126, 'Buổi học 4: Kĩ thuật tấn công trong Boxing', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(101,101,101);\">Giữ thế phòng thủ bị động sẽ làm cho đối phương dễ dàng tìm ra sơ hở và nhân cơ hội đó để tấn công bạn. Nó cũng khiến bạn trở nên mệt mỏi hơn vì bạn phải chống lại sức mạnh của các cú đấm từ phía đối phương.</span></p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(101,101,101);\">Giữ thế phòng thủ bị động sẽ làm cho đối phương dễ dàng tìm ra sơ hở và nhân cơ hội đó để tấn công bạn. Nó cũng khiến bạn trở nên mệt mỏi hơn vì bạn phải chống lại sức mạnh của các cú đấm từ phía đối phương.</span></p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203585869_download%20%282%29.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639488236692_boxing.jpg?alt=media&token=54a20dac-dddb-47ee-a03b-356ed4d9329f', 2, '2021-12-14 20:24:13', '2021-12-23 03:06:27', 'Active', 1);
INSERT INTO `course_planes` VALUES (127, 'Buổi học 5: Bổ túc kĩ thuật nâng cao', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(46,46,46);\">Một cú đấm móc có thể thực hiện bằng cả hai tay, nhưng bạn nên tập trung luyện nó ở tay thuận. Đúng như tên gọi của nó cú đấm này nhằm vào vị trí bên hông của đối thủ. Cú đấm được thực hiện như một cú Cross với lực phát ra từ chân và thân trên. Nhưng khi truyền lực lên tay thay vì đấm thẳng cú đấm sẽ được móc qua bên hông đối thủ. Lưu ý đừng để khuỷu tay rộng hơn vai hãy để khoảng hẹp để lực phát ra mạnh hơn.</span></p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(46,46,46);\">Một cú đấm móc có thể thực hiện bằng cả hai tay, nhưng bạn nên tập trung luyện nó ở tay thuận. Đúng như tên gọi của nó cú đấm này nhằm vào vị trí bên hông của đối thủ. Cú đấm được thực hiện như một cú Cross với lực phát ra từ chân và thân trên. Nhưng khi truyền lực lên tay thay vì đấm thẳng cú đấm sẽ được móc qua bên hông đối thủ. Lưu ý đừng để khuỷu tay rộng hơn vai hãy để khoảng hẹp để lực phát ra mạnh hơn.</span></p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203339630_download%20%281%29.mp4', 'https://file.hstatic.net/1000185761/file/cach_giam_can_nhanh_grande.jpg', 3, '2021-12-14 20:27:43', '2021-12-23 03:02:21', 'Active', 1);
INSERT INTO `course_planes` VALUES (143, 'Buổi học 5: Bổ túc kĩ thuật nâng cao', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(46,46,46);\">Một cú đấm móc có thể thực hiện bằng cả hai tay, nhưng bạn nên tập trung luyện nó ở tay thuận. Đúng như tên gọi của nó cú đấm này nhằm vào vị trí bên hông của đối thủ. Cú đấm được thực hiện như một cú Cross với lực phát ra từ chân và thân trên. Nhưng khi truyền lực lên tay thay vì đấm thẳng cú đấm sẽ được móc qua bên hông đối thủ. Lưu ý đừng để khuỷu tay rộng hơn vai hãy để khoảng hẹp để lực phát ra mạnh hơn.</span></p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(46,46,46);\">Một cú đấm móc có thể thực hiện bằng cả hai tay, nhưng bạn nên tập trung luyện nó ở tay thuận. Đúng như tên gọi của nó cú đấm này nhằm vào vị trí bên hông của đối thủ. Cú đấm được thực hiện như một cú Cross với lực phát ra từ chân và thân trên. Nhưng khi truyền lực lên tay thay vì đấm thẳng cú đấm sẽ được móc qua bên hông đối thủ. Lưu ý đừng để khuỷu tay rộng hơn vai hãy để khoảng hẹp để lực phát ra mạnh hơn.</span></p>', '', 'https://file.hstatic.net/1000185761/file/cach_giam_can_nhanh_grande.jpg', 2, '2021-12-22 00:19:07', '2021-12-22 00:50:25', 'Active', 0);
INSERT INTO `course_planes` VALUES (144, 'Buổi học 5: Bổ túc kĩ thuật nâng cao tesst', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(46,46,46);\">Một cú đấm móc có thể thực hiện bằng cả hai tay, nhưng bạn nên tập trung luyện nó ở tay thuận. Đúng như tên gọi của nó cú đấm này nhằm vào vị trí bên hông của đối thủ. Cú đấm được thực hiện như một cú Cross với lực phát ra từ chân và thân trên. Nhưng khi truyền lực lên tay thay vì đấm thẳng cú đấm sẽ được móc qua bên hông đối thủ. Lưu ý đừng để khuỷu tay rộng hơn vai hãy để khoảng hẹp để lực phát ra mạnh hơn.</span></p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(46,46,46);\">Một cú đấm móc có thể thực hiện bằng cả hai tay, nhưng bạn nên tập trung luyện nó ở tay thuận. Đúng như tên gọi của nó cú đấm này nhằm vào vị trí bên hông của đối thủ. Cú đấm được thực hiện như một cú Cross với lực phát ra từ chân và thân trên. Nhưng khi truyền lực lên tay thay vì đấm thẳng cú đấm sẽ được móc qua bên hông đối thủ. Lưu ý đừng để khuỷu tay rộng hơn vai hãy để khoảng hẹp để lực phát ra mạnh hơn.</span></p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203574671_download%20%281%29.mp4', 'https://file.hstatic.net/1000185761/file/cach_giam_can_nhanh_grande.jpg', 2, '2021-12-22 00:39:21', '2021-12-23 03:06:16', 'Active', 1);
INSERT INTO `course_planes` VALUES (145, 'Buổi học vỡ lòng dành học sinh lớp 1', '<p>Buổi học vỡ lòng</p>', '<p>Buổi học vỡ lòng</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1639488228486_%C4%91%E1%BB%A1+%C4%91%C3%B2n+-+blocking+trong+boxing+sao+cho+%C4%91%C3%BAng_.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640108341922_locay.png?alt=media&token=41d3149e-1afb-47e5-8841-badd1c177687', 21, '2021-12-22 00:39:33', '2021-12-22 00:42:32', 'Active', 1);
INSERT INTO `course_planes` VALUES (146, 'Sư Tử', '<p>Buổi học vỡ lòng</p>', '<p>Buổi học vỡ lòng</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640108411672_S3new.drawio.png?alt=media&token=47d21610-bd98-4fc4-965a-54db8bc1bd88', 21, '2021-12-22 00:40:22', '2021-12-22 02:27:49', 'Active', 0);
INSERT INTO `course_planes` VALUES (147, 'Buổi học làm quen với học viên', '<p>Buổi học 1 khóa học demo</p>', '<p>Buổi học 1 khóa học demo</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640114974634_locay.png?alt=media&token=7232bd9b-126d-4e7d-8530-90b30d8b46d0', 16, '2021-12-22 02:30:07', '2021-12-22 02:30:07', 'Active', 0);
INSERT INTO `course_planes` VALUES (148, 'Buổi 1 : Làm nóng cơ thể với các động tác Warm up', '<p>Khóa học Học nhảy Dance Cardio - Đốt cháy năng lượng mỗi ngày gồm những động tác từ cơ bản đến nâng cao, sau đó giảng viên sẽ hướng dẫn bạn ghép thành tổ hợp hoạt động liên hoàn trong một bài hát giúp đốt cháy năng lượng một cách hiệu quả nhất.</p>', '<p>Khóa học Học nhảy Dance Cardio - Đốt cháy năng lượng mỗi ngày gồm những động tác từ cơ bản đến nâng cao, sau đó giảng viên sẽ hướng dẫn bạn ghép thành tổ hợp hoạt động liên hoàn trong một bài hát giúp đốt cháy năng lượng một cách hiệu quả nhất.</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640167479524_59ff4f00d26284144565d5b591a380f3.jpg?alt=media&token=94f14de8-3079-4c77-9461-666e641e2db1', 24, '2021-12-22 17:06:28', '2021-12-22 17:12:17', 'Active', 0);
INSERT INTO `course_planes` VALUES (149, 'Buổi 1: Gặp gỡ PT và lên menu ăn dinh dưỡng', '<p>Buổi học đầu tiên, để hiểu nhau hơn PT và học viên sẽ có buổi đầu tiên để hiểu nhau hơn. Buổi học đầu tiên PT sẽ nói về quy trình học cũng như những quy luật học cho học viên. Điều quan trọng nhất PT sẽ lên menu ăn uống dinh dưỡng phù hợp cho học viên để dễ dàng cho những buổi học tiếp theo.</p>', '<p>Buổi học đầu tiên, để hiểu nhau hơn PT và học viên sẽ có buổi đầu tiên để hiểu nhau hơn. Buổi học đầu tiên PT sẽ nói về quy trình học cũng như những quy luật học cho học viên. Điều quan trọng nhất PT sẽ lên menu ăn uống dinh dưỡng phù hợp cho học viên để dễ dàng cho những buổi học tiếp theo.</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640167765307_hi4.jpeg?alt=media&token=a0d9e062-d25f-4047-a6e4-152a2ac6d1f3', 23, '2021-12-22 17:15:21', '2021-12-22 17:15:21', 'Active', 0);
INSERT INTO `course_planes` VALUES (150, 'Buổi học 3 : Làm quen với quá trình tập', '<p>Buổi học 3 : Làm quen với quá trình tập</p>', '<p><i>Buổi học 3 : Làm quen với quá trình tập</i></p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640169523792_blackpinkl.jpg?alt=media&token=b5501e77-decc-451e-99d7-9c666d8cab68', 24, '2021-12-22 17:18:39', '2021-12-22 17:38:47', 'Active', 0);
INSERT INTO `course_planes` VALUES (151, 'Buổi học 2: Những combo cho ngày mới năng động', '<p>Buổi học 2 học viên sẽ được học thông qua video, trong video PT sẽ có những hướng dẫn cụ thể từng động tác cho học viên và sẽ support học viên khi học viên không hiểu.</p>', '<p>Buổi học 2 học viên sẽ được học thông qua video, trong video PT sẽ có những hướng dẫn cụ thể từng động tác cho học viên và sẽ support học viên khi học viên không hiểu.</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203662331_download.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640168229925_hi4.jpeg?alt=media&token=e79aa57e-c751-441a-b6fc-af152a63934c', 23, '2021-12-22 17:18:42', '2021-12-23 03:07:43', 'Active', 1);
INSERT INTO `course_planes` VALUES (152, 'Cách tập gym hiệu quả dành cho phái mạnh từ trung tâm thể hình hàng đầu', '<p><strong>Cách tập gym hiệu quả</strong></p><p>&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-1024x558.jpg\" alt=\"\" srcset=\"https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-1024x558.jpg 1024w, https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-300x164.jpg 300w, https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-768x419.jpg 768w, https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua.jpg 1500w\" sizes=\"100vw\" width=\"1024\">Cách tập gym hiệu quả cùng Swequity</p><p>&nbsp;</p><p>Tập gym là cách hiệu quả nhất giúp anh em có được sức khỏe dồi dào cùng với thân hình săn chắc, vạm vỡ. Cách tập gym hiệu quả là tập trung vào rèn luyện 5 nhóm cơ chính sau theo một lịch tập khoa học:&nbsp;</p><p>Cơ ngực: Ngực trên, ngực giữa và ngực dưới (người mới tập không nên tập ngực dưới ngay).&nbsp;</p><p>Cơ tay: Gồm cẳng tay, bắp tay trước và tay sau&nbsp;</p><p>Cơ vai: Cơ cầu vai, cơ vai trước, vai sau và vai giữa.&nbsp;</p><p>Nhóm cơ lưng: Cơ xô, cơ lưng trên, lưng dưới và lưng giữa.&nbsp;</p><p>Cơ chân: Đùi trước, đùi sau, bắp chuối</p>', '<p><span style=\"background-color:rgb(246,246,246);color:rgb(122,122,122);\">Cơ thể khỏe mạnh, săn chắc, cơ bụng 6 múi thu hút mọi ánh nhìn từ phái nữ là điều tất cả các anh em đều mong muốn. Để có được điều này, bạn phải có một chế độ tập luyện và ăn uống hợp lý, khoa học. Trong bài viết này, Swequity.vn xin hướng dẫn bạn chế độ tập gym hiệu quả dành cho cả nam giới.&nbsp;</span></p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640168462432_%C4%91%E1%BB%A1+%C4%91%C3%B2n+-+blocking+trong+boxing+sao+cho+%C4%91%C3%BAng_.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640168480924_Screenshot_58.png?alt=media&token=0921e6ef-da67-4149-bfb0-43f5b2a2069d', 22, '2021-12-22 17:21:55', '2021-12-22 17:21:55', 'Active', 1);
INSERT INTO `course_planes` VALUES (153, 'Buổi 3: Buổi học bước vào giai đoạn combo tăng cường tim mạch', '<p>Buổi học 3 PT sẽ dậy học viên những &nbsp;combo thần thánh để tăng cường tim mạch và bước vào giai đoạn nước rút .</p>', '<p>Buổi học 3 PT sẽ dậy học viên những &nbsp;combo thần thánh để tăng cường tim mạch và bước vào giai đoạn nước rút .</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640168386078_hi4.jpeg?alt=media&token=99f209be-9b2b-4115-b880-aa957fb29aa0', 26, '2021-12-22 17:23:13', '2021-12-22 17:23:13', 'Active', 0);
INSERT INTO `course_planes` VALUES (154, 'Buổi học 4:  Hệ thống lại kiến thức', '<p>PT sẽ hệ thống lại kiến thức cho học viên và những lưu ý cho học viên nay cả khi khoá học kết thúc, PT vẫn support học viên nhiệt tình.</p>', '<p>PT sẽ hệ thống lại kiến thức cho học viên và những lưu ý cho học viên nay cả khi khoá học kết thúc, PT vẫn support học viên nhiệt tình.</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640168847459_hi4.jpeg?alt=media&token=eef4b3fd-1d0d-4190-b7ae-6c27ad241950', 27, '2021-12-22 17:29:10', '2021-12-22 17:29:10', 'Active', 0);
INSERT INTO `course_planes` VALUES (155, 'Chế độ ăn khi tập gym cho nam giới', '<p><strong>Chế độ ăn khi tập gym cho nam giới</strong></p><p>&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://swequity.vn/wp-content/uploads/elementor/thumbs/cach-tap-gym-hieu-qua-1-on304xixs0uzp9332fz10zjun9j2usf7xkhc1pcqa8.jpg\" alt=\"cach-tap-gym-hieu-qua-1\"></p><p>&nbsp;</p><p>Vấn đề bổ sung dinh dưỡng cho cơ thể có vai trò quyết định đến cách tập gym hiệu quả mà bạn đang áp dụng, để có body săn chắc anh em cần lưu ý những vấn đề sau trong chế độ ăn khi tập gym:&nbsp;</p><p>Trước khi tập: Bổ sung đồ ăn nhẹ để cung cấp năng lượng trong quá trình tập luyện như bánh mì, sữa, trứng, chuối, ngũ cốc, nước ép…&nbsp;</p><p>Trong khi tập cũng cần bổ sung năng lượng cho cơ thể nhé, uống đủ nước, từ 15 – 30 phút bạn nên bổ sung 350 ml nước để tránh không bị mệt mỏi và mất sức.&nbsp;</p><p>Bữa ăn sau tập có vai trò quan trọng trong việc phục hồi năng lượng đã mất. Thực phẩm bạn nên bổ sung gồm: Trứng, cá, thịt, tinh bột, ngũ cốc… Với anh em tập gym để tăng cân thì nên ăn nhiều thực phẩm giàu chất đạm và chất béo nhé.&nbsp;</p>', '<p>Mỗi người có 1 thể trạng, thể hình và sức chịu đựng riêng. Bởi vậy, anh em cần chọn lịch tập gym phù hợp với cơ thể mình, đảm bảo mang lại hiệu quả tốt nhất. Dưới đây là cách tập gym hiệu quả chia theo lịch tập các nhóm cơ:&nbsp;</p><p><i>Tập gym 3 buổi/ tuần (dành cho người bận rộn)</i></p><p>Buổi 1: Tập nhóm cơ kéo: tay trước, lưng, cẳng tay</p><p>Buổi 2: Tập nhóm cơ đẩy: tay sau, vai, ngực</p><p>Buổi 3: Tập chân, bắp chân, mông, bụng</p><p><i>Tập gym 4 buổi/ tuần</i></p><p>Buổi 1: Tập lưng , cẳng tay, tay trước</p><p>Buổi 2: Tập tay sau và ngực</p><p>Buổi 3: Tập chân, mông, bụng</p><p>Buổi 4: Tập vai, tay sau và bắp chân</p><p><i>Tập gym 5 buổi/ tuần</i></p><p>Buổi 1: Tập ngực</p><p>Buổi 2: Tập lưng, cẳng tay và tay trước&nbsp;</p><p>Buổi 3 : Tập vai, tay sau</p><p>Buổi 4: Tập Chân, bắp chân, mông, bụng</p><p>Buổi 5: Tập thêm các nhóm cơ cảm thấy còn nhỏ</p><p><i>Tập gym 6 buổi/tuần (dành cho những người muốn phát triển cơ bắp nhanh chóng)</i></p><p>Buổi 1: Tập nhóm cơ kéo gồm tay trước, lưng, cẳng tay</p><p>Buổi 2: Tập nhóm cơ đẩy: Vai, ngực, tay sau</p><p>Buổi 3: Tập chân, bắp chân, mông, bụng</p><p>Buổi 4: Tập nhóm cơ kéo gồm tay trước, lưng, cẳng tay</p><p>Buổi 5: Tập nhóm cơ đẩy: Vai, ngực, tay sau</p><p>Buổi 6: Tập chân, bắp chân, mông, bụng</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203194941_videoviet.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640169427468_Screenshot_58.png?alt=media&token=8ccaa906-2271-4f5b-b46a-3ad698d26ca3', 28, '2021-12-22 17:37:24', '2021-12-23 03:00:08', 'Active', 1);
INSERT INTO `course_planes` VALUES (156, 'Tập gym đúng cách cùng Mai Văn Anh', '<p style=\"text-align:center;\"><br><img src=\"https://swequity.vn/wp-content/uploads/2019/06/1-nhom-co-nen-tap-may-buoi-1.jpg\" alt=\"\" srcset=\"https://swequity.vn/wp-content/uploads/2019/06/1-nhom-co-nen-tap-may-buoi-1.jpg 640w, https://swequity.vn/wp-content/uploads/2019/06/1-nhom-co-nen-tap-may-buoi-1-300x225.jpg 300w\" sizes=\"100vw\" width=\"640\"></p><p>&nbsp;</p><p>Muốn tập gym đúng cách thì cần chọn được phòng tập chất lượng và người hướng dẫn bạn có chuyên môn cao. Từ năm 2015 Hà Nội đã có một phòng tập gym đúng chuẩn như vậy mang tên Swequity Ultimate fitness:&nbsp;</p><p>– Đội ngũ Coach tại Swequity là những người có chuyên môn cao, đạt chứng chỉ quốc tế, có kinh nghiệm giảng dạy trong và ngoài nước. Họ sẽ trực tiếp hướng dẫn bạn cách tập luyện, điều chỉnh động tác và xây dựng cho bạn lộ trình luyện tập kết hợp cùng chế độ ăn uống, đảm bảo giúp bạn nhanh chóng hoàn thành mục tiêu</p><p>– Hệ thống phòng tập với trang thiết bị hiện đại, đồng bộ, được nhập khẩu 100% từ Mỹ và Châu Âu. Cùng với đó là không gian thoáng mát, sang trọng và một môi trường tập luyện văn minh giúp học viên đạt được trạng thái tập trung tối đa khi rèn luyện.&nbsp;</p><p>Với triết lý hoạt động <i>“Lợi ích của khách hàng là lợi nhuận quý báu của Swequity”</i>, sau hơn 5 năm có mặt trên thị trường fitness Hà Nội, Swequity tự hào là phòng tập mang lại kết quả cao nhất cho hội viên hiện nay.</p><p><br>&nbsp;</p>', '<p><strong>Tập gym đúng cách cùng Mai Văn Anh&nbsp;</strong></p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640169648544_%C4%91%E1%BB%A1+%C4%91%C3%B2n+-+blocking+trong+boxing+sao+cho+%C4%91%C3%BAng_.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640169677852_Screenshot_58.png?alt=media&token=0a891885-e0bd-46b9-a144-3d4488469cb1', 30, '2021-12-22 17:41:19', '2021-12-22 17:41:19', 'Active', 1);
INSERT INTO `course_planes` VALUES (157, 'Buổi học 1:  Gặp gỡ PT và nên menu dinh dưỡng cho học viên.', '<p>Buổi học 1 PT sẽ lên menu dinh dưỡng cho &nbsp;học viên và bắt đầu những bài tập cơ bản.</p>', '<p>Buổi học 1 PT sẽ lên menu dinh dưỡng cho &nbsp;học viên và bắt đầu những bài tập cơ bản.</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203651147_videoviet.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640170459568_hi5.jpeg?alt=media&token=5f842d69-9a32-488a-b7b0-c72279df9cb8', 29, '2021-12-22 17:57:54', '2021-12-23 03:07:38', 'Active', 1);
INSERT INTO `course_planes` VALUES (158, 'Buổi 2: Những bài tập khởi động cơ bản.', '<p>Trong video PT sẽ hưỡng dẫn những bài khởi động hiệu quả.</p>', '<p>Trong video PT sẽ hưỡng dẫn những bài khởi động hiệu quả.</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640169648544_%C4%91%E1%BB%A1+%C4%91%C3%B2n+-+blocking+trong+boxing+sao+cho+%C4%91%C3%BAng_.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640170459568_hi5.jpeg?alt=media&token=5f842d69-9a32-488a-b7b0-c72279df9cb8', 31, '2021-12-22 18:04:32', '2021-12-22 18:04:32', 'Active', 1);
INSERT INTO `course_planes` VALUES (159, 'Khóa học huấn luyện viên Gym  tại nhà', '<p style=\"text-align:justify;\">Phần 1: Các động tác cơ bản</p><p style=\"text-align:justify;\">Phần 2: Các động tác nâng cao</p><p style=\"text-align:justify;\">Phần 3: Ghép tổ hợp động tác</p><p style=\"text-align:justify;\">Phần 4: Hướng dẫn tập trong 4 tuần đầu tiên&nbsp;</p><p style=\"text-align:justify;\">Phần 5: Hướng dẫn tập trong 4 tuần tiếp theo</p>', '<p><strong>.1. Về kiến thức chuyên ngành thực chiến&nbsp;</strong></p><p style=\"text-align:justify;\">Kỹ năng xây dựng nhân hiệu – thương hiệu trên các mạng xã hội (Xây dựng hình ảnh, sản phẩm sức khoẻ thông qua Facebook, Zalo,..cách tiếp cận các khách hàng tiềm năng)</p><p style=\"text-align:justify;\">Nghiệp vụ sư phạm&nbsp; trong huấn luyện sức khoẻ - thể hình</p><p style=\"text-align:justify;\">Kỹ năng chăm sóc sức khỏe và tư vấn khách hàng</p><p style=\"text-align:justify;\">Kỹ năng bán hàng sale dịch vụ sức khỏe&nbsp; (POS, New – N, Renew – RN, Referal – RF, F1, F2…)</p><p style=\"text-align:justify;\">Kỹ năng nhận diện DISC trong huấn luyện và chăm sóc khách hàng</p><p style=\"text-align:justify;\">Kỹ năng quản lý vận hành Teamwork</p><p><strong>.2. Về kỹ thuật</strong></p><p style=\"text-align:justify;\">Thể hình, phương pháp rèn luyện thể lực.</p><p style=\"text-align:justify;\">Kỹ thuật huấn luyện thể hình, thể hình.</p><p style=\"text-align:justify;\">Phương pháp sử dụng TPCN(thực phẩm chức năng)</p><p style=\"text-align:justify;\">Phương pháp tuyển chọn và đào tạo vận động viên thi đấu.</p><p style=\"text-align:justify;\">Luật thi đấu, tổ chức thi đấu thể hình, thể hình.</p><p><strong>.3. Về kiến thức y học</strong></p><p style=\"text-align:justify;\">Giải phẫu, sinh lý và thể lực.</p><p style=\"text-align:justify;\">Chế độ ăn uống trong thể dục và thể thao</p><p style=\"text-align:justify;\">Xử trí chấn thương và chấn thương khi vận động</p><p><strong>2.4. Đối tượng tham gia</strong></p><p style=\"text-align:justify;\">Là huấn luyện viên, hướng dẫn viên, vận động viên và hội viên đang hoạt động và rèn luyện trong các câu lạc bộ, đơn vị, trung tâm thể dục, thể hình.&nbsp;</p><p style=\"text-align:justify;\">Có trình độ tốt nghiệp 12 trở lên</p><p style=\"text-align:justify;\">Đã hoàn thành các khóa học cơ bản</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640171103284_%C4%91%E1%BB%A1+%C4%91%C3%B2n+-+blocking+trong+boxing+sao+cho+%C4%91%C3%BAng_.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640171085345_Screenshot_63.png?alt=media&token=7dd86ea9-9002-4e7f-bd16-560b025953bf', 32, '2021-12-22 18:05:20', '2021-12-22 18:05:20', 'Active', 1);
INSERT INTO `course_planes` VALUES (160, 'Buổi 2: Những bài tập nâng cao.', '<p>PT sẽ hướng dẫn những động tác nâng cao cho học viên. PT luôn support cho học viên nhiệt tình.</p>', '<p>PT sẽ hướng dẫn những động tác nâng cao cho học viên. PT luôn support cho học viên nhiệt tình.</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203636242_download%20%283%29.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640171158340_hi5.jpeg?alt=media&token=e743a42f-3237-4550-883e-2c049a406f6f', 31, '2021-12-22 18:10:01', '2021-12-23 03:07:17', 'Active', 1);
INSERT INTO `course_planes` VALUES (161, 'Buổi 4: Hệ thống kiến thức.', '<p>PT sẽ hệ thống lại kiến thức cho học viên và vẫn support nhiệt tình cho học viên.</p>', '<p>PT sẽ hệ thống lại kiến thức cho học viên và vẫn support nhiệt tình cho học viên.</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640171432784_hi5.jpeg?alt=media&token=31072ec2-2962-4bcd-b06e-c29a92b71732', 31, '2021-12-22 18:11:36', '2021-12-22 18:11:36', 'Active', 0);
INSERT INTO `course_planes` VALUES (164, 'giai đoạn 2.1 : Khởi động', '<p>giai đoạn 2.1 : Khởi động</p>', '<p>giai đoạn 2.1 : Khởi động</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640178774416_cron%20job.drawio.png?alt=media&token=16b8d491-de4e-4ba9-8c21-0314de591907', 25, '2021-12-22 20:12:59', '2021-12-22 20:12:59', 'Active', 0);
INSERT INTO `course_planes` VALUES (165, 'Buổi học 1 : Làm quen với các động tác', '<p style=\"text-align:justify;\">Đối với tôi, sức khỏe là quan trọng nhất vì “khi có sức khỏe, bạn có thể làm được bất kì điều gì bạn muốn”. Tôi biết đến Gym lần đầu là qua lời rủ rê của đồng nghiệp hồi đó, khi mới tập cũng chỉ với mục đích đơn giản là nâng cao sức khỏe và giết thời gian. Nhưng sau một thời gian tập luyện chăm chỉ và bền bỉ, kết quả nhận được khiến tôi cảm thấy hào hứng và có động lực hơn. Gym không những giúp tôi thay đổi về ngoại hình bên ngoài, cải thiện sức khỏe mà còn mang đến cho mình một lối sống mới và tích cực hơn. Và tôi nghĩ đã đến lúc nên chia sẻ và truyền cảm hứng cho mọi người về những điều thú vị tôi đã từng trải qua. Tôi chọn Swequity Ultimate Fitness là nơi tôi có thể chia sẻ, giúp đỡ những khách hàng trở thành một phiên bản tốt hơn của chính mình. Nếu bạn còn đang do dự để tìm hướng đi đúng cho sự lột xác hoàn toàn mới, đủ quyết tâm và không ngại thay đổi, hãy tới SUF và tôi sẽ giúp bạn hoàn thành mục tiêu của mình.</p><p style=\"text-align:justify;\">Với tôi, đẹp tự nhiên nhưng không tự nhiên mà đẹp.</p>', '<p>Làm quen với các động tác đơn giản</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640193394787_trungsky_1640191988000_video1234.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640192977933_c%E1%BA%A3io.jpg?alt=media&token=366e8200-97ab-4936-8453-3f5edfcfec0e', 33, '2021-12-22 21:34:40', '2021-12-23 00:16:37', 'Active', 1);
INSERT INTO `course_planes` VALUES (166, 'Buổi 1 : Các động tác cơ bản tránh căng cơ', '<p>1. Những lợi ích của bài tập căng cơ</p><p>Cơ chân bị căng là một vấn đề chung của nhiều người. Nếu cơ chân của chúng ta bị căng, hoặc nếu chúng ta gặp phải một chấn thương ở <a href=\"https://www.vinmec.com/vi/tin-tuc/thong-tin-suc-khoe/co-xuong-khop/cac-tinh-huong-de-gay-chan-thuong-co-gan-kheo/\"><strong>cơ gân kheo</strong></a> như căng cơ, do đó việc tìm gặp các chuyên gia trong lĩnh vực <strong>vật lý trị liệu</strong> là điều cần thiết. Các chuyên gia vật lý trị liệu có thể hướng dẫn người tập các bài tập kéo giãn gân khoeo, giống như những bài tập kéo giãn cơ mà chúng tôi sẽ trình bày ở phần dưới đây, để giúp bạn cải thiện tính linh hoạt tổng thể của cơ chân.</p><figure class=\"image image_resized\" style=\"width:420px;\"><img src=\"https://vinmec-prod.s3.amazonaws.com/images/20210309_023835_087333_keo_gian_co_1.max-1800x1800.jpg\" alt=\"Hướng dẫn cách kéo giãn cơ bản\"></figure><p style=\"text-align:center;\">Bài tập kéo giãn cơ giúp cải thiện tính linh hoạt của chân</p><p>1.1. Những lợi ích của bài tập căng cơ chân</p><p>Nhóm cơ gân kheo nằm ở phía sau đùi của cơ chân và chịu trách nhiệm cho các tư thế uốn cong hoặc gập đầu gối của chúng ta. Vì gân kheo cũng bắt chéo khớp hông ở phía sau đùi nên chúng cũng giúp cơ mông kéo dài chân trong các hoạt động như chạy và đi bộ.</p><p>Trong khi các nghiên cứu vẫn đang tiếp tục được tiến hành để đánh giá hiệu quả của việc kéo giãn cơ gân kheo, thì vẫn có một số lý do mà chúng ta nên luyện tập để tăng độ dẻo dai của gân kheo, bao gồm:</p><p>Ngăn ngừa chấn thương</p><p>Ngăn ngừa hoặc điều trị tình trạng đau thắt lưng</p><p>Cải thiện tính di động tổng thể. Duy trì khả năng vận động ở chân và đùi cũng có thể giúp chúng ta duy trì hiệu suất <a href=\"https://www.vinmec.com/vi/tin-tuc/thong-tin-suc-khoe/tap-the-duc-chon-sang-hay-toi/\"><strong>tập thể dục</strong></a> hay chơi thể thao ở mức tối ưu.</p><p>Kéo giãn gân khoeo sau khi hoạt động thể dục, thể thao có thể giúp giảm đau cơ khởi phát muộn (DOMS) ở những nhóm cơ này.</p><p>Một bài tập nhằm làm tăng tính linh hoạt của cơ gân kheo nói chung có thể cải thiện cách di chuyển của chúng ta. Trước khi bắt đầu thực hiện các bài tập này, hay bất kỳ chương trình tập thể dục nào khác, hãy trao đổi với các bác sĩ hoặc các giáo viên thể dục để đảm bảo rằng những bài tập bạn mong muốn áp dụng là an toàn và phù hợp với bạn.</p><p>1.2. Giãn tĩnh so với động</p><p>Việc lựa chọn hình thức kéo giãn tĩnh hay kéo giãn động cơ gân khoeo phụ thuộc vào thời gian và cường độ mỗi người áp dụng nhóm cơ này trong lúc tập luyện.</p><p>Giãn tĩnh là những động tác mà người tập sẽ duy trì một vị trí hoặc tư thế trong vài giây. Những động tác này được thực hiện tốt nhất sau khi vừa hoàn thành các bài tập, khi các cơ còn ấm.</p><p>Động tác kéo giãn động là những động tác bao gồm các chuyển động có kiểm soát để giúp làm ấm cơ thể và chuẩn bị cho các cơ của chúng ta có thể chuyển động mạnh mẽ và linh hoạt hơn. Chúng được thực hiện tốt nhất trước khi tập luyện.</p><p>Để làm cho các động tác giãn tĩnh chuyển thành các động tác giãn động, người tập chỉ cần dành 60 đến 90 giây để liên tục di chuyển trong từng tư thế với chuyển động ổn định, có kiểm soát. Nếu xuất hiện cảm đau hoặc cảm giác bất thường ở hông, đùi hoặc cẳng chân, hãy dừng việc luyện tập lại và thông báo với các huấn luyện viên hoặc bác sĩ.</p>', '<p>Những người tham gia các môn thể thao liên quan đến chạy nước rút dễ bị căng hoặc chấn thương ở các cơ. Bởi vì mọi người sử dụng gân cơ chân cho các chuyển động hàng ngày như <a href=\"https://www.vinmec.com/vi/tin-tuc/thong-tin-suc-khoe/song-khoe/chi-di-bo-co-giam-can-khong/\">đi bộ</a>, <a href=\"https://www.vinmec.com/vi/tin-tuc/thong-tin-suc-khoe/song-khoe/dap-xe-dap-co-giam-can-khong/\">đạp xe</a>,.... Kéo giãn cơ chân sẽ giúp mọi người tránh <a href=\"https://www.vinmec.com/vi/tin-tuc/thong-tin-suc-khoe/song-khoe/lam-gi-khi-bi-cang-co/\">căng cơ</a> và rách cơ. Bài viết này sẽ thảo luận về 5 bài tập căng cơ đơn giản để thử tại nhà tốt nhất, khi nào sử dụng chúng, tần suất sử dụng chúng và lợi ích của việc kéo giãn cơ chân.</p><p>&nbsp;</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203870187_nguyen_test.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640203343802_khoa-hoc-dinh-duong-giam-can-online-5.jpg?alt=media&token=a5a3517a-5876-42bd-9f03-626020065d35', 25, '2021-12-22 23:55:23', '2021-12-23 03:11:15', 'Active', 1);
INSERT INTO `course_planes` VALUES (167, 'Buổi 1: Gặp gỡ PT và lên menu ăn dinh dưỡng', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Khóa học là tổng hợp các động tác và kỹ thuật thực hành các bài tập nhảy từ đơn giản cho đến phức tạp, giúp học viên không bị \"ngợp\" khi mới bắt đầu luyện tập nhảy giảm cân tại nhà,&nbsp;sớm làm quen vời các bài tập hay kỹ thuật nhảy và nhanh chóng gặt hái được những kết quả đầu tiên.</span></p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Khóa học là tổng hợp các động tác và kỹ thuật thực hành các bài tập nhảy từ đơn giản cho đến phức tạp, giúp học viên không bị \"ngợp\" khi mới bắt đầu luyện tập nhảy giảm cân tại nhà,&nbsp;sớm làm quen vời các bài tập hay kỹ thuật nhảy và nhanh chóng gặt hái được những kết quả đầu tiên.</span></p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640198839043_hihi7.jpeg?alt=media&token=444f905a-9d30-4010-90ef-271f196d7391', 41, '2021-12-23 01:48:33', '2021-12-23 01:48:33', 'Active', 0);
INSERT INTO `course_planes` VALUES (169, 'Buổi 2:  Kĩ thuật nhảy tổng hợp', '<p>Buổi 2: &nbsp;Kĩ thuật nhảy tổng hợp</p>', '<p>Buổi 2: &nbsp;Kĩ thuật nhảy tổng hợp</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203467609_download%20%283%29.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640199323160_hihi9.jpeg?alt=media&token=a88c66f3-81c1-4c4c-9e82-ab6d62398ce5', 41, '2021-12-23 01:55:43', '2021-12-23 03:04:30', 'Active', 1);
INSERT INTO `course_planes` VALUES (170, 'Buổi 3: Kĩ thuật nhảy trung cấp', '<p>Buổi 3: Kĩ thuật nhảu trung cấp</p>', '<p>Buổi 3: Kĩ thuật nhảu trung cấp</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203429006_download%20%282%29.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640199735564_hihi9.jpeg?alt=media&token=1e00c719-5242-4ec4-bb15-1255856922f0', 42, '2021-12-23 02:02:31', '2021-12-23 03:03:50', 'Active', 1);
INSERT INTO `course_planes` VALUES (171, 'Buổi 4: Kĩ thuật nhảy cao cấp', '<p>Buổi 4: Kĩ thuật nhảy cao cấp</p>', '<p>Buổi 4: Kĩ thuật nhảy cao cấp</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203439212_download%20%281%29.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640199735564_hihi9.jpeg?alt=media&token=1e00c719-5242-4ec4-bb15-1255856922f0', 42, '2021-12-23 02:04:35', '2021-12-23 03:04:01', 'Active', 1);
INSERT INTO `course_planes` VALUES (172, 'Buổi 5: Hệ thống lại kiến thức', '<p>Hệ thống lại kiến thức và PT vẫn sẽ support cho học viên bất cứ lúc nào học viên cần.</p>', '<p>Hệ thống lại kiến thức và PT vẫn sẽ support cho học viên bất cứ lúc nào học viên cần.</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640199947548_hihi9.jpeg?alt=media&token=499f40f6-761f-42ad-8599-a9c65ca3e3d1', 42, '2021-12-23 02:06:34', '2021-12-23 02:06:34', 'Active', 0);
INSERT INTO `course_planes` VALUES (173, 'Buổi học 1: Hướng dẫn cách tập', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p><p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.&nbsp;</p><p style=\"text-align:justify;\">Đừng lo lắng! Tất cả sẽ được giải quyết chỉ với một khóa học duy nhất của Luna Thái tại Unica: Khóa học <i><strong>\"Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i></p><p style=\"text-align:justify;\">Khóa học \"<i><strong>Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i>&nbsp;gồm 23 bài tập là những bài tập, các động tác giúp chị em đốt cháy mỡ thừa, đặc biệt ở vùng bụng, đùi, bắp tay. Đồng hành cùng bạn chính là giảng viên Luna Thái sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ&nbsp;sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', '<p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.&nbsp;</p><p style=\"text-align:justify;\">Đừng lo lắng! Tất cả sẽ được giải quyết chỉ với một khóa học duy nhất của Luna Thái tại Unica: Khóa học <i><strong>\"Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i></p><p style=\"text-align:justify;\">Khóa học \"<i><strong>Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i>&nbsp;gồm 23 bài tập là những bài tập, các động tác giúp chị em đốt cháy mỡ thừa, đặc biệt ở vùng bụng, đùi, bắp tay. Đồng hành cùng bạn chính là giảng viên Luna Thái sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ&nbsp;sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640200398767_giao%20ti%E1%BA%BFp.jpg?alt=media&token=3bef5c82-ccdd-4ecf-9e43-bdcc0fe605d0', 37, '2021-12-23 02:14:15', '2021-12-23 02:19:06', 'Active', 0);
INSERT INTO `course_planes` VALUES (174, 'Hướng dẫn cách tập', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này.</p><p style=\"text-align:justify;\">&nbsp;Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Đừng lo lắng! Tất cả sẽ được giải quyết chỉ với một khóa học duy nhất của Luna Thái tại Unica: Khóa học <i><strong>\"Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i></p><p style=\"text-align:justify;\">Khóa học \"<i><strong>Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i>&nbsp;gồm 23 bài tập là những bài tập, các động tác giúp chị em đốt cháy mỡ thừa, đặc biệt ở vùng bụng, đùi, bắp tay. Đồng hành cùng bạn chính là giảng viên Luna Thái sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ&nbsp;sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này.</p><p style=\"text-align:justify;\">&nbsp;Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640204045440_c%C3%A1ch+gi%E1%BA%A3m+c%C3%A2n+nhanh+trong+1+tu%E1%BA%A7n+_+gi%E1%BA%A3m+6kg+trong+7+ng%C3%A0y+hi%E1%BB%87u+qu%E1%BA%A3+t%E1%BA%A1i+nh%C3%A0+%5Bbeauty+daily%5D.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640200816305_c%E1%BA%A3io.jpg?alt=media&token=23202548-3576-4b27-9f0e-6c913bb18afe', 37, '2021-12-23 02:21:04', '2021-12-23 03:14:09', 'Active', 1);
INSERT INTO `course_planes` VALUES (175, 'Hướng dẫn cách tập', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p><p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.&nbsp;</p><p style=\"text-align:justify;\">Đừng lo lắng! Tất cả sẽ được giải quyết chỉ với một khóa học duy nhất của Luna Thái tại Unica: Khóa học <i><strong>\"Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i></p><p style=\"text-align:justify;\">Khóa học \"<i><strong>Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i>&nbsp;gồm 23 bài tập là những bài tập, các động tác giúp chị em đốt cháy mỡ thừa, đặc biệt ở vùng bụng, đùi, bắp tay. Đồng hành cùng bạn chính là giảng viên Luna Thái sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ&nbsp;sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</span></p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203995567_c%C3%A1ch+gi%E1%BA%A3m+c%C3%A2n+nhanh+trong+1+tu%E1%BA%A7n+_+gi%E1%BA%A3m+6kg+trong+7+ng%C3%A0y+hi%E1%BB%87u+qu%E1%BA%A3+t%E1%BA%A1i+nh%C3%A0+%5Bbeauty+daily%5D.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640201028385_la-nam-giam-can-0.jpg?alt=media&token=3f8d1e54-1822-4086-9a1e-b674f50dbc7f', 38, '2021-12-23 02:24:11', '2021-12-23 03:13:21', 'Active', 1);
INSERT INTO `course_planes` VALUES (176, 'Buổi 2 : Học theo PT', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p><p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.&nbsp;</p><p style=\"text-align:justify;\">Đừng lo lắng! Tất cả sẽ được giải quyết chỉ với một khóa học duy nhất của Luna Thái tại Unica: Khóa học <i><strong>\"Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i></p><p style=\"text-align:justify;\">Khóa học \"<i><strong>Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i>&nbsp;gồm 23 bài tập là những bài tập, các động tác giúp chị em đốt cháy mỡ thừa, đặc biệt ở vùng bụng, đùi, bắp tay. Đồng hành cùng bạn chính là giảng viên Luna Thái sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ&nbsp;sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', '<p>Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640204085777_c%C3%A1ch+gi%E1%BA%A3m+c%C3%A2n+nhanh+trong+1+tu%E1%BA%A7n+_+gi%E1%BA%A3m+6kg+trong+7+ng%C3%A0y+hi%E1%BB%87u+qu%E1%BA%A3+t%E1%BA%A1i+nh%C3%A0+%5Bbeauty+daily%5D.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640201220751_cach-giam-can-cho-nhan-vien-van-phong(1).jpg?alt=media&token=863fc28b-b4bd-4d19-a689-62eb23eb56cb', 40, '2021-12-23 02:27:30', '2021-12-23 03:14:52', 'Active', 1);
INSERT INTO `course_planes` VALUES (177, 'Buổi học 1 : Giới thiệu lợi ích của việc giảm cân', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p><p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.&nbsp;</p><p style=\"text-align:justify;\">Đừng lo lắng! Tất cả sẽ được giải quyết chỉ với một khóa học duy nhất của Luna Thái tại Unica: Khóa học <i><strong>\"Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i></p><p style=\"text-align:justify;\">Khóa học \"<i><strong>Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i>&nbsp;gồm 23 bài tập là những bài tập, các động tác giúp chị em đốt cháy mỡ thừa, đặc biệt ở vùng bụng, đùi, bắp tay. Đồng hành cùng bạn chính là giảng viên Luna Thái sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ&nbsp;sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', '<p>Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640201336169_la-nam-giam-can-0.jpg?alt=media&token=966d5dc5-7e89-4e92-8363-cec7fb5a0127', 39, '2021-12-23 02:29:15', '2021-12-23 02:29:15', 'Active', 0);
INSERT INTO `course_planes` VALUES (180, 'Buổi 1 : Làm nóng cơ thể với các động tác đơn giản', '<p>&nbsp;Làm nóng cơ thể với các động tác đơn giản</p>', '<p>&nbsp;Làm nóng cơ thể với các động tác đơn giản</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203796276_nguyen_test.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640203409972_c%E1%BA%A3io.jpg?alt=media&token=9a2b2d00-e2ac-4dbb-bdd2-36be3ef9bfe9', 35, '2021-12-23 03:03:59', '2021-12-23 03:09:59', 'Active', 1);
INSERT INTO `course_planes` VALUES (181, 'Buổi 1 : Giới thiệu khóa học', '<p>&nbsp;Giới thiệu khóa học</p>', '<p>&nbsp;Giới thiệu khóa học</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640203504894_giao%20ti%E1%BA%BFp.jpg?alt=media&token=30a6067f-cbdc-4e9b-8b09-acd545ee6056', 34, '2021-12-23 03:05:12', '2021-12-23 03:05:12', 'Active', 0);
INSERT INTO `course_planes` VALUES (182, 'Buổi học 1 : Giới thiệu lợi ích việc khởi động tự do', '<p>Giới thiệu lợi ích việc khởi động tự do</p>', '<p>Giới thiệu lợi ích việc khởi động tự do</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640203630172_blackpinkl.jpg?alt=media&token=2a273afe-b09a-417d-afe3-29fca2a205ab', 36, '2021-12-23 03:07:14', '2021-12-23 03:07:14', 'Active', 0);
INSERT INTO `course_planes` VALUES (183, 'Buổi 1: Gặp gỡ PT và lên menu ăn dinh dưỡng', '<p>Buổi 1: Gặp gỡ PT và lên menu ăn dinh dưỡng</p>', '<p>Buổi 1: Gặp gỡ PT và lên menu ăn dinh dưỡng</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640192352238_video1234.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640203797957_hihi2.jpeg?alt=media&token=a9588b00-ae3f-4ad1-88f6-e22bb05fb2cd', 11, '2021-12-23 03:10:11', '2021-12-23 03:10:11', 'Active', 0);
INSERT INTO `course_planes` VALUES (184, 'Buổi 2: Các động tác cơ bản', '<p>Buổi 2: Các động tác cơ bản&nbsp;</p>', '<p>Buổi 2: Các động tác cơ bản&nbsp;</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203864410_videoviet.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640203882279_hihi2.jpeg?alt=media&token=f7bbb35a-3deb-42b9-9784-d73ff04881ee', 11, '2021-12-23 03:11:35', '2021-12-23 03:11:35', 'Active', 1);
INSERT INTO `course_planes` VALUES (185, 'Buổi 3: Các động tác nâng cao', '<p>Buổi 3: Các động tác nâng cao</p>', '<p>Buổi 3: Các động tác nâng cao</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640203963599_videoviet.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640203953117_hihi2.jpeg?alt=media&token=c7b00806-9589-4b0e-b8e4-8b8eecea1d18', 12, '2021-12-23 03:12:50', '2021-12-23 03:12:50', 'Active', 1);
INSERT INTO `course_planes` VALUES (186, 'Buổi 4: Kĩ thuật nhảy cao cấp', '<p>Buổi 4: Kĩ thuật nhảy cao cấp</p>', '<p>Buổi 4: Kĩ thuật nhảy cao cấp</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640204020558_hihi2.jpeg?alt=media&token=97f398d3-0307-4574-8833-249b80b26b24', 12, '2021-12-23 03:13:50', '2021-12-23 03:13:50', 'Active', 0);
INSERT INTO `course_planes` VALUES (187, 'demo', '<p>demo</p>', '<p>demo</p>', '', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640204668069_hi2.jpeg?alt=media&token=a0113bed-f24a-4cd8-8ce8-49b1e84d304d', 43, '2021-12-23 03:24:38', '2021-12-23 03:24:38', 'Active', 0);
INSERT INTO `course_planes` VALUES (188, 'demo 2', '<p>dem demo</p>', '<p>demo demo dmeo</p>', 'https://datn73-uploader.s3.ap-east-1.amazonaws.com/trungsky_1640222538732_videoviet.mp4', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640222531259_hihi2.jpeg?alt=media&token=4252b715-107c-4fa0-a6c0-f5a811b0d4cc', 43, '2021-12-23 08:22:36', '2021-12-23 08:22:36', 'Active', 1);
COMMIT;

-- ----------------------------
-- Table structure for course_students
-- ----------------------------
DROP TABLE IF EXISTS `course_students`;
CREATE TABLE `course_students` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Canceled','CanceledByPt','Unscheduled','Schedule','RequestAdmin','Complete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unscheduled',
  `user_consent` enum('Unsent','Sent','UserAgrees','UserDisAgrees') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unsent',
  `user_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of course_students
-- ----------------------------
BEGIN;
INSERT INTO `course_students` VALUES (114, NULL, 'Complete', 'UserAgrees', 4, 21, '2021-12-23 03:39:21', '2021-12-23 04:26:15', NULL);
INSERT INTO `course_students` VALUES (115, NULL, 'Schedule', 'UserAgrees', 4, 1, '2021-12-23 04:27:15', '2021-12-23 08:58:44', NULL);
INSERT INTO `course_students` VALUES (116, NULL, 'Unscheduled', 'Unsent', 4, 14, '2021-12-23 04:33:00', '2021-12-23 08:50:25', NULL);
INSERT INTO `course_students` VALUES (117, NULL, 'Complete', 'UserAgrees', 4, 12, '2021-12-23 04:39:27', '2021-12-23 04:43:48', NULL);
INSERT INTO `course_students` VALUES (118, NULL, 'Unscheduled', 'UserAgrees', 4, 21, '2021-12-23 08:26:18', '2021-12-23 08:57:43', NULL);
COMMIT;

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lessons` int(11) NOT NULL,
  `time_a_lessons` int(11) NOT NULL,
  `price` double(12,2) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Pending','Happening','Pause','Request') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `display` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_by` bigint(20) unsigned NOT NULL,
  `specialize_detail_id` bigint(20) unsigned NOT NULL,
  `customer_level_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of courses
-- ----------------------------
BEGIN;
INSERT INTO `courses` VALUES (1, 'Khoá học Boxing cho người mới tập', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1639416713023_khoahocboxxing.jpeg?alt=media&token=c90be4c1-7aa8-455f-af02-48b0c61a37b0', 5, 60, 799000.00, '<p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Boxing môn thể thao tối ưu thời thượng ngày càng được ưa chuộng tại các phòng tập hiện đại trên thế giới. Khóa học&nbsp;Boxing mang đến cho bạn một cơ thể khỏe mạnh, body săn chắc, quyến rũ.</span></p><p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Các bài tập trong bộ môn Boxing giúp đốt cháy calories và chất béo nhanh chóng, đặc biệt giảm mỡ toàn thân, giúp tăng cường hệ hô hấp và tim mạch.</span></p>', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Boxing hay còn gọi là quyền Anh, đấm bốc là môn võ và thể thao đối kháng&nbsp;giữa 2 người xuất phát từ phương Tây, sử dụng cú đấm kết hợp với di chuyển chân, đầu và thân mình). Ngày nay tại các Trung tâm thể thao hiện đại, Boxing luôn là sự lựa chọn hàng đầu cho những người muốn giảm cân, nâng cao sức khỏe. Học Boxing không chỉ giúp giảm cân hiệu quả, xua tan mọi stress mà còn giúp bạn nâng cao khả năng tự vệ khi đối mặt với những tình huống nguy hiểm trong cuộc sống.</span></p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2F11.jpeg?alt=media&amp;token=5fd695c7-e5a9-48c7-9741-21a318dc87aa\"></figure><p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Việc học Boxing sẽ giúp bạn giảm cân hiệu quả và nhanh chóng do người tập phải vận động toàn thân, việc chuyển động toàn thân giúp đốt cháy mỡ thừa toàn thân nhanh chóng và cho bạn vóc dáng săn chắc, cơ thể khỏe mạnh. Khóa học hoàn toàn thích hợp với các bạn nam, nữ muốn một body chuẩn, sexy trong mắt người khác giới.</span></p><p>&nbsp;</p><p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Học Boxing còn giúp bạn nâng cao sự dẻo dai, giúp người tập trở nên khéo léo, phản xạ nhanh nhạy, và đặc biệt Boxing giúp bạn tăng cường sức chịu đựng của bản thân trong mọi tình huống của cuộc sống.</span></p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2F22.jpeg?alt=media&amp;token=1698e900-28a0-4ef8-b430-8f8079ac0248\"></figure><p>Trong quá trình học bạn được rèn luyện, được trải qua những phút chịu đựng cường độ cao - Vậy nên Boxing rèn luyện bạn thành một chiến binh, nâng cao sức chịu đựng cơ thể, cũng như khối óc, giúp bạn vượt qua áp lực, căng thẳng trong cuộc sống và trong công việc.</p><p>&nbsp;</p><p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Bất kể bạn là một cô gái, hay một anh chàng thư sinh với cặp kính cận, bất kể bạn già hay trẻ, khỏe mạnh hay ốm yếu...Đến với lớp học, chắc chắn bạn sẽ cảm thấy cơ thể mình khỏe ra trông thấy, body sexy hơn, tâm trí kiên quyết hơn. Sau những giờ tập, mọi mệt mỏi sẽ được xua tan, bạn sẽ hạnh phúc hơn, yêu cuộc sống hơn, và bản lĩnh hơn. &nbsp;</span></p><p>&nbsp;</p><p><strong>Nhanh tay MUA ngay hôm nay để nhận được ưu đãi hấp dẫn từ Hotdeal bạn nhé!</strong></p><p>&nbsp;</p>', 'Happening', 'Active', 2, 2, 2, '2021-12-14 00:35:44', '2021-12-23 03:15:37');
INSERT INTO `courses` VALUES (10, 'Hướng dẫn tự tập Fitness tại nhà hiệu quả trong 8 tuần', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640065256419_fitness.jpeg?alt=media&token=0d8c8dc0-c332-4e54-ad5e-8bb12debe36a', 4, 60, 529000.00, '<p>Rèn luyện sức khoẻ, tạo vóc dáng tuyết đẹp ngay tay nhà cực kỳ đơn giản. Bài hướng dẫn phù hợp với các lứa tuổi từ 15-40 và phù hợp với cả nam và nữ.</p>', '<p style=\"text-align:justify;\"><span class=\"text-big\"><strong>Giới thiệu khoá học&nbsp;</strong></span></p><p style=\"text-align:justify;\">Calisthenics là 1 môn tập luyện rèn luyện sức khỏe, tạo vóc dáng thẩm mỹ, thân hình cường tráng nhưng có độ dẻo dai cho người tập. Sử dụng chính trọng lượng cơ thể để tập luyện nên Calisthenics phù hợp với tập cả mọi người, dễ dàng tập luyện mà không cần những dụng cụ tập luyện cầu kì như trong phòng gym.</p><p style=\"text-align:justify;\">Đến với khóa học Hướng dẫn tự tập Fitness tại nhà hiệu quả trong 8 tuần, các bạn sẽ được hướng dẫn cụ thể qua những bài giảng từ cơ bản đến nâng cao, giúp bạn dễ dàng luyện tập một cách an toàn và hiệu quả.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Khóa học đặc biệt dành cho những bạn bận rộn, không có nhiều thời gian tập luyện tham gia các lớp tập luyện trực tiếp tại các trung tâm.</p><p style=\"text-align:justify;\">Đảm bảo khi bạn hoàn thành xong khóa học, bạn sẽ có được trang bị đầy đủ nhất những kiến thức về Calisthenics để sẵn sàng thay đổi bản thân với 1 thân hình chuẩn mẫu và sức khỏe kinh ngạc.</p><p style=\"text-align:justify;\">&nbsp;</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ffetness2.jpeg?alt=media&amp;token=548cc9b8-c813-41d7-b87c-27f01b4af901\"></figure><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Bạn mong muốn sở hữu thân hình săn chắc, cơ bắp cuồn cuộn 6 múi với sức khoẻ, sức bền dẻo dai. Bạn mong muốn tìm được một bộ môn thể thao giúp bạn giải toả căng thẳng, mệt mỏi, stress sau những giờ làm việc căng thẳng</p><p style=\"text-align:justify;\">Bạn là một người bận rộn không có thời gian để đến phòng tập hay là người hạn hẹp kinh tế không đủ điều kiện để chi trả cho chi phí phòng tập đắt đỏ trong nhiều tháng liền?</p><p style=\"text-align:justify;\">Để giải đáp được mọi khó khăn và đáp ứng yêu cầu của bạn. YM mang đến cho bạn khoá học giảm cân online mua 1 lần sở hữu trọn đời <i><strong>Hướng dẫn tự tập Fitness tại nhà hiệu quả trong 8 tuần.</strong></i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\"><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Đảm bảo khi bạn hoàn thành xong khóa học, bạn sẽ có được trang bị đầy đủ nhất những kiến thức về Calisthenics để sẵn sàng thay đổi bản thân với 1 thân hình chuẩn mẫu và sức khỏe kinh ngạc.</span></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">&nbsp;</p>', 'Request', 'Active', 2, 7, 2, '2021-12-21 12:49:27', '2021-12-23 03:14:15');
INSERT INTO `courses` VALUES (12, 'Khoá học bí mật BODY triệu người mê', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640164361232_Screenshot%202021-12-22%20at%2016.11.51.png?alt=media&token=32859ca4-d565-4dcb-85ac-0613d670f296', 4, 60, 629000.00, '<p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Đối với phái nữ - để có vòng eo đẹp, mông cong, thân hình chữ S là điều không dễ dàng. Còn phái mạnh nào chẳng ước mơ sáu múi, cơ bắp cuồn cuộn đầy vẻ nam tính. Nhưng để có thân hình như mơ thì bạn cần trải qua quá trình tập luyện không hề dễ dàng.</span></p>', '<p style=\"text-align:justify;\"><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Đối với phái nữ - để có vòng eo đẹp, mông cong, thân hình chữ S là điều không dễ dàng. Còn phái mạnh nào chẳng ước mơ sáu múi, cơ bắp cuồn cuộn đầy vẻ nam tính. Nhưng để có thân hình như mơ thì bạn cần trải qua quá trình tập luyện không hề dễ dàng.</span></p><p style=\"text-align:justify;\">&nbsp;</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Fhi2.jpeg?alt=media&amp;token=682f59d3-f816-4d48-99d5-ba58ecd99249\"></figure><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Bỏ ra vài triệu để đăng ký thẻ tập và thuê PT (huấn luyện viên cá nhân) riêng chứ? Không phải ai cũng có đủ điều kiện và thời gian để làm thế!</p><p style=\"text-align:justify;\">Bạn đã từng nghĩ mình có thể tập Gym cải thiện vóc dáng hiệu quả NGAY TẠI NHÀ? Không cần phải đăng ký những chiếc thẻ hàng chục triệu đồng đến các phòng tập, càng không cần thuê riêng PT để tập luyện. Hoặc thậm chí chẳng cần phải bỏ thời gian đến phòng Gym khi lịch làm việc của bạn đã kín. Khóa học “Bí mật body triệu người mê” chính là giải pháp cho bạn!</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Chỉ với vài thao tác đơn giản để sở hữu khóa học <i><strong>Bí mật BODY triệu người mê</strong></i> trọn đời của giảng viên <i><strong>Chúc Anh Quân</strong></i> với hệ thống các bài tập hiệu quả cho từng vùng trên cơ thể do chính Huấn luyện viên thể hình 5 năm chuyên nghiệp. Tại sao chỉ suy nghĩ mà không hành động ngay hôm nay để tiến gần hơn với thân hình mơ ước?</p><p style=\"text-align:justify;\">Sau khi tham gia khoá học này các bạn sẽ cảm nhận được vóc dáng và sức khoẻ của bạn thay đổi rõ rệt. Đồng thời các bạn có thể tự lên chương trình tập luyện phù hợp cũng như thực đơn ăn uống dinh dưỡng, phù hợp hàng ngày như một chuyên gia. Hơn nữa các bạn có thể tiết kiệm thời gian, chi phí, tiền bạn cho chính bạn.</p><p style=\"text-align:justify;\">Đăng ký ngay khoá học&nbsp;<i><strong>Bí mật BODY triệu người mê&nbsp;</strong></i>ngay&nbsp;hôm nay để sở hữu thân hình chữ S sexcy, thon gọn hay một thân hình cuồn cuộn sáu múi vạn người mê.</p>', 'Pending', 'Inactive', 2, 1, 1, '2021-12-22 16:09:37', '2021-12-25 20:29:04');
INSERT INTO `courses` VALUES (13, 'Khóa học Dancer từ cơ bản đến nâng cao', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640165824273_blackpinkl.jpg?alt=media&token=58b2d39b-53c5-4dc8-a84e-b90b855b1f9a', 4, 60, 900000.00, '<p>Khoá học nhảy sexy Dance tại nhà dành cho người mới bắt đầu hướng dẫn các bạn cách kết hợp các bộ phận trên cơ thể để được một thân hình sexy. Hướng dẫn bài bản những động tác quyến rũ, kết hợp từ nhiều bộ phận trên cơ thể, Sexy Dance đem lại bạn sự thoải mái, trẻ trung và cuốn hút</p>', '<p>Học Sexy Dance là một thể loại nhảy phổ biến, gồm những động tác quyến rũ được kết hợp từ nhiều bộ phận như đầu, ngực, hông, tay và chân, nhảy được trên nhiều bản nhạc khác nhau, từ giai điệu chậm lôi cuốn đến những bản nhạc Remix sôi động.</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Fblackpinkl.jpg?alt=media&amp;token=f4271eb9-55ff-47f9-be49-0c2474cb2929\"></figure><p>&nbsp;Sexy Dance đem lại sự thoải mái, tự do cho người học, đặc biệt sau những giờ học tập và làm việc căng thẳng. Chính vì vậy, Sexy Dance luôn là lựa chọn số 1 cho người mới bắt đầu học nhảy hiện đại. Khóa học Học nhảy Sexy Dance từ cơ bản đến nâng cao, được giảng dạy bởi Giảng viên Phạm Vân Thu Hằng, đến từ trung tâm nhảy hiện đại, sẽ phù hợp với những bạn mới tiếp xúc với nhảy hiện đại. Bạn sẽ được hướng dẫn cụ thể qua những bài giảng từ cơ bản đến nâng cao, giúp bạn dễ dàng luyện tập một cách an toàn và hiệu quả.</p>', 'Happening', 'Active', 48, 10, 1, '2021-12-22 16:21:22', '2021-12-23 03:15:59');
INSERT INTO `courses` VALUES (14, 'Khoá học giảm cân online an toàn', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640166171492_hi3.jpeg?alt=media&token=c39b7691-3dc3-4bdf-bfad-9d93ab4a760a', 4, 60, 299000.00, '<p>Bạn muốn giảm cân tại nhà trong mùa dịch này? Bạn muốn đăng ký những khoá học online giá rẻ? Bạn đang băn khoăn vì không biết chọn khoá học nào uy tín? Đừng lo lắng! <strong>Khoá học boxing giảm béo làm đẹp cho người văn phòng</strong> chắc chắn sẽ là lựa chọn tốt nhất dành cho bạn.</p>', '<p style=\"text-align:justify;\">Bộ môn Boxing không còn xa lạ gì với những ai yêu thích tập luyện thể thao, chăm sóc sức khỏe. Tuy nhiên, hiện vẫn còn có rất nhiều quan điểm rằng đây là bộ môn dành cho nam giới hay tập luyện Boxing rất khó không phải ai muốn cũng có thể tham gia được.</p><p style=\"text-align:justify;\">Bộ môn Boxing là môn võ giống MMA, cũng lấy cảm hứng từ nhiều phong cách võ thuật kết hợp với các động tác mạnh mẽ như đấm, đá cùng kỹ thuật tấn công để rèn luyện thể lực và thể hình săn chắc.</p><p style=\"text-align:justify;\">&nbsp;</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Fhi4.jpeg?alt=media&amp;token=9aa4ebf1-f75b-48c4-9757-a3eb5374bc18\"></figure><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">&nbsp;</p><p><strong>Thông tin giảng viên – Khoá học giảm cân online an toàn</strong></p><p>Giảng viên Chúc Anh Quân – là chuyên gia chăm sóc sức khoẻ với 12 năm là vận động viên tỉnh Thái Nguyên và 3 năm kinh nghiệm đào tạo huấn luyện các môn võ như Tán Thủ, wushu va taekwondo. Bộ môn boxing là lựa chọn tuyệt vời nhất dành cho bạn nếu như có một hướng dẫn viên chất lượng. Với mong muốn giúp cho mọi người có một sức khoẻ tốt, chị đã chuẩn bị những khoá học tốt nhất. Chắc chắn rằng khi kết thúc khoá học này, các học viên sẽ được nhận lại nhiều hơn những gì bỏ ra.</p><p>&nbsp;</p><p><strong>Học viên nhận được gì sau khoá học – Lớp học giảm cân</strong></p><p>Học viên khi tham gia lớp học sẽ được tìm hiểu về bộ môn boxing. Những bài học được đưa ra sẽ đi từ nhẹ đến nặng. Dưới sự giám sát của giảng viên, các học viên sẽ được chỉ ra những cái sai và cần thiện điều gì. Ngoài việc tập các bài tập, học viên sẽ được đưa ra lời khuyên về chế độ dinh dưỡng và tâm quan trọng của nó. Cơ thể sẽ săn chắc và tràn đầy sức sống.</p>', 'Happening', 'Active', 2, 2, 2, '2021-12-22 16:49:08', '2021-12-23 03:16:10');
INSERT INTO `courses` VALUES (15, 'Chế độ ăn khi tập gym giảm cân bài bản, khoa học dành cho nữ giới', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640166468777_Screenshot_59.png?alt=media&token=07748d31-4c66-4c7f-9a1d-288e6b824e3c', 1, 120, 2000000.00, '<p><span style=\"background-color:rgb(246,246,246);color:rgb(122,122,122);\">Nếu bạn chọn tập gym để giảm cân thì bạn cần đặc biệt lưu ý tới chế độ ăn uống, vì nó chiếm 70% vai trò quyết định quá trình giảm cân có thành công hay không. Để giúp việc giảm cân của bạn đạt kết quả tốt nhất, bài viết dưới đây Swequity sẽ cung cấp tới bạn chế độ ăn khi tập gym giảm cân một cách khoa học, bài bản nhất. Tham khảo ngay nhé.</span></p>', '<p>Những quy tắc cần có khi xây dựng chế độ ăn tập gym giảm cân bạn cần nắm rõ gồm:&nbsp;</p><p><i><strong>#Thực phẩm giúp giảm mỡ, giảm cân</strong></i></p><p>Để giảm cân hiệu quả, bạn cần hạn chế dung nạp chất béo vào trong cơ thể, hạn chế thực phẩm chiên xào, đồ nước. Và cũng nên hạn chế uống nước ngọt hay đồ có gas…&nbsp;</p><p>Bổ sung thực phẩm cần thiết cho cơ thể như chất xơ, protein trong bữa ăn hàng ngày. Chia nhỏ bữa ăn để giúp cơ thể hấp thụ tối đa dinh dưỡng. Không được bỏ bữa.&nbsp;</p><p><i><strong>#Chế độ tập luyện</strong></i></p><p>Việc tập luyện cũng rất quan trọng, một chế độ ăn đem lại kết quả tốt là nó cần kết hợp với 1 chế độ tập luyện khoa học, phù hợp. Hãy tập luyện đều đặn các bài tập theo từng bộ phận khác nhau để giảm mỡ, giảm cân và tăng cơ.&nbsp;</p>', 'Pending', 'Active', 49, 11, 1, '2021-12-22 16:49:20', '2021-12-22 20:13:16');
INSERT INTO `courses` VALUES (16, 'Học nhảy Shuffle Dance từ cơ bản đến nâng cao', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640166719810_shuffle.jpg?alt=media&token=ace78fba-b480-4b99-a4bc-26c1123dfbc2', 4, 60, 600000.00, '<p>Khóa học Shuffle Dance cơ bản sẽ giúp bạn có thể tự tin nhảy và thể hiện mình, cải thiện được sức khỏe, duy trì được vóc dáng đẹp và một cơ thể cân đối và đầy quyến rũ. Bạn sẽ cảm nhận được sự uyển chuyên của cơ thể rõ rệt chỉ sau vài buộc học đầu tiên.</p>', '<p>Shuffle Dance là một điệu nhảy phổ biến, sử dụng phần lớn là các động tác ở chân cùng với tiết tấu âm nhạc vui tươi đem lại sự thoải mái tự do cho người học. Chính vì điều đó, Shuffle Dance đã tạo ra sự sức hút mới, nhanh chóng lôi cuốn nhiều người tham gia. Đến với giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đến từ Sweet Media.</p><p>&nbsp;</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Fshuffle.jpg?alt=media&amp;token=76471679-3533-4f08-8ebc-f0283f0c2f48\"></figure><p>&nbsp;Sweet Media tập trung sản xuất các khoá học online nhiều lực vực giúp đa dạng hóa lựa chọn cho học viên. Điển hình như: nhảy hiện đại, gym, zumba, shuffle dance,... Tìm hiểu sâu hơn về khoá học shuffle dance, các bạn sẽ được hướng dẫn cụ thể qua những bài giảng từ cơ bản đến nâng cao do chính những huấn luyện viên chuyên nghiệp dạy nhảy dance cơ bản giúp bạn dễ dàng luyện tập một cách an toàn và hiệu quả. Bạn có thể hoàn toàn tin tưởng lựa chọn về khoá học Shuffle Dance cơ bản mà không cần phải lo lắng băn khoăn học nhảy shuffle dance ở đâu nữa. Giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đặc biệt dành cho những bạn bận rộn, không có nhiều thời gian tập luyện, những bạn vì nhiều lý do mà không thể tham gia các lớp học nhảy Shuffle Dance trực tiếp tại các trung tâm. Bạn có thể tham gia khoá học và luyện tập cùng giảng viên chuyên nghiệp ở bất kỳ nơi nào vào thời điểm thuận lợi. Khoá học shuffle dance cơ bản mang đến cho bạn trải nghiệm cá nhân hoá tối ưu nhất. Giúp bạn đạt được hiệu quả tối đa nhờ phương pháp giảng dạy nhảy dance cơ bản đến nâng cao bài bản. Đảm bảo khi bạn hoàn thành xong khóa học, bạn sẽ có được trang bị đầy đủ nhất những kiến thức về Shuffle Dance và sở hữu một thân hình bốc lửa để tự tin thể hiện trước đám đông. Ngoài ra còn rất nhiều lợi ích thần kỳ của bộ môn nghệ thuật này mang lại đến với sức khoẻ của bạn. Tham gia để khám phá ngay hôm nay!</p><p>&nbsp;Đăng ký và tham gia khoá học ngay thôi!</p>', 'Happening', 'Active', 48, 10, 2, '2021-12-22 16:52:25', '2021-12-23 03:16:31');
INSERT INTO `courses` VALUES (17, 'Học nhảy Dance Cardio - Đốt cháy năng lượng mỗi ngày', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640166970180_c%E1%BA%A3io.jpg?alt=media&token=899dc619-01e9-406d-bc1b-f7e4863e253b', 4, 45, 700000.00, '<p>Tập Dance Cardio Lấy mỗi ngày để lấy lại vóc dáng, có một cơ thể săn chắc, linh hoạt, tràn đầy sức sống.</p>', '<p>Khóa học Học nhảy Dance Cardio - Đốt cháy năng lượng mỗi ngày gồm những động tác từ cơ bản đến nâng cao, sau đó giảng viên sẽ hướng dẫn bạn ghép thành tổ hợp hoạt động liên hoàn trong một bài hát giúp đốt cháy năng lượng một cách hiệu quả nhất.&nbsp;</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Fc%E1%BA%A3io.jpg?alt=media&amp;token=e1ee8ff1-1c4f-4f1c-95d9-b042e2ede649\"></figure><p>Giáo trình đặc biệt dành cho những bạn bận rộn, không có nhiều thời gian tập luyện. Giúp bạn cải thiện thể lực, duy trì vóc dáng cân đối của cơ thể, năng lượng tràn trề.</p><p>&nbsp;Bạn sẽ cảm nhận được sự khác biệt ngay sau những buổi học giảm cân đầu tiên. Việc kiên trì luyện tập sẽ giúp bạn rèn luyện sức khoẻ và sở hữu thân hình thon gọn bốc lửa. Bạn đã sẵn sàng để cùng UNICA trở lên cuốn hút từng ngày không?</p>', 'Request', 'Active', 48, 10, 1, '2021-12-22 16:56:12', '2021-12-23 03:11:36');
INSERT INTO `courses` VALUES (18, 'Cách tập gym hiệu quả dành cho phái mạnh từ trung tâm thể hình hàng đầu', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640169289570_Screenshot_58.png?alt=media&token=cfacb791-b506-4db2-8b7b-f8082ff691dc', 1, 120, 500000.00, '<p><span style=\"background-color:rgb(246,246,246);color:rgb(122,122,122);\">Cơ thể khỏe mạnh, săn chắc, cơ bụng 6 múi thu hút mọi ánh nhìn từ phái nữ là điều tất cả các anh em đều mong muốn. Để có được điều này, bạn phải có một chế độ tập luyện và ăn uống hợp lý, khoa học. Trong bài viết này, Swequity.vn xin hướng dẫn bạn chế độ tập gym hiệu quả dành cho cả nam giới.&nbsp;</span></p>', '<p><strong>Cách tập gym hiệu quả</strong></p><p>&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-1024x558.jpg\" alt=\"\" srcset=\"https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-1024x558.jpg 1024w, https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-300x164.jpg 300w, https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua-768x419.jpg 768w, https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-hieu-qua.jpg 1500w\" sizes=\"100vw\" width=\"1024\">Cách tập gym hiệu quả cùng Swequity</p><p>&nbsp;</p><p>Tập gym là cách hiệu quả nhất giúp anh em có được sức khỏe dồi dào cùng với thân hình săn chắc, vạm vỡ. Cách tập gym hiệu quả là tập trung vào rèn luyện 5 nhóm cơ chính sau theo một lịch tập khoa học:&nbsp;</p><p>Cơ ngực: Ngực trên, ngực giữa và ngực dưới (người mới tập không nên tập ngực dưới ngay).&nbsp;</p><p>Cơ tay: Gồm cẳng tay, bắp tay trước và tay sau&nbsp;</p><p>Cơ vai: Cơ cầu vai, cơ vai trước, vai sau và vai giữa.&nbsp;</p><p>Nhóm cơ lưng: Cơ xô, cơ lưng trên, lưng dưới và lưng giữa.&nbsp;</p><p>Cơ chân: Đùi trước, đùi sau, bắp chuối</p>', 'Happening', 'Active', 49, 11, 2, '2021-12-22 17:35:17', '2021-12-23 03:16:05');
INSERT INTO `courses` VALUES (19, 'Cách tập gym hiệu quả nhưng vẫn đảm bảo an toàn', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640169508898_Screenshot_58.png?alt=media&token=d892d12c-b2c2-45da-a12d-21a5eb83d14f', 1, 120, 200000.00, '<p><span style=\"background-color:rgb(246,246,246);color:rgb(122,122,122);\">Việc tập gym không đơn giản là chỉ đến phòng gym thực hiện bài tập mà bạn cần nắm rõ các kiến thức xung quanh việc tập để có được kết quả tốt nhất. Bài viết dưới đây, Swequity sẽ hướng dẫn bạn cách tập gym đúng chuẩn mang tới hiệu quả cao nhưng vẫn đảm bảo an toàn khi luyện tập.&nbsp;</span></p>', '<p><strong>Cách tập gym an toàn và hiệu quả</strong></p><p>&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym.jpg\" alt=\"\" srcset=\"https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym.jpg 700w, https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-300x200.jpg 300w\" sizes=\"100vw\" width=\"700\"></p><p style=\"text-align:center;\">Cách tập gym hiệu quả và an toàn</p><p>&nbsp;</p><p><i>Khởi động và thả lỏng</i></p><p>Đây là 2 vấn đề gymer luôn cần ghi nhớ trước và sau khi tập gym:&nbsp;</p><p>– Bởi đây là loại hình tập luyện đòi hỏi cơ bắp phải vấn động liên tục, do đó bạn hãy chú ý khởi động trước khi tập để làm nóng cơ thể nhé. Nó là bước đệm để chuyển cơ thể từ trạng thái tĩnh sang vận động nhẹ rồi mới tới mạnh.&nbsp;</p><p>– Sau khi kết thúc quá trình tập luyện, để tránh gặp phải hiện tượng đau nhức hoặc co cơ, bạn cần thả lỏng để cơ thể được trở về trạng thái bình thường ban đầu.&nbsp;</p><p><i>Không ăn quá no hoặc quá đói khi tập</i></p><p>Khi tập gym cơ bắp của bạn sẽ phải vận động mạnh, điều này sẽ khiến cơ thể bị tiêu hao năng lượng. Để tránh gặp phải tình trạng mệt, lả hoặc ngất khi tập bạn nên ăn nhẹ trước khi tập và uống 0,5 lít nước để khi tập mồ hôi ra nhiều sẽ tốt hơn. Lưu ý ăn ở mức vừa phải, ko nên ăn quá no nhé.&nbsp;</p><p><i>Xác định rõ mục đích tập luyện</i></p><p>Đây là một trong những cách tập gym rất quan trọng. Cụ thể, bạn cần xác định rõ mục đích của bạn khi đến với gym là gì, tăng cân, giảm cân, cải thiện vóc dáng hay đơn giản chỉ là giảm stress? Điều đó sẽ giúp bạn lựa chọn được phương án tập luyện phù hợp để hoàn thành mục tiêu của mình với kết quả tốt nhất.</p><p style=\"text-align:center;\"><img src=\"https://swequity.vn/wp-content/uploads/2020/03/cach-tap-gym-1-1.jpg\" alt=\"\"></p><p>&nbsp;</p><p><i>Thời gian tập luyện</i></p><p>Với người mới, nên tập 6 buổi/tuần trong 3 tháng đầu, thời gian tập là 30 phút/ngày. Hãy dành thời gian để nghỉ ngơi giúp cơ bắp được co giãn, không bị mỏi sau khi vận động liên tục.&nbsp;</p><p>Với người đã tập từ 3 – 6 tháng, nên tập 1h/ngày, tập từ 6 – 12 tháng nên tập 1h30p/ngày. Với người đã tập từ 1 đến 2 năm thì nên tập từ 3 – 4 ngày/tuần và tập ít nhất 2h/ngày.</p><p><i>Đa dạng hóa các bài tập</i></p><p>Nếu bạn mới tập gym, bạn không nên tập theo cách tập của những người đã tập lâu ngày hoặc thực hiện các bài tập quá sức so với khả năng của mình. Vì hiệu quả của việc tập gym không phụ thuộc vào việc tập nặng hay nhẹ, nhiều hay ít mà quan trọng là cần tập đúng kỹ thuật và ăn vào các cơ mới đảm bảo hiệu quả.</p><p><i>Uống nước đầy đủ&nbsp;</i></p><p>Trong khi tập, bạn nên bổ sung nước cho cơ thể nhiều hơn mức bình thường để bù cho lượng mồ hôi đã thoát ra. Hãy uống nước trước khi tập 30 phút, uống vào thời gian nghỉ ngơi giữa các hiệp và uống sau khi tập. Nên uống nước lọc, tránh xa đồ uống có gas hoặc quá ngọt.</p><p><i>Ăn uống đúng cách</i></p><p>Chế độ dinh dưỡng sẽ quyết định đến 60% kết quả đạt được khi tham gia tập gym. Bởi vậy, bạn cần am hiểu chế độ dinh dưỡng khi tập gym và xây dựng thực đơn phù hợp với mục đích tập luyện của mình.</p><p><i>Ngủ đủ giấc, đặc biệt là ban đêm&nbsp;</i></p><p><i>Đây là cách tập gym rất quan trọng, cơ thể </i>bạn sẽ tiết ra hormon tăng trưởng, testosterone và IGF – 1 khi ngủ. Chúng có tác dụng giúp cơ thể phục hồi sau thời gian tập luyện kéo dài và cải tạo cơ bắp. Đặc biệt, ngủ đủ giấc vào ban đêm sẽ giúp bạn có được năng lượng tuyệt vời cho ngày hôm sau.&nbsp;</p>', 'Happening', 'Active', 49, 11, 2, '2021-12-22 17:38:59', '2021-12-23 03:16:24');
INSERT INTO `courses` VALUES (20, 'Bài tập gym cơ bản cho nam phát triển cơ ngực', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640170964245_Screenshot_63.png?alt=media&token=f5f5fadd-8a10-4236-bfb2-5942ea9f4ae8', 1, 120, 1000000.00, '<p style=\"text-align:justify;\">Bạn mong muốn sở hữu thân hình săn chắc, cơ bắp cuồn cuộn 6 múi với sức khoẻ, sức bền dẻo dai?</p><p style=\"text-align:justify;\">Bạn mong muốn tìm được một bộ môn thể thao giúp bạn giải toả căng thẳng, mệt mỏi, stress sau những giờ làm việc căng thẳng</p><p style=\"text-align:justify;\">Bạn là một người bận rộn không có thời gian để đến phòng tập hay là người hạn hẹp kinh tế không đủ điều kiện để chi trả cho chi phí phòng tập đắt đỏ trong nhiều tháng liền?</p><p style=\"text-align:justify;\">Để giải đáp được mọi khó khăn và đáp ứng yêu cầu của bạn. Unica mang đến cho bạn khoá học giảm cân online mua 1 lần sở hữu trọn đời <i><strong>Hướng dẫn tự tập Fitness tại nhà hiệu quả trong 8 tuần</strong></i> của huấn luyện viên&nbsp;<i><strong> Mai Văn Anh&nbsp;</strong></i> <i><strong>đến từ Sweet Media</strong></i>.</p><p style=\"text-align:justify;\">Calisthenics là 1 môn tập luyện rèn luyện sức khỏe, tạo vóc dáng thẩm mỹ, thân hình cường tráng nhưng có độ dẻo dai cho người tập. Sử dụng chính trọng lượng cơ thể để tập luyện nên Calisthenics phù hợp với tập cả mọi người, dễ dàng tập luyện mà không cần những dụng cụ tập luyện cầu kỳ như trong phòng gym.</p><p style=\"text-align:justify;\">Đến với khóa học <i><strong>Hướng dẫn tự tập Fitness tại nhà hiệu quả trong 8 tuần</strong></i>, các bạn sẽ được hướng dẫn cụ thể qua những bài giảng từ cơ bản đến nâng cao, giúp bạn dễ dàng luyện tập một cách an toàn và hiệu quả. Qua 66 bài giảng với 5 phần bài tập dành cho những bạn bận rộn, không có nhiều thời gian tập luyện tham gia các lớp tập luyện trực tiếp tại các trung tâm được xây dựng bài bản:</p>', '<p style=\"text-align:justify;\">Phần 1: Các động tác cơ bản</p><p style=\"text-align:justify;\">Phần 2: Các động tác nâng cao</p><p style=\"text-align:justify;\">Phần 3: Ghép tổ hợp động tác</p><p style=\"text-align:justify;\">Phần 4: Hướng dẫn tập trong 4 tuần đầu tiên&nbsp;</p><p style=\"text-align:justify;\">Phần 5: Hướng dẫn tập trong 4 tuần tiếp theo</p><p style=\"text-align:justify;\">Đảm bảo khi bạn hoàn thành xong khóa học, bạn sẽ có được trang bị đầy đủ nhất những kiến thức về Calisthenics để sẵn sàng thay đổi bản thân với 1 thân hình chuẩn mẫu và sức khỏe kinh ngạc.</p><p style=\"text-align:justify;\"><i><strong>Giảng viên: &nbsp;Mai Văn Anh&nbsp;</strong></i></p><p style=\"text-align:justify;\"><i>+ HLV chuyên nghiệp tại Tổ chức thể dục đường phố Việt Nam cho các vận động viên.</i></p><p style=\"text-align:justify;\"><i>+ Chủ tịch Tổ chức thể dục đường phố Việt Nam</i></p><p style=\"text-align:justify;\"><i>+ Thành viên của Liên đoàn thể dục đường phố Thế giới</i></p><p style=\"text-align:justify;\"><i>+ Thành viên Nhóm Sáu Múi tại chung kết Vietnam\'s Got talent 2014 - 2015</i></p><p style=\"text-align:justify;\"><i>+ HLV cá nhân Gym</i></p>', 'Request', 'Active', 49, 11, 2, '2021-12-22 18:02:49', '2021-12-23 03:14:53');
INSERT INTO `courses` VALUES (21, '30 Ngày giảm mỡ cùng giáo án Fitness', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640194133082_hihi3.jpeg?alt=media&token=c3903acb-1d0a-49b7-bbcc-9716451ea8dd', 4, 60, 699000.00, '<p>Sau khoảng 30 ngày tập luyện sẽ bạn giảm mỡ và body săn chắn và thon gọn. Khoá học 30 thay đổi diện mạo làm bạn trở nên tự tin hơn trước mọi ánh mắt. Nó không chỉ giúp bạn về mặt sắc đẹp mà còn giúp sức khoẻ của bản thân tăng lên bội phần.</p>', '<p style=\"text-align:justify;\">Khoá học 30 thay đổi diện mạo làm bạn trở nên tự tin hơn trước mọi ánh mắt. Nó không chỉ giúp bạn về mặt sắc đẹp mà còn giúp sức khoẻ của bản thân tăng lên bội phần.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">&nbsp;- &nbsp;Bạn đang phải đối mặt với những vấn đề liên quan đến cân nặng</p><p style=\"text-align:justify;\">&nbsp;- &nbsp;Bạn đang cần phải giảm cân nhanh</p><p style=\"text-align:justify;\">&nbsp;- &nbsp;Bạn sắp đám cưới muốn có body đẹp</p><p style=\"text-align:justify;\">&nbsp;- &nbsp;Bạn đang muốn tạo những đường nét gợi cảm hằng mơ ước cho vóc dáng của chính bạn.</p><p style=\"text-align:justify;\">- &nbsp; Bạn không dám tin rằng mình sẽ giảm cân tại nhà trong 30 ngày</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Điều đó khiến bạn mất tự tin và tỷ lệ mắc phải các bệnh nguy hiểm là rất cao. Dan Fitness giới thiệu đến bạn giáo án tập luyện giảm cân nhanh tại nhà trong 30 ngày với videos thiết kế bài tập bài bản và dễ tập&nbsp;</p><p style=\"text-align:justify;\">&nbsp;</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Fhihi2.jpeg?alt=media&amp;token=8b91f9b5-a384-4ef6-adb4-8746f9c0cd34\"></figure><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Khoá học <i><strong>30 Ngày giảm mỡ cùng giáo án Fitness </strong></i>của huấn luyện viên <i><strong>Thủy Hoàng Dân</strong></i> là một trong những sản phẩm rất thành công và tạo nên thương hiệu Dan Fitness Chắc chắn bạn cũng sẽ rất hài lòng vì kết quả đạt được sau khoảng 3 ngày tập luyện.</p><p style=\"text-align:justify;\">Khoá <a href=\"https://unica.vn/tag/giam-can\">học giảm cân online</a> chia ra làm 5 phần dưới sự hướng dẫn chuyên nghiệp của huấn luyện viên sẽ chia sẻ đến bạn những kiến thức, phương pháp, bài tập,... chi tiết:</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\"><strong>&nbsp;CHI TIẾT GIAI ĐOẠN</strong></p><p style=\"text-align:justify;\">Phần 1: Tổng quan giáo án tập luyện</p><p style=\"text-align:justify;\">Phần 2: Dinh dưỡng trong tập luyện - Khởi động - Căng cơ</p><p style=\"text-align:justify;\">Phần 3: Giáo án tập Mông - Đùi - Bụng</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\"><strong>CHẾ ĐỘ DINH DƯỠNG</strong></p><p style=\"text-align:justify;\">Hướng dẫn căn bản để học viên dễ dàng nắm bắt và áp dụng: lựa chọn những thực phẩm Đạm tốt, ít chất béo, giàu chất xơ và các loại trái cây phù hợp. Như vậy, bạn sẽ được cung cấp đủ chất dinh dưỡng, năng lượng để hoạt động nhưng lại có thể hỗ trợ cho quá trình giảm cân trong khoảng 30 ngày</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\"><strong>CHẾ ĐỘ TẬP LUYỆN</strong></p><p style=\"text-align:justify;\">Bạn sẽ tập luyện bằng phương pháp FITNESS hiện đại. Đây là phương pháp tập luyện kết hợp và vận dụng nhiều nhóm cơ trong cùng một bài tập giúp đem lại hiệu quả nhanh nhất trong việc giảm mỡ toàn thân, đặc biệt là mỡ vùng Bụng – Eo – Mông, cải thiện các khuyết điểm trên cơ thể, đặc biệt là các khuyết điểm về tư thế của các đối tượng làm việc Văn phòng – Ngồi nhiều và Ít vận động.</p><p style=\"text-align:justify;\">Hệ thống bài tập được thiết kế dựa trên các động tác chính trong 7 yếu tố Fitness giúp tác động đúng các nhóm cơ và cải thiện sức khoẻ, vóc dáng tốt.</p>', 'Happening', 'Active', 2, 7, 1, '2021-12-23 00:29:22', '2021-12-23 08:24:03');
INSERT INTO `courses` VALUES (22, 'Khóa học tăng cơ giảm mỡ trong 21 ngày', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640194650680_khoa-hoc-dinh-duong-giam-can-online-5.jpg?alt=media&token=a9bdf16c-4753-4116-beb7-bf1b3d0aa9c4', 4, 60, 1000000.00, '<p>Khóa học được thiết kế dành riêng cho bạn, gần 40 công thức chế biến các món ăn sạch theo chế độ Clean Eating giúp tăng cơ, giảm mỡ, cho một sức khỏe toàn diện Menu mẫu cho 21 ngày ăn sạch. Từ các món ăn sáng, giữa buổi, ăn trưa, ăn xế, ăn tối, bạn sẽ tự tạo cho mình những thực đơn ăn sạch không nhàm chán.</p>', '<p style=\"text-align:justify;\">Có vể như những điều bạn muốn thực hiện nó thực sự rất khó khăn và bạn không thể nào tránh được và thực hiện được nó.</p><p style=\"text-align:justify;\">Vậy còn chần chờ gì nữa, hãy nhanh tay đăng kí khóa học giảm cân online <i><strong>Clean Eating từ A-Z: Tăng cơ giảm mỡ trong 21 ngày</strong></i> của giảng viên Nguyễn Quỳnh Nga trên YMđể nắm vững những công thức ăn uống trong lành.</p><p style=\"text-align:justify;\">Khóa học được thiết kế dành riêng cho bạn, gần 40 công thức chế biến các món ăn sạch theo chế độ Clean Eating giúp tăng cơ, giảm mỡ, cho một sức khỏe toàn diện Menu mẫu cho 21 ngày ăn sạch. Từ các món ăn sáng, giữa buổi, ăn trưa, ăn xế, ăn tối, bạn sẽ tự tạo cho mình những thực đơn ăn sạch không nhàm chán.</p><p style=\"text-align:justify;\">Nhiều nghiên cứu đã chỉ ra rằng, nếu bạn lặp đi lặp lại một hành động nào đó trong 21 ngày, một thói quen mới sẽ hình thành. Vậy, khóa học “<i><strong> Clean Eating từ A-Z: Tăng cơ giảm mỡ trong 21 ngày</strong></i>” sẽ giúp bạn nhanh chóng giảm được lượng mỡ thừa ra khỏi cơ thể, tận hưởng và cảm nhận sự tươi mới, những thay đổi tích cực từ trong ra ngoài.</p>', 'Happening', 'Active', 51, 13, 1, '2021-12-23 00:38:21', '2021-12-23 03:16:18');
INSERT INTO `courses` VALUES (23, 'Giảm mỡ bụng triệt để sau 1 tháng', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640194856343_cach-giam-can-cho-nhan-vien-van-phong(1).jpg?alt=media&token=885bb91c-d5db-4f8d-9a02-a4e3af2b112b', 4, 45, 300000.00, '<p>Hướng dẫn bạn các bài tập, động tác Yoga giúp chị em đốt cháy mỡ thừa, giảm cân triệt để, nhanh chóng lấy lại vóc dáng thon gọn, cơ thể săn chắc, đẩy lùi bệnh tập, tăng sự tự tin, hấp dẫn cho chị em</p>', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p><p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.&nbsp;</p><p style=\"text-align:justify;\">Đừng lo lắng! Tất cả sẽ được giải quyết chỉ với một khóa học duy nhất của Luna Thái tại Unica: Khóa học <i><strong>\"Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i></p><p style=\"text-align:justify;\">Khóa học \"<i><strong>Yoga - Giảm mỡ bụng triệt để sau 1 tháng\"</strong></i>&nbsp;gồm 23 bài tập là những bài tập, các động tác giúp chị em đốt cháy mỡ thừa, đặc biệt ở vùng bụng, đùi, bắp tay. Đồng hành cùng bạn chính là giảng viên Luna Thái sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ&nbsp;sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', 'Request', 'Active', 51, 13, 1, '2021-12-23 00:40:59', '2021-12-23 03:14:29');
INSERT INTO `courses` VALUES (24, 'Đốt cháy mỡ tại nhà với nhảy hiện đại', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Ftrungsky_1640195032068_hihi9.jpeg?alt=media&token=4ec64a90-d799-4b55-b724-11df4d18cb5a', 4, 60, 729000.00, '<p>Eo thon - dáng đẹp với nhảy hiện đại ngay hôm nay! Khóa học nhảy hiện đại giúp bạn nhanh chóng lấy lại được vóc dáng quyến rũ hoàn hảo vốn có, cải thiện sức khỏe, đánh bay stress, trẻ hóa toàn thân</p>', '<p><strong>Có phải bạn vẫn luôn trăn trở về cơ thể của mình?</strong></p><p>&nbsp;</p><p style=\"text-align:justify;\">Làm sao để đốt cháy mỡ thừa? Làm sao để có thể lấy lại thân hình thon gọn nóng bỏng và dẻo dai như trước đây? Làm sao để có thể vừa luyện tập hiệu quả vừa tiết kiệm được chi phí luyện tập... Học giảm cân online là nhu cầu của rất nhiều chị em, đặc biệt là giới văn phòng ít vận động, thiếu thốn thời gian để tập luyện.</p><p style=\"text-align:justify;\">Thân hình quá khổ, thừa cân, vòng eo lớn,... khiến chị em thiếu tự tin trong giao tiếp, gặp nhiều cản trở trong công việc và ngay cả chuyện tình cảm.</p><p style=\"text-align:justify;\">Đồng thời cân nặng vượt mức sẽ khiến cơ thể trở nên nặng nề, chậm chạp và gặp nhiều các vấn đề về sức khỏe như tim mạch, vận động...</p><p style=\"text-align:justify;\">Chính vì thế, giảm cân nhanh chóng đốt cháy lượng mỡ thừa chính là chăm lo cho sự nghiệp, tình cảm và sức khỏe của bạn.&nbsp;</p><p style=\"text-align:justify;\">&nbsp;</p><figure class=\"image\"><img src=\"https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/uploads%2Fhihi7.jpeg?alt=media&amp;token=e32b6986-b706-47fe-b100-7e2e111d9b4e\"></figure><p style=\"text-align:justify;\">&nbsp;</p><p><strong>Đăng ký ngay khóa học \"Đốt cháy mỡ tại nhà với nhảy hiện đại\" tại YM</strong></p><p>&nbsp;</p><p style=\"text-align:justify;\">Khóa học là tổng hợp các động tác và kỹ thuật thực hành các bài tập nhảy từ đơn giản cho đến phức tạp, giúp học viên không bị \"ngợp\" khi mới bắt đầu luyện tập nhảy giảm cân tại nhà,&nbsp;sớm làm quen vời các bài tập hay kỹ thuật nhảy và nhanh chóng gặt hái được những kết quả đầu tiên.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">&nbsp; &nbsp; &nbsp;✔️ Tham gia khóa học này bạn sẽ ngay lập tức cảm nhận được sự thay đổi của bản thân chỉ sau những bài tập cơ bản đầu tiên.</p><p style=\"text-align:justify;\">&nbsp; &nbsp; &nbsp;✔️ Giảm cân hiệu quả, đốt cháy mỡ thừa và trả lại thân hình quyến rũ, dẻo dai cho bạn</p><p style=\"text-align:justify;\">&nbsp; &nbsp; &nbsp;✔️ Rũ sạch stress, sảng khoái tinh thần hơn sau mỗi bài tập nhảy hết mình</p><p style=\"text-align:justify;\">&nbsp; &nbsp; &nbsp;✔️ Thải độc cho cơ thể, ngăn chặn lão hoá, trẻ hóa cơ thể và làn da</p><p style=\"text-align:justify;\">&nbsp; &nbsp; &nbsp;✔️ Tự tin “phiêu” cùng bạn bè tại các bữa tiệc, các buổi party với đồng nghiệp</p><p style=\"text-align:justify;\">&nbsp; &nbsp; &nbsp;✔️ Vận động tối đa, kích thích tim đập nhanh và lưu thông máu tốt hơn, cải thiện sức khỏe thêm dẻo dai đầy sức sống hơn</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Vậy còn chờ gì nữa, nhanh chóng lấy lại vóc dáng thanh xuân quyến rũ và sức khỏe tuyệt vời ngay hôm nay chỉ với một khóa học duy nhất&nbsp;<i><strong>\"Đốt cháy mỡ tại nhà với nhảy hiện đại\"&nbsp;</strong></i>tại YM!</p>', 'Pending', 'Active', 2, 1, 1, '2021-12-23 00:42:12', '2021-12-23 00:52:45');
COMMIT;

-- ----------------------------
-- Table structure for customer_levels
-- ----------------------------
DROP TABLE IF EXISTS `customer_levels`;
CREATE TABLE `customer_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of customer_levels
-- ----------------------------
BEGIN;
INSERT INTO `customer_levels` VALUES (1, 'Người chưa tiếp cận', '2021-10-03 01:47:22', '2021-10-03 01:47:22', NULL);
INSERT INTO `customer_levels` VALUES (2, 'Người đã tiếp cận', '2021-10-03 01:47:26', '2021-10-03 01:47:26', NULL);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES (10, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (11, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (12, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (13, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (14, '2021_09_29_164221_create_slides_table', 1);
INSERT INTO `migrations` VALUES (15, '2021_09_29_165908_create_settings_table', 1);
INSERT INTO `migrations` VALUES (16, '2021_09_29_170116_create_contacts_table', 1);
INSERT INTO `migrations` VALUES (17, '2021_09_29_170456_create_roles_table', 1);
INSERT INTO `migrations` VALUES (18, '2021_09_30_064804_create_customer_levels_table', 1);
INSERT INTO `migrations` VALUES (19, '2021_10_03_015645_change_column_alt_slide_table', 2);
INSERT INTO `migrations` VALUES (22, '2021_10_04_100205_change_column_user_table', 3);
INSERT INTO `migrations` VALUES (30, '2021_10_04_220237_add_column_is_mutable_table_roles', 4);
INSERT INTO `migrations` VALUES (31, '2021_10_05_002108_create_specializes_table', 4);
INSERT INTO `migrations` VALUES (33, '2021_10_05_011337_create_model_has_roles_table', 5);
INSERT INTO `migrations` VALUES (34, '2016_06_01_000001_create_oauth_auth_codes_table', 6);
INSERT INTO `migrations` VALUES (35, '2016_06_01_000002_create_oauth_access_tokens_table', 6);
INSERT INTO `migrations` VALUES (36, '2016_06_01_000003_create_oauth_refresh_tokens_table', 6);
INSERT INTO `migrations` VALUES (37, '2016_06_01_000004_create_oauth_clients_table', 6);
INSERT INTO `migrations` VALUES (38, '2016_06_01_000005_create_oauth_personal_access_clients_table', 6);
INSERT INTO `migrations` VALUES (40, '2021_10_05_211616_create_certificates_table', 7);
INSERT INTO `migrations` VALUES (41, '2021_10_05_234804_create_specialize_details_table', 8);
INSERT INTO `migrations` VALUES (42, '2021_10_06_222417_create_courses_table', 9);
INSERT INTO `migrations` VALUES (43, '2021_10_07_215032_create_stages_table', 10);
INSERT INTO `migrations` VALUES (44, '2021_10_07_224059_add_column_created_by_courses_table', 11);
INSERT INTO `migrations` VALUES (46, '2021_10_09_100627_create_course_planes_table', 12);
INSERT INTO `migrations` VALUES (47, '2021_10_10_232718_add_column_deleted_at_users_table', 13);
INSERT INTO `migrations` VALUES (48, '2021_10_11_150642_add_column_display_courses_table', 14);
INSERT INTO `migrations` VALUES (49, '2021_10_11_214204_add_column_status_certificates_table', 15);
INSERT INTO `migrations` VALUES (50, '2021_10_11_214415_add_column_status_couser_planes_table', 15);
INSERT INTO `migrations` VALUES (53, '2021_10_13_105039_create_table_social_accounts', 16);
INSERT INTO `migrations` VALUES (54, '2021_10_13_105358_drop_colum_users_table', 16);
INSERT INTO `migrations` VALUES (55, '2021_10_13_112846_change_column_social_id_social_accounts_table', 17);
INSERT INTO `migrations` VALUES (57, '2021_10_19_001935_create_table_account_levels_table', 18);
INSERT INTO `migrations` VALUES (58, '2021_10_20_225648_add_column_is_mutable_table_account_levels', 19);
INSERT INTO `migrations` VALUES (59, '2021_10_21_014056_add_column_account_level_id_table_users', 20);
INSERT INTO `migrations` VALUES (60, '2021_10_24_214230_add_columns_image_table', 21);
INSERT INTO `migrations` VALUES (61, '2021_10_25_011338_drop_column_deleted_at_table_specialize_detail', 22);
INSERT INTO `migrations` VALUES (62, '2021_10_25_224609_add_column_type_video_table', 23);
INSERT INTO `migrations` VALUES (63, '2021_10_28_141838_create_payments_table', 24);
INSERT INTO `migrations` VALUES (66, '2021_10_31_215247_create_course_students_table', 25);
INSERT INTO `migrations` VALUES (67, '2021_10_31_214322_create_bills_table', 26);
INSERT INTO `migrations` VALUES (68, '2021_10_31_222307_add_column_bill_id_to_payments_table', 27);
INSERT INTO `migrations` VALUES (69, '2021_10_31_232104_add_column_note_to_payments_table', 28);
INSERT INTO `migrations` VALUES (70, '2021_11_01_005000_drop_column_bill_code_to_payments_table', 29);
INSERT INTO `migrations` VALUES (77, '2021_11_03_003650_create_table_schedules_table', 30);
INSERT INTO `migrations` VALUES (78, '2021_11_14_231209_change_column_status_courses_table', 31);
INSERT INTO `migrations` VALUES (80, '2021_11_18_232730_add_column_user_consent_table', 32);
INSERT INTO `migrations` VALUES (81, '2021_11_19_105832_change_colum_status_schedules_table', 33);
INSERT INTO `migrations` VALUES (82, '2021_11_19_110409_add_column_participation_complain_actual_start_time_actual_end_time_to_schedules_table', 33);
INSERT INTO `migrations` VALUES (83, '2021_11_20_151716_change_column_status_to_bills_table', 34);
INSERT INTO `migrations` VALUES (84, '2021_11_20_151735_change_column_note_to_payments_table', 35);
INSERT INTO `migrations` VALUES (85, '2021_11_20_154816_add_column_reason_to_schedules_table', 36);
INSERT INTO `migrations` VALUES (86, '2021_11_25_232849_change_column_status_table_course_students', 37);
INSERT INTO `migrations` VALUES (87, '2021_11_27_114659_create_bill_personal_trainers_table', 38);
INSERT INTO `migrations` VALUES (88, '2021_11_27_190816_add_column_image_to_bill_personal_trainers_table', 39);
INSERT INTO `migrations` VALUES (89, '2021_11_27_225021_add_columns_check_link_record_to_schedules_table', 40);
INSERT INTO `migrations` VALUES (91, '2021_11_29_230708_add_column_description_table_user', 41);
INSERT INTO `migrations` VALUES (92, '2021_11_29_231404_create_table_socials', 42);
INSERT INTO `migrations` VALUES (93, '2021_11_29_232425_create_user_socials_table', 43);
INSERT INTO `migrations` VALUES (94, '2021_11_30_221344_add_column_money_old_to_bill_personal_trainers_table', 44);
INSERT INTO `migrations` VALUES (95, '2021_12_01_221300_create_table_permissions', 45);
INSERT INTO `migrations` VALUES (96, '2021_12_01_221550_create_table_role_has_permissions', 46);
INSERT INTO `migrations` VALUES (97, '2021_12_02_205030_create_comment_table', 47);
INSERT INTO `migrations` VALUES (98, '2021_12_13_223544_create_roles_table', 48);
INSERT INTO `migrations` VALUES (99, '2021_12_13_230914_create_courses_table', 49);
INSERT INTO `migrations` VALUES (100, '2021_12_16_013350_delete_column_deleted_at', 50);
INSERT INTO `migrations` VALUES (101, '2021_12_16_013807_deleted_at_column_table_stages', 51);
INSERT INTO `migrations` VALUES (102, '2021_12_16_014750_deleted_at_column_table_course_planes', 52);
INSERT INTO `migrations` VALUES (103, '2021_12_17_061617_delete_column_table_contact', 53);
INSERT INTO `migrations` VALUES (104, '2021_12_22_014547_delete_column_delete_at', 53);
INSERT INTO `migrations` VALUES (105, '2021_12_22_154327_update_column_description', 54);
COMMIT;

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` smallint(5) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
BEGIN;
INSERT INTO `model_has_roles` VALUES (1, 1, 1, '2021-12-13 22:51:59', '2021-12-13 22:51:59');
INSERT INTO `model_has_roles` VALUES (2, 2, 3, '2021-12-13 22:51:59', '2021-12-13 22:51:59');
INSERT INTO `model_has_roles` VALUES (160, 4, 2, '2021-12-13 22:51:59', '2021-12-13 22:51:59');
INSERT INTO `model_has_roles` VALUES (167, 2, 5, '2021-12-18 01:45:53', '2021-12-18 01:45:56');
INSERT INTO `model_has_roles` VALUES (200, 48, 3, NULL, NULL);
INSERT INTO `model_has_roles` VALUES (201, 49, 3, NULL, NULL);
INSERT INTO `model_has_roles` VALUES (202, 50, 2, NULL, NULL);
INSERT INTO `model_has_roles` VALUES (203, 51, 3, NULL, NULL);
INSERT INTO `model_has_roles` VALUES (204, 52, 3, NULL, NULL);
INSERT INTO `model_has_roles` VALUES (205, 53, 2, NULL, NULL);
INSERT INTO `model_has_roles` VALUES (206, 54, 2, NULL, NULL);
INSERT INTO `model_has_roles` VALUES (207, 55, 2, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------
BEGIN;
INSERT INTO `oauth_access_tokens` VALUES ('0041154acd95ba8920d18e8a194d02d595234137edd4d4cbe9ad6f55d8cc1144d8d4a5078b3d5792', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 00:35:41', '2021-12-14 00:35:41', '2021-12-16 00:35:40');
INSERT INTO `oauth_access_tokens` VALUES ('00930c450496b5c3df03777bec5291bff8712239bd3042210d9c8ac93ec09fd1df2911b76eb76af3', 11, 13, 'Personal Access Token', '[]', 0, '2021-12-18 16:52:33', '2021-12-18 16:52:33', '2021-12-20 16:52:33');
INSERT INTO `oauth_access_tokens` VALUES ('00e136d43ab66a230201b7f3a6bbd685231100ac434e0f62eb9cb731a95258555db12a1971a888f5', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 14:07:57', '2021-12-18 14:07:57', '2021-12-20 14:07:56');
INSERT INTO `oauth_access_tokens` VALUES ('011503fadcb8850d52bfb730b5f6de984439271df86fd3d9330c355cf3ca7be78954f44009f89727', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-23 23:07:26', '2021-12-23 23:07:26', '2021-12-25 23:07:26');
INSERT INTO `oauth_access_tokens` VALUES ('013a4bbb1049b0679555c9e7ab0e376bc409c19df4e4068be3ad3eb0fedf66f5e6f2f0a2a4db0121', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:08:50', '2021-12-20 23:08:50', '2021-12-22 23:08:50');
INSERT INTO `oauth_access_tokens` VALUES ('01b04be478d32609a174e0c54461950798fa114162abef7bc40f3af9a1e14731e2eabd521dca1219', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-19 00:16:11', '2021-12-19 00:16:11', '2021-12-21 00:16:10');
INSERT INTO `oauth_access_tokens` VALUES ('0277311b60b6f2e592343d6636b339430d84712796adeac5f588cc6cd8fb53fb4ce057127144544c', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:44:10', '2021-12-20 00:44:10', '2021-12-22 00:44:10');
INSERT INTO `oauth_access_tokens` VALUES ('02ccfb4c5046f9659c761dcda9d5eaf05112d288c7c185318715d6d2c919c3702de3184141d86d14', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 10:08:32', '2021-12-20 10:08:32', '2021-12-22 10:08:32');
INSERT INTO `oauth_access_tokens` VALUES ('03344a3a5f48226cb9a903dbe0756bd3840faa837f20f557d45f264572d9bd506eccbc45d3c0e4db', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-22 14:23:07', '2021-12-22 14:23:07', '2021-12-24 14:23:07');
INSERT INTO `oauth_access_tokens` VALUES ('039c1b49ec4ecac206537f93279cc150e4e56dfc72ee120ac479f1ca214362309c09d1ebda755b8a', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-21 20:49:28', '2021-12-21 20:49:28', '2021-12-23 20:49:28');
INSERT INTO `oauth_access_tokens` VALUES ('040d3530abba544cca7440e0de0fbb0aa3109ca435ca5471e9d992010eebcd999a80dfb458b2c81e', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 22:30:46', '2021-12-14 22:30:46', '2021-12-16 22:30:46');
INSERT INTO `oauth_access_tokens` VALUES ('0660141985b14a406e275981085226126856846edc20c7dfce2d8a8ac9c8403af5aa81869a6154f6', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-15 22:03:44', '2021-12-15 22:03:44', '2021-12-17 22:03:44');
INSERT INTO `oauth_access_tokens` VALUES ('066c93bfbde28c486f88ab9d5dd3aa852e9f1261f32179af5f76a00a91cb0f322647c41f4322fe5d', 7, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:02:01', '2021-12-20 21:02:01', '2021-12-22 21:02:01');
INSERT INTO `oauth_access_tokens` VALUES ('069d57095eeb7fcd1b8aa452b6f186c45c48303a23bd0f17f4e107ba0680cdabe21aa4cfba3eb9d0', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 11:22:51', '2021-12-17 11:22:51', '2021-12-19 11:22:50');
INSERT INTO `oauth_access_tokens` VALUES ('07817f8657a5a581ad0d531ca41497b8604b35ff44e44301615396d4a1353aa1a97ac4333d667a8d', 11, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:20:32', '2021-12-20 21:20:32', '2021-12-22 21:20:32');
INSERT INTO `oauth_access_tokens` VALUES ('081a71e125d9ca7d1e60dc68294a6232e50d6fa8ad5c9ec9ca041f199b668283d39432e0795caa4f', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 08:27:49', '2021-12-19 08:27:49', '2021-12-21 08:27:49');
INSERT INTO `oauth_access_tokens` VALUES ('08efd8b75da3edd1faf689908f7563b8ec691eb7225beb4d03fc05791cf7d57d033618b465c6d0e6', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 20:59:43', '2021-12-18 20:59:43', '2021-12-20 20:59:43');
INSERT INTO `oauth_access_tokens` VALUES ('090b03c3177f82bd6ae006bb95e571302b7bb2804c433d4a7c337360ff7cbf54c88d8bfcd912937d', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 22:35:11', '2021-12-17 22:35:11', '2021-12-19 22:35:11');
INSERT INTO `oauth_access_tokens` VALUES ('09546f6212882328efb23cc06db4dac60b7604ff1658b608068c5cc47fc5921a1eeff9f7fdf786b2', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 18:22:02', '2021-12-16 18:22:02', '2021-12-18 18:22:02');
INSERT INTO `oauth_access_tokens` VALUES ('09ee9382472c945f86825f181088a7438f5c66b5069fbb64f92799e3745977ec0475b25658f378cb', 51, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:11:56', '2021-12-23 01:11:56', '2021-12-25 01:11:56');
INSERT INTO `oauth_access_tokens` VALUES ('0a08facbdd8647e7a3e21b2327903ff6708ee1ae6b12b39a979b5fa4818bacbb041e6595adf6e296', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 02:25:42', '2021-12-14 02:25:42', '2021-12-16 02:25:42');
INSERT INTO `oauth_access_tokens` VALUES ('0a2c51a92d353e60b24cee5709877edccf9c1310db3c72610759a780c74bfe7ff58a39110cd1010e', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-14 03:29:29', '2021-12-14 03:29:29', '2021-12-16 03:29:29');
INSERT INTO `oauth_access_tokens` VALUES ('0acbca6e52b9426c62a87f289ab2036776acc106dec91f96d3bfc6b695e60ab10b2500b853ac8e31', 39, 13, 'Personal Access Token', '[]', 1, '2021-12-21 22:55:06', '2021-12-21 22:55:06', '2021-12-23 22:55:06');
INSERT INTO `oauth_access_tokens` VALUES ('0b7a7cad94fe5824948d44f7edf15915a754500397a8eac8657d0b0525682f028019b0164f988470', 7, 11, 'Personal Access Token', '[]', 0, '2021-12-14 04:20:47', '2021-12-14 04:20:47', '2021-12-16 04:20:47');
INSERT INTO `oauth_access_tokens` VALUES ('0b80e4f3ca30f30482e1a4a7a6351ee009ab0c318494c991e9a67b0f980c6700c73198bcc702e3bc', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:14:39', '2021-12-23 03:14:39', '2021-12-25 03:14:39');
INSERT INTO `oauth_access_tokens` VALUES ('0ba050f627dc3a04b24065de0ecc8cb126e56c64f81e7991d6f975c608d3aff93d699dd5cd21e8e1', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 12:41:36', '2021-12-17 12:41:36', '2021-12-19 12:41:35');
INSERT INTO `oauth_access_tokens` VALUES ('0bbfedf0c17cf13e9c0c7fd56c5c54148e64f7e9bce1fc3db10f55496abd25084fe395fc8fb1ec5e', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:25:59', '2021-12-23 01:25:59', '2021-12-25 01:25:59');
INSERT INTO `oauth_access_tokens` VALUES ('0caa7765ada3a899796646bfe0f16abf1832d391a8c9f8f798ce7700a720c59d71640bb5ab493454', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-15 04:12:26', '2021-12-15 04:12:26', '2021-12-17 04:12:26');
INSERT INTO `oauth_access_tokens` VALUES ('0d98c2d30d2f819cc83b20aafa7bb2359474b91cac47b44220b2fdb73fd5d782e608d74008545703', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 02:35:31', '2021-12-19 02:35:31', '2021-12-21 02:35:31');
INSERT INTO `oauth_access_tokens` VALUES ('0e1a36bfbaf955f25ce7bd0e949751a641cfc625b93fe83db298e3000bf996bf1556d379c884ef6e', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 21:09:43', '2021-12-14 21:09:43', '2021-12-16 21:09:43');
INSERT INTO `oauth_access_tokens` VALUES ('0ea2ab34e5d70812f4e886a73136e46c9dcd490fd6a599cc708d06fcd0c8ba2acb90de47b2ef3a34', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-19 23:27:21', '2021-12-19 23:27:21', '2021-12-21 23:27:21');
INSERT INTO `oauth_access_tokens` VALUES ('0ef1a6f7704ec0f5717183a2f9d66de5e7db3ab46ec1633427945e1775945472204a273c716f8613', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:05:47', '2021-12-23 03:05:47', '2021-12-25 03:05:47');
INSERT INTO `oauth_access_tokens` VALUES ('0f2fe8d90dc99db834bb058dc333ddde80b87352d0fab0a507142e7f9df608bb3c3ac57d337a42b4', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-20 23:22:40', '2021-12-20 23:22:40', '2021-12-22 23:22:39');
INSERT INTO `oauth_access_tokens` VALUES ('0f47abf2e1fdf17632409c59931c6dfc7ff71d6b8f4d7862b915969dc65fdddbdcbe6c84358b994f', 25, 13, 'Personal Access Token', '[]', 0, '2021-12-20 01:08:10', '2021-12-20 01:08:10', '2021-12-22 01:08:09');
INSERT INTO `oauth_access_tokens` VALUES ('0f52de9d5fd7b3f6fcc595b850e79a321f3a9461bcbc9cdda028cbb660e6a4cd755687bf56fb1523', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 23:29:10', '2021-12-14 23:29:10', '2021-12-16 23:29:10');
INSERT INTO `oauth_access_tokens` VALUES ('0fcb76a82f33d57e3325ee61d4f63fa3ce10608e0aa6c76eb10ace541fb819c36e46aa3d3b05f583', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 20:53:05', '2021-12-14 20:53:05', '2021-12-16 20:53:05');
INSERT INTO `oauth_access_tokens` VALUES ('0fdb8d5bc3bd79e488ef099e166eb3f01890f584aac97058e54e184889880b18e268f2c69336c801', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 22:21:04', '2021-12-20 22:21:04', '2021-12-22 22:21:04');
INSERT INTO `oauth_access_tokens` VALUES ('1007d41502c7d36457b29f5b8012781414c0aeecf2c46145f54d974e03c395c4cec5a58a3952f037', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:45:15', '2021-12-20 00:45:15', '2021-12-22 00:45:15');
INSERT INTO `oauth_access_tokens` VALUES ('106245cfa009589578dc2642867d06551edf28a120cb588aafe4de132aa94043e2d18ade876d3c53', 4, 11, 'Personal Access Token', '[]', 0, '2021-12-14 20:32:19', '2021-12-14 20:32:19', '2021-12-16 20:32:19');
INSERT INTO `oauth_access_tokens` VALUES ('107a3e2a357dcfbdc30d0b5fabbbcf5b42f0abc37dcbf71507d50e28c0121aef49d99a6609e9c352', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 02:13:02', '2021-12-22 02:13:02', '2021-12-24 02:13:01');
INSERT INTO `oauth_access_tokens` VALUES ('11591d1346ef27e587026540a5837c126a643e0f8825ea025d46c65e83f6fb897f6bc9a93dd0e028', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-21 23:22:37', '2021-12-21 23:22:37', '2021-12-23 23:22:37');
INSERT INTO `oauth_access_tokens` VALUES ('11605a0ded371b3edf30e1e546487085673a767c7d84a303a93f19fbe89271fe4611d7737561473b', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 01:05:09', '2021-12-21 01:05:09', '2021-12-23 01:05:08');
INSERT INTO `oauth_access_tokens` VALUES ('1165ecb5671fe9f8c1865a6cb1ea8e0a6f6fe6992779457238d2a06bd1a5a00ad9a9b3d4600413b0', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 19:24:50', '2021-12-21 19:24:50', '2021-12-23 19:24:50');
INSERT INTO `oauth_access_tokens` VALUES ('1192d471631fa39042b11b43933e75198dadf081a32996fc96940c062d6b19205ef95646d79f3cf8', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 02:16:26', '2021-12-22 02:16:26', '2021-12-24 02:16:26');
INSERT INTO `oauth_access_tokens` VALUES ('121a279e6f69c8449181bb51df174e6b31a232902c4a5746e74cf57033593493854cf17e35ed0daa', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-18 22:43:31', '2021-12-18 22:43:31', '2021-12-20 22:43:30');
INSERT INTO `oauth_access_tokens` VALUES ('1274985a34286281fc6cffd9a6b006a8e65ea82bc061e8d3508bb76975467f93bbed0073f69a16cc', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-14 22:26:55', '2021-12-14 22:26:55', '2021-12-16 22:26:55');
INSERT INTO `oauth_access_tokens` VALUES ('133a0d332bb5131c9c718ac06094044e3b9f42eacfdaf1a550754a4cfbd59efd933103de5259b214', 4, 11, 'Personal Access Token', '[]', 1, '2021-12-13 22:57:43', '2021-12-13 22:57:43', '2021-12-15 22:57:42');
INSERT INTO `oauth_access_tokens` VALUES ('135ef546a880947583d8ca4b9f7cb8848ff798858d7b5bd63d57e1d55e8abf94d33ce8cc4d71baf5', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-21 21:16:13', '2021-12-21 21:16:13', '2021-12-23 21:16:13');
INSERT INTO `oauth_access_tokens` VALUES ('14ed802a97eb80313a183064488605fe27bf6ec582c868ee3192705382b7de2bc5826b1bb63581c3', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:37:14', '2021-12-22 23:37:14', '2021-12-24 23:37:14');
INSERT INTO `oauth_access_tokens` VALUES ('156f6da8cb61a679af643881ced8847638dd1969dd7e34ea480adf6b8e3a0d052160099e92393e20', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-13 23:33:20', '2021-12-13 23:33:20', '2021-12-15 23:33:20');
INSERT INTO `oauth_access_tokens` VALUES ('1581f7b2c9d88f54e62cfd3a6379f8ec0a9c443820d4abe6df0c80ebc89c90e228a72ac9f69d72df', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-20 15:06:05', '2021-12-20 15:06:05', '2021-12-22 15:06:05');
INSERT INTO `oauth_access_tokens` VALUES ('15d001f93066070d2a31b62439699c1e80aedc7ccfb355779e530eff5fcf7cf14cc7f14d359d2a90', 53, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:42:45', '2021-12-23 01:42:45', '2021-12-25 01:42:45');
INSERT INTO `oauth_access_tokens` VALUES ('15e52fb30e65b02062d2e03b950544b3d39786775520e6683d5cf39f89cebea06f3e01360f7e41a8', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 01:33:06', '2021-12-21 01:33:06', '2021-12-23 01:33:06');
INSERT INTO `oauth_access_tokens` VALUES ('1740c8571929038971894ed3a7a297fd7da48b2143d73bcd029d8ba551ff2b1187b3491dab2a6d87', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-23 08:24:33', '2021-12-23 08:24:33', '2021-12-25 08:24:33');
INSERT INTO `oauth_access_tokens` VALUES ('175394077a82ded87c13ec5a99c47f4e209d6d5c0baa58583e02023792b7f2f1b786889bb346a541', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-17 05:54:11', '2021-12-17 05:54:11', '2021-12-19 05:54:11');
INSERT INTO `oauth_access_tokens` VALUES ('1779ee98331c283f02f886c3d76baf1b5db6f6d628a118c8a99e1e3e88d00c13de52b58ca52de172', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-22 17:37:40', '2021-12-22 17:37:40', '2021-12-24 17:37:40');
INSERT INTO `oauth_access_tokens` VALUES ('19fae52a0743aa764dd571228d775e0e79054908d5fca47ab0d28db6e127e240bd9c755d55b0ad24', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 15:48:22', '2021-12-19 15:48:22', '2021-12-21 15:48:22');
INSERT INTO `oauth_access_tokens` VALUES ('1a5660c3d409b009df83e78c0cc9bdffcdb09de1625c067142a919b100002ce17ad4c2581a2e3615', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-19 00:33:04', '2021-12-19 00:33:04', '2021-12-21 00:33:04');
INSERT INTO `oauth_access_tokens` VALUES ('1a866461eca2319eb0a7856aa1145304fa4646ebc357e7258d5ff321402287a29af01f6326222ff0', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-30 09:02:20', '2021-12-30 09:02:20', '2022-01-01 09:02:20');
INSERT INTO `oauth_access_tokens` VALUES ('1b4f7d31d609397c13d2d1a48fde910b25664a06a657b8a7a8bab019a54d917342ae25c0c5b15b93', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-20 22:21:12', '2021-12-20 22:21:12', '2021-12-22 22:21:12');
INSERT INTO `oauth_access_tokens` VALUES ('1b5c131dd93db389cc3ced42d49b7fb8b04db52f8a7fc73fcc5562a48e7339aa67ea16298b6d8b58', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 21:43:33', '2021-12-18 21:43:33', '2021-12-20 21:43:33');
INSERT INTO `oauth_access_tokens` VALUES ('1c0d32e2041fe6225acfdd7deb588423ed27b6786086c0647be40ff9811e3ff42194493bc624d05d', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 04:59:24', '2021-12-22 04:59:24', '2021-12-24 04:59:23');
INSERT INTO `oauth_access_tokens` VALUES ('1c298fdb2a48c3b6ee2b884b13fb41405afafcb77b3802cabed2a7faa48c32e778092e2d9a69d996', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-19 17:36:11', '2021-12-19 17:36:11', '2021-12-21 17:36:10');
INSERT INTO `oauth_access_tokens` VALUES ('1c31e90f63fbf37b810efa194473568c18b8b5ddfb4bf497a002abdb1695c315c7c68f6a187e5c3f', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-18 02:37:27', '2021-12-18 02:37:27', '2021-12-20 02:37:27');
INSERT INTO `oauth_access_tokens` VALUES ('1c4d269d40fcb12a603a01b75f744520e4b4e547ac37172444f35e192fe49cd7ad94cd06a64cb5b6', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 19:05:12', '2021-12-16 19:05:12', '2021-12-18 19:05:12');
INSERT INTO `oauth_access_tokens` VALUES ('1c94537175dde901c0c7f0e775c4d8d9743a88fbfce9175557d42eb2fbc2d4e768e75de7ba3d541f', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:04:36', '2021-12-21 20:04:36', '2021-12-23 20:04:36');
INSERT INTO `oauth_access_tokens` VALUES ('1c956e4a34873423b0ff3a9d2f7ea22c0fd4bd74d37b6f223185f52830a101c0ae887956f5e33ad3', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 03:41:05', '2021-12-19 03:41:05', '2021-12-21 03:41:05');
INSERT INTO `oauth_access_tokens` VALUES ('1d96cbc63b989cd4dc5b01992fabbd86cdd669bc9fadd5045e9a8612afae714bc836fee764829ab1', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 23:24:55', '2021-12-19 23:24:55', '2021-12-21 23:24:55');
INSERT INTO `oauth_access_tokens` VALUES ('1e5de77896544fb31b5df76b88dd6c325a36602dc3384449df481c1aa51f06a33e35df25eb8594ce', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 04:16:04', '2021-12-22 04:16:04', '2021-12-24 04:16:04');
INSERT INTO `oauth_access_tokens` VALUES ('1e7b40c4b8a4443c859abbd61a6471305e2a2533a306d28c1efc55d6ed9a83fd2beb4dea94f57295', 39, 13, 'Personal Access Token', '[]', 1, '2021-12-20 22:54:32', '2021-12-20 22:54:32', '2021-12-22 22:54:32');
INSERT INTO `oauth_access_tokens` VALUES ('1ea55709d7892672088ed60bfa25e3753a514ca6af3a13f790760ead9c44f3426ad0ecd33930b291', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 18:56:29', '2021-12-14 18:56:29', '2021-12-16 18:56:29');
INSERT INTO `oauth_access_tokens` VALUES ('1eb4d0be9058b37ae010be9c7140a02cf160043fc8799eb352eafae6a6066cc646730e54eef8c430', 49, 13, 'Personal Access Token', '[]', 0, '2021-12-23 03:11:20', '2021-12-23 03:11:20', '2021-12-25 03:11:20');
INSERT INTO `oauth_access_tokens` VALUES ('1ee09d7cf0442945d3f586984135bfef2699f719d30e2cb47f9f5eb0e9b4a747563e4f018fa0950e', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:04:28', '2021-12-22 10:04:28', '2021-12-24 10:04:28');
INSERT INTO `oauth_access_tokens` VALUES ('207c5407bc8d5e5718f2fe29687bec0284182f35d9c154e057e0886917828091ddd9d454077798de', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-15 01:12:27', '2021-12-15 01:12:27', '2021-12-17 01:12:27');
INSERT INTO `oauth_access_tokens` VALUES ('20f20c32e4a478e92089d7de8c2fd14444f5b7447c809584b2bdc737a83fe7bf15a459868f3c4acc', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 22:42:41', '2021-12-17 22:42:41', '2021-12-19 22:42:41');
INSERT INTO `oauth_access_tokens` VALUES ('2141703aad303a73fa945cf226a281da92cdb32f7bf67b2c2fa0ef13449ddcd40cf4692cc42849e7', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-21 14:06:50', '2021-12-21 14:06:50', '2021-12-23 14:06:50');
INSERT INTO `oauth_access_tokens` VALUES ('229fabc6f09f733bb92c4de30c20fff482fb0f0556e9083693971ed93c62a2c5f281e7db605d8173', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-15 12:16:51', '2021-12-15 12:16:51', '2021-12-17 12:16:50');
INSERT INTO `oauth_access_tokens` VALUES ('2351d726d5ad602502d8604e0d1360e410db385e8b4846b16c606d0719b0b6d30ad3e0920d188593', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 02:37:51', '2021-12-18 02:37:51', '2021-12-20 02:37:51');
INSERT INTO `oauth_access_tokens` VALUES ('239533c80cf853486477c53cad492e5faad80b0687a93a5557f6e1f262aea90edf43ab97422d31a9', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:32:43', '2021-12-22 10:32:43', '2021-12-24 10:32:42');
INSERT INTO `oauth_access_tokens` VALUES ('24e3f5a2e1b67b66147d6d73f31092969da533a5c634474bc8487684a38acc4aa04ce7245ed5d5b5', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-23 08:58:14', '2021-12-23 08:58:14', '2021-12-25 08:58:14');
INSERT INTO `oauth_access_tokens` VALUES ('25b9a1e5b5fee83cd1bdbe6df91b02d80f61b47eee2bb2fdc8c4591d0ff9aa4eefa4f642833a1155', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 16:27:01', '2021-12-19 16:27:01', '2021-12-21 16:27:01');
INSERT INTO `oauth_access_tokens` VALUES ('266142c979b077fb1f8df7bd95079235e6ee95467906ad779826db8365e12571b4edeecc4ca1a1ea', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 08:21:10', '2021-12-23 08:21:10', '2021-12-25 08:21:10');
INSERT INTO `oauth_access_tokens` VALUES ('26b092c4e4f6e9623372d7e7386c2903b7463dda90555b361af00112e60a486ae0b1d2ca9d786a50', 6, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:26:28', '2021-12-20 21:26:28', '2021-12-22 21:26:27');
INSERT INTO `oauth_access_tokens` VALUES ('26f5ae7b97d488af8b08e2ae2a49fde56ca1d548ad6d32164e894beb59af4d024911a0e63dadb560', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 16:21:36', '2021-12-21 16:21:36', '2021-12-23 16:21:36');
INSERT INTO `oauth_access_tokens` VALUES ('27637edbec2e26bca2313eb46e36bcf09ce0c807fe3877e8bf20a596cd6e55049aef261746156fa8', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-20 00:50:38', '2021-12-20 00:50:38', '2021-12-22 00:50:38');
INSERT INTO `oauth_access_tokens` VALUES ('27f3c57e7cd63b4506f1169b702231d4bcc79ae66680c1e63510b1adb40de3586d2dc3cd2b1c17ee', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-18 21:58:56', '2021-12-18 21:58:56', '2021-12-20 21:58:56');
INSERT INTO `oauth_access_tokens` VALUES ('281607d2389b0f9f792ca7397ebc0ec141292f4661a229451c28b71b74a7dd0ba08081eb757b12c0', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-16 00:19:01', '2021-12-16 00:19:01', '2021-12-18 00:19:01');
INSERT INTO `oauth_access_tokens` VALUES ('285b1ba47de619617bcc3979b5b65a1081e07c69503178a3904f199c4410cdf5a12a3a0c2fdb852d', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 02:58:40', '2021-12-16 02:58:40', '2021-12-18 02:58:40');
INSERT INTO `oauth_access_tokens` VALUES ('2880cf9a29fa5e26c0873118ee05a8b31811f363d41edebcede43efe18f019f18f9e686d6ba595b3', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 17:33:54', '2021-12-18 17:33:54', '2021-12-20 17:33:54');
INSERT INTO `oauth_access_tokens` VALUES ('289fbca39f4930884150fbaac6f0080cfcc2cf0026ba7fd509779d778bf04e17bb0d8c5bc5a8f436', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 00:40:56', '2021-12-21 00:40:56', '2021-12-23 00:40:56');
INSERT INTO `oauth_access_tokens` VALUES ('29f00c6d22613af660d841d3bb0759b08be78e1b63f0ac524f7c75db7ca7ba5d3d7e562dabcd7a35', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 21:36:54', '2021-12-19 21:36:54', '2021-12-21 21:36:53');
INSERT INTO `oauth_access_tokens` VALUES ('29f2675a36bdf8859fcc7aeb95ab9a68d5e484b1a78a78f17e302c95ee7c9a2d02ad9b1a83bf92a6', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 00:02:02', '2021-12-22 00:02:02', '2021-12-24 00:02:02');
INSERT INTO `oauth_access_tokens` VALUES ('2a16ef48486b7789763dfbbed41a774f791bd5b1f375492cfb4e1152d7ee9f524e8d9aca914dd29b', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 15:07:00', '2021-12-20 15:07:00', '2021-12-22 15:07:00');
INSERT INTO `oauth_access_tokens` VALUES ('2a46b80d6ddeac34c639e5f014c777d8ed0b0b0ca5f691d43cd09d93073df113b1cd97601f7b24bb', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:44:09', '2021-12-20 21:44:09', '2021-12-22 21:44:09');
INSERT INTO `oauth_access_tokens` VALUES ('2a91e173b0e8e3403359df70c3c78e662d2ffc18b85d3903382adf364c0ee5fe7218bc1eb5c40ccc', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 01:16:10', '2021-12-20 01:16:10', '2021-12-22 01:16:10');
INSERT INTO `oauth_access_tokens` VALUES ('2ade7655db0b533bff8f1c3ec5f978970ddbb569c12d70485552d49b3c13e4906615c624ac94e5a4', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:07:38', '2021-12-23 02:07:38', '2021-12-25 02:07:38');
INSERT INTO `oauth_access_tokens` VALUES ('2d3505a4c46aebbb0345bd547e08535bf2002558960cc1acf3f4367e0e7173b07eeaf1d48bf2def5', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:53:22', '2021-12-22 10:53:22', '2021-12-24 10:53:22');
INSERT INTO `oauth_access_tokens` VALUES ('2dfebba7813bb97451d135bb228d2a3158ed64b9784cd5f77dc4c461786d8e64b7e952d94ebe3ef3', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 04:29:11', '2021-12-22 04:29:11', '2021-12-24 04:29:11');
INSERT INTO `oauth_access_tokens` VALUES ('2e25408b34bb57d0a963d609847ae88f0977d428a6b900d39f1ec4b6aa2e62de07a5b3bb67cee41a', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-19 19:08:08', '2021-12-19 19:08:08', '2021-12-21 19:08:07');
INSERT INTO `oauth_access_tokens` VALUES ('2e5e573b7e59c073251fcbf5637ae244a23e1f312ba2992b43529c27148a4b98d37af46f02cff2e6', 39, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:42:27', '2021-12-22 08:42:27', '2021-12-24 08:42:27');
INSERT INTO `oauth_access_tokens` VALUES ('2e8009f052299bbc71d30a8a84c91156bbed15890f59acca35760d1daf2d630b1ae62a632c22accf', 52, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:31:41', '2021-12-23 02:31:41', '2021-12-25 02:31:41');
INSERT INTO `oauth_access_tokens` VALUES ('2e97332422f782d8f52ee09ec6f4c7f36972df95c74942b2105e77395ef6e1b07d73e6f496ef55de', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 07:27:15', '2021-12-23 07:27:15', '2021-12-25 07:27:15');
INSERT INTO `oauth_access_tokens` VALUES ('2ef2de42bc919d0e25ddd988d508ba0f9d5cb4054cd5a146615a7eb46b09597d9b737fb6df28e3ca', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-20 13:42:19', '2021-12-20 13:42:19', '2021-12-22 13:42:19');
INSERT INTO `oauth_access_tokens` VALUES ('2f41e39ff9b8fe1b03b36f5b1bfc1ab04dbcd2307a890a6fa16f22f75bd66a71e24edfe9bbef3a00', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-19 22:38:30', '2021-12-19 22:38:30', '2021-12-21 22:38:30');
INSERT INTO `oauth_access_tokens` VALUES ('2f5b9b343b1e58101e357f8067a8caedcca25b876aa98b7908b13a85870beba1ad9c7fd7358bec74', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 09:56:39', '2021-12-22 09:56:39', '2021-12-24 09:56:39');
INSERT INTO `oauth_access_tokens` VALUES ('2f6c8b7c7fb04b9d975167577dbc7ec86c50005db98166e87bfae4acca4e77c20eec0c3c94cfde9a', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 00:17:39', '2021-12-18 00:17:39', '2021-12-20 00:17:39');
INSERT INTO `oauth_access_tokens` VALUES ('2fa2662265ffe5bbc5546beaa7df3048e42054c46d51a46f91b932d08a501b727e99f458ff00c2d9', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-27 12:06:21', '2021-12-27 12:06:21', '2021-12-29 12:06:21');
INSERT INTO `oauth_access_tokens` VALUES ('2feefacf897f013aa4e4b148ced94708559bc30f97b0628b5a57a2c868668548a70538fc97222867', 7, 11, 'Personal Access Token', '[]', 1, '2021-12-15 02:35:29', '2021-12-15 02:35:29', '2021-12-17 02:35:29');
INSERT INTO `oauth_access_tokens` VALUES ('30183faf3f1844ebe0dd4b40b465bb0c7312c9e14d796a8f1acb8e9a80a6d08fcf22cc4d022e7fed', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:58:12', '2021-12-23 02:58:12', '2021-12-25 02:58:12');
INSERT INTO `oauth_access_tokens` VALUES ('306d96bfada6127fb276dc86d8080976470c94614e579faeaf2dfb73022c023c6ee26e44916f6ceb', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 12:27:02', '2021-12-21 12:27:02', '2021-12-23 12:27:01');
INSERT INTO `oauth_access_tokens` VALUES ('312bf7faac6bda19d0d7bdffae9beac91ad3c779e5690220971aca4625347c2e7845b27119eda104', 47, 13, 'Personal Access Token', '[]', 0, '2021-12-22 09:07:05', '2021-12-22 09:07:05', '2021-12-24 09:07:05');
INSERT INTO `oauth_access_tokens` VALUES ('3161dedfc66ac4621e07f881aa45acb4cf121d47d46b241c8f59f58ca2bbd9a03919ba5b2aa0ce2b', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:29:00', '2021-12-20 23:29:00', '2021-12-22 23:29:00');
INSERT INTO `oauth_access_tokens` VALUES ('31ddfdf849622f499fb5e80d6a4f3b82bb389e7b753cd5f243f02708f31ba92235419cab1ecc1f60', 9, 11, 'Personal Access Token', '[]', 0, '2021-12-14 16:19:10', '2021-12-14 16:19:10', '2021-12-16 16:19:10');
INSERT INTO `oauth_access_tokens` VALUES ('32454ab7e9d97614113c325b76719b7ddbe265144af81a59133a908376ebef3d3b39598b70ae458e', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-19 00:08:52', '2021-12-19 00:08:52', '2021-12-21 00:08:52');
INSERT INTO `oauth_access_tokens` VALUES ('32a38622c00919f94b5b4510870d980966e267d7ee182589a7e1628a6f8fda8af91df50b6e233830', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 22:07:52', '2021-12-17 22:07:52', '2021-12-19 22:07:52');
INSERT INTO `oauth_access_tokens` VALUES ('330cc2b000526a45033e85b2c1371cb489e3d5145308162e53408e3981c681701b70f2f769d7c454', 30, 13, 'Personal Access Token', '[]', 0, '2021-12-20 23:27:12', '2021-12-20 23:27:12', '2021-12-22 23:27:12');
INSERT INTO `oauth_access_tokens` VALUES ('334a0cc6ccfd56cdc59a49379b32da62e63cb3d060fa8782dab0e1f66d40713e5ee42f05fad0d147', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:22:23', '2021-12-20 21:22:23', '2021-12-22 21:22:23');
INSERT INTO `oauth_access_tokens` VALUES ('3355187f3f93befdc5b24dee33adba45e36c9d651a3d352fca7ae9a975e64dcc1949a235e1442f04', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-22 16:18:10', '2021-12-22 16:18:10', '2021-12-24 16:18:09');
INSERT INTO `oauth_access_tokens` VALUES ('33c1d7724eae67ad16228c63a05183643c88b428ba18b2830729e25b2fe07f2710d46310d1272bbe', 48, 13, 'Personal Access Token', '[]', 1, '2021-12-22 15:41:41', '2021-12-22 15:41:41', '2021-12-24 15:41:40');
INSERT INTO `oauth_access_tokens` VALUES ('3419ab14b2519b26839f0ddfc7b895242bae9132ae0bee37c508617dc66744df3cdfa614b1794364', 6, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:25:40', '2021-12-20 21:25:40', '2021-12-22 21:25:40');
INSERT INTO `oauth_access_tokens` VALUES ('348875ecd5b7588209202e782635252ff432cb003cf7e10e60196bcedc5c57bb41e717e7ccf01a6d', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 04:27:38', '2021-12-23 04:27:38', '2021-12-25 04:27:38');
INSERT INTO `oauth_access_tokens` VALUES ('34a8a35f5b45af9b5ac4e12544a8523e94b45fe4b715910822ade5e49e109ff5e407467b36e81f4b', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:36:23', '2021-12-22 01:36:23', '2021-12-24 01:36:23');
INSERT INTO `oauth_access_tokens` VALUES ('34aea669afb1068c91ce831a295cab8ca6d662945bc854c0b67b099be463632fdef23cae28dc9360', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:46:48', '2021-12-22 10:46:48', '2021-12-24 10:46:48');
INSERT INTO `oauth_access_tokens` VALUES ('35202306370e1d93e05113e08eb3f0cfbd5ab8330c2680a3ef2d3b26581bf1c3b6a176fb493d8ee8', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:59:17', '2021-12-23 03:59:17', '2021-12-25 03:59:16');
INSERT INTO `oauth_access_tokens` VALUES ('3526d669ac1893dc144a3e53dc195ad27bf89fa491b01bf4f3129eb6a418e2472c7852d693725bef', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 18:56:39', '2021-12-17 18:56:39', '2021-12-19 18:56:39');
INSERT INTO `oauth_access_tokens` VALUES ('352f48fe5aaf376978fc671926d810fa16f5cf55bb29851a17bba4583e04e15f864eee1ca5010eeb', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 00:01:04', '2021-12-14 00:01:04', '2021-12-16 00:01:04');
INSERT INTO `oauth_access_tokens` VALUES ('356b942f8600918219c1d6d6fc396978a4c62f64fde259838041dbf60125763c192c9fde19acd4b1', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 20:50:19', '2021-12-20 20:50:19', '2021-12-22 20:50:19');
INSERT INTO `oauth_access_tokens` VALUES ('356d4de6a3ea3e70f44a42f0e908d81ea6623a763be4602e17150a9afa937c2a730304287d52565f', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 02:24:34', '2021-12-22 02:24:34', '2021-12-24 02:24:34');
INSERT INTO `oauth_access_tokens` VALUES ('35b053be7f3605d1f5804bc37f2ea5537dc015dd7da5bc9ca0133357d0d528fed31c05926deb57ad', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 21:39:50', '2021-12-21 21:39:50', '2021-12-23 21:39:50');
INSERT INTO `oauth_access_tokens` VALUES ('362d6af8dd2d37a12bebd6455b5e74909818ed6638e206172949c5bc8de1beb7955ab0a35ebf98aa', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-13 22:49:46', '2021-12-13 22:49:46', '2021-12-15 22:49:46');
INSERT INTO `oauth_access_tokens` VALUES ('36fe03435398fbee140982b2889378d199327924c5bac6395682afab80887b173a799d9c45d7c696', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:08:29', '2021-12-20 23:08:29', '2021-12-22 23:08:29');
INSERT INTO `oauth_access_tokens` VALUES ('3740cc81817d45adfc94f25922f941df7e98386b5198e0de85179eae6765830ed9a021260fce4e3f', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 22:15:57', '2021-12-17 22:15:57', '2021-12-19 22:15:57');
INSERT INTO `oauth_access_tokens` VALUES ('37620865ddc9aa72c57eb48fd9358d324c0f071684b073ad4eb67f4016a5de3b7581b5a8057b8695', 52, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:39:06', '2021-12-23 01:39:06', '2021-12-25 01:39:06');
INSERT INTO `oauth_access_tokens` VALUES ('38189e37868751804947146ad50d04372783e1a1bca72672b7627abad154da807ad13899d6381b24', 1, 11, 'Personal Access Token', '[]', 0, '2021-12-13 23:54:57', '2021-12-13 23:54:57', '2021-12-15 23:54:57');
INSERT INTO `oauth_access_tokens` VALUES ('384fd3c1f124f5ae5e5c5539d1bd7003bc835d3f67d9db642dbc604f0c2f998ff7cb53ab2aa00449', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-23 00:58:41', '2021-12-23 00:58:41', '2021-12-25 00:58:41');
INSERT INTO `oauth_access_tokens` VALUES ('3872ce5c3644b9089d1f9d13f4e91d2b816829c5c769b08a3f871dbb17214effc89701ddc817678e', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-14 20:28:33', '2021-12-14 20:28:33', '2021-12-16 20:28:33');
INSERT INTO `oauth_access_tokens` VALUES ('38ef44a9a27cae26d0d1124f550c044919175a33852900ace6aa496dfa820950ac05d6c17600f0fd', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-18 22:38:05', '2021-12-18 22:38:05', '2021-12-20 22:38:05');
INSERT INTO `oauth_access_tokens` VALUES ('398b0a468b537ea457cb59ba5b82cbd7d82823e36ea63cb6cc215d0b3e07cf079b06d1e19a5de249', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-13 23:51:28', '2021-12-13 23:51:28', '2021-12-15 23:51:28');
INSERT INTO `oauth_access_tokens` VALUES ('3a2094a7b468fcaf561ec2bd5637d44787ba38e9f74cf1f641ee74220f9640f2aabd96bcdfcc62d2', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:19:58', '2021-12-22 10:19:58', '2021-12-24 10:19:58');
INSERT INTO `oauth_access_tokens` VALUES ('3a35f95ef5deae1a10c753224e0db370114ab5a80de91e1caf0444ce9bbdf0f0a060a8859ddaf8c4', 13, 13, 'Personal Access Token', '[]', 0, '2021-12-22 10:36:17', '2021-12-22 10:36:17', '2021-12-24 10:36:16');
INSERT INTO `oauth_access_tokens` VALUES ('3a3888e6c8fa6f80ae45c4e6c4251107c9cd05e6ab3e85836d44cad65412fe180436dc2144923feb', 14, 13, 'Personal Access Token', '[]', 0, '2021-12-19 18:03:46', '2021-12-19 18:03:46', '2021-12-21 18:03:45');
INSERT INTO `oauth_access_tokens` VALUES ('3a3c438fc0cc30cd64b9b50d34f9984cf6061991e19848fcd142a13596a7e0ac491033da0e37992c', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 21:58:43', '2021-12-18 21:58:43', '2021-12-20 21:58:43');
INSERT INTO `oauth_access_tokens` VALUES ('3a7d9a5c8e3886c40a1537b5dd5ea269a19821079c6094448fc3592189a843948af25fe3c24e6738', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 19:31:08', '2021-12-21 19:31:08', '2021-12-23 19:31:08');
INSERT INTO `oauth_access_tokens` VALUES ('3a7e7366a1f67d05632437fcc3869bacf3caa9e767b7e3f3f72fb621bf8b28305566627c64ea2b93', 1, 11, 'Personal Access Token', '[]', 0, '2021-12-13 23:57:33', '2021-12-13 23:57:33', '2021-12-15 23:57:33');
INSERT INTO `oauth_access_tokens` VALUES ('3c2aafae7ab0ff5ead4e84f91d3547aa0ec60d4710d65829aeca2e596f9fe726bea32530376c5831', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 21:28:39', '2021-12-19 21:28:39', '2021-12-21 21:28:39');
INSERT INTO `oauth_access_tokens` VALUES ('3c3ead7ad1f9a9c5067336e30915daf6317d46993953f1c15cd6a15050d9381888424f571b189085', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:29:08', '2021-12-22 10:29:08', '2021-12-24 10:29:08');
INSERT INTO `oauth_access_tokens` VALUES ('3cfc709b1dcb90dd14b10e6124d8ca6252b17ff22dcd7f28239d61b6e42a5d602ff1cd1ec58b636c', 7, 13, 'Personal Access Token', '[]', 1, '2021-12-18 16:51:40', '2021-12-18 16:51:40', '2021-12-20 16:51:40');
INSERT INTO `oauth_access_tokens` VALUES ('3d4c545a8aa0ed3366be4cba6df00e0b338e164f07b4322058b78c820b2f8b3a0302f8ba14958321', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-13 23:59:36', '2021-12-13 23:59:36', '2021-12-15 23:59:36');
INSERT INTO `oauth_access_tokens` VALUES ('3e15cecda907f45f657e2a40fadf56360a3256942ead6265a2258413ba98ccda2e8fcfcd0ce9e2ac', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:35:31', '2021-12-20 21:35:31', '2021-12-22 21:35:31');
INSERT INTO `oauth_access_tokens` VALUES ('3e6f5587174cfd4d211e40f84c8589914b4aaa9087d94393887bc57b4c48a77989bbe9de0468c6c7', 55, 13, 'Personal Access Token', '[]', 0, '2021-12-28 18:06:08', '2021-12-28 18:06:08', '2021-12-30 18:06:08');
INSERT INTO `oauth_access_tokens` VALUES ('3ec58a8e9064d2b784bd43d9d333414971a181aeaedd8ac25735e2da6895631f93c867cb404e5196', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:49:36', '2021-12-22 23:49:36', '2021-12-24 23:49:36');
INSERT INTO `oauth_access_tokens` VALUES ('3f4ed5030a7e476eb9a6c56e49cd160b57b8f02723a81fc2d50864f8db9eafe93d47fdb099893d4d', 48, 13, 'Personal Access Token', '[]', 1, '2021-12-22 21:34:06', '2021-12-22 21:34:06', '2021-12-24 21:34:06');
INSERT INTO `oauth_access_tokens` VALUES ('3fad3e9505acdb71976d00cb0698cb8e2d73c5c06514d9caeceb05b8a7e0c5f060ec6a94f717bd75', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:51:56', '2021-12-22 01:51:56', '2021-12-24 01:51:56');
INSERT INTO `oauth_access_tokens` VALUES ('4036d6f17523534a191cbf0db55abbf3e73db0444fd4b99107be33aa6ffee0a8d65c32a5dd49cb7d', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 15:21:30', '2021-12-17 15:21:30', '2021-12-19 15:21:30');
INSERT INTO `oauth_access_tokens` VALUES ('404b9fc97e9a0149d51ae49feda1086acfbe1ef10fb84a0daf8f9f45e73a2192c6b957361c384428', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-25 20:22:58', '2021-12-25 20:22:58', '2021-12-27 20:22:57');
INSERT INTO `oauth_access_tokens` VALUES ('40bbd4e274813c3d0e0ef17d155b204c2f13af90ac670dc1b4f418c3638d0d9088f9eb4a26d105cb', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-23 02:24:24', '2021-12-23 02:24:24', '2021-12-25 02:24:24');
INSERT INTO `oauth_access_tokens` VALUES ('40f7b31c2ae3e7f52f62a943f68b8cec592a1c77d838905e450b308579529947da30c43599516016', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-17 23:08:42', '2021-12-17 23:08:42', '2021-12-19 23:08:41');
INSERT INTO `oauth_access_tokens` VALUES ('4111c5f5d1b281e4d895d69a73cc2d3151d84065784136086eb85455dd3ab316ce39735384029582', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 11:01:09', '2021-12-20 11:01:09', '2021-12-22 11:01:09');
INSERT INTO `oauth_access_tokens` VALUES ('41e8ece22aab9829b649ed7fe1f3d0339689d595907ba6c791fb9db42081eabba9017f31da45cb70', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 02:21:33', '2021-12-16 02:21:33', '2021-12-18 02:21:33');
INSERT INTO `oauth_access_tokens` VALUES ('43b23fa1bda342ee15a8bdff64dc68e683742d23e2e42abee8bb7bd63931878a73d9c5c44d2ee9f9', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:11:54', '2021-12-20 21:11:54', '2021-12-22 21:11:53');
INSERT INTO `oauth_access_tokens` VALUES ('43b9d7b4d0251638bf797a97bc94a5eed7c75497232eb4abeaad2acbf466ae62e18d9101ae94405d', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 03:13:57', '2021-12-16 03:13:57', '2021-12-18 03:13:56');
INSERT INTO `oauth_access_tokens` VALUES ('43c2004e652ff66c9e7c6ac32c4a3f1522d1e52885140817d12411a9f8ea07b9a9b00d7046721f94', 13, 13, 'Personal Access Token', '[]', 0, '2021-12-19 01:55:38', '2021-12-19 01:55:38', '2021-12-21 01:55:38');
INSERT INTO `oauth_access_tokens` VALUES ('4404a092ecfaa5230c009c88780c089009471b82472716650eeec38685d27eadf724911e20fac27a', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 02:23:27', '2021-12-16 02:23:27', '2021-12-18 02:23:26');
INSERT INTO `oauth_access_tokens` VALUES ('447b38494d6af56257298078a6c540f1f68d3a18bbfc12ce556583d234689172929ba9b0ff07fb9b', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 15:04:26', '2021-12-22 15:04:26', '2021-12-24 15:04:26');
INSERT INTO `oauth_access_tokens` VALUES ('457602e02040140e7ec0f1ac43648baa5249a0e65414274bfcc3c81f89d5e74600a8c79e12b7ba70', 25, 13, 'Personal Access Token', '[]', 0, '2021-12-20 01:05:44', '2021-12-20 01:05:44', '2021-12-22 01:05:44');
INSERT INTO `oauth_access_tokens` VALUES ('458ee65bd206334972f75701b31f85e317edc4b87f19c88951779df1f7eaaa4f05d05030ba064cdd', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 02:22:44', '2021-12-16 02:22:44', '2021-12-18 02:22:44');
INSERT INTO `oauth_access_tokens` VALUES ('463cd121eed1682a45607f544977e074a74516b32170b70d9795238b6439d6ba8db03cb958ee7145', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-23 01:22:50', '2021-12-23 01:22:50', '2021-12-25 01:22:49');
INSERT INTO `oauth_access_tokens` VALUES ('480f75b9477b159e93f79998cf601f59fa03e15a9271a790cfa2c13c323267a6bbbc5dc34b59e829', 48, 13, 'Personal Access Token', '[]', 1, '2021-12-22 16:02:44', '2021-12-22 16:02:44', '2021-12-24 16:02:44');
INSERT INTO `oauth_access_tokens` VALUES ('489792a28d3a6717375e20e1ddeaf41b380722f77619efd1e83a6ae573ff9068f3a53388771e0734', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:07:45', '2021-12-20 23:07:45', '2021-12-22 23:07:45');
INSERT INTO `oauth_access_tokens` VALUES ('490b437b36a0a1a9f0cb74a4115b2a7fb5cc69e8fba607cc77c9aa347906123f5d982465e9304367', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-22 02:55:05', '2021-12-22 02:55:05', '2021-12-24 02:55:05');
INSERT INTO `oauth_access_tokens` VALUES ('492a335b2eab55b0debab0d3ab784cf33b1fa686a505bdc8c152fecedb8524c27165093e5555b5de', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 02:23:09', '2021-12-22 02:23:09', '2021-12-24 02:23:09');
INSERT INTO `oauth_access_tokens` VALUES ('492fdf1d1600ca57607e3b570eb6eb02725e05d8ac4938bfb36a199138cff9a783c7eafcc8dd3ca1', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:48:04', '2021-12-16 18:48:04', '2021-12-18 18:48:04');
INSERT INTO `oauth_access_tokens` VALUES ('4a307ad68c6e803bc60608f0846a4e19c29838c53523d0e250646e77fae91af4e83cbf25d4e891bc', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 04:33:17', '2021-12-22 04:33:17', '2021-12-24 04:33:17');
INSERT INTO `oauth_access_tokens` VALUES ('4afac675f419dcecf10c3ad592d2f7e658e51b4052e437befa60fdac62d78717e5c5ec437e562f7c', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:42:41', '2021-12-20 00:42:41', '2021-12-22 00:42:41');
INSERT INTO `oauth_access_tokens` VALUES ('4b3d5437018723765650985ccaaa671e0f2f66fa5aac442f436b4345a5481e0a317ef9e5b22efaed', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-14 03:43:59', '2021-12-14 03:43:59', '2021-12-16 03:43:59');
INSERT INTO `oauth_access_tokens` VALUES ('4d680e0658c18c28684d62a0b65debce0e02836e2ceec490ee0244808524fe1ad3ca58828dde4a80', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 18:55:16', '2021-12-21 18:55:16', '2021-12-23 18:55:16');
INSERT INTO `oauth_access_tokens` VALUES ('4e7f6b1dbc2c2f8bcc17c9f58348a6f8a8de7fe3a68d123ab42591f552549140bf957ece00faeea4', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-18 00:12:53', '2021-12-18 00:12:53', '2021-12-20 00:12:53');
INSERT INTO `oauth_access_tokens` VALUES ('4e8d3731e9bfe8e721114d1c265091bcdc8c78008f135319033fc642d99e3a918ca5e36e6f5eda29', 39, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:38:28', '2021-12-22 08:38:28', '2021-12-24 08:38:28');
INSERT INTO `oauth_access_tokens` VALUES ('4fcc663cab70e387a8623d0e6218bb08b67ee87390466d60974cf7aa1bc3c7088231756ca18d2093', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-23 08:39:14', '2021-12-23 08:39:14', '2021-12-25 08:39:13');
INSERT INTO `oauth_access_tokens` VALUES ('50192d715e9569a6adbf0f8916f2e9ed531af7f10061e43e6765b16e59dc3874e8da4eccfce032ba', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-22 11:05:02', '2021-12-22 11:05:02', '2021-12-24 11:05:01');
INSERT INTO `oauth_access_tokens` VALUES ('5143b42a1f083f16b3f78e214c8cfb0c86b3d670b5d47e710b8f781070095ca645d08cbb03b4e796', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 23:26:15', '2021-12-21 23:26:15', '2021-12-23 23:26:15');
INSERT INTO `oauth_access_tokens` VALUES ('518125bd6f61414d61563c63236865df1f6c9e71c31477baccd451384a13c49487e506fa1b000db7', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 00:15:04', '2021-12-23 00:15:04', '2021-12-25 00:15:04');
INSERT INTO `oauth_access_tokens` VALUES ('51ea481f507ff8083e4d42511a5fbd709717a156dabfe667f5b2c33dc30394c9bb42d49dca8cf34e', 7, 11, 'Personal Access Token', '[]', 1, '2021-12-15 09:21:57', '2021-12-15 09:21:57', '2021-12-17 09:21:57');
INSERT INTO `oauth_access_tokens` VALUES ('520e02117506c80debb939ce17767c5b5f7447c6b794f7c7289fbd97ff4cdd4217110d8494f7ba07', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 16:55:12', '2021-12-22 16:55:12', '2021-12-24 16:55:12');
INSERT INTO `oauth_access_tokens` VALUES ('521290d7ff35c27e8c83997f689dd337d63656b65ef757ea7178d415082199ff86289f1c6f4ddf1a', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:44:37', '2021-12-22 01:44:37', '2021-12-24 01:44:37');
INSERT INTO `oauth_access_tokens` VALUES ('52f1e499f03ffcc1a370b9d191fd73812679be072cb94788af0b55f65a52ed7549f300d7a375bdf3', 1, 11, 'Personal Access Token', '[]', 0, '2021-12-14 00:20:25', '2021-12-14 00:20:25', '2021-12-16 00:20:25');
INSERT INTO `oauth_access_tokens` VALUES ('52feb9f36e4c365d766f8df7979beb897e1d2b72bf8ab26e7fa6f0645bf0abb0003b3a17c5b7996e', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:49:14', '2021-12-21 20:49:14', '2021-12-23 20:49:14');
INSERT INTO `oauth_access_tokens` VALUES ('532191ac78e79e61ce48171d43f0684e6b8a5bdf52f378d9571b7a3baaa0085613c491f0041f146d', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 20:57:35', '2021-12-20 20:57:35', '2021-12-22 20:57:35');
INSERT INTO `oauth_access_tokens` VALUES ('5339761603c5571eac0d528a0cbd1d504e357b57cd7012cf5d6024b2d82814367c5bb81945fdd0bd', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:12:45', '2021-12-23 01:12:45', '2021-12-25 01:12:45');
INSERT INTO `oauth_access_tokens` VALUES ('53e1adb706ab7e5305565d356960f5be62f13ccefe4c8ae1ef42043a104b18ac96529294d90a9284', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 15:11:28', '2021-12-18 15:11:28', '2021-12-20 15:11:28');
INSERT INTO `oauth_access_tokens` VALUES ('53fe848426b2dc48d39a1d9723a627617b9697f00cce69a4f1654633cfd6d84a6fac41172d4e312c', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 09:26:01', '2021-12-17 09:26:01', '2021-12-19 09:26:01');
INSERT INTO `oauth_access_tokens` VALUES ('54464ecc1d6b7599c8d20c3b5a5c9aa78141a667516424adb2ba2994c8a528b5ac76c66e8fbd3b27', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:49:26', '2021-12-22 23:49:26', '2021-12-24 23:49:26');
INSERT INTO `oauth_access_tokens` VALUES ('54cf25435cb0792d75b48bd48ad6d09d0dddff12e27625d9fb1089c194a981e8ac91ceda8dcfc471', 4, 11, 'Personal Access Token', '[]', 1, '2021-12-15 21:42:14', '2021-12-15 21:42:14', '2021-12-17 21:42:14');
INSERT INTO `oauth_access_tokens` VALUES ('55395f8894db8ccce7119d51600742991c90f828a4c77ad1bc48eef4d63b30345c2e2de3c848077a', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 15:05:58', '2021-12-20 15:05:58', '2021-12-22 15:05:58');
INSERT INTO `oauth_access_tokens` VALUES ('55df9914929c5a71dca4396adc16f8db9bf0e50e8ae81a427dc19d57d1f80ab6ecf94fbe36d6918b', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 00:01:07', '2021-12-14 00:01:07', '2021-12-16 00:01:07');
INSERT INTO `oauth_access_tokens` VALUES ('55f7d3bce9148d4dd5397682d4f565403817c7b53b6084dbd91a2218f062942b7a7d52655f714b26', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-29 10:20:17', '2021-12-29 10:20:17', '2021-12-31 10:20:16');
INSERT INTO `oauth_access_tokens` VALUES ('56840e85144640d2a1600574df0ff04b9a8b3e127c2359b80c845e1b593c1a0c6560d2711374c2f7', 13, 13, 'Personal Access Token', '[]', 0, '2021-12-19 16:11:25', '2021-12-19 16:11:25', '2021-12-21 16:11:24');
INSERT INTO `oauth_access_tokens` VALUES ('5704417c18bcf019dff3a3449e4bb112e3342997ebf4bbbccbc0d6167931b6e1c7540bf468889868', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 01:43:31', '2021-12-19 01:43:31', '2021-12-21 01:43:31');
INSERT INTO `oauth_access_tokens` VALUES ('57f45fec0c072da942a93d734c713d11f6a05751a122d3cf07c576e564f931b23c1e6a62b485cc20', 51, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:03:26', '2021-12-23 02:03:26', '2021-12-25 02:03:26');
INSERT INTO `oauth_access_tokens` VALUES ('584a6cc92232029baaff8628d9a8964933c33fe579b1e0980605aba23502076827e613ecb0660570', 28, 13, 'Personal Access Token', '[]', 0, '2021-12-20 23:31:26', '2021-12-20 23:31:26', '2021-12-22 23:31:26');
INSERT INTO `oauth_access_tokens` VALUES ('590b45302ee177c90552eeb90840da357b8ac6f3d9d8e1899cafe30062e57dbc5fedd32d9c478db1', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 20:28:51', '2021-12-16 20:28:51', '2021-12-18 20:28:51');
INSERT INTO `oauth_access_tokens` VALUES ('59cf98252259371dca1b1cc4c416b5971f386de951055c71fe9471ebc50c539ccdf58128671d0a96', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:41:11', '2021-12-22 23:41:11', '2021-12-24 23:41:11');
INSERT INTO `oauth_access_tokens` VALUES ('59d67b25aa2e5fff72e4f1eeb6f9e0c8fb0eff27ee75abb9212c01d99e43de3405a90de63182295b', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 04:59:32', '2021-12-22 04:59:32', '2021-12-24 04:59:32');
INSERT INTO `oauth_access_tokens` VALUES ('5bbeee5385a8229454f7abcabd431e93a1a374683ac10193e6fac8bb98136515f332756bd4d8bad6', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 03:40:07', '2021-12-19 03:40:07', '2021-12-21 03:40:07');
INSERT INTO `oauth_access_tokens` VALUES ('5c4d63ec422c5278d63b6a92cc85eae0cb67dfbf48c44d77330b8daebf107a7766d7aba677d19220', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-17 23:33:50', '2021-12-17 23:33:50', '2021-12-19 23:33:50');
INSERT INTO `oauth_access_tokens` VALUES ('5ca6b2aa2c575976e6721d344ff524b48a39716a668b3e23a79d394b046c6a0f98c51e7a53af9a80', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 22:19:03', '2021-12-19 22:19:03', '2021-12-21 22:19:03');
INSERT INTO `oauth_access_tokens` VALUES ('5d02a0c08ec6344ab6ed02fd58edf515d8f9914df884a1d7746a15b9de6b385b223c94fbfa4abce1', 48, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:50:24', '2021-12-22 23:50:24', '2021-12-24 23:50:24');
INSERT INTO `oauth_access_tokens` VALUES ('5db035d5a416ead041ee16e0950e16887a827b9d934ad5b03d68a4ca083870b4efd092be45fcb8d8', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 18:22:01', '2021-12-16 18:22:01', '2021-12-18 18:22:00');
INSERT INTO `oauth_access_tokens` VALUES ('5df9ef92de3bd169c9fd1bce6a840af8265e2a662b620ef1b3c2e2a9bb32f5b18f42eecda9bab00a', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-21 00:30:51', '2021-12-21 00:30:51', '2021-12-23 00:30:51');
INSERT INTO `oauth_access_tokens` VALUES ('5e5292536c88ad96ddb6d26dbb9200608e3f021b35d94c46a405e728ae182cdd21edf7a33694f27b', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-22 16:35:35', '2021-12-22 16:35:35', '2021-12-24 16:35:35');
INSERT INTO `oauth_access_tokens` VALUES ('5e5cf77be526c02c439d6cae90458be83de99ac8800bd881f7467097f6c96cdbe165ecd44fef3428', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 22:29:20', '2021-12-17 22:29:20', '2021-12-19 22:29:20');
INSERT INTO `oauth_access_tokens` VALUES ('5e708009460bde020fb630d0aa3cfd42f1d6d4d7189e064825950cbe89a801022116225f112d0e19', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:20:36', '2021-12-21 20:20:36', '2021-12-23 20:20:36');
INSERT INTO `oauth_access_tokens` VALUES ('5f14e669fafbcff747c5641e0005b02d767a7472ef51fdd0f5e3d312a401c0d47d7932f953c36b32', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:15:24', '2021-12-22 10:15:24', '2021-12-24 10:15:23');
INSERT INTO `oauth_access_tokens` VALUES ('5f59f1f8a06ca7fbc7296c5ddd7d1cee2c8e1744e8967df9a72fa14bef4470669a1b5aa9817409cd', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 23:30:13', '2021-12-19 23:30:13', '2021-12-21 23:30:13');
INSERT INTO `oauth_access_tokens` VALUES ('5f6e39abccba83b0c2893dab6a58d9be4f60adddda0ac85a267da5cc76cbb9408e7d38993f7e71e6', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 02:10:40', '2021-12-14 02:10:40', '2021-12-16 02:10:40');
INSERT INTO `oauth_access_tokens` VALUES ('6029f6ad50e1d09259d162c49baa07726c4881910e3cff4b9109ea5c4c8eea8dc81f6e300c2019a8', 51, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:57:19', '2021-12-23 01:57:19', '2021-12-25 01:57:19');
INSERT INTO `oauth_access_tokens` VALUES ('6102fd7522824e6ebc917e91036bdde21c5f0c24bc9f0c58501269ebd09e3c680dc07cf52012fa23', 14, 13, 'Personal Access Token', '[]', 1, '2021-12-19 17:38:53', '2021-12-19 17:38:53', '2021-12-21 17:38:53');
INSERT INTO `oauth_access_tokens` VALUES ('6218887166237eb8502e7d5961f768a0cda98294c257a12ef1798d7a5b23c4a7797ef5a95578d25b', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 01:54:40', '2021-12-19 01:54:40', '2021-12-21 01:54:40');
INSERT INTO `oauth_access_tokens` VALUES ('63bb7893d429e979469c65ae74f6437293bdc5836290297c65819506d4273eaf24e214337feca0be', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:39:54', '2021-12-20 21:39:54', '2021-12-22 21:39:54');
INSERT INTO `oauth_access_tokens` VALUES ('644cbaf6dbcfc295951012a7c9b43962a9d617b65830dd3b2b8c09832f24dd099b11f07789364cc5', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-22 14:23:21', '2021-12-22 14:23:21', '2021-12-24 14:23:21');
INSERT INTO `oauth_access_tokens` VALUES ('647ba80254c53f8c800ea8e3a606d3b5bc5bdecf48f08156ae75ffda234091fe463e4f0716288778', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 23:47:23', '2021-12-17 23:47:23', '2021-12-19 23:47:22');
INSERT INTO `oauth_access_tokens` VALUES ('64ccdec14f9777beb67b3ee3a8a7c6509d1808062492ce850653eb5af05e4507031a175300249f98', 48, 13, 'Personal Access Token', '[]', 1, '2021-12-23 00:16:14', '2021-12-23 00:16:14', '2021-12-25 00:16:14');
INSERT INTO `oauth_access_tokens` VALUES ('64fe56f0248e3fe9d8f5d0462312d1d1fbca1448653b97cad7c85e3a0dd984003545cfc46a0d08d8', 3, 11, 'Personal Access Token', '[]', 1, '2021-12-13 22:51:59', '2021-12-13 22:51:59', '2021-12-15 22:51:59');
INSERT INTO `oauth_access_tokens` VALUES ('658598a2996caa3944e62cf832ac36f534d2909805411b53f36155851f5136db44eec247f9f8efb0', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 00:31:20', '2021-12-21 00:31:20', '2021-12-23 00:31:20');
INSERT INTO `oauth_access_tokens` VALUES ('65d3155dccc74431329d158045bc83c0ef9218e4c7c0214286a5c9bca4bc6d5ffd46b3d5dd3ac481', 16, 13, 'Personal Access Token', '[]', 1, '2021-12-19 23:13:37', '2021-12-19 23:13:37', '2021-12-21 23:13:36');
INSERT INTO `oauth_access_tokens` VALUES ('66a0383abcfb66638dd84f1d8597087f11b7973d4ab1304c20380030b5e495d8b08faecd2d55ff4a', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-29 10:19:11', '2021-12-29 10:19:11', '2021-12-31 10:19:11');
INSERT INTO `oauth_access_tokens` VALUES ('66e02b929d834f127442c7b8f0a47a3a3a3d343ffd26b9c3d0fff633a1eed3301c51e320a61638c7', 11, 13, 'Personal Access Token', '[]', 1, '2021-12-21 00:42:03', '2021-12-21 00:42:03', '2021-12-23 00:42:03');
INSERT INTO `oauth_access_tokens` VALUES ('675b29f5557a0b6d23fc477971715fecc74c60c38e7648630bc1f665e68e1d65469a18a975ee5c8d', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-18 15:48:36', '2021-12-18 15:48:36', '2021-12-20 15:48:35');
INSERT INTO `oauth_access_tokens` VALUES ('6765c7e8f33a01768ecc9665ec4e2cf3d895f12c44aad80b2e777ae6d16836e7f0ff1afb54635edf', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-15 22:16:22', '2021-12-15 22:16:22', '2021-12-17 22:16:22');
INSERT INTO `oauth_access_tokens` VALUES ('67741ab67fe45b45a61950eba7cba25276d2c58dfcd5dc5203af932806fa6f3c110ce77cd85d6f2d', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:48:07', '2021-12-16 18:48:07', '2021-12-18 18:48:07');
INSERT INTO `oauth_access_tokens` VALUES ('67ee79292ee993c76d84e4e08de60f0a87bb46a97f01c5f5a69a14b8b4d0f30cbef41dc3a6f5e3cc', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-21 19:32:47', '2021-12-21 19:32:47', '2021-12-23 19:32:47');
INSERT INTO `oauth_access_tokens` VALUES ('681a478cf4d6367c6a6851b327b3eb2304f0fce121042e24feabc51c6b768085a4808021dce725e1', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 23:38:50', '2021-12-17 23:38:50', '2021-12-19 23:38:50');
INSERT INTO `oauth_access_tokens` VALUES ('682413c6cfd70466df08e91bea169281f3dbe897b994f7b7d5c3edbfaf2398adb84247aa5763a4ea', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 19:51:11', '2021-12-17 19:51:11', '2021-12-19 19:51:11');
INSERT INTO `oauth_access_tokens` VALUES ('69a2cc8f35b34a2fa9c8cdf2da1797f11596532b1345f22652ec8c6b627e8d2e656ba55ae854cc4d', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:58:32', '2021-12-23 02:58:32', '2021-12-25 02:58:32');
INSERT INTO `oauth_access_tokens` VALUES ('69dd579d96b392f85c14214be9abefb6d0c791603e887e243d95a0eb2b16f90419f15541d74caf02', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-17 14:04:47', '2021-12-17 14:04:47', '2021-12-19 14:04:47');
INSERT INTO `oauth_access_tokens` VALUES ('6a63577f851dd511c9a174be709f8f291a66b3284a11228c0556c5ea858dcfdc80304739ff774ff2', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-22 11:30:27', '2021-12-22 11:30:27', '2021-12-24 11:30:26');
INSERT INTO `oauth_access_tokens` VALUES ('6b749794fcf9c88755cc09ed4434ce0c435efe396cfea6a30476e5fa10f06fc9cf5cbcb3b99960c2', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-23 04:25:06', '2021-12-23 04:25:06', '2021-12-25 04:25:06');
INSERT INTO `oauth_access_tokens` VALUES ('6c61677c1b74a3bb0e52e1569850033db681d6a7d2d979d5319c5e5ff0b2be600a1ff013580580e0', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 03:11:33', '2021-12-18 03:11:33', '2021-12-20 03:11:33');
INSERT INTO `oauth_access_tokens` VALUES ('6cacfce6843b45a6e87b4003cd5249243cd9510ab90049fbec9755d83477dc9b2fed7d0f33148907', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:48:04', '2021-12-16 18:48:04', '2021-12-18 18:48:03');
INSERT INTO `oauth_access_tokens` VALUES ('6d24962b79a5b38069a6aaf482fb20928ce66bf56385c9f872433e3f9c23086350ab30bbb4753f91', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:41:33', '2021-12-20 21:41:33', '2021-12-22 21:41:33');
INSERT INTO `oauth_access_tokens` VALUES ('6d4f10565f7e2f5694e0cc5b45b20629977d84ee32e7916fc02f3f5d39efca2dea39d6b64b0f6961', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 19:03:07', '2021-12-14 19:03:07', '2021-12-16 19:03:07');
INSERT INTO `oauth_access_tokens` VALUES ('6dc8ea559060d2ed32e0372b5454d10525592cbdf8b7bdc276dbff55276133e65c3bb36b563fa40d', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-17 08:09:04', '2021-12-17 08:09:04', '2021-12-19 08:09:04');
INSERT INTO `oauth_access_tokens` VALUES ('6ef74e377556052d0e8e4960884326e2629a73d2659df33e20684f9e130c01278d663775d0c39184', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 21:33:36', '2021-12-22 21:33:36', '2021-12-24 21:33:36');
INSERT INTO `oauth_access_tokens` VALUES ('6f98c47cf4748383c617263f9bd508127a0880f058b36c0c4a3413046a7a0f5df946fe084abc01a1', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-18 15:08:56', '2021-12-18 15:08:56', '2021-12-20 15:08:56');
INSERT INTO `oauth_access_tokens` VALUES ('6ff7a7b05009b512881b9ca5a5c3fe8aed0b06a595c31ae5bf52bab55f121956587f6c43e24e5fb1', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-19 21:50:03', '2021-12-19 21:50:03', '2021-12-21 21:50:02');
INSERT INTO `oauth_access_tokens` VALUES ('70a3f3b80ae4f6fa6aa6bdb82f99a349e7514c6b3317f90500c28e69c325c3ff16bb25057bf2f833', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 18:06:49', '2021-12-19 18:06:49', '2021-12-21 18:06:48');
INSERT INTO `oauth_access_tokens` VALUES ('71403105d7e4f352ffeb3be8d7d7792a80f13d79c85b41a8c63995a595f8b8ab02e118f664fd5890', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-18 23:17:51', '2021-12-18 23:17:51', '2021-12-20 23:17:51');
INSERT INTO `oauth_access_tokens` VALUES ('7158551789de76d9de65bf573e7d32c880244270cde972c76ea04fa7b63fc9b3041518822f5fea74', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:34:39', '2021-12-22 01:34:39', '2021-12-24 01:34:39');
INSERT INTO `oauth_access_tokens` VALUES ('732aae02e64bd78a46d26d8cd0af582e85069e874970d0f27c618b369eaf001ebd04ca9a1a4c7f37', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 21:32:05', '2021-12-21 21:32:05', '2021-12-23 21:32:05');
INSERT INTO `oauth_access_tokens` VALUES ('74aff8bdf0e685a34db52c0ba360536041d7453dbb683b662de4ae2b3ed0af2e32ff294b77d317cf', 10, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:13:03', '2021-12-20 23:13:03', '2021-12-22 23:13:03');
INSERT INTO `oauth_access_tokens` VALUES ('74b80e048066676a9b10eecc86b686ca181c07ecaa1a63e1412ce85433a1c9244acd940edfafb7e4', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:13:50', '2021-12-22 01:13:50', '2021-12-24 01:13:50');
INSERT INTO `oauth_access_tokens` VALUES ('74e1c2f17236bd8c78ba805fb84ddeb689c38a594a0adee48b43b7490a5f1b67e15bff3641b98046', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-22 16:55:46', '2021-12-22 16:55:46', '2021-12-24 16:55:46');
INSERT INTO `oauth_access_tokens` VALUES ('755b0b3624df63be5f1aa9b3973ebc7bf7af566829bac965358aaf7f76cf8e614935fe9aeac48e5a', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-20 22:31:45', '2021-12-20 22:31:45', '2021-12-22 22:31:45');
INSERT INTO `oauth_access_tokens` VALUES ('76319b534dca65a29e900f469539c8099163f92890807e1e071c845eafc58ef6fdf9a2233abb965c', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-18 16:05:11', '2021-12-18 16:05:11', '2021-12-20 16:05:11');
INSERT INTO `oauth_access_tokens` VALUES ('7828fe9f83d7e5bbc2238f286643f13717b65bc41b3ce6c89eab9c27878345df87794869e5e57c66', 6, 11, 'Personal Access Token', '[]', 1, '2021-12-14 03:39:55', '2021-12-14 03:39:55', '2021-12-16 03:39:55');
INSERT INTO `oauth_access_tokens` VALUES ('7854bc4cd97b502b893961e689c4630831c1b426c46769c8a1f97af0e319510bc79df9741b2a690b', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-19 21:45:36', '2021-12-19 21:45:36', '2021-12-21 21:45:35');
INSERT INTO `oauth_access_tokens` VALUES ('785b0eac98396f57254f9c5744f20f80f36d72a6fb36abe083de532575cc842312cfb25af93b7b66', 7, 13, 'Personal Access Token', '[]', 1, '2021-12-17 18:04:32', '2021-12-17 18:04:32', '2021-12-19 18:04:32');
INSERT INTO `oauth_access_tokens` VALUES ('78caed7e3c99e570e84e80ec681c185a963c068b35aef3f41b89bdb622699db2a15e3ea747e70492', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 23:47:46', '2021-12-17 23:47:46', '2021-12-19 23:47:46');
INSERT INTO `oauth_access_tokens` VALUES ('78df54a1e53e27751c304a71775c02e23f12b132245dab06bcbe46776bfcc3031bc3e52abef23268', 7, 13, 'Personal Access Token', '[]', 1, '2021-12-17 15:34:44', '2021-12-17 15:34:44', '2021-12-19 15:34:44');
INSERT INTO `oauth_access_tokens` VALUES ('7939d988ed9e7646d34fa848f4cf15f0a391150c48f7e32f643ed6bfc5a061baf7f8a728bcb98359', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-23 08:42:00', '2021-12-23 08:42:00', '2021-12-25 08:42:00');
INSERT INTO `oauth_access_tokens` VALUES ('79c12fadd96ef66c6e31539bd9750d251f0227a80bc0c02580cf4494dc4a95adeb96cb1934034e45', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-18 23:38:56', '2021-12-18 23:38:56', '2021-12-20 23:38:56');
INSERT INTO `oauth_access_tokens` VALUES ('7a0d92f463c00fe8499ef41f028c3e32efce1529f53307c5872dbe38517624b3a500e42e625438c3', 11, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:56:12', '2021-12-22 08:56:12', '2021-12-24 08:56:12');
INSERT INTO `oauth_access_tokens` VALUES ('7a24ffe01eef007af1861705b98b8ef09aca16ba0f41897b96d341f92f7eb4536a58d07aa8bcee73', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-19 00:20:56', '2021-12-19 00:20:56', '2021-12-21 00:20:56');
INSERT INTO `oauth_access_tokens` VALUES ('7ab0cff3a323d5e314c97633355501045ecb96834b653e09b897a71480dfc10fafc12a3920be2f33', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-13 23:59:59', '2021-12-13 23:59:59', '2021-12-15 23:59:58');
INSERT INTO `oauth_access_tokens` VALUES ('7b05f3e721573f531885adb924770a6183cd62bbc9c8dc84c012c04fe2593aa2f68ce225ceb5ac34', 28, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:12:38', '2021-12-20 23:12:38', '2021-12-22 23:12:38');
INSERT INTO `oauth_access_tokens` VALUES ('7b0e5d8b9ae72691c8bc05806d0d751977659b8ca7ec7d4cf816269c834e5e05ee1c1c1a57ebdec2', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 23:09:59', '2021-12-19 23:09:59', '2021-12-21 23:09:59');
INSERT INTO `oauth_access_tokens` VALUES ('7c373a1e6d732964d4a5941e1126608d58877f16959456018491ee645a1f1119436cc149f585468d', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 01:00:46', '2021-12-14 01:00:46', '2021-12-16 01:00:46');
INSERT INTO `oauth_access_tokens` VALUES ('7c6334ba25a70d8db1cd101d9d68ba3ea8baffb5a300cf529ef3553cf58018817a0108fbb1e99535', 1, 11, 'Personal Access Token', '[]', 0, '2021-12-15 21:31:21', '2021-12-15 21:31:21', '2021-12-17 21:31:21');
INSERT INTO `oauth_access_tokens` VALUES ('7c66a9ff1be64229a3ac21d3900bfa1982822845e96d85236206f6d6acee946f6402bb685f0ad4d2', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-15 12:51:39', '2021-12-15 12:51:39', '2021-12-17 12:51:39');
INSERT INTO `oauth_access_tokens` VALUES ('7c706012ea8cc5be8a8037b383ab075cff2c174425c82f10bb67e4f7453652cb6fc183d1c9af0a03', 7, 11, 'Personal Access Token', '[]', 1, '2021-12-15 22:21:00', '2021-12-15 22:21:00', '2021-12-17 22:21:00');
INSERT INTO `oauth_access_tokens` VALUES ('7c8331a26ff2f8e0d1145e0029d07d6d8cf0d4c4c0f662a52e6c29dcc81d8cf524f05c43b8262499', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:44:22', '2021-12-23 01:44:22', '2021-12-25 01:44:22');
INSERT INTO `oauth_access_tokens` VALUES ('7d18452188355320977af1264b32318420f3c5eb2c8a599b9d2f1083a6f83b76ee358dd2b30ae3a3', 23, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:33:30', '2021-12-20 00:33:30', '2021-12-22 00:33:30');
INSERT INTO `oauth_access_tokens` VALUES ('7d425bf1a86660944f0a157ed7f2f3b54dde5a5846c1544c4e2fde00bf7573376ec4e9a53591736b', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 21:53:43', '2021-12-14 21:53:43', '2021-12-16 21:53:43');
INSERT INTO `oauth_access_tokens` VALUES ('7db2c6d13d798d78951a803eae3aa4ece4b8b6737a1693e3f6c81ad98031d42fb1b6d111eec8c9c6', 24, 13, 'Personal Access Token', '[]', 0, '2021-12-20 00:45:18', '2021-12-20 00:45:18', '2021-12-22 00:45:18');
INSERT INTO `oauth_access_tokens` VALUES ('7dc1118a6b940b7c699b308592091aced3df8dfe05c411c8b0e2aebb8be1b3eae87d501667c279db', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 00:20:45', '2021-12-18 00:20:45', '2021-12-20 00:20:45');
INSERT INTO `oauth_access_tokens` VALUES ('7df23f9bcaa6b6a9fac313b3def1e0d096d5caf13c3ccf5a422db8ef916429ca5e4c8d43007db815', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:51:35', '2021-12-23 03:51:35', '2021-12-25 03:51:35');
INSERT INTO `oauth_access_tokens` VALUES ('7df582112e4ed96bfd44e567a9aaad535fd8f2ac8db1bc209f4899fff0621a40a11a21d6a2df36fa', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 23:29:02', '2021-12-14 23:29:02', '2021-12-16 23:29:02');
INSERT INTO `oauth_access_tokens` VALUES ('7df641d37fb7090e67939e83caa155f8b6cf963bb11a7ff33d69b4d90495035a6533750fbf6a2535', 12, 13, 'Personal Access Token', '[]', 0, '2021-12-18 21:44:15', '2021-12-18 21:44:15', '2021-12-20 21:44:15');
INSERT INTO `oauth_access_tokens` VALUES ('7e2a6929e06ea226bafee4678691298e8bdd0cd414aae3d0a7c97ac86e833f0971fa644412323d9a', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:51:15', '2021-12-16 18:51:15', '2021-12-18 18:51:15');
INSERT INTO `oauth_access_tokens` VALUES ('7ef69609e1a3c04e97bd6d9d71b4ded6881c2780b075e49fcdc7a6dbe1cfcc1c135fb105f95bb558', 11, 13, 'Personal Access Token', '[]', 1, '2021-12-20 20:53:05', '2021-12-20 20:53:05', '2021-12-22 20:53:05');
INSERT INTO `oauth_access_tokens` VALUES ('7f06f616a692f35cdbb11c53fba22988c3ac57cfd33bbe2e21c3f0ef3e35204235d8cefd268b54b6', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:15:10', '2021-12-23 02:15:10', '2021-12-25 02:15:10');
INSERT INTO `oauth_access_tokens` VALUES ('7f26d357f1181d4562b52086ddae68a9fca5abb3bab0d7b1b4cc5c4119496984ac28a0e439529bc5', 11, 11, 'Personal Access Token', '[]', 0, '2021-12-15 22:25:06', '2021-12-15 22:25:06', '2021-12-17 22:25:06');
INSERT INTO `oauth_access_tokens` VALUES ('7f52439a857e116ea71f6b25567157974a17553155e41f69f3cee0c65a6ac53147e02edae00f3e1d', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:24:39', '2021-12-20 21:24:39', '2021-12-22 21:24:39');
INSERT INTO `oauth_access_tokens` VALUES ('7fd19ec82c380a266c40fae9c6b1d998087e0b58e1542eead563b588d42fa189fafe3a4a31173145', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:48:06', '2021-12-16 18:48:06', '2021-12-18 18:48:06');
INSERT INTO `oauth_access_tokens` VALUES ('8094795903eec8439908c9fc2d25050f2a1e44e663c4d1cda5fe30c1ca79168c042ec93fa900c67e', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 19:05:13', '2021-12-16 19:05:13', '2021-12-18 19:05:13');
INSERT INTO `oauth_access_tokens` VALUES ('80ec3f7d6cac1a570cbc84ef7d834993c2126aa5015487a6c50b489ecf4bb7f91e00319ed32bc04d', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 13:48:32', '2021-12-18 13:48:32', '2021-12-20 13:48:32');
INSERT INTO `oauth_access_tokens` VALUES ('810659ebf3a7a8a8b14118b846be890f13ab76906d51cc62ccee2688b3324afa3fec6fb5ec2a9056', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-22 20:12:59', '2021-12-22 20:12:59', '2021-12-24 20:12:59');
INSERT INTO `oauth_access_tokens` VALUES ('81694a9fbebcce682b41f08d5d6a9a575242fa2ad37fd1455419ce8588ee85ddf8be66d85d47f69a', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 00:36:20', '2021-12-14 00:36:20', '2021-12-16 00:36:20');
INSERT INTO `oauth_access_tokens` VALUES ('8175d65b27d0e81dff64d58a3056dd55545b84b2ee18f9ccc7af6d744e6ae8b4659b231546671588', 30, 13, 'Personal Access Token', '[]', 0, '2021-12-21 00:57:54', '2021-12-21 00:57:54', '2021-12-23 00:57:54');
INSERT INTO `oauth_access_tokens` VALUES ('8196c3c25b907b581cda5666efc0adbb7520f987633e75e336c8402304f5ff51013b6df2a3310dea', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 00:10:18', '2021-12-23 00:10:18', '2021-12-25 00:10:17');
INSERT INTO `oauth_access_tokens` VALUES ('82b43cea91e91c5bd711f8dd52c50ab1fcf29e720a4063d5dd71520fb7e099131fdc1bc4233dd1bc', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 22:10:42', '2021-12-14 22:10:42', '2021-12-16 22:10:42');
INSERT INTO `oauth_access_tokens` VALUES ('82df5c45d1ad397ef5fd4cdc80a2a883548db0795c6055b9c59430228b187e41acc1a0260eafc83e', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-13 23:20:53', '2021-12-13 23:20:53', '2021-12-15 23:20:53');
INSERT INTO `oauth_access_tokens` VALUES ('83b5f5efe621964d538480307c88497a5b1a185b316ae1e16e7cf6ec806be2ac9dea8dc735c62cdb', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:24:40', '2021-12-22 10:24:40', '2021-12-24 10:24:40');
INSERT INTO `oauth_access_tokens` VALUES ('83c85ed3e098e6a4b667999217a5e045a7d1d00dfc8f3c90bc0c2245f336c170ca65685da61c6f8f', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 20:56:20', '2021-12-22 20:56:20', '2021-12-24 20:56:20');
INSERT INTO `oauth_access_tokens` VALUES ('841ef4fa58bee5c516b1a6a8c2a2e9c0af6718080328416ac5c89b47daaa929227d478264f200332', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 11:47:18', '2021-12-22 11:47:18', '2021-12-24 11:47:18');
INSERT INTO `oauth_access_tokens` VALUES ('843b46655e7e6bcd417aedba533e2d9b37fe671ed0425646492dc36712664357d6a4e61de3b29c20', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-23 04:44:32', '2021-12-23 04:44:32', '2021-12-25 04:44:32');
INSERT INTO `oauth_access_tokens` VALUES ('8494e54cbfe1a552b0b74315c2f6c7cf01633a9b6f71d1b6651adfbef88716498a66079be334b24f', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 13:47:09', '2021-12-18 13:47:09', '2021-12-20 13:47:09');
INSERT INTO `oauth_access_tokens` VALUES ('84bd725d2bea97144a5887d156f4a40b21b109c2bb566499fb1bd84c88fe93f2b797517e1a0e4b3d', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 02:56:29', '2021-12-16 02:56:29', '2021-12-18 02:56:29');
INSERT INTO `oauth_access_tokens` VALUES ('84e48d51f53f71bd7d0f8e5b38d008744a284d360446cad27ccb95fbd7104de9a660a9c1f0fad596', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 22:23:09', '2021-12-20 22:23:09', '2021-12-22 22:23:08');
INSERT INTO `oauth_access_tokens` VALUES ('85949c652667ff69f08a3c8e7cb109e09f95ea26d8dc26cee87ac309fa1fb76c3f3ffd9d3bbae0bb', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 14:53:32', '2021-12-20 14:53:32', '2021-12-22 14:53:31');
INSERT INTO `oauth_access_tokens` VALUES ('863b57c442df2d8a72d9d85e22f7147b6397fa93a0523db35652277ed1feb48e50727952b2ca853a', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:58:56', '2021-12-22 01:58:56', '2021-12-24 01:58:56');
INSERT INTO `oauth_access_tokens` VALUES ('86ae814e5497561892e5aadc39b351053fee4075c13b3a96a007be126c5c0aa37cd3bb0e352e5dfc', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 09:53:34', '2021-12-22 09:53:34', '2021-12-24 09:53:33');
INSERT INTO `oauth_access_tokens` VALUES ('8738955f0ac29efa8b8acd915e38d6f98e7825f3d24d93f99802ea0cc4624680bb96ba09e8809ac5', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-21 01:49:00', '2021-12-21 01:49:00', '2021-12-23 01:49:00');
INSERT INTO `oauth_access_tokens` VALUES ('875dd948e5ab8d369326f0e2228eb463f3dafb906f1b19d8eea71f77213dcc0a73bec9d93c881ada', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 23:43:03', '2021-12-21 23:43:03', '2021-12-23 23:43:03');
INSERT INTO `oauth_access_tokens` VALUES ('878cdb067751d8dde967d8f3d42eaa53c0cbf669866af9926c40310f8ef02495ebad80d8484d9498', 28, 13, 'Personal Access Token', '[]', 1, '2021-12-20 20:46:35', '2021-12-20 20:46:35', '2021-12-22 20:46:35');
INSERT INTO `oauth_access_tokens` VALUES ('879f3ff95149b62f93ce771f64f9b1f6842034a291f00e2f23d38087395cffaef86b07d0d583f1cf', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-16 20:15:22', '2021-12-16 20:15:22', '2021-12-18 20:15:22');
INSERT INTO `oauth_access_tokens` VALUES ('88cbcc99a37bfb42e1be72f334a1f5578690e7941bc5d7cccf03760b93e168cd2075eea2271044ba', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-21 01:28:18', '2021-12-21 01:28:18', '2021-12-23 01:28:18');
INSERT INTO `oauth_access_tokens` VALUES ('893cba8c2fc23260860e2330ad467a5befc122c7865ebe06ee8a3ff8a697395252a043165eeaed1e', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 20:53:03', '2021-12-22 20:53:03', '2021-12-24 20:53:03');
INSERT INTO `oauth_access_tokens` VALUES ('8972f753a1b3e5599181048a034a5315fed59f1e2afe76b097c1d3100749ed6cfbe31120bda569ac', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-29 09:48:42', '2021-12-29 09:48:42', '2021-12-31 09:48:42');
INSERT INTO `oauth_access_tokens` VALUES ('898b6927797b198c436fab80c64effdf6cfd2bed297f19a8ea5b3188db5bfa683a0df2b1e73f9b75', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:51:51', '2021-12-22 01:51:51', '2021-12-24 01:51:51');
INSERT INTO `oauth_access_tokens` VALUES ('8a48427a3dc37beb107061bd3a4ed068b11b4659f1a437c6207645078326e6d28dc9820cb1343903', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 09:24:43', '2021-12-22 09:24:43', '2021-12-24 09:24:43');
INSERT INTO `oauth_access_tokens` VALUES ('8a51515239125854368a0e1f52d801d41e9134078f1d3b787147fb98b3bbd1555924fa2e1eb6ac8e', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-22 04:22:15', '2021-12-22 04:22:15', '2021-12-24 04:22:14');
INSERT INTO `oauth_access_tokens` VALUES ('8abefe13ab4818883052726cc39b59f799d8e6e50d2c64a5ee2efd79541fcd3970e3e724043a987c', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-23 04:08:07', '2021-12-23 04:08:07', '2021-12-25 04:08:06');
INSERT INTO `oauth_access_tokens` VALUES ('8b0235a855e332c98a6916ede464d03e445c743e35133f88a0d9f66948f02c7ddbed064e6edd237c', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-20 22:21:17', '2021-12-20 22:21:17', '2021-12-22 22:21:17');
INSERT INTO `oauth_access_tokens` VALUES ('8b74a7c995830d4d85aa65d424d88ed88d82997632bbbce7b67d65051dd33eea77212553de3ca708', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 02:54:54', '2021-12-22 02:54:54', '2021-12-24 02:54:54');
INSERT INTO `oauth_access_tokens` VALUES ('8c29495c685f8ac3e80529e0d3c4358fe58f9e9c8a100b4c1f369c208d1d4e97e3d7f46a4a086b37', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-23 07:13:38', '2021-12-23 07:13:38', '2021-12-25 07:13:38');
INSERT INTO `oauth_access_tokens` VALUES ('8cc311a34b26056c54d82fc51f8cad751faa7b13e2f58bff39f546411546bc2879e3ef78e105a823', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-20 22:20:57', '2021-12-20 22:20:57', '2021-12-22 22:20:57');
INSERT INTO `oauth_access_tokens` VALUES ('8d6fc89eb6dc9984432d0ea6fe3316bbb9c6b9e87c37a217e2e1e463feae7b07b5b35ac68a04f2af', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-23 01:44:24', '2021-12-23 01:44:24', '2021-12-25 01:44:23');
INSERT INTO `oauth_access_tokens` VALUES ('8de097eae11816b2a499498d0c7a9d3ac7ab86f4d32d22b2eeda629fb8e434ee4e444ffab1a0ad1c', 41, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:19:12', '2021-12-22 08:19:12', '2021-12-24 08:19:12');
INSERT INTO `oauth_access_tokens` VALUES ('8e392e9c6aa00e1eaf2e07daa61e81f2b3194645218b92a932f8c867458ba935205a768cad1764bb', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-21 21:17:50', '2021-12-21 21:17:50', '2021-12-23 21:17:49');
INSERT INTO `oauth_access_tokens` VALUES ('8ec6a9749bea1c97c766f0ad94e6ec5254a622ee95e11567f7042ed46003860d806b889070881576', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 09:59:19', '2021-12-22 09:59:19', '2021-12-24 09:59:19');
INSERT INTO `oauth_access_tokens` VALUES ('8ec7b6cad03fdb00aed97ea0123301eb4e41894edb74238791a804c0c69ce44abe657deeeec0f90c', 39, 13, 'Personal Access Token', '[]', 0, '2021-12-22 08:42:45', '2021-12-22 08:42:45', '2021-12-24 08:42:45');
INSERT INTO `oauth_access_tokens` VALUES ('8f1d614641f2be91a08942d3558cb70277ef9cb333dd3eece14884230f16cab2465cf2bdfc12e845', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 21:53:29', '2021-12-17 21:53:29', '2021-12-19 21:53:29');
INSERT INTO `oauth_access_tokens` VALUES ('8fe5d36952e248c65346cf0f2f061b4414ce77ec6b14580b6dff7ecb94df8ea6aa9561f7ec595c5d', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:36:20', '2021-12-23 03:36:20', '2021-12-25 03:36:20');
INSERT INTO `oauth_access_tokens` VALUES ('9029a0f52609a4478c456327565bdd68883d792fc39658d8647ced3e7a0525f73f6bb266cb5b63bc', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-18 16:20:36', '2021-12-18 16:20:36', '2021-12-20 16:20:35');
INSERT INTO `oauth_access_tokens` VALUES ('90fa910b412d5022661abc2c5726f32cac6f1c3ac50170ec50a53ed2c875d682e963ed4987cf19ae', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 00:01:33', '2021-12-14 00:01:33', '2021-12-16 00:01:33');
INSERT INTO `oauth_access_tokens` VALUES ('9103f24ae5d3321bd395580a78222e87eef235ca346b0bc339db8402926e68f28e34fe1d0ce389d4', 30, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:23:49', '2021-12-20 21:23:49', '2021-12-22 21:23:49');
INSERT INTO `oauth_access_tokens` VALUES ('916fc3b709a183cbbefa7b3f2252069eb4af5eebb2cd62e8de5651f31f5377d60e5108dc3e4cda35', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-15 01:33:35', '2021-12-15 01:33:35', '2021-12-17 01:33:35');
INSERT INTO `oauth_access_tokens` VALUES ('91fbb10774092dfc7f05e167ca5f0c3b9558097228cf570b8a8b45b3d4f6d48d5d7fb2ec9e76912f', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 08:54:28', '2021-12-17 08:54:28', '2021-12-19 08:54:28');
INSERT INTO `oauth_access_tokens` VALUES ('923ee1a330955541b912342a68d2a69085249ab0e31636329a0bb84c2f98e5962c7bbae3436a3b12', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 00:58:02', '2021-12-18 00:58:02', '2021-12-20 00:58:02');
INSERT INTO `oauth_access_tokens` VALUES ('927a17cd95378d15f031d016971084b0ddbeb7c5c3f900b9ef121d7e711dadfaaa5739515c13c6d9', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:17:08', '2021-12-20 23:17:08', '2021-12-22 23:17:08');
INSERT INTO `oauth_access_tokens` VALUES ('9280326702a0a6d77c8e2bf10588d08ca851b78ec955b1ea1862bdd7e13834a6a7c722a79fb01128', 22, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:32:07', '2021-12-20 00:32:07', '2021-12-22 00:32:07');
INSERT INTO `oauth_access_tokens` VALUES ('92853831848d3c55d17e369d295c557ffde524727ecd6adc701e6660e49536bffabe393459ca2a9a', 25, 13, 'Personal Access Token', '[]', 0, '2021-12-20 00:56:17', '2021-12-20 00:56:17', '2021-12-22 00:56:17');
INSERT INTO `oauth_access_tokens` VALUES ('9298969c242cba6c406a8fafbfa7dfa2c27c1f9d42b6464c19423bf00ca864c41b9cb3bb6c7805ae', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:41:22', '2021-12-20 21:41:22', '2021-12-22 21:41:22');
INSERT INTO `oauth_access_tokens` VALUES ('92b7f40c360ae525e84ff535fcfe8066e47fa66bf0c8ca8415f72250d6de5b99265052e6d34212b3', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-18 23:54:27', '2021-12-18 23:54:27', '2021-12-20 23:54:27');
INSERT INTO `oauth_access_tokens` VALUES ('93ad4157d8b8d85d192434a2a61ee2a104bcedc9b85bc2bf1f55d7e0c811ffa972fab87fa9837e24', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-16 02:13:45', '2021-12-16 02:13:45', '2021-12-18 02:13:44');
INSERT INTO `oauth_access_tokens` VALUES ('93ec3cf4c11b4ddf392fcb805c3a36bfdb21216f7f5e813794b7a40bbcaa76f15412b519fa64b65b', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-15 00:19:15', '2021-12-15 00:19:15', '2021-12-17 00:19:15');
INSERT INTO `oauth_access_tokens` VALUES ('93fd81e56f715092c15fb002522ab1fc25b1acb28d199857b9dc487d830c20a8924bc08f610556ce', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-18 07:49:18', '2021-12-18 07:49:18', '2021-12-20 07:49:17');
INSERT INTO `oauth_access_tokens` VALUES ('948992a5d79adaa2e87d6bf0a8ae497a62573600fd8d0e995afe977b4f96f17c84f1be72044f3741', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 23:30:25', '2021-12-17 23:30:25', '2021-12-19 23:30:25');
INSERT INTO `oauth_access_tokens` VALUES ('956bc7b6da3241abb301d1a340929c711ff96fd9ceb6ba3562a1bec21ffc99c2223c4a4a415e9a08', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 07:31:14', '2021-12-23 07:31:14', '2021-12-25 07:31:14');
INSERT INTO `oauth_access_tokens` VALUES ('97693b2db29e946fee04849e36f732b298cb6eaa8a6aa76e0529b8a4aebdbf18b596ce089fde825e', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 17:42:19', '2021-12-19 17:42:19', '2021-12-21 17:42:19');
INSERT INTO `oauth_access_tokens` VALUES ('994ef78014f83fa5245fafca95886fd5b68e9701ff80b214e50692b5e7ffc1fb7b82412df9862993', 7, 11, 'Personal Access Token', '[]', 0, '2021-12-14 03:42:05', '2021-12-14 03:42:05', '2021-12-16 03:42:05');
INSERT INTO `oauth_access_tokens` VALUES ('995fd9e6d54888778f7b9279122ce7a8f28597ea95de1ddb5e077b3a80791ecbb1d6a50143c243e4', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 21:32:56', '2021-12-21 21:32:56', '2021-12-23 21:32:56');
INSERT INTO `oauth_access_tokens` VALUES ('99843a5929d7b1bdf64ecfbbaf33cbdbbf3e0a88f0f7f94ee5b5f318c18912c9128cd38088783e53', 41, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:21:42', '2021-12-22 08:21:42', '2021-12-24 08:21:42');
INSERT INTO `oauth_access_tokens` VALUES ('99ee18baf19763c7914b2d7b4c44babd9b92f74d5daafcfaa5ae87313bf5c2d8e0fdfa2acc70633e', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 18:21:59', '2021-12-16 18:21:59', '2021-12-18 18:21:58');
INSERT INTO `oauth_access_tokens` VALUES ('9a2775535da55343a39c0468bc7c0f835230277e175d39ca180377049188312e3ee71b78b67c8d4c', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:38:21', '2021-12-22 10:38:21', '2021-12-24 10:38:21');
INSERT INTO `oauth_access_tokens` VALUES ('9b3c988ebef9b99d3f33382396415af60b3ecae00c9a5426a6b260c13968af1b432a149e27ad5794', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:34:10', '2021-12-22 10:34:10', '2021-12-24 10:34:10');
INSERT INTO `oauth_access_tokens` VALUES ('9b6057d0af95812d477c89a8eb460e13590813945c7d85d57053fe02c8f48da718565ea2786f6618', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-18 22:08:52', '2021-12-18 22:08:52', '2021-12-20 22:08:52');
INSERT INTO `oauth_access_tokens` VALUES ('9bec1eb89f2cc04a606cdd47f9015dba2cbe4e01aea20813b5483da4fbea8f627f60c9ffc915baa6', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-23 03:56:15', '2021-12-23 03:56:15', '2021-12-25 03:56:15');
INSERT INTO `oauth_access_tokens` VALUES ('9c6592ded2f12585e44e0d4321f5b25ead76af2f67dd3bfa808eeec2446dec5b5d62f4728a882863', 11, 11, 'Personal Access Token', '[]', 1, '2021-12-14 23:11:04', '2021-12-14 23:11:04', '2021-12-16 23:11:04');
INSERT INTO `oauth_access_tokens` VALUES ('9c9a2fd8204e64e8213d050b7d199098d70cdffb8f79cb17ebfc53d870f4642d1bc6722d56d241d6', 29, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:23:01', '2021-12-20 21:23:01', '2021-12-22 21:23:01');
INSERT INTO `oauth_access_tokens` VALUES ('9dd57d8b06dc149d932c6dc986b5b01b840c586372053baeb744b47ed7dfef96d43cb4857b8c04c1', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 23:58:16', '2021-12-17 23:58:16', '2021-12-19 23:58:14');
INSERT INTO `oauth_access_tokens` VALUES ('9de25b30b2dc6b0366da397007ff253b1d65b4d84503b0114843631afcb83ee86d9897e9a786a85c', 45, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:36:30', '2021-12-22 08:36:30', '2021-12-24 08:36:30');
INSERT INTO `oauth_access_tokens` VALUES ('9e8a4e6719f9c9c34ebbbbbb0f54285b135c0708b272be46ee2fab6515fbfcd84acf1b078b8d1e34', 42, 13, 'Personal Access Token', '[]', 0, '2021-12-22 08:32:07', '2021-12-22 08:32:07', '2021-12-24 08:32:07');
INSERT INTO `oauth_access_tokens` VALUES ('9f51497a85e033bc3ea5c0985cf6cff3fe0a18f8565a86fcb1766a42eeb60d92331b2615831a9424', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 17:53:27', '2021-12-19 17:53:27', '2021-12-21 17:53:27');
INSERT INTO `oauth_access_tokens` VALUES ('a08f12c15d183a3d9f9a0f0f3d8a3d574545410c05bd557e97cf060c5d7b37ad481cbe50f3f82123', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-22 00:48:25', '2021-12-22 00:48:25', '2021-12-24 00:48:23');
INSERT INTO `oauth_access_tokens` VALUES ('a09d69381d76764b8453a6e177819902d6ee7323d1552e92aa2eac19a259ba22d5f924ee2e3bcc1d', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:41:10', '2021-12-20 00:41:10', '2021-12-22 00:41:10');
INSERT INTO `oauth_access_tokens` VALUES ('a0f40504f4e191f458ad83a77fc47067cbc45d0cc7345068cde704efd2453eebfc7c3f58d7233247', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 23:26:53', '2021-12-18 23:26:53', '2021-12-20 23:26:52');
INSERT INTO `oauth_access_tokens` VALUES ('a2172b82d734c8807245c26a060957e82bc02ad945a7b19cfecfa2869f04600cbc5b0bf2e1096f51', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-18 21:47:29', '2021-12-18 21:47:29', '2021-12-20 21:47:29');
INSERT INTO `oauth_access_tokens` VALUES ('a21da21ed2990fcc9fcc645bdf8d4b56b0b340d779940820528aeb29cdcb1f1e9170d9e0b1aad4d8', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-16 01:10:08', '2021-12-16 01:10:08', '2021-12-18 01:10:08');
INSERT INTO `oauth_access_tokens` VALUES ('a25ca67d33352f1281f4f7628c475fa1586518007de69c2912b429d678af4b99d1b2232d7f17d49a', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-23 00:00:09', '2021-12-23 00:00:09', '2021-12-25 00:00:09');
INSERT INTO `oauth_access_tokens` VALUES ('a2c336865842dbc3ba22919daea24a7277d18bc919501fb973480f06c327e58e3b497a23fbca9bd9', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 13:11:32', '2021-12-21 13:11:32', '2021-12-23 13:11:32');
INSERT INTO `oauth_access_tokens` VALUES ('a3e2159c1c04e3b06e3bd785dc840ff53907eb0ec37b3953fe858481e924f67930405975f8e43cd1', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-23 08:42:56', '2021-12-23 08:42:56', '2021-12-25 08:42:56');
INSERT INTO `oauth_access_tokens` VALUES ('a40f230121da5895321555bde645b8ac4e9c1013205d2590f37e74d4e290c26aae40ed196f27150c', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-19 23:12:53', '2021-12-19 23:12:53', '2021-12-21 23:12:52');
INSERT INTO `oauth_access_tokens` VALUES ('a537f41f736de2436480d50754dcc1ba71fd112d76260b721c92d9533d073a7c17bd5d0dfe6fcd6f', 13, 13, 'Personal Access Token', '[]', 0, '2021-12-18 23:35:41', '2021-12-18 23:35:41', '2021-12-20 23:35:41');
INSERT INTO `oauth_access_tokens` VALUES ('a5a83ca7445dd678fa3a172f9f4bed2db56d829857b632c213f1fb3152fbdad6734fd149a97a3fb6', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 18:22:04', '2021-12-16 18:22:04', '2021-12-18 18:22:04');
INSERT INTO `oauth_access_tokens` VALUES ('a63f111f221bc9e25fa1afd093ce40102e5f2c024027d6f9adb7234b12f09ea45212bda97f84aba2', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 12:38:39', '2021-12-17 12:38:39', '2021-12-19 12:38:39');
INSERT INTO `oauth_access_tokens` VALUES ('a6aa11faf48608c98e0b4c50cb73a9903a46a3f13689981191b38dc9e379e68518afce84cdf9e13e', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 09:24:09', '2021-12-22 09:24:09', '2021-12-24 09:24:09');
INSERT INTO `oauth_access_tokens` VALUES ('a7b8954c1cfacedf20086003c012b1432b454b65e5e118637d6def0f622fae2de371afa9521b680a', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:07:18', '2021-12-22 10:07:18', '2021-12-24 10:07:17');
INSERT INTO `oauth_access_tokens` VALUES ('a849fc52bb43bb9909e09b677902445067b47b47660554ba9a80ff1c05e7f31c10fc8f5f195bcd2a', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-18 23:06:29', '2021-12-18 23:06:29', '2021-12-20 23:06:29');
INSERT INTO `oauth_access_tokens` VALUES ('a8655da8d0e9a78e336fb60537eacd45717d940b8129dd3c371d474a0a80e809acd07cbddc6a1072', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-14 02:27:39', '2021-12-14 02:27:39', '2021-12-16 02:27:39');
INSERT INTO `oauth_access_tokens` VALUES ('a8920067654d393382e1b1f4fd635f591afccf1f13848dadf9ef73f88178dc156ec05a1e8622f883', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-18 01:29:15', '2021-12-18 01:29:15', '2021-12-20 01:29:14');
INSERT INTO `oauth_access_tokens` VALUES ('a92b610558b75b351ff7e5c992aa86b1ce97a1a5b5b932b910592175776939147fc6fb6343f7d19e', 38, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:26:20', '2021-12-20 23:26:20', '2021-12-22 23:26:20');
INSERT INTO `oauth_access_tokens` VALUES ('a9b246956a07d060817e7e5627cccf98a6c96c8d5d1c584f8300b8a9d33a3e0afe60bd7d7971bb02', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-21 19:34:44', '2021-12-21 19:34:44', '2021-12-23 19:34:44');
INSERT INTO `oauth_access_tokens` VALUES ('a9f69836ab20d6f4f6b356378826c5e7bbb033479eb475d3c14d0aa849436246e618c586466da65e', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:39:28', '2021-12-23 01:39:28', '2021-12-25 01:39:28');
INSERT INTO `oauth_access_tokens` VALUES ('a9f75ba131d64e0f63ddd766d1d25885a94257d34ce1669a60d01a1b266f45c0b5ee70bd1cb46035', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 23:42:07', '2021-12-14 23:42:07', '2021-12-16 23:42:06');
INSERT INTO `oauth_access_tokens` VALUES ('aa012c1d799b0f480d37a5e1be849506da3f718c5c23c4ff8864efae66836b9bbdf8d6bf71884ca7', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 21:58:46', '2021-12-19 21:58:46', '2021-12-21 21:58:46');
INSERT INTO `oauth_access_tokens` VALUES ('ab967270ef56b7b90ead2ee5b848c0c42a36fdede57f76d204eead2a05677e3fdb2202ecc87542a9', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:09:42', '2021-12-23 02:09:42', '2021-12-25 02:09:42');
INSERT INTO `oauth_access_tokens` VALUES ('abd909016ae10ded00521630564ad4de1cf0086dfca0ab14428ed4436f7b36a20d1577eda0ff4ffd', 11, 11, 'Personal Access Token', '[]', 1, '2021-12-15 19:41:39', '2021-12-15 19:41:39', '2021-12-17 19:41:39');
INSERT INTO `oauth_access_tokens` VALUES ('ac2d925413fa19538369dcdd5ae6e66b0a189673c14a581c5ee6821921ae1e1010aa43ea235ac653', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 15:48:00', '2021-12-19 15:48:00', '2021-12-21 15:48:00');
INSERT INTO `oauth_access_tokens` VALUES ('acc6d0eec266deab69db89f567ee1c063107a99a10e3bec30c2e5e36ebbae7005b69cadc1fec04df', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:20:12', '2021-12-23 01:20:12', '2021-12-25 01:20:12');
INSERT INTO `oauth_access_tokens` VALUES ('acd320a1cf10b3ef7d8e6b9f5e91a2641054b38ace060b39f6939c7adf4a2ffcc34c6b78a5a8da3a', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 20:03:58', '2021-12-14 20:03:58', '2021-12-16 20:03:58');
INSERT INTO `oauth_access_tokens` VALUES ('ad0b047d0c0c0382dfa38f101a4ee1fa86b00baf602e4b52cda86ba96ff8fd9735d3a1cbf32c10ea', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:59:56', '2021-12-21 20:59:56', '2021-12-23 20:59:56');
INSERT INTO `oauth_access_tokens` VALUES ('adf73905a0b6f882c762dc783ed295ce3cf8b3af9ef57de399a7b97141b21bfacdf81be48cdf883c', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 02:24:01', '2021-12-22 02:24:01', '2021-12-24 02:24:01');
INSERT INTO `oauth_access_tokens` VALUES ('ae45d0870fc17ef907cbe97fa0a4d89a362e9ee52d857c317dff961aa5f5452941d7f1739f94c8b7', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 00:09:47', '2021-12-19 00:09:47', '2021-12-21 00:09:47');
INSERT INTO `oauth_access_tokens` VALUES ('af2e77ead62eee1dd0c23728267d50a7f32d28c4bbc557148e3a2f674a623fd3d63b595ff4d1d291', 28, 13, 'Personal Access Token', '[]', 0, '2021-12-20 23:30:43', '2021-12-20 23:30:43', '2021-12-22 23:30:42');
INSERT INTO `oauth_access_tokens` VALUES ('afa9719c56ea2d2098d5dad7f0dc9418b35e3cdc59f43a690a279300508badc335af894b06d06dcf', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:32:48', '2021-12-21 20:32:48', '2021-12-23 20:32:48');
INSERT INTO `oauth_access_tokens` VALUES ('afd42cc8ac96b57928de27a11fe05d4a00eef65abda824a0f3f67456eaa5d42be029610d46611bc2', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 00:56:42', '2021-12-22 00:56:42', '2021-12-24 00:56:42');
INSERT INTO `oauth_access_tokens` VALUES ('b10af8c1c15e303f041cec730f5247d5c89a1838eca0a244d83422c9390ae90255904f5075c195ab', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:21:17', '2021-12-23 03:21:17', '2021-12-25 03:21:17');
INSERT INTO `oauth_access_tokens` VALUES ('b1d4f8cc8d81ca35d4014a17b8d1dabffaaf8e46dcdd307af63cde0a09ffbaa97f9c30a0aed14efd', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 21:50:27', '2021-12-18 21:50:27', '2021-12-20 21:50:27');
INSERT INTO `oauth_access_tokens` VALUES ('b2c65748a4f3e9bb589fddb257825219d128993759f1882122e4dc7db30abec85b9238c8c43508e0', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-22 17:37:12', '2021-12-22 17:37:12', '2021-12-24 17:37:12');
INSERT INTO `oauth_access_tokens` VALUES ('b2ce661022a501e4b36a8070918fb5b0d414d90f8ae0aa8deb3e62886b3c5a62f850175e5d7d8129', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 21:39:57', '2021-12-19 21:39:57', '2021-12-21 21:39:57');
INSERT INTO `oauth_access_tokens` VALUES ('b2d8fa43ef22447365bd4139e8572f2a5620e4eaa393ca977da68c164ad165580c514eb9ce6d0577', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 16:01:18', '2021-12-19 16:01:18', '2021-12-21 16:01:18');
INSERT INTO `oauth_access_tokens` VALUES ('b4d8cf9e576b7261fbf4ea6b92966b371644208ace5acd72508b82c3b4b75a619b1e0da353b30a92', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 12:27:43', '2021-12-21 12:27:43', '2021-12-23 12:27:43');
INSERT INTO `oauth_access_tokens` VALUES ('b528c7dbc934a555bcfcfdcbaaef4318f619c3b8810ec040b4f4fb40ab1c695d4a116eb7cb70235b', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:39:19', '2021-12-22 10:39:19', '2021-12-24 10:39:18');
INSERT INTO `oauth_access_tokens` VALUES ('b5837266125b1c77447f92b9cadb7132acf413b07f82e0f87675825dc8b64f4c3d9ef4e20ba0872b', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-20 00:14:47', '2021-12-20 00:14:47', '2021-12-22 00:14:46');
INSERT INTO `oauth_access_tokens` VALUES ('b5b634280bdbbecc1fe4500981b900e569eca241fa85b2c2b00c98cc22d93f4786566341e877ca49', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 02:06:11', '2021-12-19 02:06:11', '2021-12-21 02:06:11');
INSERT INTO `oauth_access_tokens` VALUES ('b6243a5a630970a0f6ed700f775e0807e5225696e2bb162ca5e76cb35ed60edc1d8ac8e4a754ebbc', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 18:08:45', '2021-12-19 18:08:45', '2021-12-21 18:08:45');
INSERT INTO `oauth_access_tokens` VALUES ('b66db7eaad0035c113f56048e4cb31c8d3214d810c03c261a98cd7f58b396225f09f83a8362e718e', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 01:44:57', '2021-12-21 01:44:57', '2021-12-23 01:44:57');
INSERT INTO `oauth_access_tokens` VALUES ('b8073ad35ff092f974fb0606f43b84dc83b4eac761a8db88362b4074f9c5e6dd1a6e482a68411b94', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-29 10:33:54', '2021-12-29 10:33:54', '2021-12-31 10:33:54');
INSERT INTO `oauth_access_tokens` VALUES ('b900b155e9335ee3705ba37c09e2d4875201b7ba91e7ab606ac6dba4feeba564f91c9c0f38a2292b', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 18:09:56', '2021-12-19 18:09:56', '2021-12-21 18:09:56');
INSERT INTO `oauth_access_tokens` VALUES ('b9c56fe9a27f6595064b4fdc53ab479a9ed65fcfd45685da41296a7543cf05b6c6c3064586e7c7e9', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-20 00:39:44', '2021-12-20 00:39:44', '2021-12-22 00:39:44');
INSERT INTO `oauth_access_tokens` VALUES ('b9c8a4c973124f300349008bd26f59aa4fc8c1618e24df59ce81a7b44ac7319bd9f0e8980506f675', 5, 11, 'Personal Access Token', '[]', 0, '2021-12-13 23:26:55', '2021-12-13 23:26:55', '2021-12-15 23:26:55');
INSERT INTO `oauth_access_tokens` VALUES ('ba14a2196a562d2b2c170bc8e8f5e6db71cb41296802b9500fdc30c7d6b5ce44d7d49ddea533e5b7', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 16:20:53', '2021-12-21 16:20:53', '2021-12-23 16:20:53');
INSERT INTO `oauth_access_tokens` VALUES ('bb104d088e5e670cece687b320d3a49919d5a4293237d64dcbfaea228c85e20dbd5e31a89a45129c', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:52:19', '2021-12-22 10:52:19', '2021-12-24 10:52:19');
INSERT INTO `oauth_access_tokens` VALUES ('bb35ce7b5119dbdfe8c8a8a9b5bad45756db6a8c1ed7bd6d5a6542f38bd3da1a6ecf77e606ad60a5', 10, 11, 'Personal Access Token', '[]', 1, '2021-12-14 16:45:10', '2021-12-14 16:45:10', '2021-12-16 16:45:10');
INSERT INTO `oauth_access_tokens` VALUES ('bb693b33b515334c5c3fd9523db5c8ef3634bcb2d344497b7d400da0fafbe87160c0f93a14aa78ee', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-19 00:17:01', '2021-12-19 00:17:01', '2021-12-21 00:17:01');
INSERT INTO `oauth_access_tokens` VALUES ('bc9b5f3eec0b7cb3358415325254747ef9c6d93cf9d0f276f2e865ffa65f55a62efa9218e9f29f49', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 13:17:14', '2021-12-21 13:17:14', '2021-12-23 13:17:14');
INSERT INTO `oauth_access_tokens` VALUES ('bcc720bd24ce0ef260047e387ec567113e06d386ec4b623a50e3e14c481a903b0f78e049154e985a', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-15 02:39:09', '2021-12-15 02:39:09', '2021-12-17 02:39:09');
INSERT INTO `oauth_access_tokens` VALUES ('bd2aee3697fc5945c83298625cf552c3811244521a4249c1e056879f8abe5baf48607c4ef253e53f', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:54:07', '2021-12-20 00:54:07', '2021-12-22 00:54:07');
INSERT INTO `oauth_access_tokens` VALUES ('bd553ffa00cde0ce6d2c166676e4d374069c4ce406d6703c56e14dde311b066f9fa504850a8f375e', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 13:39:52', '2021-12-20 13:39:52', '2021-12-22 13:39:52');
INSERT INTO `oauth_access_tokens` VALUES ('bda95dffb6441595f407ae68b85c2ca39a1d56435b0634d86b3d60f430779c95410294d852ca017d', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 00:39:05', '2021-12-21 00:39:05', '2021-12-23 00:39:05');
INSERT INTO `oauth_access_tokens` VALUES ('bdab11646fb12a88ee31e9c4334c1e6d482eb7ce41e0ee8eadff56eec0820fb801ec526335427753', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-25 20:28:16', '2021-12-25 20:28:16', '2021-12-27 20:28:16');
INSERT INTO `oauth_access_tokens` VALUES ('bdcd1ac9685bc6e9e6d384b5416e8882f337dd1c570c10fe8f8d00e01d7a2baedcc4b724c17c3ff1', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-18 13:48:50', '2021-12-18 13:48:50', '2021-12-20 13:48:49');
INSERT INTO `oauth_access_tokens` VALUES ('be0388e176d79c1d08c0174b06a3e409f23b82832369f6322097f0f0d59095462defd16a1aaf16d6', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:52:36', '2021-12-20 00:52:36', '2021-12-22 00:52:36');
INSERT INTO `oauth_access_tokens` VALUES ('be4bee69bdd548cf6e8d061d1213fb934cd2ac2d4e6b34642a4fc9458436b0082c0a4f0e4ed44737', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 15:21:14', '2021-12-17 15:21:14', '2021-12-19 15:21:14');
INSERT INTO `oauth_access_tokens` VALUES ('be7891ff47d3ddb877df4d5d86f09fec1f9e86ce9c35553f2e006e175798c21356d205b771fdc595', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:12:16', '2021-12-20 23:12:16', '2021-12-22 23:12:16');
INSERT INTO `oauth_access_tokens` VALUES ('be7afdbeebbc2683c6f6b898157cd5447cd7085d6a320fc8e103530266eabf971745de3dd565630e', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 19:48:24', '2021-12-14 19:48:24', '2021-12-16 19:48:23');
INSERT INTO `oauth_access_tokens` VALUES ('beb1dc779013f24bc70d0d2304dd1a5247c82b31d511aaa1faba16743dd0414074b499947f93b666', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-22 10:55:58', '2021-12-22 10:55:58', '2021-12-24 10:55:58');
INSERT INTO `oauth_access_tokens` VALUES ('beda11953bc3e21238b488459489268c4d84f5af4f8086c5bd483bb8f992a45349f76c635d651c20', 6, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:26:58', '2021-12-20 21:26:58', '2021-12-22 21:26:58');
INSERT INTO `oauth_access_tokens` VALUES ('bf04df504dd369793c0e66b0444f7bbdecc81e6268bc494a6be8bd0c1243851875278d81cb20b674', 44, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:26:17', '2021-12-22 08:26:17', '2021-12-24 08:26:17');
INSERT INTO `oauth_access_tokens` VALUES ('bf204e48adb7c5976d3904ad9bf9e1afc2be2107bf7a1b35c24480f9b167c7593719cfb9b596a7d7', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 16:22:18', '2021-12-21 16:22:18', '2021-12-23 16:22:18');
INSERT INTO `oauth_access_tokens` VALUES ('c0117d1503280de26920edb9c5aff6dabe677bcadb6796aee7d36be1d1abfa433b48cb7ae0fb3c06', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 11:05:57', '2021-12-14 11:05:57', '2021-12-16 11:05:57');
INSERT INTO `oauth_access_tokens` VALUES ('c09b5ac25480243430747f04e9fd1bda73548ac24b0ac56658bde05dc0b979fe8f05b5b743668071', 38, 13, 'Personal Access Token', '[]', 0, '2021-12-20 23:29:57', '2021-12-20 23:29:57', '2021-12-22 23:29:57');
INSERT INTO `oauth_access_tokens` VALUES ('c18d0de8e51ef78646f95333629de8b60be3a014e6ea334c4ebadd0be641fbdc58544bed1b1e5a2a', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 15:57:20', '2021-12-18 15:57:20', '2021-12-20 15:57:20');
INSERT INTO `oauth_access_tokens` VALUES ('c1b4e749a073cbbba236af3ae8f69ce2731b75e0ed47cca9776125569da3ff22366c60c4acedf395', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-22 13:40:58', '2021-12-22 13:40:58', '2021-12-24 13:40:58');
INSERT INTO `oauth_access_tokens` VALUES ('c27eb7988402da0d30493a8f5f428e62581481f0e3ae02efb1a3af60cf3f35b660d5788f3c00de56', 11, 13, 'Personal Access Token', '[]', 0, '2021-12-16 20:01:51', '2021-12-16 20:01:51', '2021-12-18 20:01:51');
INSERT INTO `oauth_access_tokens` VALUES ('c2fde20863eb1b200ce562283745fc02e6821bd64a7dde326b33d24160582ce5270c155778b150e2', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-14 00:10:52', '2021-12-14 00:10:52', '2021-12-16 00:10:52');
INSERT INTO `oauth_access_tokens` VALUES ('c30cc398fe83c9f76a57e43a17bb8bda90850701db4bb6b793fd36482966dc7beff7028c97ffbe5f', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 19:05:09', '2021-12-16 19:05:09', '2021-12-18 19:05:09');
INSERT INTO `oauth_access_tokens` VALUES ('c3eeba9a81e0afc4c8e3bcebf85f393fada6e8016b08c3ceed2b868781ce27767db7a27a13b35e58', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:20:14', '2021-12-20 23:20:14', '2021-12-22 23:20:14');
INSERT INTO `oauth_access_tokens` VALUES ('c3f47884ad0fde9891a1151890e6645331ccc9e7e0b675e561b96bc5d6064bc76eec32b642ee3123', 30, 13, 'Personal Access Token', '[]', 0, '2021-12-21 00:24:26', '2021-12-21 00:24:26', '2021-12-23 00:24:25');
INSERT INTO `oauth_access_tokens` VALUES ('c401eb0a9017df6913e4544d77425f356d57f8c6c028021e9d21da4605998a84dd70a51901db4bce', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 01:34:03', '2021-12-22 01:34:03', '2021-12-24 01:34:03');
INSERT INTO `oauth_access_tokens` VALUES ('c68252a53f45ebe773bf8208b246997b98f53132e57c3f2bd19d7dae010625afe83dfb7816479551', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-18 01:25:05', '2021-12-18 01:25:05', '2021-12-20 01:25:05');
INSERT INTO `oauth_access_tokens` VALUES ('c6a782763dec654e01f498e2d7f0e1b342ba6d3c204cd1c2bccfcabaf08f049940349bccf2974897', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 15:02:07', '2021-12-20 15:02:07', '2021-12-22 15:02:07');
INSERT INTO `oauth_access_tokens` VALUES ('c6b0fe40cdf56d9e5249e8ab00fb7d4cbd3845b65bd3301148e206baef87841c9d672a865943a062', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:48:32', '2021-12-23 01:48:32', '2021-12-25 01:48:32');
INSERT INTO `oauth_access_tokens` VALUES ('c72726b0d4421fa8ade750dcc0a5f861594cd24f099c605cfc0c57e9d07b879e51d8ac2f896a3bea', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-19 00:11:13', '2021-12-19 00:11:13', '2021-12-21 00:11:13');
INSERT INTO `oauth_access_tokens` VALUES ('c8616dd9dfab1352607b3e80e7fac31586cd6a6a141aeabef97f97244c2c46caf850a3f86ae56c23', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 03:40:45', '2021-12-19 03:40:45', '2021-12-21 03:40:45');
INSERT INTO `oauth_access_tokens` VALUES ('c8a0832362c969424858e78bcd02a57c8336048660049f50f3e7f95fe7977febc2e8bc6b6e9690b1', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 03:12:14', '2021-12-16 03:12:14', '2021-12-18 03:12:13');
INSERT INTO `oauth_access_tokens` VALUES ('ca6058c657a59741d6c688e042ab81e73409a5f71924f3a8f369f4a7a7972ab0272738a6ae82bd38', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-15 01:05:58', '2021-12-15 01:05:58', '2021-12-17 01:05:57');
INSERT INTO `oauth_access_tokens` VALUES ('ca719ddd6c8c79ba15a4b7f2297b059f47efd1cbeecc6d12f0e651436964d5d2e7ccc6db49cf2921', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-17 17:19:27', '2021-12-17 17:19:27', '2021-12-19 17:19:27');
INSERT INTO `oauth_access_tokens` VALUES ('cab9060670509ba22fd7062fae6ed1f713021f5e8a2a2e535fdd96f779d9470b6e1f33d190d33f53', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 02:35:27', '2021-12-14 02:35:27', '2021-12-16 02:35:27');
INSERT INTO `oauth_access_tokens` VALUES ('cae96f9c419e2fc9abb537e5d9193d18a05ca86b5bc35ff37665b5fa60bb87f79e1c566c03622805', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-13 23:53:46', '2021-12-13 23:53:46', '2021-12-15 23:53:45');
INSERT INTO `oauth_access_tokens` VALUES ('cb738466cc2e7f89f7eb14cffc155894242adfd2027ee3753bb251f2ef3e4dd40016e553314c25ab', 42, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:32:58', '2021-12-22 08:32:58', '2021-12-24 08:32:58');
INSERT INTO `oauth_access_tokens` VALUES ('cc2cf3a6c124d2d5053ff26d0a06283a205a161774516afd999bada0e60bda47aea88f942b3fcabe', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 22:00:20', '2021-12-17 22:00:20', '2021-12-19 22:00:20');
INSERT INTO `oauth_access_tokens` VALUES ('cc84a8aa755b7375317e085938d5b45db932e76b2ba8ee98498caef7a5f5465feb6f7df3f6179843', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:40:13', '2021-12-22 23:40:13', '2021-12-24 23:40:13');
INSERT INTO `oauth_access_tokens` VALUES ('ccf825c805feb5b3484ecd81a358b0d838687a3b7017fca7bdd23a5899a2e0749ea55f964ae6a36d', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 22:11:23', '2021-12-17 22:11:23', '2021-12-19 22:11:23');
INSERT INTO `oauth_access_tokens` VALUES ('ce4fdef854df5a87c4664447c8c3d7f697254409ca6661d61fbb6db9ae67ea45a82e6bc020101a21', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 01:23:48', '2021-12-20 01:23:48', '2021-12-22 01:23:48');
INSERT INTO `oauth_access_tokens` VALUES ('cf00a95f411d6d7e11dfa73e0737b75ba4f9cd6529989752d6e170a6eb5c7668a60c82ed0c81747f', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 22:57:24', '2021-12-21 22:57:24', '2021-12-23 22:57:24');
INSERT INTO `oauth_access_tokens` VALUES ('cf867791f7e422621f626df4110b6f0b396238e06111105f3177646af21ae35ad1323b81500eeec2', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:48:06', '2021-12-16 18:48:06', '2021-12-18 18:48:06');
INSERT INTO `oauth_access_tokens` VALUES ('cfbb4ab6af7ee864fc0eb06356fbfeb9d6e9688152fc74bf962853c8074cfe28a446ce40fe979971', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-15 22:03:30', '2021-12-15 22:03:30', '2021-12-17 22:03:30');
INSERT INTO `oauth_access_tokens` VALUES ('cfe7ef816b2ca0ca53eb6b0c01861f1a6432925b721c4b148bab8f1de86cf4341bb4253ae40e12e4', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 00:08:08', '2021-12-19 00:08:08', '2021-12-21 00:08:08');
INSERT INTO `oauth_access_tokens` VALUES ('cfe826caf669fd56ee5d693ca110ac9d951743e14b9ad9746de7f3295113a94b730e88926ab232d1', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:50:00', '2021-12-22 23:50:00', '2021-12-24 23:50:00');
INSERT INTO `oauth_access_tokens` VALUES ('d006b8b8746a64fa5e398e70ebde6a2c538bff72c830a21dac8011a1513ec89fb9479864ae2999b0', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 22:25:47', '2021-12-17 22:25:47', '2021-12-19 22:25:46');
INSERT INTO `oauth_access_tokens` VALUES ('d092a6f0f856531408b229ccab96b2e6d1bac466680d4fbccf9839b46fb41a31f0280ab480968a27', 28, 13, 'Personal Access Token', '[]', 1, '2021-12-20 20:53:28', '2021-12-20 20:53:28', '2021-12-22 20:53:28');
INSERT INTO `oauth_access_tokens` VALUES ('d0d9973b5c49875b4a93a2998d07112e86967e8e3bc5aac45ee2820742e75bcf32cd80a18a0e0abc', 11, 13, 'Personal Access Token', '[]', 1, '2021-12-18 16:26:02', '2021-12-18 16:26:02', '2021-12-20 16:26:01');
INSERT INTO `oauth_access_tokens` VALUES ('d11f74a05c9e30ec28b2cfe408b38aab8c66721db045dc86bf4c078246050a92510729c1b592413d', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-16 18:22:45', '2021-12-16 18:22:45', '2021-12-18 18:22:45');
INSERT INTO `oauth_access_tokens` VALUES ('d140060a5616b326f4563a5143c6426e24a4823aaaa4938eab67d94792c3cbd429434a026037f0ee', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 20:18:09', '2021-12-22 20:18:09', '2021-12-24 20:18:09');
INSERT INTO `oauth_access_tokens` VALUES ('d16362af44e32869aa3ff8520dce4995c2e71e0274607a0dcdadaef9efb986703962620dcc84bed9', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 12:09:34', '2021-12-22 12:09:34', '2021-12-24 12:09:34');
INSERT INTO `oauth_access_tokens` VALUES ('d19d44472d37ab60d9580c9cdb26328c7b7feac81efed93eca93519337c614537f960b2c47d68015', 50, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:36:33', '2021-12-23 02:36:33', '2021-12-25 02:36:33');
INSERT INTO `oauth_access_tokens` VALUES ('d1cbf92fda3f226f86510efa9c7a8abed8ef9b0f9730b4fe265834cdb7988d22bd10ef1061bc51a8', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:24:03', '2021-12-21 20:24:03', '2021-12-23 20:24:03');
INSERT INTO `oauth_access_tokens` VALUES ('d1eb41a9fa3ee567460a0d684def3b00c1eb356a9a4c16946c33bf9b0e28751dd39a1030888e89c1', 11, 11, 'Personal Access Token', '[]', 1, '2021-12-15 02:34:59', '2021-12-15 02:34:59', '2021-12-17 02:34:59');
INSERT INTO `oauth_access_tokens` VALUES ('d2a81bd986d23505b13fc27a807d7eb2a9e54f9e55743cd8c337ae3af16997a929b031061cec7498', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-19 21:42:54', '2021-12-19 21:42:54', '2021-12-21 21:42:53');
INSERT INTO `oauth_access_tokens` VALUES ('d32838aae961a6f32f70a4e1b281eae83c693c3729fcc8629e8a87ef0c09a7f30995783a5303fcaa', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 19:51:31', '2021-12-17 19:51:31', '2021-12-19 19:51:31');
INSERT INTO `oauth_access_tokens` VALUES ('d36035bb1f4cb055bff4913e3d85dc9d657c1b61585c7044841f91700c72b2c3b14e22d482ca9718', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-13 23:14:41', '2021-12-13 23:14:41', '2021-12-15 23:14:40');
INSERT INTO `oauth_access_tokens` VALUES ('d3c932451957d3a8ca2c46a7e43d8203e1d2edd3318580f542bec41a43a4342be905c2b9b8759d96', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:34:45', '2021-12-22 10:34:45', '2021-12-24 10:34:45');
INSERT INTO `oauth_access_tokens` VALUES ('d4dd3bf5de2f6eb1a750313c36e6b55a4d095c402efd648bad0060c14084841edd9490a462d6cd05', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-23 07:15:33', '2021-12-23 07:15:33', '2021-12-25 07:15:33');
INSERT INTO `oauth_access_tokens` VALUES ('d4ecf308d5e0f72f8ca932862da6318acb58e513471a7905b8e8f83d5fb6712185e3b39d684b09ec', 10, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:08:01', '2021-12-20 23:08:01', '2021-12-22 23:08:01');
INSERT INTO `oauth_access_tokens` VALUES ('d506374818c8850b6d94d60499baab89384653f379ae14f98ff2dec9ad31ee75ba936cc7b6f4c85b', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-19 23:50:11', '2021-12-19 23:50:11', '2021-12-21 23:50:11');
INSERT INTO `oauth_access_tokens` VALUES ('d5e13f0862a87c579d2d3c7bce5c5b988a43b2efdd7731284354ec5c7b7465aad308c58c125b001f', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 00:03:12', '2021-12-14 00:03:12', '2021-12-16 00:03:12');
INSERT INTO `oauth_access_tokens` VALUES ('d695e87646160718175d11e43537fad7ea0a387f98d6d10493c2f625b64f0795db73b8626d24f727', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-18 21:43:22', '2021-12-18 21:43:22', '2021-12-20 21:43:21');
INSERT INTO `oauth_access_tokens` VALUES ('d7711de02e078ca3af1fae63a6bd916ff4cfba7d19522597ba4e1070147859e8b749850d91911716', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 11:13:39', '2021-12-22 11:13:39', '2021-12-24 11:13:38');
INSERT INTO `oauth_access_tokens` VALUES ('d7da2eb176ad59aa680b4c461152a8fd8c818112e73f087b1658863558be3054f16e0ac93aef4dbe', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:58:23', '2021-12-23 02:58:23', '2021-12-25 02:58:23');
INSERT INTO `oauth_access_tokens` VALUES ('d83ba61d5ed1f83947ce76a944c3fe1f02f7572a37be22f4578fa20669e67a8a213a2f1877d7089a', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:48:05', '2021-12-16 18:48:05', '2021-12-18 18:48:05');
INSERT INTO `oauth_access_tokens` VALUES ('d86a033fcd067b3428911c7a422381fc010853d17188bfc1e87f73259a6f10e3481695f3e4c514ce', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 10:50:32', '2021-12-20 10:50:32', '2021-12-22 10:50:32');
INSERT INTO `oauth_access_tokens` VALUES ('d98e72e53afaf193cbbf39a18bee70ee97b23dcd8ebe988043d5e1353f4e32e52ebc886aec397e50', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-22 16:57:35', '2021-12-22 16:57:35', '2021-12-24 16:57:35');
INSERT INTO `oauth_access_tokens` VALUES ('da08ed1b7fe3bb276f985fe8858874809724db009b9b1d66496196a1ab90b69b0e20411887e7c41a', 53, 13, 'Personal Access Token', '[]', 1, '2021-12-23 02:34:45', '2021-12-23 02:34:45', '2021-12-25 02:34:45');
INSERT INTO `oauth_access_tokens` VALUES ('da421f761d01da9341071bed697ea696e0ef9a96f7752063448fee8c28a35d7f1d136efb524c4fc4', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-18 13:43:15', '2021-12-18 13:43:15', '2021-12-20 13:43:15');
INSERT INTO `oauth_access_tokens` VALUES ('da52bf526b365310b15ce749b17f9f10f8c429c05d52fede8b6813308500826e39be87cafeb3a054', 39, 13, 'Personal Access Token', '[]', 1, '2021-12-21 00:27:53', '2021-12-21 00:27:53', '2021-12-23 00:27:53');
INSERT INTO `oauth_access_tokens` VALUES ('db8389a04409ea536fe9984f7babffd0b031e546f39a6ba8fdc7a2e0bc28ba7275238e07a96d272e', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 21:54:43', '2021-12-17 21:54:43', '2021-12-19 21:54:43');
INSERT INTO `oauth_access_tokens` VALUES ('dbc605bb3429bd3bc930bf77e5735b34546a3b583e4dd84d85c532376cd833d48902f79f7541d778', 48, 13, 'Personal Access Token', '[]', 0, '2021-12-22 16:43:27', '2021-12-22 16:43:27', '2021-12-24 16:43:26');
INSERT INTO `oauth_access_tokens` VALUES ('dbe84dc3ff1b8469f10d6e2a8318ff5abfcf88263371d3a4efab3939de82e7873be1a82352830334', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:36:15', '2021-12-21 20:36:15', '2021-12-23 20:36:15');
INSERT INTO `oauth_access_tokens` VALUES ('dd52f04e431a0e6c0cbdf501bb6b1174a861f1ece4982a304b32b20cdb18e6de225ca8aaa5eff2c3', 48, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:01:45', '2021-12-23 03:01:45', '2021-12-25 03:01:45');
INSERT INTO `oauth_access_tokens` VALUES ('ddcfaf4d19c299fdc4ee0ff1b5cd5b5d8b4f7b12125647c250850eb24b91ab1447615b779807d058', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 04:42:35', '2021-12-23 04:42:35', '2021-12-25 04:42:35');
INSERT INTO `oauth_access_tokens` VALUES ('dec89a8e41e2a8e1a3298f190e0fa7c586f1bcf12ab7810891624026c98e0491b4c5a1faa2e15a52', 28, 13, 'Personal Access Token', '[]', 1, '2021-12-20 23:03:34', '2021-12-20 23:03:34', '2021-12-22 23:03:34');
INSERT INTO `oauth_access_tokens` VALUES ('ded796e0fce187733b05371faa063befc5a5851ac0f37e87df471aa03e2d4832637c6592f2fa40cc', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 08:10:55', '2021-12-23 08:10:55', '2021-12-25 08:10:55');
INSERT INTO `oauth_access_tokens` VALUES ('df162abb8aed18ead6dfe5143032d20f668c4953b517bb8bca6a9badbe452303556e88ad0753da13', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-21 20:59:46', '2021-12-21 20:59:46', '2021-12-23 20:59:46');
INSERT INTO `oauth_access_tokens` VALUES ('dfbef7555548e10ed6cc7f685d02fe6fb8a0ba62326cb9eed18910ac5f78b1d15c1357c51f002f05', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-23 01:36:07', '2021-12-23 01:36:07', '2021-12-25 01:36:07');
INSERT INTO `oauth_access_tokens` VALUES ('e003205d462ae497d3cb05ae2b95502711a67ec0f123eca20dc12f37f0d3860fcb96e6cef3cabf07', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-22 01:15:09', '2021-12-22 01:15:09', '2021-12-24 01:15:09');
INSERT INTO `oauth_access_tokens` VALUES ('e01092e03487ffc5ea5afb539c2fa7ad66d35862dd0af24e7626b2c5a585e24da8c4bfbb0ed4eaaa', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-22 20:22:22', '2021-12-22 20:22:22', '2021-12-24 20:22:22');
INSERT INTO `oauth_access_tokens` VALUES ('e0178fae8961a4d8af917856c4cc067e5b6a2a6b6bed97453e8aaa10f26bea31d82aa381f3ad3d8a', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-21 00:55:52', '2021-12-21 00:55:52', '2021-12-23 00:55:52');
INSERT INTO `oauth_access_tokens` VALUES ('e051c3b1dceb6fb3bb56008d796f8a80470bd4b7978d952a39c361afbf2159c83d783207ae4dfa04', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 12:38:34', '2021-12-17 12:38:34', '2021-12-19 12:38:33');
INSERT INTO `oauth_access_tokens` VALUES ('e1756fe4581c06bd5c3d11b97c3c50397f78dd63531ae24cc2b5f46d67c3bf5231fbb28ce0d4fe23', 49, 13, 'Personal Access Token', '[]', 1, '2021-12-22 17:32:29', '2021-12-22 17:32:29', '2021-12-24 17:32:29');
INSERT INTO `oauth_access_tokens` VALUES ('e2546bacd3c01e1d6c28124aa197ddd7ff37542f17888dee36a2f61620cdbe3fdefbcac3acf77a07', 50, 13, 'Personal Access Token', '[]', 1, '2021-12-22 17:27:56', '2021-12-22 17:27:56', '2021-12-24 17:27:56');
INSERT INTO `oauth_access_tokens` VALUES ('e290c9db304db725fe9d7dbd5d60181fdb88c1ee3a1704647233ca5b44b876f4d71f29280ba7d4b6', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 22:24:10', '2021-12-17 22:24:10', '2021-12-19 22:24:10');
INSERT INTO `oauth_access_tokens` VALUES ('e34c852daee8a1a57768a61066eb1d0559dd56e983f09fbc023aad9b6ba450f302c012286dbd7523', 13, 13, 'Personal Access Token', '[]', 1, '2021-12-20 00:58:05', '2021-12-20 00:58:05', '2021-12-22 00:58:05');
INSERT INTO `oauth_access_tokens` VALUES ('e3677f86d6dce3586f1895079648590a0c1d5ba2b031764396e41af521d31eebaaf5449ab340aa2c', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-15 19:26:49', '2021-12-15 19:26:49', '2021-12-17 19:26:49');
INSERT INTO `oauth_access_tokens` VALUES ('e367b6df3b79f9da43fb1744ebefbbb12b623b34cc484d5e82e4ab03d1270e21dd216502a6ae1949', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 01:09:43', '2021-12-20 01:09:43', '2021-12-22 01:09:43');
INSERT INTO `oauth_access_tokens` VALUES ('e3b307753f1dd34d8021fa68455772e8c1e942fc61eb313806c503c28c5c372575ae500c6bf88998', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-20 11:13:32', '2021-12-20 11:13:32', '2021-12-22 11:13:32');
INSERT INTO `oauth_access_tokens` VALUES ('e4066c0451ab9cce9db7f85a3a9a9c7b4866ce355acd5820c283735313330b26c6abf8a27d25b01b', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-17 23:41:23', '2021-12-17 23:41:23', '2021-12-19 23:41:23');
INSERT INTO `oauth_access_tokens` VALUES ('e409419c36ad9eacc3f66cf94277542ccaa9ab417ea98297d5fcb8236c136ae6270bd32da79088c8', 51, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:12:35', '2021-12-23 03:12:35', '2021-12-25 03:12:35');
INSERT INTO `oauth_access_tokens` VALUES ('e470132f1dcda065600d4d9185a1276ed23ed4c7c7cf5bd7218f973e7003c6a7a6272483f86af9e3', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 16:47:06', '2021-12-22 16:47:06', '2021-12-24 16:47:06');
INSERT INTO `oauth_access_tokens` VALUES ('e4fff80d40d0d8fa8a4848a8754a0a9055a185d8ae9f12be2654bf99b4dda280159a8947281b13c3', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-17 16:50:08', '2021-12-17 16:50:08', '2021-12-19 16:50:08');
INSERT INTO `oauth_access_tokens` VALUES ('e506d1506fcd9d310057f7b9ea0552c5039c83116015b97db54c604e8721bd6baa3c8a6c49d0ad9f', 7, 13, 'Personal Access Token', '[]', 1, '2021-12-20 21:15:20', '2021-12-20 21:15:20', '2021-12-22 21:15:20');
INSERT INTO `oauth_access_tokens` VALUES ('e52fca52241435774dff88d58e3242d4bf8a7301da44a1c44e1ce6c15b61dc25261d85e06c3bec46', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-23 07:33:29', '2021-12-23 07:33:29', '2021-12-25 07:33:29');
INSERT INTO `oauth_access_tokens` VALUES ('e567a7f54ad2f1c9653af75ad80951a2ae850181a17a6edca5ff1c456e660d872fec507c33939acf', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-21 16:47:34', '2021-12-21 16:47:34', '2021-12-23 16:47:33');
INSERT INTO `oauth_access_tokens` VALUES ('e63d2687e4bff17db687e3ef1e394f1a376c4bb47dd6fa83ca3d6690705a66da52969823c9ec53f5', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 14:56:39', '2021-12-20 14:56:39', '2021-12-22 14:56:39');
INSERT INTO `oauth_access_tokens` VALUES ('e64e99417cd017e725cce05680743045373dd463107d2778439db8f31c7a148b51ede05b28bbbdd2', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-23 03:51:56', '2021-12-23 03:51:56', '2021-12-25 03:51:56');
INSERT INTO `oauth_access_tokens` VALUES ('e67eb8484739cc89d4f510288e7bb5f0c53f8dcbcd4bffe9ad27e58b4fac2fc1e0376f8c43c0373a', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 01:44:57', '2021-12-19 01:44:57', '2021-12-21 01:44:57');
INSERT INTO `oauth_access_tokens` VALUES ('e6e8f57fa700adab3b98789723042ed6d1e10c9b441924f58a0f325606748ec58e1ef45b13eaafd7', 4, 13, 'Personal Access Token', '[]', 0, '2021-12-18 14:25:16', '2021-12-18 14:25:16', '2021-12-20 14:25:13');
INSERT INTO `oauth_access_tokens` VALUES ('e70ea4a9b83ae0139643a1988ba952a4f7bd8e4ec918452be8a2f2b21b90dafed0c988abdc5ccb63', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 15:35:11', '2021-12-19 15:35:11', '2021-12-21 15:35:11');
INSERT INTO `oauth_access_tokens` VALUES ('e79da21a91839635dd64df5d44f80e591a95d878f3b64a80630aa51169ac8eb4bcdd268897c9bb73', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-15 22:19:48', '2021-12-15 22:19:48', '2021-12-17 22:19:48');
INSERT INTO `oauth_access_tokens` VALUES ('e85a3ec0fac24fa269bba0ee0a9f472b8164678450d70435ce4369ddf4413a55295f77dd967e7448', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 23:26:50', '2021-12-19 23:26:50', '2021-12-21 23:26:50');
INSERT INTO `oauth_access_tokens` VALUES ('e8d16b661a78e075e486b3ea4b237777008229c82f7feee6baeb6f94a3661a05e7e69f1e3baeb33b', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-14 02:06:06', '2021-12-14 02:06:06', '2021-12-16 02:06:06');
INSERT INTO `oauth_access_tokens` VALUES ('e959009096d78c39fe88d36b81ce6ebdbe1ab6972a0491221a4761dba1b47d76982b023539fda813', 46, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:39:09', '2021-12-22 08:39:09', '2021-12-24 08:39:09');
INSERT INTO `oauth_access_tokens` VALUES ('e9f8dbfe27acc01e57667993d19f7fa0e6bbba0541dd8690757c67ea41c0ac1898abdf1cab58679b', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 16:01:41', '2021-12-19 16:01:41', '2021-12-21 16:01:41');
INSERT INTO `oauth_access_tokens` VALUES ('ea5ce99ac79135186dfa163aeeadd85a746d455f0fa15b1b910b5fd58e4ca1e808f99899d7ae461a', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:41:03', '2021-12-22 23:41:03', '2021-12-24 23:41:03');
INSERT INTO `oauth_access_tokens` VALUES ('ead7ee6ee1f705b3ebb61a1bfaa8b571ffca7244a687e8345fe2c1cd6a6ea6f93e2f64c9b62088ce', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:30:53', '2021-12-22 10:30:53', '2021-12-24 10:30:53');
INSERT INTO `oauth_access_tokens` VALUES ('eb780c0ceaeb253caadd033ad1c04e5ad817c4721c354c6b517411d8d514ec8ffcd564d6a1b6b1a3', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-15 02:38:51', '2021-12-15 02:38:51', '2021-12-17 02:38:51');
INSERT INTO `oauth_access_tokens` VALUES ('ec3abd21775e43cd6cc614aef0a5af322204712314f3dd90f46f96f6b141ed52de2cf6c5ac3f7cec', 2, 11, 'Personal Access Token', '[]', 1, '2021-12-15 01:02:56', '2021-12-15 01:02:56', '2021-12-17 01:02:56');
INSERT INTO `oauth_access_tokens` VALUES ('ec6a0487555d5800114d2fd8d4a413ae4ab0d5c78c300f061498c9c4b408a62fd2ea433af8001933', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 16:48:02', '2021-12-22 16:48:02', '2021-12-24 16:48:02');
INSERT INTO `oauth_access_tokens` VALUES ('ecce98e0c4100e3cb10177444e648657ea3e0877b29d9913533c1309da8e2918118418c7475a8137', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 20:14:07', '2021-12-22 20:14:07', '2021-12-24 20:14:07');
INSERT INTO `oauth_access_tokens` VALUES ('ece5d5c38659cacc90c336541cdf9b1ce3ac1a9bf8b2be136b2f11786c8df3ec6170b0a39fb9098a', 15, 13, 'Personal Access Token', '[]', 0, '2021-12-19 19:09:05', '2021-12-19 19:09:05', '2021-12-21 19:09:04');
INSERT INTO `oauth_access_tokens` VALUES ('ed9af38a31e5f6d42c385aca832bf9dc1c476ebfea2197edf7f2e31c873e33af6938cc8e1458d8d2', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-19 22:17:05', '2021-12-19 22:17:05', '2021-12-21 22:17:05');
INSERT INTO `oauth_access_tokens` VALUES ('eda8405a3468d6eb74025f1643b895e9b32f083c4ae96bb1b4e51c12581d14379ebe10ea28a3f4e2', 42, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:25:05', '2021-12-22 08:25:05', '2021-12-24 08:25:05');
INSERT INTO `oauth_access_tokens` VALUES ('edecc26ab470b936396bb79a8fad21fc76ee1670f5e8e32ee1b821bc66e2156ade8fb58e7a7fe70b', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-13 23:32:48', '2021-12-13 23:32:48', '2021-12-15 23:32:48');
INSERT INTO `oauth_access_tokens` VALUES ('edfd7041d766e58c47213927bfa46eba2f953420dd9fb6b95336906fc18ca17177f5aea2872da5ec', 13, 13, 'Personal Access Token', '[]', 0, '2021-12-22 10:57:22', '2021-12-22 10:57:22', '2021-12-24 10:57:22');
INSERT INTO `oauth_access_tokens` VALUES ('ee892a9fc8d82d8cd83fad1f4e44eb9392f8a190dc8468cb297b699d39aea24f85a5019d748cdec4', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 21:26:44', '2021-12-22 21:26:44', '2021-12-24 21:26:44');
INSERT INTO `oauth_access_tokens` VALUES ('ef3bc5edf20ca380d8179f26928aad41af9415d5a7fdd3d57c86917fc98d85ea54a073471a34a030', 54, 13, 'Personal Access Token', '[]', 0, '2021-12-23 08:37:45', '2021-12-23 08:37:45', '2021-12-25 08:37:45');
INSERT INTO `oauth_access_tokens` VALUES ('effb5feaad6027a725c64a254d73e6bc49a2ea83c52faf199e5fd0799f8cc2ccc774541baf660069', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 19:24:15', '2021-12-21 19:24:15', '2021-12-23 19:24:15');
INSERT INTO `oauth_access_tokens` VALUES ('efff8ff275a5e7be067d0e2834ff107f99b5ede3acb11810e5a50e39002a3fc0fa28173b5b337264', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-20 01:43:56', '2021-12-20 01:43:56', '2021-12-22 01:43:56');
INSERT INTO `oauth_access_tokens` VALUES ('efffdf82d3d9a3ccce7d1887bdbd397671410fdbc55b04546e0fd883d74c64cf9db3554c6dea2c6b', 13, 13, 'Personal Access Token', '[]', 0, '2021-12-21 01:47:54', '2021-12-21 01:47:54', '2021-12-23 01:47:54');
INSERT INTO `oauth_access_tokens` VALUES ('f2137be6991d513b75c6d08f0f1da01f4f735162b690875f03ab8f7b4b628b0763aedea5e682506b', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 09:38:17', '2021-12-14 09:38:17', '2021-12-16 09:38:17');
INSERT INTO `oauth_access_tokens` VALUES ('f31d3696646ca7b7907d37921c56121528cc4b7f2809dbd89e00e3f2695e3df92442311b78831629', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-18 23:25:38', '2021-12-18 23:25:38', '2021-12-20 23:25:38');
INSERT INTO `oauth_access_tokens` VALUES ('f323acd23345a24214bfa5bd449c5a7cddbefb1dcc343a40d7ed11b8782aa78fe33c7ff2097010c9', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-18 02:04:10', '2021-12-18 02:04:10', '2021-12-20 02:04:10');
INSERT INTO `oauth_access_tokens` VALUES ('f4553f10adca8e73300ead37b3af93fa7373e0593541a8bcd3e2db118c8821edb875bfbe7860cbbd', 36, 13, 'Personal Access Token', '[]', 0, '2021-12-20 22:15:38', '2021-12-20 22:15:38', '2021-12-22 22:15:38');
INSERT INTO `oauth_access_tokens` VALUES ('f4699a03b7e88997767d29f816182f6e4a9f238893c6d23db9059d573aada626b0bb7f1fe3aca6a6', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-14 00:11:58', '2021-12-14 00:11:58', '2021-12-16 00:11:58');
INSERT INTO `oauth_access_tokens` VALUES ('f4917db66b6ccaab861aaefefc0b38ff0430ae2e3cee2ced9674de4e4bd200adbdb5a8773797d376', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-22 10:35:14', '2021-12-22 10:35:14', '2021-12-24 10:35:14');
INSERT INTO `oauth_access_tokens` VALUES ('f4c5b9b9223200d76dfe36f0a5f6034535c4b4130bd77d4c131d4a4c1560dd4cf8a17ef4953ca436', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-18 22:52:39', '2021-12-18 22:52:39', '2021-12-20 22:52:39');
INSERT INTO `oauth_access_tokens` VALUES ('f59a2ccff1c2255d223d84563f235b11617c3f01c1192b6c048b29129dbd0f1f083a1619b8022ad8', 1, 11, 'Personal Access Token', '[]', 1, '2021-12-13 23:15:25', '2021-12-13 23:15:25', '2021-12-15 23:15:25');
INSERT INTO `oauth_access_tokens` VALUES ('f609bd6a3a91c25ac5821e4e23212cae6c84bca030be308d051080cc08116edc98fcfb3e0030eeda', 9, 11, 'Personal Access Token', '[]', 1, '2021-12-14 16:11:49', '2021-12-14 16:11:49', '2021-12-16 16:11:49');
INSERT INTO `oauth_access_tokens` VALUES ('f66cc68e75bde4ae06e77443c3f58bcc52ca60682eac2622ba594324df42d6557ba1ac0f5c559991', 1, 11, 'Personal Access Token', '[]', 0, '2021-12-13 23:57:52', '2021-12-13 23:57:52', '2021-12-15 23:57:51');
INSERT INTO `oauth_access_tokens` VALUES ('f684851308bc51c2f7c5a2b1f5fd7a2d0f5f9ff922f299555045f98b37d413a5c15abc32801e2aeb', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-22 01:39:26', '2021-12-22 01:39:26', '2021-12-24 01:39:25');
INSERT INTO `oauth_access_tokens` VALUES ('f7c2fbb3901096b5c9b03808b9b7e086dac8c06f6feb7a3d49ba92497cf81e1c49b9211d106542dc', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-22 02:12:00', '2021-12-22 02:12:00', '2021-12-24 02:12:00');
INSERT INTO `oauth_access_tokens` VALUES ('f8091940e5421d732b68df04addfc116f73f851984421f454fe0a462553ba30d6581d33bc1156b25', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-19 23:23:16', '2021-12-19 23:23:16', '2021-12-21 23:23:16');
INSERT INTO `oauth_access_tokens` VALUES ('f82189f01cb099623c59318b83ba907442d43af6afe37f0ecfe93962b3e6f7d7d3ebfbc6a4d6299a', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-17 05:50:09', '2021-12-17 05:50:09', '2021-12-19 05:50:09');
INSERT INTO `oauth_access_tokens` VALUES ('fa16dcadab3f1c004f67f28ff670fc9a70a784f0447dbf81335e70c7823a7cfc3c833a170ca2c349', 4, 13, 'Personal Access Token', '[]', 1, '2021-12-18 02:59:00', '2021-12-18 02:59:00', '2021-12-20 02:59:00');
INSERT INTO `oauth_access_tokens` VALUES ('faef212bd1cbe439598b4d0ef6dd401cacbca828a2da751c07261382f8f68d9c52cd9f1774c695a9', 4, 11, 'Personal Access Token', '[]', 0, '2021-12-16 01:19:40', '2021-12-16 01:19:40', '2021-12-18 01:19:39');
INSERT INTO `oauth_access_tokens` VALUES ('fb0a13bf7f4ec643275236d00e6eecc2fb7920a5e949807e5b4d68f85252660e2fe3da33cab8d997', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-16 18:48:07', '2021-12-16 18:48:07', '2021-12-18 18:48:07');
INSERT INTO `oauth_access_tokens` VALUES ('fbd367fb68c43f4f73fb962e6ccd228532886dbd14b8df97ce36c37264e7949a339ad70f6e02a36d', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 01:31:45', '2021-12-20 01:31:45', '2021-12-22 01:31:45');
INSERT INTO `oauth_access_tokens` VALUES ('fbfb2e2c3b729e89caaba6f3357d609a39a25b5bd9cf1c3e70d3435500f17c5f2393800b26bc0c6e', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-19 00:09:09', '2021-12-19 00:09:09', '2021-12-21 00:09:09');
INSERT INTO `oauth_access_tokens` VALUES ('fc0226a9703ce6ddac602c603c6c2fae1261433b206c3759d8675e273b12b0666e1eddf7a920fe2d', 51, 13, 'Personal Access Token', '[]', 1, '2021-12-23 00:28:03', '2021-12-23 00:28:03', '2021-12-25 00:28:03');
INSERT INTO `oauth_access_tokens` VALUES ('fc29f0d4fc30c9654d3c9e08f92715e0508479c391df8204af6bd78598564a2c46fb99881bc2d6a0', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-22 23:13:28', '2021-12-22 23:13:28', '2021-12-24 23:13:28');
INSERT INTO `oauth_access_tokens` VALUES ('fd184518f08733a1969a3d34e8445da4d85b36debe2493c0c000a008466fc41a592d617fb9db05d5', 26, 13, 'Personal Access Token', '[]', 1, '2021-12-20 01:17:30', '2021-12-20 01:17:30', '2021-12-22 01:17:29');
INSERT INTO `oauth_access_tokens` VALUES ('fd4c85cba5bc38747c991ebd07d8b83883e5e88175f634bfc43f79c7e366c2f533207f736c7a21f8', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-21 01:52:40', '2021-12-21 01:52:40', '2021-12-23 01:52:40');
INSERT INTO `oauth_access_tokens` VALUES ('fd7e72fcb0b2b419b5c3bcae6dcc8135601dbb41eb7ca30a83a2b7357a3620f8f01da30c13d6f524', 2, 13, 'Personal Access Token', '[]', 0, '2021-12-20 00:24:35', '2021-12-20 00:24:35', '2021-12-22 00:24:34');
INSERT INTO `oauth_access_tokens` VALUES ('fdab4658cb6783552423502589eb94db4700b1957d4b7554058d5e47fd78aaa78f8413f194e0db51', 27, 13, 'Personal Access Token', '[]', 1, '2021-12-20 15:06:46', '2021-12-20 15:06:46', '2021-12-22 15:06:46');
INSERT INTO `oauth_access_tokens` VALUES ('fdbdc8a5fe8a3119c3cc0c0de2e4ef79ea6fb7926eb6bef833084c518def8a5df49377acd23922b6', 47, 13, 'Personal Access Token', '[]', 1, '2021-12-22 09:05:39', '2021-12-22 09:05:39', '2021-12-24 09:05:39');
INSERT INTO `oauth_access_tokens` VALUES ('ff141b84d2577490186ab41b7ecba5ba5546b4dc1aac1f18f869e73800ceb446d831da72e3426235', 41, 13, 'Personal Access Token', '[]', 1, '2021-12-22 08:35:16', '2021-12-22 08:35:16', '2021-12-24 08:35:16');
INSERT INTO `oauth_access_tokens` VALUES ('ff1ce5bbd7be05643347b28f52c72e0cff67a503e9c41883ebd01913f7256de5740b09206420868a', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-21 01:06:18', '2021-12-21 01:06:18', '2021-12-23 01:06:18');
INSERT INTO `oauth_access_tokens` VALUES ('ff4a6a10e8f0b26f2c01db23b3f672711c9cc29b1685920108f5e0cbcd81d82e6017dc807c2847e4', 2, 13, 'Personal Access Token', '[]', 1, '2021-12-20 22:25:25', '2021-12-20 22:25:25', '2021-12-22 22:25:25');
INSERT INTO `oauth_access_tokens` VALUES ('ffddb1e6d89bac09bdcbba9423f20624ba5769bec72db34560594457a37e4941934007fcbbfb5eb0', 1, 13, 'Personal Access Token', '[]', 1, '2021-12-19 16:00:01', '2021-12-19 16:00:01', '2021-12-21 16:00:01');
INSERT INTO `oauth_access_tokens` VALUES ('ffeac22ce34f426df30ae15f31a5c4b855dc6d631ec42945d1f4c2ff3fbbf25c7cf1d48e4342c9e2', 2, 11, 'Personal Access Token', '[]', 0, '2021-12-13 23:53:38', '2021-12-13 23:53:38', '2021-12-15 23:53:38');
INSERT INTO `oauth_access_tokens` VALUES ('fff5a39f978651dd6eb87d6fb881e7812b2fa84e8fd8f84a121fb61a873c0232f8225c32ce9d2d11', 1, 13, 'Personal Access Token', '[]', 0, '2021-12-17 21:05:17', '2021-12-17 21:05:17', '2021-12-19 21:05:17');
COMMIT;

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------
BEGIN;
INSERT INTO `oauth_clients` VALUES (1, NULL, 'Laravel Personal Access Client', 'ertSdPGX2JJNQO6PhDOfogVdCwJyOrql3VEuZdPz', NULL, 'http://localhost', 1, 0, 0, '2021-10-05 16:38:29', '2021-10-05 16:38:29');
INSERT INTO `oauth_clients` VALUES (2, NULL, 'Laravel Password Grant Client', 'Thshj97S4hMqmOPpTgSj9JtR3HfhcL1qd6ZUTG1X', 'users', 'http://localhost', 0, 1, 0, '2021-10-05 16:38:30', '2021-10-05 16:38:30');
INSERT INTO `oauth_clients` VALUES (10, NULL, 'Laravel Personal Access Client', 'n368zQ2wNTjyC1rBCgceL8t67Te1S0ttYSgQqXc5', NULL, 'http://localhost', 1, 0, 0, '2021-10-11 11:33:05', '2021-10-11 11:33:05');
INSERT INTO `oauth_clients` VALUES (11, NULL, 'Laravel Personal Access Client', 'Sg5xWuSvK3hjccvFR8rpP5wFWVQX9D1ffvJ0ROSq', NULL, 'http://localhost', 1, 0, 0, '2021-12-03 22:30:59', '2021-12-03 22:30:59');
INSERT INTO `oauth_clients` VALUES (12, NULL, 'Laravel Password Grant Client', 'oEU81kCc8I7OAp83NmwvF4g0WlOwTbdNF1ag8sBc', 'users', 'http://localhost', 0, 1, 0, '2021-12-03 22:30:59', '2021-12-03 22:30:59');
INSERT INTO `oauth_clients` VALUES (13, NULL, 'Laravel Personal Access Client', 'AJAFWFizLJZjdRAY46dBaN5tMRqMxCznu0hPdTJg', NULL, 'http://localhost', 1, 0, 0, '2021-12-16 18:48:02', '2021-12-16 18:48:02');
INSERT INTO `oauth_clients` VALUES (14, NULL, 'Laravel Password Grant Client', 'q1XbJw83pUSV9cprFzJjpyiDEqVaBEu8lCofppFU', 'users', 'http://localhost', 0, 1, 0, '2021-12-16 18:48:02', '2021-12-16 18:48:02');
COMMIT;

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------
BEGIN;
INSERT INTO `oauth_personal_access_clients` VALUES (1, 1, '2021-10-05 16:38:29', '2021-10-05 16:38:29');
INSERT INTO `oauth_personal_access_clients` VALUES (2, 3, '2021-10-08 14:18:25', '2021-10-08 14:18:25');
INSERT INTO `oauth_personal_access_clients` VALUES (3, 5, '2021-10-08 14:18:45', '2021-10-08 14:18:45');
INSERT INTO `oauth_personal_access_clients` VALUES (4, 6, '2021-10-08 23:46:24', '2021-10-08 23:46:24');
INSERT INTO `oauth_personal_access_clients` VALUES (5, 8, '2021-10-09 12:01:55', '2021-10-09 12:01:55');
INSERT INTO `oauth_personal_access_clients` VALUES (6, 10, '2021-10-11 11:33:06', '2021-10-11 11:33:06');
INSERT INTO `oauth_personal_access_clients` VALUES (7, 11, '2021-12-03 22:30:59', '2021-12-03 22:30:59');
INSERT INTO `oauth_personal_access_clients` VALUES (8, 13, '2021-12-16 18:48:02', '2021-12-16 18:48:02');
COMMIT;

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------
BEGIN;
INSERT INTO `oauth_refresh_tokens` VALUES ('180bf5880ab408a957c7b1fbc06e445f291f9ef4a34adb5126ea1c1cc3840f47e59700b1b1fa5f7c', '525e60259f39b4799ed99e1061be7dfff8a21ac32813a2e56750fa50265dee099e4637e1117706a0', 0, '2021-10-15 11:47:50');
INSERT INTO `oauth_refresh_tokens` VALUES ('1bba56d1e3b9f6d6325ff029ce89dedc97605274fcd7eb8dbf1dbd11966c78609e126c10221dad18', '2221510efbdf2e28153dc6a51cdb45ca8e438a9c257547933a2415b2c9814b65e70ea4f51f83e210', 0, '2021-10-15 11:45:39');
INSERT INTO `oauth_refresh_tokens` VALUES ('3eba3d46e9a28f47f5d9427e4425cd0d21a578b0ace4d0e1d4165559723526e8273716550176b500', '626b4d585a3e65e885da9833ce174178dfeb7f61500458472e1fd495ed676c6b7283c5997c76aa76', 1, '2021-10-15 14:30:36');
INSERT INTO `oauth_refresh_tokens` VALUES ('5cef916bee01fc7c8536211d1c73ce8bdaf86d50b147401a445661523436f7338ffde057cd08d430', '92c63bbd69159ec18f2a4114c18fe161fd489bd9a4e92bf8aa8ba02eb3b4dd5c8948181fc24640f6', 0, '2021-10-15 14:49:31');
INSERT INTO `oauth_refresh_tokens` VALUES ('ddc494a703ff1fed571039f13805fe282eae51e6eda42abcb9710d0f2aef97bee257dc600ac2ae16', '847c6fb84c3fd8b594c8c8aa03f2f88879c0c49240b036cf29b5a2373df637be43422c70ac7e4716', 0, '2021-10-15 12:02:17');
COMMIT;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `money` float NOT NULL,
  `code_vnp_response` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_bank` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_vnp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` enum('Rechage','CoursePayment') COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `bill_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of payments
-- ----------------------------
BEGIN;
INSERT INTO `payments` VALUES (1, 5000, '00', 'NCB', '13620939', 'CoursePayment', '2021-12-18 01:31:23', 4, 5, '2021-12-18 01:31:28', '2021-12-18 01:31:28');
INSERT INTO `payments` VALUES (2, 5000, '00', 'NCB', '13620939', 'CoursePayment', '2021-12-18 01:35:11', 4, 6, '2021-12-18 01:35:14', '2021-12-18 01:35:14');
INSERT INTO `payments` VALUES (3, 5000, '00', 'NCB', '13620939', 'Rechage', '2021-12-18 01:56:33', 4, NULL, '2021-12-18 01:56:33', '2021-12-18 01:56:33');
INSERT INTO `payments` VALUES (4, 5000, '00', 'NCB', '13620939', 'Rechage', '2021-12-18 02:00:06', 4, NULL, '2021-12-18 02:00:06', '2021-12-18 02:00:06');
INSERT INTO `payments` VALUES (5, 5000, '00', 'NCB', '13620939', 'Rechage', '2021-12-18 02:00:48', 4, NULL, '2021-12-18 02:00:48', '2021-12-18 02:00:48');
INSERT INTO `payments` VALUES (6, 100000, '00', 'NCB', '13656037', 'Rechage', '2021-12-18 02:04:58', 4, NULL, '2021-12-18 02:04:58', '2021-12-18 02:04:58');
INSERT INTO `payments` VALUES (7, 100000, '00', 'NCB', '13658379', 'Rechage', '2021-12-22 01:59:30', 4, NULL, '2021-12-22 01:59:30', '2021-12-22 01:59:30');
INSERT INTO `payments` VALUES (8, 200000, '00', 'NCB', '13658381', 'Rechage', '2021-12-22 02:03:29', 4, NULL, '2021-12-22 02:03:29', '2021-12-22 02:03:29');
INSERT INTO `payments` VALUES (9, 200000, '00', 'NCB', '13658589', 'Rechage', '2021-12-22 10:16:32', 4, NULL, '2021-12-22 10:16:32', '2021-12-22 10:16:32');
INSERT INTO `payments` VALUES (10, 99000, '00', 'NCB', '13658593', 'CoursePayment', '2021-12-22 10:17:56', 4, 13, '2021-12-22 10:17:58', '2021-12-22 10:17:58');
INSERT INTO `payments` VALUES (11, 529000, '00', 'NCB', '13658609', 'CoursePayment', '2021-12-22 10:32:16', 4, 14, '2021-12-22 10:32:18', '2021-12-22 10:32:18');
INSERT INTO `payments` VALUES (12, 799000, '00', 'NCB', '13658618', 'CoursePayment', '2021-12-22 10:37:28', 4, 15, '2021-12-22 10:37:31', '2021-12-22 10:37:31');
INSERT INTO `payments` VALUES (13, 500000, '00', 'NCB', '13658640', 'Rechage', '2021-12-22 10:53:45', 4, NULL, '2021-12-22 10:53:45', '2021-12-22 10:53:45');
INSERT INTO `payments` VALUES (14, 529000, '00', 'NCB', '13658647', 'CoursePayment', '2021-12-22 10:59:44', 4, 16, '2021-12-22 10:59:47', '2021-12-22 10:59:47');
INSERT INTO `payments` VALUES (15, 99000, '00', 'NCB', '13658799', 'CoursePayment', '2021-12-22 13:41:33', 27, 17, '2021-12-22 13:41:35', '2021-12-22 13:41:35');
INSERT INTO `payments` VALUES (16, 2000000, '00', 'NCB', '13659182', 'CoursePayment', '2021-12-22 17:31:42', 50, 18, '2021-12-22 17:31:45', '2021-12-22 17:31:45');
INSERT INTO `payments` VALUES (17, 799000, '00', 'NCB', '13659314', 'CoursePayment', '2021-12-22 20:55:09', 4, 19, '2021-12-22 20:55:12', '2021-12-22 20:55:12');
INSERT INTO `payments` VALUES (18, 1000000, '00', 'NCB', '13659324', 'CoursePayment', '2021-12-22 21:26:21', 4, 21, '2021-12-22 21:26:24', '2021-12-22 21:26:24');
INSERT INTO `payments` VALUES (19, 500000, '00', 'NCB', '13659438', 'Rechage', '2021-12-23 02:35:34', 53, NULL, '2021-12-23 02:35:34', '2021-12-23 02:35:34');
INSERT INTO `payments` VALUES (20, 699000, '00', 'NCB', '13659465', 'CoursePayment', '2021-12-23 03:39:21', 4, 22, '2021-12-23 03:39:24', '2021-12-23 03:39:24');
INSERT INTO `payments` VALUES (21, 799000, '00', 'NCB', '13659480', 'CoursePayment', '2021-12-23 04:27:15', 4, 23, '2021-12-23 04:27:18', '2021-12-23 04:27:18');
INSERT INTO `payments` VALUES (22, 299000, '00', 'NCB', '13659482', 'CoursePayment', '2021-12-23 04:33:00', 4, 24, '2021-12-23 04:33:03', '2021-12-23 04:33:03');
INSERT INTO `payments` VALUES (23, 629000, '00', 'NCB', '13659486', 'CoursePayment', '2021-12-23 04:39:27', 4, 25, '2021-12-23 04:39:29', '2021-12-23 04:39:29');
INSERT INTO `payments` VALUES (24, 699000, '00', 'NCB', '13659516', 'CoursePayment', '2021-12-23 08:26:18', 4, 26, '2021-12-23 08:26:21', '2021-12-23 08:26:21');
COMMIT;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of permissions
-- ----------------------------
BEGIN;
INSERT INTO `permissions` VALUES (1, 'dashboard:list', 'Màn hình quản lý thống kê', '2021-12-18 15:27:26', '2021-12-18 15:36:04');
INSERT INTO `permissions` VALUES (2, 'dashboard:statistical', 'Màn hình thống kê ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (3, 'course:list', 'Danh sách khoá học', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (4, 'course:edit', 'Chỉnh sửa trạng thái khoá học', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (5, 'user:list', 'Danh sách tài khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (6, 'user:add', 'Thêm mới tài khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (7, 'user:edit', 'Chỉnh sửa tài khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (8, 'user:delete', 'Xoá tài  khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (9, 'student:list', 'Danh sách học viên đã đăng ký', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (10, 'payment:list', 'Danh sách yêu cầu thanh toán khóa học ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (11, 'role:list', 'Danh sách chức vụ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (12, 'role:add', 'Thêm mới chức vụ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (13, 'role:edit', 'Chỉnh sửa chức vụ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (14, 'role:delete', 'Xoá chức vụ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (15, 'permission:list', 'Danh sách quyền', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (16, 'permission:add', 'Thêm mới quyền', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (17, 'permission:edit', 'Chỉnh sửa quyền', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (18, 'permission:delete', 'Xoá quyền', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (19, 'permission:import', 'Import danh sách quyền', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (20, 'permission:export', 'Export template quyền', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (21, 'setting:list', 'Danh sách thông tin website', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (22, 'setting:add', 'Thêm mới thông tin website', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (23, 'setting:edit', 'Chỉnh sửa thông tin website', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (24, 'setting:edit-status', 'Chỉnh sửa trạng thái hoạt động của thông tin website', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (25, 'setting:delete', 'Xoá thông tin website', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (26, 'specialize:list', 'Danh sách chuyên môn', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (27, 'specialize:add', 'Thêm mới chuyên môn', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (28, 'specialize:edit', 'Chỉnh sửa chuyên môn', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (29, 'specialize:edit-status', 'Chỉnh sửa trạng thái hoạt động của chuyên môn', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (30, 'specialize:delete', 'Xoá chuyên môn', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (31, 'account-level:list', 'Danh sách cấp độ tài khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (32, 'account-level:add', 'Thêm mới cấp độ tài khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (33, 'account-level:edit', 'Chỉnh sủa cấp dộ tài khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (34, 'account-level:delete', 'Xoá cấp độ tài khoản', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (35, 'bill:customer', 'Danh sách hoá đơn', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (36, 'bill:payment', 'Dánh sách hoá đơn thanh toán cho PT', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (37, 'bill:vnp', 'Danh sách giao dịch bằng vnp', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (38, 'contact:list', 'Danh sách liên hệ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (39, 'contact:feedback', 'Phản hổi email liên hệ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (40, 'complain:list', 'Danh sách khiêu nại', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (41, 'complain:send-link-record', 'Yêu cầu gửi link record', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (42, 'complain:cancel-order', 'Huỷ đơn khiếu nại', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (43, 'complain:complete', 'Chấp nhận khiếu nại', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (44, 'comment:list', 'Danh sách đánh giá khoá học', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
INSERT INTO `permissions` VALUES (45, 'comment:edit-status', 'Chỉnh sửa trạng thái hoạt động ', '2021-12-18 15:27:26', '2021-12-18 15:27:26');
COMMIT;

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6304 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
BEGIN;
INSERT INTO `role_has_permissions` VALUES (17, 4, 1, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (18, 4, 3, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (19, 4, 4, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (20, 4, 9, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (21, 4, 10, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (22, 4, 21, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (23, 4, 22, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (24, 4, 23, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (25, 4, 24, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (26, 4, 25, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (27, 4, 26, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (28, 4, 27, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (29, 4, 28, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (30, 4, 29, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (31, 4, 30, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (32, 4, 31, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (33, 4, 32, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (34, 4, 33, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (35, 4, 34, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (36, 4, 35, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (37, 4, 36, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (38, 4, 37, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (39, 4, 38, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (40, 4, 39, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (41, 4, 40, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (42, 4, 41, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (43, 4, 42, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (44, 4, 43, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (45, 4, 44, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (46, 4, 45, '2021-12-18 15:36:46', '2021-12-18 15:36:46');
INSERT INTO `role_has_permissions` VALUES (47, 5, 1, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (48, 5, 31, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (49, 5, 32, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (50, 5, 33, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (51, 5, 34, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (52, 5, 38, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (53, 5, 39, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (54, 5, 44, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (55, 5, 45, '2021-12-18 15:37:06', '2021-12-18 15:37:06');
INSERT INTO `role_has_permissions` VALUES (710, 6, 1, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (711, 6, 2, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (712, 6, 5, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (713, 6, 6, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (714, 6, 7, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (715, 6, 11, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (716, 6, 12, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (717, 6, 13, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (718, 6, 14, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (719, 6, 15, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (720, 6, 16, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (721, 6, 17, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (722, 6, 18, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (723, 6, 19, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (724, 6, 20, '2021-12-19 00:41:40', '2021-12-19 00:41:40');
INSERT INTO `role_has_permissions` VALUES (4434, 8, 4, '2021-12-19 17:43:45', '2021-12-19 17:43:45');
INSERT INTO `role_has_permissions` VALUES (5994, 1, 1, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (5995, 1, 2, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (5996, 1, 3, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (5997, 1, 4, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (5998, 1, 5, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (5999, 1, 6, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6000, 1, 7, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6001, 1, 8, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6002, 1, 9, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6003, 1, 10, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6004, 1, 11, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6005, 1, 12, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6006, 1, 13, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6007, 1, 14, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6008, 1, 15, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6009, 1, 16, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6010, 1, 17, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6011, 1, 18, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6012, 1, 19, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6013, 1, 20, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6014, 1, 21, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6015, 1, 22, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6016, 1, 23, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6017, 1, 24, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6018, 1, 25, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6019, 1, 26, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6020, 1, 27, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6021, 1, 28, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6022, 1, 29, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6023, 1, 30, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6024, 1, 31, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6025, 1, 32, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6026, 1, 33, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6027, 1, 34, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6028, 1, 35, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6029, 1, 36, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6030, 1, 37, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6031, 1, 38, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6032, 1, 39, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6033, 1, 40, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6034, 1, 41, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6035, 1, 42, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6036, 1, 43, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6037, 1, 44, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6038, 1, 45, '2021-12-21 01:45:09', '2021-12-21 01:45:09');
INSERT INTO `role_has_permissions` VALUES (6259, 7, 1, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6260, 7, 2, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6261, 7, 3, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6262, 7, 4, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6263, 7, 5, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6264, 7, 6, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6265, 7, 7, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6266, 7, 8, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6267, 7, 9, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6268, 7, 10, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6269, 7, 11, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6270, 7, 12, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6271, 7, 13, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6272, 7, 14, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6273, 7, 15, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6274, 7, 16, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6275, 7, 17, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6276, 7, 18, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6277, 7, 19, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6278, 7, 20, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6279, 7, 21, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6280, 7, 22, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6281, 7, 25, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6282, 7, 24, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6283, 7, 23, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6284, 7, 26, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6285, 7, 27, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6286, 7, 28, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6287, 7, 29, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6288, 7, 30, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6289, 7, 31, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6290, 7, 32, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6291, 7, 33, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6292, 7, 34, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6293, 7, 35, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6294, 7, 36, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6295, 7, 37, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6296, 7, 38, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6297, 7, 39, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6298, 7, 40, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6299, 7, 41, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6300, 7, 42, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6301, 7, 43, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6302, 7, 44, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
INSERT INTO `role_has_permissions` VALUES (6303, 7, 45, '2021-12-21 21:14:40', '2021-12-21 21:14:40');
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_mutable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES (1, 'Admin', 'Quản trị hệ thống', 0, '2021-11-21 09:11:59', '2021-12-18 15:21:57', NULL);
INSERT INTO `roles` VALUES (2, 'Customer', 'Khách hàng', 0, '2021-11-21 09:11:59', '2021-12-18 15:23:01', NULL);
INSERT INTO `roles` VALUES (3, 'Pt', 'Huấn luyện viên', 0, '2021-11-21 09:11:59', '2021-12-18 15:22:39', NULL);
INSERT INTO `roles` VALUES (4, 'Staff', 'Nhân viên', 0, '2021-11-21 09:11:59', '2021-12-18 15:23:18', NULL);
INSERT INTO `roles` VALUES (5, 'Nhân viên IT', 'Nhân viên IT', 0, '2021-12-13 23:38:28', '2021-12-13 23:38:28', NULL);
INSERT INTO `roles` VALUES (6, 'Sub Admin', 'Hỗ trợ người quản trị', 0, '2021-12-18 15:14:24', '2021-12-18 15:22:19', NULL);
INSERT INTO `roles` VALUES (7, 'vietanhhda', '3123123', 0, '2021-12-18 22:18:08', '2021-12-18 22:18:08', NULL);
COMMIT;

-- ----------------------------
-- Table structure for schedules
-- ----------------------------
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `time_start` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_end` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Complete','unfinished','happenning') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unfinished',
  `participation` enum('Join','NoJoin') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `complain` enum('Complain','NoComplaints') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoComplaints',
  `reason_complain` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_room` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_record` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `check_link_record` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_send_link_record` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_end_time` datetime DEFAULT NULL,
  `actual_start_time` datetime DEFAULT NULL,
  `course_plan_id` bigint(20) unsigned NOT NULL,
  `course_student_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of schedules
-- ----------------------------
BEGIN;
INSERT INTO `schedules` VALUES (16, 'buoi học demo', '2021-12-23', '06:00:00', '07:00:00', 'Complete', NULL, 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', NULL, NULL, NULL, '2021-12-23 03:53:46', '2021-12-23 03:53:16', 187, 114, '2021-12-23 03:44:29', '2021-12-23 04:20:39');
INSERT INTO `schedules` VALUES (17, 'Gặp gỡ PT, training ăn uống và chế độ luyện tập', '2021-12-23', '08:00:00', '09:00:00', 'unfinished', 'Join', 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', NULL, NULL, NULL, NULL, NULL, 122, 115, '2021-12-23 04:28:36', '2021-12-23 08:29:49');
INSERT INTO `schedules` VALUES (18, 'Bổ túc kĩ thuật nâng cao', '2021-12-23', '11:00:00', '12:00:00', 'unfinished', 'Join', 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', NULL, NULL, NULL, '2021-12-23 08:54:11', '2021-12-23 08:53:57', 143, 115, '2021-12-23 04:29:24', '2021-12-23 08:55:00');
INSERT INTO `schedules` VALUES (19, 'Gặp gỡ PT và lên menu ăn dinh dưỡngnjnj', '2021-12-25', '09:00:00', '10:00:00', 'unfinished', NULL, 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', NULL, NULL, NULL, NULL, NULL, 149, 116, '2021-12-23 04:33:53', '2021-12-25 20:44:00');
INSERT INTO `schedules` VALUES (20, 'Buổi học bước vào giai đoạn combo tăng cường tim mạch', '2021-12-30', '11:00:00', '12:00:00', 'unfinished', NULL, 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', NULL, NULL, NULL, NULL, NULL, 153, 116, '2021-12-23 04:36:28', '2021-12-25 20:43:23');
INSERT INTO `schedules` VALUES (21, 'Hệ thống lại kiến thức', '2021-12-25', '07:00:00', '08:00:00', 'unfinished', NULL, 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', NULL, NULL, NULL, NULL, NULL, 154, 116, '2021-12-23 04:36:57', '2021-12-23 04:36:57');
INSERT INTO `schedules` VALUES (22, 'Hệ thống kiến thức', '2021-12-22', '07:00:00', '08:00:00', 'Complete', 'Join', 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', 'https://www.google.com/search', NULL, NULL, '2021-12-23 04:41:48', '2021-12-23 04:41:36', 161, 117, '2021-12-23 04:40:10', '2021-12-23 04:41:48');
INSERT INTO `schedules` VALUES (23, 'DEMO', '2021-12-31', '07:00:00', '08:00:00', 'unfinished', NULL, 'NoComplaints', NULL, 'https://meet.google.com/pwy-gqkv-zor', NULL, NULL, NULL, '2021-12-23 08:30:43', '2021-12-23 08:30:26', 187, 118, '2021-12-23 08:27:30', '2021-12-23 08:33:00');
COMMIT;

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `config_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `config_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of settings
-- ----------------------------
BEGIN;
INSERT INTO `settings` VALUES (5, 'Logo', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Flogo.png?alt=media&token=cb9007ac-629c-4f3b-a379-a8ce7075c5ba', 'Active', '2021-12-14 00:00:37', '2021-12-22 00:24:56');
INSERT INTO `settings` VALUES (6, 'Địa chỉ', 'Trịnh Văn Bô - Nam Từ Liêm - Hà Nội', 'Active', '2021-12-14 00:01:07', '2021-12-23 01:22:25');
INSERT INTO `settings` VALUES (7, 'SĐT', '085.985.0000', 'Active', '2021-12-14 00:01:28', '2021-12-14 00:01:28');
INSERT INTO `settings` VALUES (8, 'Email', 'gymYm@gmail.com', 'Active', '2021-12-14 00:01:45', '2021-12-16 00:20:16');
INSERT INTO `settings` VALUES (9, 'Slogan Footer', 'Webite thuê huấn luyện thể hình chúng tôi cam kết cung cấp PT đều dày dặn kinh nghiệm và có tâm huyết trong nghề. Chúc bạn nhanh chóng có một thân hình mơ ước', 'Active', '2021-12-14 00:02:32', '2021-12-16 18:54:24');
INSERT INTO `settings` VALUES (10, 'Tên công ty', 'Công Ty TNHH GYM', 'Active', '2021-12-14 00:02:59', '2021-12-16 18:53:59');
INSERT INTO `settings` VALUES (11, 'Background Footer', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2F2.jpg?alt=media&token=b912e91f-4093-454a-b344-73a5e5c640ee', 'Active', '2021-12-14 00:03:23', '2021-12-14 00:03:23');
INSERT INTO `settings` VALUES (12, 'Image Slide 1', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fimage-1.jpg?alt=media&token=d3a88581-d801-4039-b7e3-f7c3ca7c6c47', 'Active', '2021-12-14 00:04:25', '2021-12-14 00:04:25');
INSERT INTO `settings` VALUES (13, 'Image Slide 2', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fimage-2.png?alt=media&token=edb7a21d-66d5-4d5f-beb1-220366513444', 'Active', '2021-12-14 00:04:42', '2021-12-17 23:43:36');
INSERT INTO `settings` VALUES (14, 'Image Map', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Finfo-map.jpg?alt=media&token=6a2a9aa1-c050-445c-93a8-ae468160c12c', 'Active', '2021-12-14 00:05:02', '2021-12-14 00:05:02');
COMMIT;

-- ----------------------------
-- Table structure for slides
-- ----------------------------
DROP TABLE IF EXISTS `slides`;
CREATE TABLE `slides` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Inactive',
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of slides
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for social_accounts
-- ----------------------------
DROP TABLE IF EXISTS `social_accounts`;
CREATE TABLE `social_accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `social_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `social_provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of social_accounts
-- ----------------------------
BEGIN;
INSERT INTO `social_accounts` VALUES (1, '110375457317115349858', 'google', 3, '2021-12-13 22:51:59', '2021-12-13 22:51:59');
INSERT INTO `social_accounts` VALUES (2, '103185423365216422619', 'google', 5, '2021-12-13 23:26:55', '2021-12-13 23:26:55');
INSERT INTO `social_accounts` VALUES (3, '100397758401478185104', 'google', 49, '2021-12-14 03:42:05', '2021-12-22 16:18:09');
INSERT INTO `social_accounts` VALUES (4, '111388148203974795224', 'google', 9, '2021-12-14 16:11:49', '2021-12-14 16:11:49');
INSERT INTO `social_accounts` VALUES (5, '109109218998091506676', 'google', 10, '2021-12-14 16:45:10', '2021-12-14 16:45:10');
INSERT INTO `social_accounts` VALUES (6, '106867928999810841710', 'google', 12, '2021-12-18 21:44:15', '2021-12-18 21:44:15');
INSERT INTO `social_accounts` VALUES (7, '116626941814098679534', 'google', 22, '2021-12-20 00:32:07', '2021-12-20 00:32:07');
INSERT INTO `social_accounts` VALUES (8, '100682094946624606923', 'google', 44, '2021-12-22 08:26:17', '2021-12-22 08:26:17');
INSERT INTO `social_accounts` VALUES (9, '104700710798601384894', 'google', 45, '2021-12-22 08:36:30', '2021-12-22 08:36:30');
INSERT INTO `social_accounts` VALUES (10, '117529670827461869868', 'google', 50, '2021-12-22 17:27:56', '2021-12-22 17:27:56');
INSERT INTO `social_accounts` VALUES (11, '115572497117022465026', 'google', 54, '2021-12-23 08:37:45', '2021-12-23 08:37:45');
INSERT INTO `social_accounts` VALUES (12, '107582119587738956534', 'google', 55, '2021-12-28 18:06:08', '2021-12-28 18:06:08');
COMMIT;

-- ----------------------------
-- Table structure for socials
-- ----------------------------
DROP TABLE IF EXISTS `socials`;
CREATE TABLE `socials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of socials
-- ----------------------------
BEGIN;
INSERT INTO `socials` VALUES (1, 'Facebook', 'Mạng xã hội facebook', '2021-12-18 16:00:51', '2021-12-18 16:00:53');
INSERT INTO `socials` VALUES (2, 'Zalo', 'Mạng xã hội zalo', '2021-12-18 16:01:33', '2021-12-18 16:01:36');
INSERT INTO `socials` VALUES (3, 'Tiktok', 'Mạng xã hội tiktok', '2021-12-18 16:02:04', '2021-12-18 16:02:06');
INSERT INTO `socials` VALUES (4, 'Instagram', 'Mạng xã hội instagram', '2021-12-18 16:02:35', '2021-12-18 16:02:38');
INSERT INTO `socials` VALUES (5, 'Youtube', 'Mạng xã hội youtube', '2021-12-18 16:03:07', '2021-12-18 16:03:10');
COMMIT;

-- ----------------------------
-- Table structure for specialize_details
-- ----------------------------
DROP TABLE IF EXISTS `specialize_details`;
CREATE TABLE `specialize_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `experience` double(8,2) NOT NULL,
  `specialize_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of specialize_details
-- ----------------------------
BEGIN;
INSERT INTO `specialize_details` VALUES (1, 3.00, 4, 2, '2021-12-14 00:03:08', '2021-12-14 00:03:08');
INSERT INTO `specialize_details` VALUES (2, 2.00, 2, 2, '2021-12-14 00:03:33', '2021-12-14 00:03:33');
INSERT INTO `specialize_details` VALUES (7, 3.00, 5, 2, '2021-12-20 21:28:48', '2021-12-20 21:28:48');
INSERT INTO `specialize_details` VALUES (8, 2.00, 4, 39, '2021-12-20 23:01:31', '2021-12-20 23:01:31');
INSERT INTO `specialize_details` VALUES (9, 2.00, 1, 39, '2021-12-21 00:33:40', '2021-12-21 00:33:40');
INSERT INTO `specialize_details` VALUES (10, 5.00, 3, 48, '2021-12-22 16:05:05', '2021-12-22 16:05:05');
INSERT INTO `specialize_details` VALUES (11, 2.00, 4, 49, '2021-12-22 16:37:49', '2021-12-22 16:37:49');
INSERT INTO `specialize_details` VALUES (13, 3.00, 4, 51, '2021-12-23 00:30:15', '2021-12-23 00:30:15');
INSERT INTO `specialize_details` VALUES (14, 3.00, 2, 51, '2021-12-23 00:31:11', '2021-12-23 00:31:11');
COMMIT;

-- ----------------------------
-- Table structure for specializes
-- ----------------------------
DROP TABLE IF EXISTS `specializes`;
CREATE TABLE `specializes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of specializes
-- ----------------------------
BEGIN;
INSERT INTO `specializes` VALUES (1, 'Yoga', 'Active', 'Yoga vừa đủ nhẹ nhàng vừa đủ mạnh mẽ để thu hút nhiều người. Cái hay của Yoga là bạn không cần phải tập tất cả các tư thế, bạn có thể thực hành trong giới hạn của riêng mình và điều chỉnh cho phù hợp với nhu cầu cá nhân.', '2021-12-13 23:25:07', '2021-12-13 23:25:12');
INSERT INTO `specializes` VALUES (2, 'Boxing', 'Active', 'Nếu bạn muốn tập trung vào việc luyện tập thể dục thể thao để sở hữu cơ bắp săn chắc, cải thiện sự ổn định cơ cốt lõi và tăng cường sức khỏe tim mạch, đồng thời cảm thấy tràn đầy năng lượng hơn mỗi ngày, thì Boxing là một trong những lựa chọn tốt nhất cho bạn. Vậy bộ môn này là gì, cùng tìm hiểu.', '2021-12-13 23:27:54', '2021-12-13 23:36:47');
INSERT INTO `specializes` VALUES (3, 'Dance', 'Active', 'Việc nhảy múa có thể có lợi cho mọi người ở mọi lứa tuổi. Nhiều hình thức, chẳng hạn như khiêu vũ có thể phù hợp cho những người bị hạn chế về khả năng vận động hoặc các vấn đề sức khỏe, bệnh mãn tính, trong khi các hình thức khác có thể cho phép trẻ tự do thể hiện bản thân, giải phóng năng lượng và rèn luyện tính kỷ luật bằng cách ghi nhớ và học các bước nhảy', '2021-12-13 23:31:46', '2021-12-13 23:37:15');
INSERT INTO `specializes` VALUES (4, 'Gym', 'Active', 'Gym là loại hình tập luyện dành cho mọi đối tượng, không phân biệt tuổi tác, giới tính vì nó giúp mang lại cho người tập một sức khỏe, một cơ thể săn chắc, một vóc dáng trẻ trung, loại bỏ stress, giúp hạn chế các bệnh về xương khớp, thoái hóa, đặc biệt tập gym còn giúp tăng cường khả năng sinh lý cho cả nam và nữ. Những người tập gym luôn là những người tự tin, thành công vì để đạt được như vậy họ là những người cực kỳ kỷ luật, khoa học trong cả lối sống và thói quen sinh hoạt hàng ngày để theo đuổi và vượt qua những thử thách khắc nghiệt trong việc tập luyện để đạt được một cơ thể như vậy.', '2021-12-13 23:32:42', '2021-12-13 23:36:50');
INSERT INTO `specializes` VALUES (5, 'Fitness', 'Active', 'Luyện tập Fitness thường xuyên, cơ thể cũng sẽ tránh được nguy cơ mắc các bệnh về tim mạch, cơ bắp, phổi hay xương khớp... Các nguy cơ mắc các bệnh về suy tim, tiểu đường, đột quy... cũng sẽ được giảm thiểu đáng kể.', '2021-12-13 23:35:58', '2021-12-15 22:47:11');
INSERT INTO `specializes` VALUES (9, 'Swim', 'Active', 'Bơi lội', '2021-12-23 23:08:42', '2021-12-23 23:08:42');
COMMIT;

-- ----------------------------
-- Table structure for stages
-- ----------------------------
DROP TABLE IF EXISTS `stages`;
CREATE TABLE `stages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `course_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of stages
-- ----------------------------
BEGIN;
INSERT INTO `stages` VALUES (1, 'Giai đoạn 1: Làm quen với Boxing', 'Tiếp cận và làm quen với bộ môn Boxing', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(51,51,51);\">Nếu bạn muốn tập trung vào việc luyện tập thể dục thể thao để sở hữu cơ bắp săn chắc, cải thiện sự ổn định cơ cốt lõi và tăng cường sức khỏe tim mạch, đồng thời cảm thấy tràn đầy năng lượng hơn mỗi ngày, thì Boxing là một trong những lựa chọn tốt nhất cho bạn. Vậy bộ môn này là gì, cùng tìm hiểu.&nbsp;</span></p>', 'Active', 1, '2021-12-14 00:56:49', '2021-12-14 00:56:49');
INSERT INTO `stages` VALUES (2, 'Giai đoạn 2: Kĩ thuật cơ bản', 'Kĩ thuật cơ bản của Boxing', '<p>Boxing<span style=\"background-color:rgb(255,255,255);color:rgb(0,0,0);\"> có tên gọi khác là Quyền Anh, là bộ môn võ thuật sử dụng 3 đòn&nbsp;cơ bản gồm đấm thẳng, đấm vòng và đấm móc để dùng cho hai tay. Khi tập Boxing, việc di chuyển đôi chân và thân người là cực kì quan trọng. Di chuyển, né đòn và phản công là những thứ làm nên sự hiệu quả&nbsp;trong các trận đấu </span>Boxing<span style=\"background-color:rgb(255,255,255);color:rgb(0,0,0);\">. Những cú đấm hay độ xoay trong </span>Boxing<span style=\"background-color:rgb(255,255,255);color:rgb(0,0,0);\"> của các múi cơ giúp sức mạnh trong đòn đấm được phát huy mạnh nhất.</span></p>', 'Active', 1, '2021-12-14 15:53:08', '2021-12-14 15:53:08');
INSERT INTO `stages` VALUES (3, 'Giai đoạn 3: Kĩ thuật nâng cao', 'Kĩ thuật nâng cao trong Boxing', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(46,46,46);\">Một cú đấm móc có thể thực hiện bằng cả hai tay, nhưng bạn nên tập trung luyện nó ở tay thuận. Đúng như tên gọi của nó cú đấm này nhằm vào vị trí bên hông của đối thủ. Cú đấm được thực hiện như một cú Cross với lực phát ra từ chân và thân trên. Nhưng khi truyền lực lên tay thay vì đấm thẳng cú đấm sẽ được móc qua bên hông đối thủ. Lưu ý đừng để khuỷu tay rộng hơn vai hãy để khoảng hẹp để lực phát ra mạnh hơn.</span></p>', 'Active', 1, '2021-12-14 20:26:42', '2021-12-14 20:26:42');
INSERT INTO `stages` VALUES (11, 'Giai đoạn 1 : Các động tác cơ bản', 'Giai đoạn 1 : Các động tác cơ bản', '<p>Giai đoạn đầu cho học viên tiếp cận bài tập một cách dễ dàng hơn. Gồm những video bổ trợ và những bài tập động tác nhẹ nhàng làm quen dần với các động tác.</p>', 'Active', 10, '2021-12-21 12:52:40', '2021-12-22 01:18:06');
INSERT INTO `stages` VALUES (12, 'Giai đoạn 2 : Các động tác nâng cao', 'Giai đoạn 2 : Các động tác nâng cao', '<p>Giai đoạn bắt đầu cho học viên đi vào chuyên môn sâu, học những bài tập Fitness chính.</p>', 'Active', 10, '2021-12-21 12:53:52', '2021-12-21 12:53:52');
INSERT INTO `stages` VALUES (22, 'Điều chỉnh', 'Chế độ ăn khi tập gym giảm cân cho nữ giới trong 7 ngày', '<p>Một chế độ ăn uống khoa học cùng thời gian tập luyện phù hợp, chắc chắn các nàng sẽ có được một thân hình hoàn hảo với đường con quyến rũ.&nbsp;</p><p><strong>Ngày thứ 1</strong></p><p>Sáng: Sữa chua, yến mạch và trái cây.</p><p>Trưa: 150 – 200gr thịt gà, rau xanh, hoa quả, nấm + nước sốt cà chua không đường.</p><p>Tối: Salad cá ngừ, rau quả, nước lọc</p><p><strong>Ngày thứ 2</strong></p><p>Sáng: 2 quả trứng, 2 quả chuối, yến mạch, bánh mì đen</p><p>Trưa: Ức gà xào với bí đỏ, cải bó xôi, cà rốt, hạt diêm mạch</p><p>&nbsp;Tối :Salad cá hồi hun khói (cá hồi hun khói, cải bó xôi, cải xoăn, 1 quả trứng, ½ trái bơ)</p><p>&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://swequity.vn/wp-content/uploads/2020/03/89619032_2583171441970929_6616798853548998656_o.jpg\" alt=\"\" srcset=\"https://swequity.vn/wp-content/uploads/2020/03/89619032_2583171441970929_6616798853548998656_o.jpg 500w, https://swequity.vn/wp-content/uploads/2020/03/89619032_2583171441970929_6616798853548998656_o-204x300.jpg 204w\" sizes=\"100vw\" width=\"500\"></p><p>&nbsp;</p><p><strong>Ngày thứ 3</strong></p><p>Sáng: 1 ly sinh tố chuối (gồm 2 quả chuối + cải bó xôi), thịt lợn xông khói, 2 quả trứng</p><p>Trưa: 250g cá, 1 củ khoai lang, rau quả</p><p>Tối: 250g canh gà, rau củ.</p><p><strong>Ngày thứ 4</strong></p><p>Sáng: Yến mạch, trái cây và mật ong</p><p>Trưa: Nấm sốt, rau xanh, ½ củ khoai tây,</p><p>Tối: 150g tôm nướng bơ tỏi, cà rốt, măng tây, cải bó xôi, bí đỏ</p><p><strong>Ngày thứ 5</strong></p><p>Sáng: 2 quả cà chua, 2 quả trứng, sinh tố</p><p>Trưa: 250g ức gà nướng, rau salad, bí đỏ</p><p>Tối: Salad cá ngừ</p><p><strong>Ngày thứ 6</strong></p><p>Sáng: 2 quả trứng, 2 lát bánh mì đen và 1 trái táo</p><p>Trưa: 250g bò viên + cải bó xôi sốt cà chua&nbsp;</p><p>Tối: Salad cá hồi hun khói</p><p><strong>Ngày thứ 7</strong></p><p>Sáng: Yến mạch, thịt lợn muối xông khói, 2 quả trứng</p><p>Trưa: Cà ngừ, bí đỏ, cải bó xôi, cà rốt</p><p>Tối: 200g bí đỏ, 200g ức gà, 150g ớt chuông,</p>', 'Active', 15, '2021-12-22 16:51:01', '2021-12-22 16:51:01');
INSERT INTO `stages` VALUES (23, 'Giai đoạn 1:  Combo cho ngày mới năng động', 'Giai đoạn 1:  Combo cho ngày mới năng động', '<p>Giai đoạn 1 người dùng sẽ được trải nghiệm những combo cho ngày mới hiệu quả. &nbsp;Đây là bước đầu giúp học viên tiếp cận khoá học một cách nhẹ nhàng.</p>', 'Active', 14, '2021-12-22 16:57:00', '2021-12-22 16:57:00');
INSERT INTO `stages` VALUES (24, 'Warm up - Làm nóng cơ thể', 'Warm up - Làm nóng cơ thể', '<p>Luyện tập các động tác cơ bản trong bộ môn. Làm giãn gân cốt giúp luyện tập tốt hơn.</p>', 'Active', 17, '2021-12-22 17:00:42', '2021-12-22 17:00:42');
INSERT INTO `stages` VALUES (25, 'Hồi sức, duy trì sức bền', 'Hồi sức, duy trì sức bền', '<p>Các bài tập đơn giản liên quan đến giảm sự căng thẳng gân cốt.</p>', 'Active', 17, '2021-12-22 17:01:25', '2021-12-22 17:01:25');
INSERT INTO `stages` VALUES (26, 'Giai đoạn 2: Tổ hợp combo với niềm tin với Boxing', 'Giai đoạn 2: Tổ hợp combo với niềm tin với Boxing', '<p>Giai đoạn 2 Pt sẽ tổng hợp những combo với niềm tin boxing, bước đệm giúp người dùng chuẩn bị vào giai đoạn cấp tốc và đây cũng là thời gian hệ thống lại kiên thức.</p>', 'Active', 14, '2021-12-22 17:01:40', '2021-12-22 17:01:40');
INSERT INTO `stages` VALUES (27, 'Giai đoạn 3: Combo thần thánh tăng cường tim mạch nhanh nhẹn', 'Giai đoạn 3: Combo thần thánh tăng cường tim mạch nhanh nhẹn', '<p>Giai đoạn 3 cũng là giai đoạn kết thúc khoá học, giai đoạn này học viên gần như đã đầy đủ hệ thống kiến thức của khoá học, chỉ cần tập luyện lại và PT luôn luôn support 24/7.</p>', 'Active', 14, '2021-12-22 17:06:22', '2021-12-22 17:06:22');
INSERT INTO `stages` VALUES (28, 'Lên lịch tập các nhóm cơ', 'Lịch tập các nhóm cơ', '<p>Mỗi người có 1 thể trạng, thể hình và sức chịu đựng riêng. Bởi vậy, anh em cần chọn lịch tập gym phù hợp với cơ thể mình, đảm bảo mang lại hiệu quả tốt nhất. Dưới đây là cách tập gym hiệu quả chia theo lịch tập các nhóm cơ:&nbsp;</p><p><i>Tập gym 3 buổi/ tuần (dành cho người bận rộn)</i></p><p>Buổi 1: Tập nhóm cơ kéo: tay trước, lưng, cẳng tay</p><p>Buổi 2: Tập nhóm cơ đẩy: tay sau, vai, ngực</p><p>Buổi 3: Tập chân, bắp chân, mông, bụng</p><p><i>Tập gym 4 buổi/ tuần</i></p><p>Buổi 1: Tập lưng , cẳng tay, tay trước</p><p>Buổi 2: Tập tay sau và ngực</p><p>Buổi 3: Tập chân, mông, bụng</p><p>Buổi 4: Tập vai, tay sau và bắp chân</p><p><i>Tập gym 5 buổi/ tuần</i></p><p>Buổi 1: Tập ngực</p><p>Buổi 2: Tập lưng, cẳng tay và tay trước&nbsp;</p><p>Buổi 3 : Tập vai, tay sau</p><p>Buổi 4: Tập Chân, bắp chân, mông, bụng</p><p>Buổi 5: Tập thêm các nhóm cơ cảm thấy còn nhỏ</p><p><i>Tập gym 6 buổi/tuần (dành cho những người muốn phát triển cơ bắp nhanh chóng)</i></p><p>Buổi 1: Tập nhóm cơ kéo gồm tay trước, lưng, cẳng tay</p><p>Buổi 2: Tập nhóm cơ đẩy: Vai, ngực, tay sau</p><p>Buổi 3: Tập chân, bắp chân, mông, bụng</p><p>Buổi 4: Tập nhóm cơ kéo gồm tay trước, lưng, cẳng tay</p><p>Buổi 5: Tập nhóm cơ đẩy: Vai, ngực, tay sau</p><p>Buổi 6: Tập chân, bắp chân, mông, bụng</p>', 'Active', 18, '2021-12-22 17:36:10', '2021-12-22 17:36:10');
INSERT INTO `stages` VALUES (29, 'Giai đoạn 1:  Những lưu ý cần biết với Gym và nên menu dinh dưỡng', 'Giai đoạn 1:  Những lưu ý cần biết với Gym và nên menu dinh dưỡng', '<p>Giai đoạn 1 PT sẽ truyền đạt những lưu ý cần biết với Gym và nên menu dinh dưỡng cho học viên.</p>', 'Active', 12, '2021-12-22 17:38:15', '2021-12-22 17:38:15');
INSERT INTO `stages` VALUES (30, 'Tập cùng PT', 'Tập gym đúng cách cùng Mai Văn Anh', '<p><strong>Tập gym đúng cách cùng Mai Văn Anh&nbsp;</strong></p><p>&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://swequity.vn/wp-content/uploads/2019/06/1-nhom-co-nen-tap-may-buoi-1.jpg\" alt=\"\" srcset=\"https://swequity.vn/wp-content/uploads/2019/06/1-nhom-co-nen-tap-may-buoi-1.jpg 640w, https://swequity.vn/wp-content/uploads/2019/06/1-nhom-co-nen-tap-may-buoi-1-300x225.jpg 300w\" sizes=\"100vw\" width=\"640\"></p><p>&nbsp;</p><p>Muốn tập gym đúng cách thì cần chọn được phòng tập chất lượng và người hướng dẫn bạn có chuyên môn cao. Từ năm 2015 Hà Nội đã có một phòng tập gym đúng chuẩn như vậy mang tên Swequity Ultimate fitness:&nbsp;</p><p>– Đội ngũ Coach tại Swequity là những người có chuyên môn cao, đạt chứng chỉ quốc tế, có kinh nghiệm giảng dạy trong và ngoài nước. Họ sẽ trực tiếp hướng dẫn bạn cách tập luyện, điều chỉnh động tác và xây dựng cho bạn lộ trình luyện tập kết hợp cùng chế độ ăn uống, đảm bảo giúp bạn nhanh chóng hoàn thành mục tiêu</p><p>– Hệ thống phòng tập với trang thiết bị hiện đại, đồng bộ, được nhập khẩu 100% từ Mỹ và Châu Âu. Cùng với đó là không gian thoáng mát, sang trọng và một môi trường tập luyện văn minh giúp học viên đạt được trạng thái tập trung tối đa khi rèn luyện.&nbsp;</p><p>Với triết lý hoạt động <i>“Lợi ích của khách hàng là lợi nhuận quý báu của Swequity”</i>, sau hơn 5 năm có mặt trên thị trường fitness Hà Nội, Swequity tự hào là phòng tập mang lại kết quả cao nhất cho hội viên hiện nay.</p>', 'Active', 19, '2021-12-22 17:40:12', '2021-12-22 17:40:12');
INSERT INTO `stages` VALUES (31, 'Giai đoạn 2:  Những bài học Gym cơ bản đến nâng cao', 'Giai đoạn 2:  Những bài học Gym cơ bản đến nâng cao', '<p>PT sẽ truyền đạt những bài học Gym từ cơ bản đến nâng cao cho học viên.</p>', 'Active', 12, '2021-12-22 17:42:49', '2021-12-22 17:42:49');
INSERT INTO `stages` VALUES (32, 'Tự tập Fitness tại nhà', 'Hướng dẫn tự tập Fitness tại nhà hiệu quả trong 8 tuần', '<p style=\"text-align:justify;\">Phần 1: Các động tác cơ bản</p><p style=\"text-align:justify;\">Phần 2: Các động tác nâng cao</p><p style=\"text-align:justify;\">Phần 3: Ghép tổ hợp động tác</p><p style=\"text-align:justify;\">Phần 4: Hướng dẫn tập trong 4 tuần đầu tiên&nbsp;</p><p style=\"text-align:justify;\">Phần 5: Hướng dẫn tập trong 4 tuần tiếp theo</p>', 'Active', 20, '2021-12-22 18:03:50', '2021-12-22 20:13:27');
INSERT INTO `stages` VALUES (33, 'Giai đoạn tiếp xúc với dancer', 'Giai đoạn tiếp xúc với dancer', '<p>Tập với các bài tập tiếp xúc với bộ môn dancer</p>', 'Active', 16, '2021-12-22 21:34:22', '2021-12-23 00:05:27');
INSERT INTO `stages` VALUES (34, 'Giai đoạn 1: Giới thiệu khóa học và các động tác khởi động', 'Giới thiệu khóa học và các động tác khởi động', '<p style=\"text-align:justify;\">Shuffle Dance là một điệu nhảy phổ biến, sử dụng phần lớn là các động tác ở chân cùng với tiết tấu âm nhạc vui tươi đem lại sự thoải mái tự do cho người học. Chính vì điều đó, Shuffle Dance đã tạo ra sự sức hút mới, nhanh chóng lôi cuốn nhiều người tham gia.</p><p style=\"text-align:justify;\">Đến với giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đến từ Sweet Media. Sweet Media tập trung sản xuất các khoá học online nhiều lực vực giúp đa dạng hóa lựa chọn cho học viên. Điển hình như: nhảy hiện đại, gym, zumba, shuffle dance,... Tìm hiểu sâu hơn về khoá học shuffle dance, các bạn sẽ được hướng dẫn cụ thể qua những bài giảng từ cơ bản đến nâng cao do chính những huấn luyện viên chuyên nghiệp&nbsp;dạy nhảy dance cơ bản&nbsp;giúp bạn dễ dàng luyện tập một cách an toàn và hiệu quả. Bạn có thể hoàn toàn tin tưởng lựa chọn về khoá học Shuffle Dance cơ bản&nbsp;mà không cần phải lo lắng băn khoăn&nbsp;học nhảy shuffle dance ở đâu nữa.&nbsp;</p><p style=\"text-align:justify;\">Giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đặc biệt dành cho những bạn bận rộn, không có nhiều thời gian tập luyện, những bạn vì nhiều lý do mà không thể tham gia các lớp học nhảy Shuffle Dance trực tiếp tại các trung tâm. Bạn có thể tham gia khoá học và luyện tập cùng giảng viên chuyên nghiệp ở bất kỳ nơi nào vào thời điểm thuận lợi. Khoá học shuffle dance cơ bản&nbsp;mang đến cho bạn trải nghiệm cá nhân hoá tối ưu nhất. Giúp bạn đạt được hiệu quả tối đa nhờ phương pháp giảng&nbsp;dạy nhảy dance cơ bản đến nâng cao bài bản.</p><p style=\"text-align:justify;\">Đảm bảo khi bạn hoàn thành xong khóa học, bạn sẽ có được trang bị đầy đủ nhất những kiến thức về Shuffle Dance và sở hữu một thân hình bốc lửa để tự tin thể hiện trước đám đông. Ngoài ra còn rất nhiều lợi ích thần kỳ của bộ môn nghệ thuật này mang lại đến với sức khoẻ của bạn. Tham gia để khám phá ngay hôm nay!</p><p style=\"text-align:justify;\">Đăng ký và tham gia khoá học ngay thôi!</p>', 'Active', 13, '2021-12-23 00:19:05', '2021-12-23 00:19:05');
INSERT INTO `stages` VALUES (35, 'Giai đoạn 2 : Shuffle kick adv', 'Shuffle kick adv', '<p style=\"text-align:justify;\">Shuffle Dance là một điệu nhảy phổ biến, sử dụng phần lớn là các động tác ở chân cùng với tiết tấu âm nhạc vui tươi đem lại sự thoải mái tự do cho người học. Chính vì điều đó, Shuffle Dance đã tạo ra sự sức hút mới, nhanh chóng lôi cuốn nhiều người tham gia.</p><p style=\"text-align:justify;\">Đến với giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đến từ Sweet Media. Sweet Media tập trung sản xuất các khoá học online nhiều lực vực giúp đa dạng hóa lựa chọn cho học viên. Điển hình như: nhảy hiện đại, gym, zumba, shuffle dance,... Tìm hiểu sâu hơn về khoá học shuffle dance, các bạn sẽ được hướng dẫn cụ thể qua những bài giảng từ cơ bản đến nâng cao do chính những huấn luyện viên chuyên nghiệp&nbsp;dạy nhảy dance cơ bản&nbsp;giúp bạn dễ dàng luyện tập một cách an toàn và hiệu quả. Bạn có thể hoàn toàn tin tưởng lựa chọn về khoá học Shuffle Dance cơ bản&nbsp;mà không cần phải lo lắng băn khoăn&nbsp;học nhảy shuffle dance ở đâu nữa.&nbsp;</p><p style=\"text-align:justify;\">Giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đặc biệt dành cho những bạn bận rộn, không có nhiều thời gian tập luyện, những bạn vì nhiều lý do mà không thể tham gia các lớp học nhảy Shuffle Dance trực tiếp tại các trung tâm. Bạn có thể tham gia khoá học và luyện tập cùng giảng viên chuyên nghiệp ở bất kỳ nơi nào vào thời điểm thuận lợi. Khoá học shuffle dance cơ bản&nbsp;mang đến cho bạn trải nghiệm cá nhân hoá tối ưu nhất. Giúp bạn đạt được hiệu quả tối đa nhờ phương pháp giảng&nbsp;dạy nhảy dance cơ bản đến nâng cao bài bản.</p><p style=\"text-align:justify;\">Đảm bảo khi bạn hoàn thành xong khóa học, bạn sẽ có được trang bị đầy đủ nhất những kiến thức về Shuffle Dance và sở hữu một thân hình bốc lửa để tự tin thể hiện trước đám đông. Ngoài ra còn rất nhiều lợi ích thần kỳ của bộ môn nghệ thuật này mang lại đến với sức khoẻ của bạn. Tham gia để khám phá ngay hôm nay!</p><p style=\"text-align:justify;\">Đăng ký và tham gia khoá học ngay thôi!</p>', 'Active', 13, '2021-12-23 00:20:18', '2021-12-23 00:20:18');
INSERT INTO `stages` VALUES (36, 'Giai đoạn 2 : Các động tác cơ bản đến nâng cao', 'Các động tác cơ bản đến nâng cao', '<p style=\"text-align:justify;\">Đến với giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đến từ Sweet Media. Sweet Media tập trung sản xuất các khoá học online nhiều lực vực giúp đa dạng hóa lựa chọn cho học viên. Điển hình như: nhảy hiện đại, gym, zumba, shuffle dance,... Tìm hiểu sâu hơn về khoá học shuffle dance, các bạn sẽ được hướng dẫn cụ thể qua những bài giảng từ cơ bản đến nâng cao do chính những huấn luyện viên chuyên nghiệp&nbsp;dạy nhảy dance cơ bản&nbsp;giúp bạn dễ dàng luyện tập một cách an toàn và hiệu quả. Bạn có thể hoàn toàn tin tưởng lựa chọn về khoá học Shuffle Dance cơ bản&nbsp;mà không cần phải lo lắng băn khoăn&nbsp;học nhảy shuffle dance ở đâu nữa.&nbsp;</p><p style=\"text-align:justify;\">Giáo trình học nhảy Shuffle Dance từ cơ bản đến nâng cao đặc biệt dành cho những bạn bận rộn, không có nhiều thời gian tập luyện, những bạn vì nhiều lý do mà không thể tham gia các lớp học nhảy Shuffle Dance trực tiếp tại các trung tâm. Bạn có thể tham gia khoá học và luyện tập cùng giảng viên chuyên nghiệp ở bất kỳ nơi nào vào thời điểm thuận lợi. Khoá học shuffle dance cơ bản&nbsp;mang đến cho bạn trải nghiệm cá nhân hoá tối ưu nhất. Giúp bạn đạt được hiệu quả tối đa nhờ phương pháp giảng&nbsp;dạy nhảy dance cơ bản đến nâng cao bài bản.</p>', 'Active', 16, '2021-12-23 00:23:19', '2021-12-23 00:23:19');
INSERT INTO `stages` VALUES (37, 'Giai đoạn 1 : Giới thiệu khóa học', 'Giới thiệu khóa học', '<p style=\"text-align:justify;\">Tất cả các chị em phụ nữ đều muốn có đôi chân thon gọn và vòng eo săn chắc, thế nhưng, cơ thể chúng ta lại có khuynh hướng tích trữ mỡ ở những vùng này. Việc không tập thể dục đúng cách sẽ càng làm vấn đề nghiêm trọng hơn, đặc biệt là dân văn phòng hay phải ngồi&nbsp;nhiều, các bà mẹ sau khi sinh bé, hay những ai bị béo phì.&nbsp;</p><p style=\"text-align:justify;\">Mỡ nhiều không chỉ khiến các chị em thiếu tự tin, thiếu hấp dẫn mà còn gây ra nhiều bệnh như gout, béo phì, tiểu đường, ảnh hưởng nghiêm trọng tới cuộc sống.</p><p style=\"text-align:justify;\">Vấn đề là như vậy, nhưng không phải ai cũng tìm được cho mình một lộ trình học giảm cân online&nbsp;tập luyện phù hợp, hiệu quả.&nbsp;</p>', 'Active', 23, '2021-12-23 00:42:01', '2021-12-23 00:42:01');
INSERT INTO `stages` VALUES (38, 'Giai đoạn 2 : Giai đoạn làm quen với các động tác đốt cháy calo', 'Làm quen với các động tác đốt cháy calo', '<p>Đồng hành cùng bạn chính là giảng viên Lưu Minh sẽ giúp bạn lấy lại vóc dáng thon gọn, cơ thể săn chắc chỉ sau 1 thời gian ngắn tập luyện, đặc biệt không sợ bị xổ người sau khi ngừng tập như các bộ môn khác.</p>', 'Active', 23, '2021-12-23 00:43:19', '2021-12-23 00:43:19');
INSERT INTO `stages` VALUES (39, 'Giai đoạn 1 :  Hướng dẫn cách ăn uống giảm cân mà không cần ăn kiêng', 'Hướng dẫn cách ăn uống giảm cân mà không cần ăn kiêng', '<p>Có vể như những điều bạn muốn thực hiện nó thực sự rất khó khăn và bạn không thể nào tránh được và thực hiện được nó. Vậy còn chần chờ gì nữa, hãy nhanh tay đăng kí khóa học giảm cân online &nbsp;từ A-Z.</p><p>Tăng cơ giảm mỡ trong 21 ngày của giảng viên để nắm vững những công thức ăn uống trong lành. Khóa học được thiết kế dành riêng cho bạn, gần 40 công thức chế biến các món ăn sạch theo chế độ Clean Eating giúp tăng cơ, giảm mỡ, cho một sức khỏe toàn diện Menu mẫu cho 21 ngày ăn sạch. Từ các món ăn sáng, giữa buổi, ăn trưa, ăn xế, ăn tối, bạn sẽ tự tạo cho mình những thực đơn ăn sạch không nhàm chán. Nhiều nghiên cứu đã chỉ ra rằng, nếu bạn lặp đi lặp lại một hành động nào đó trong 21 ngày, một thói quen mới sẽ hình thành.&nbsp;</p><p>Vậy, khóa học “ Clean Eating từ A-Z: Tăng cơ giảm mỡ trong 21 ngày” sẽ giúp bạn nhanh chóng giảm được lượng mỡ thừa ra khỏi cơ thể, tận hưởng và cảm nhận sự tươi mới, những thay đổi tích cực từ trong ra ngoài.</p>', 'Active', 22, '2021-12-23 01:14:07', '2021-12-23 01:14:07');
INSERT INTO `stages` VALUES (40, 'Giai đoạn 2 : Chuẩn bị gì cho liệu trình 21 ngày ăn sạch', 'Chuẩn bị gì cho liệu trình 21 ngày ăn sạch', '<p>Vậy còn chần chờ gì nữa, hãy nhanh tay đăng kí khóa học giảm cân online Clean Eating từ A-Z.</p><p>&nbsp;Tăng cơ giảm mỡ trong 21 ngày của giảng viên &nbsp;để nắm vững những công thức ăn uống trong lành. Khóa học được thiết kế dành riêng cho bạn, gần 40 công thức chế biến các món ăn sạch theo chế độ Clean Eating giúp tăng cơ, giảm mỡ, cho một sức khỏe toàn diện Menu mẫu cho 21 ngày ăn sạch.&nbsp;</p><p>Từ các món ăn sáng, giữa buổi, ăn trưa, ăn xế, ăn tối, bạn sẽ tự tạo cho mình những thực đơn ăn sạch không nhàm chán. Nhiều nghiên cứu đã chỉ ra rằng, nếu bạn lặp đi lặp lại một hành động nào đó trong 21 ngày, một thói quen mới sẽ hình thành.</p><p>&nbsp;Vậy, khóa học “ Clean Eating từ A-Z: Tăng cơ giảm mỡ trong 21 ngày” sẽ giúp bạn nhanh chóng giảm được lượng mỡ thừa ra khỏi cơ thể, tận hưởng và cảm nhận sự tươi mới, những thay đổi tích cực từ trong ra ngoài.</p>', 'Active', 22, '2021-12-23 01:15:19', '2021-12-23 01:15:19');
INSERT INTO `stages` VALUES (41, 'Giai đoạn 1: Kĩ thuật nhảy cơ bản', 'Giai đoạn 1: Kĩ thuật nhảy cơ bản', '<p>Kĩ thuật nhảy cơ bản sẽ giúp người dùng bước đầu tiếp cận vào khoá học</p>', 'Active', 24, '2021-12-23 01:45:23', '2021-12-23 01:45:23');
INSERT INTO `stages` VALUES (42, 'Giai đoạn 2: Kĩ thuật nhảy trung cấp - cao cấp', 'Giai đoạn 2: Kĩ thuật nhảy trung cấp - cao cấp', '<p>Kĩ thuật nhảy cao cấp giúp người dùng có kiến thức từ cơ bản đến nâng cao.</p>', 'Active', 24, '2021-12-23 01:46:44', '2021-12-23 01:46:44');
INSERT INTO `stages` VALUES (43, 'demo', 'demo', '<p>demo</p>', 'Active', 21, '2021-12-23 03:23:36', '2021-12-23 03:23:36');
COMMIT;

-- ----------------------------
-- Table structure for user_socials
-- ----------------------------
DROP TABLE IF EXISTS `user_socials`;
CREATE TABLE `user_socials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `social_id` smallint(5) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user_socials
-- ----------------------------
BEGIN;
INSERT INTO `user_socials` VALUES (47, 'https://www.youtube.com/', 4, 5, '2021-12-22 17:45:19', '2021-12-22 17:45:19');
INSERT INTO `user_socials` VALUES (55, 'https://www.facebook.com/profile.php?id=100014981883018', 2, 1, '2021-12-23 00:05:00', '2021-12-23 00:05:00');
INSERT INTO `user_socials` VALUES (56, 'https://www.instagram.com/jennierubyjane/', 2, 4, '2021-12-23 00:05:00', '2021-12-23 00:05:00');
INSERT INTO `user_socials` VALUES (57, 'https://www.youtube.com/', 2, 5, '2021-12-23 00:05:00', '2021-12-23 00:05:00');
INSERT INTO `user_socials` VALUES (58, 'https://www.facebook.com/profile.php?id=100014981883018', 49, 1, '2021-12-23 00:59:07', '2021-12-23 00:59:07');
INSERT INTO `user_socials` VALUES (59, 'https://www.instagram.com/jennierubyjane/', 49, 4, '2021-12-23 00:59:07', '2021-12-23 00:59:07');
INSERT INTO `user_socials` VALUES (60, 'https://www.youtube.com/', 49, 5, '2021-12-23 00:59:07', '2021-12-23 00:59:07');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Inactive',
  `sex` enum('Male','Female') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Male',
  `money` double NOT NULL DEFAULT 0,
  `account_level_id` bigint(20) unsigned DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, 'Hoàng Quốc Bảo Việt', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2FEE6EB119-6B66-4D52-B777-416631280E2E.jpeg?alt=media&token=c0cd6887-f953-40f0-9ac9-941a614e5ae3', 'Việt Hoà - Khoái Châu - Hưng Yên', 'test 3', '0355755697', 'viethqb01@gmail.com', '2021-12-13 22:51:59', '$2y$10$8.I/xgzrOMa0rwiWQxIzpuzD9z.KbyuZJbc4ZICymAf2C6kFD1Nz.', 'Active', 'Male', 0, NULL, NULL, '2021-12-13 22:49:35', '2021-12-13 23:17:28', NULL);
INSERT INTO `users` VALUES (2, 'Chúc Anh Quân', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2FBu%CC%80i-Xua%CC%82n-Ma%CC%A3nh-3.jpeg?alt=media&token=e830e39b-7e8d-44a8-9ed6-bb24adfe49c6', 'Phong Vân - Ba Vì - Hà Nội', '<p style=\"text-align:center;\"><strong>Quản lý HLV/ COACH MANAGER&nbsp;</strong></p><p style=\"text-align:justify;\">Cũng giống như nhiều người khác, tôi tìm đến với gym để thay đổi ngoại hình của bản thân. Tôi vui khi nhìn thấy bản thân mình thay đổi, và mọi người xung quanh cũng đang thay đổi. Trong quá trình tự tập, tôi đã biết tới youtube của YM và tôi luôn cảm thấy ở phòng tập này có một cái gì đó rất khác các phòng gym khác.Ở đây, các HLV đều là những người có chuyên môn cao, sự tận tâm nhiệt tình, sự quan tâm chân thật, sát sao tới tình trạng khách hàng. Trước YM, tôi cũng đã từng làm việc ở nhiều phòng gym khác nhau và lên tới vị trí quản lý. Nhưng khi đến với YM lần đầu, tôi vẫn phải trải qua bài kiểm tra kiến thức và kĩ thuật khắt khe, tôi vẫn phải tham gia khóa học đào tạo chuyên môn và vượt qua các kì thi để chính thức được nhận vào làm. Bản thân tôi luôn tâm niệm dù làm nghề gì hay ở môi trường và vị trí nào thì cũng phải làm hết sức mình. Tôi tin rằng bản thân, các đồng nghiệp cùng YM luôn cố gắng đi xa hơn nữa trên đường tìm đến thành công.</p><p><br>&nbsp;</p>', '0828890896', 'quancaph09928@fpt.edu.vn', '2021-12-10 17:51:59', '$2y$10$szv6oASG87Z7KmebVS8o8OCTegEe.HhEB4xGoFHKlsX6Afk8WWi4.', 'Active', 'Male', 1132231, 3, NULL, '2021-12-13 22:51:08', '2021-12-23 00:05:00', NULL);
INSERT INTO `users` VALUES (4, 'Ngô Hồng Nguyên', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2FPima_Cotton_Sweater_393ba8d0-a0fd-4b7c-8f4e-838818720a5c_600x.jpg?alt=media&token=1ffd408d-c303-48f5-96f5-0e470ebad48d', 'Phong Vân - Ba Vì - Hà Nội', '<p>xin chào, tôi là <strong>nguyên</strong></p>', '0828890806', 'nguyennhph11479@fpt.edu.vn', '2021-12-16 14:54:08', '$2y$10$Tpz/FTwXHN8iPKsazg3H2etmhTXLyP2IYm6lqOltbMtG20Hp0ZSum', 'Active', 'Male', 259050, NULL, NULL, '2021-12-13 22:57:33', '2021-12-22 21:25:31', NULL);
INSERT INTO `users` VALUES (48, 'Lê Ngọc Anh', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2FL%C3%AA-Ng%E1%BB%8Dc-Anh-2.jpg?alt=media&token=1ed2de5a-a130-431a-aade-9cb6ea4a5a4b', 'Cầu Diễn - Phúc Diễn - Bắc Từ Liêm - Hà Nội', '<p style=\"text-align:justify;\">Đối với tôi, sức khỏe là quan trọng nhất vì “khi có sức khỏe, bạn có thể làm được bất kì điều gì bạn muốn”. Tôi biết đến Gym lần đầu là qua lời rủ rê của đồng nghiệp hồi đó, khi mới tập cũng chỉ với mục đích đơn giản là nâng cao sức khỏe và giết thời gian. Nhưng sau một thời gian tập luyện chăm chỉ và bền bỉ, kết quả nhận được khiến tôi cảm thấy hào hứng và có động lực hơn. Gym không những giúp tôi thay đổi về ngoại hình bên ngoài, cải thiện sức khỏe mà còn mang đến cho mình một lối sống mới và tích cực hơn. Và tôi nghĩ đã đến lúc nên chia sẻ và truyền cảm hứng cho mọi người về những điều thú vị tôi đã từng trải qua. Tôi chọn YM là &nbsp;nơi tôi có thể chia sẻ, giúp đỡ những khách hàng trở thành một phiên bản tốt hơn của chính mình. Nếu bạn còn đang do dự để tìm hướng đi đúng cho sự lột xác hoàn toàn mới, đủ quyết tâm và không ngại thay đổi, hãy tới SUF và tôi sẽ giúp bạn hoàn thành mục tiêu của mình.</p><p style=\"text-align:justify;\">Với tôi, đẹp tự nhiên nhưng không tự nhiên mà đẹp.</p>', '0828439204', 'ngohongnguyen016774@gmail.com', '2021-12-22 01:42:03', '$2y$10$XZJQoggJ95kiqthBVDRhduk5W5Q.uKSle2in9xkfSGriOg4Li8f.W', 'Active', 'Female', 0, 1, NULL, '2021-12-22 15:41:23', '2021-12-22 16:04:10', NULL);
INSERT INTO `users` VALUES (49, 'Mai Văn Anh', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Fhihihi1.jpeg?alt=media&token=d25c9f00-cfcc-4fb6-8b81-abf4acb8db8b', 'Nam Từ Liêm -Hà Nội', '<p><strong>HLV CAO CẤP/ SENIOR COACH</strong></p><p>&nbsp;</p><p>Trước kia tôi từng rất là gầy mặc dù ăn rất rất nhiều nhưng vẫn không thể tăng cân. Sau đó tôi quyết định tìm tới gym với mong muốn thay đổi bản thân, thay đổi ngoại hình và nâng cao sức khỏe. Nhờ tập luyện chăm chỉ và kiên trì, tôi đã đạt được mục tiêu mình mong muốn và tập luyện đã trở thành<br>thói quen không thể thiếu của tôi.</p><p>&nbsp;</p><p><span style=\"background-color:rgb(246,246,246);color:rgb(102,102,102);\">Việc trở thành HLV với tôi cũng rất ngẫu nhiên. Một hôm có một người bạn thấy tôi thay đổi nhanh chóng nên đã nhờ tôi chỉ dạy. Cảm thấy thích thú với việc dạy tập gym này tôi đã quyết định đi học để trở thành huấn luyện viên chuyên nghiệp. Trước khi đến với SUF, tôi cũng đã tìm hiểu rất nhiều phòng tập khác nhưng đối với tôi SUF là nơi có phong cách khác biệt nhất, là nơi tập trung vào chuyên môn và kết quả khách hàng nhiều hơn. Thực sự, SUF là môi trường làm việc lý tưởng và thỏa mãn đam mê của tôi; chuyên nghiệp, trẻ trung và năng động, các đồng nghiệp luôn giúp đỡ, hỗ trợ lẫn nhau. Để làm việc chính thức tại SUF, tôi đã phải trải qua khóa học kiến thức chuyên môn trong 2 tháng cùng những bài kiểm tra khắt khe và thêm cả 2 tháng thử việc. Thời điểm hiện tại, tôi cảm thấy thỏa mãn vì đã nỗ lực hết mình để theo đuổi đam mê, được góp phần giúp khách hàng thay đổi và tạo nên niềm vui cho họ. Và đặc biệt là bản thân tôi ngày càng trưởng thành hơn, học được nhiều kỹ năng không những từ đồng nghiệp mà còn từ chính những khách hàng của mình nữa. Gây dựng được nhiều mối quan hệ hơn và luôn cảm thấy vui vẻ khi làm việc tại SUF.</span></p><p><br><span style=\"background-color:rgb(246,246,246);color:rgb(102,102,102);\">Đừng bao giờ ngại khó khăn, thử thách vì cuộc sống này chẳng có gì là dễ dàng cả. Hãy quyết tâm hơn nữa để đạt được những mục tiêu, đam mê của chính mình bạn nhé!</span></p>', '0854463161', 'phuongmdtph17969@fpt.edu.vn', '2021-12-20 22:18:09', '100397758401478185104', 'Active', 'Male', 0, 1, NULL, '2021-12-22 16:18:09', '2021-12-23 00:59:07', NULL);
INSERT INTO `users` VALUES (50, 'Thanh Phương Mai', 'https://lh3.googleusercontent.com/a-/AOh14GgmHSro8yXCUdfi1NYhufXb3b7eIw7mrql2Ze28CQ=s96-c', 'Sầm Sơn - Thanh Hóa', NULL, NULL, 'maiduongthanhphuong2002@gmail.com', '2021-12-22 17:27:56', '117529670827461869868', 'Active', 'Male', 0, 1, NULL, '2021-12-22 17:27:56', '2021-12-22 17:27:56', NULL);
INSERT INTO `users` VALUES (51, 'Lưu Thế Minh', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Ftr%E1%BA%A7n%20s%C6%A1n.jpg?alt=media&token=404bf7e1-b918-4dc1-a3a8-52a8dd5db9b9', 'Bích Động - Ninh Bình', '<p style=\"text-align:justify;\">Tôi luôn quan niệm sức khỏe là quan trọng nên tôi thích tập luyện để rèn luyện sức khỏe, cũng là để giữ dáng và tự tin hơn trong cuộc sống hàng ngày. Tôi tới với SUF vì nơi đây có môi trường làm việc chuyên nghiệp, thử thách, trẻ trung và năng động. Tại SUF, toàn bộ đội ngũ nhân viên từ quản lý cao cấp tới nhân viên bình thường đều tập trung tới giá trị và kết quả của khách hàng nhận được tại phòng tập. Không chỉ là thay đổi ngoại hình, chúng tôi còn cố gắng mang tới lối sống và truyền năng lượng tích cực mỗi ngày cho khách hàng. Niềm vui mỗi ngày khi đi làm của tôi là check chỉ số cơ thể của hội viên qua Swequity app và nhìn thấy sự thay đổi tích cực của khách hàng.</p><p style=\"text-align:justify;\">Phương châm: “Thẳng thắn làm việc, đi tới cuối cùng”.</p>', '0334323213', 'luutheminh2000@gmail.com', '2021-12-22 10:27:56', '$2y$10$6EsAm4F9vU3aWhybDf9z.umzFram7angYuFL5KWMiL08Ek7ybSjZi', 'Active', 'Male', 0, 1, NULL, '2021-12-23 00:26:57', '2021-12-23 00:28:51', NULL);
INSERT INTO `users` VALUES (53, 'Ngô Văn Thắng', 'https://firebasestorage.googleapis.com/v0/b/datn73-uploader.appspot.com/o/images%2Faeonmaillhadong.jpg?alt=media&token=9e6f2366-3555-4a0a-a774-a72402709498', 'Xã Phong Vân, huyện Ba Vì, Hà Nội', NULL, '0853009301', 'web2wp2@gmail.com', '2021-12-23 01:42:51', '$2y$10$MSEW813cIz3DOhtWqGF6teeeZKVhXc84CY0R0n57gtX4ZBAn8vtpy', 'Active', 'Male', 500000, NULL, NULL, '2021-12-23 01:42:27', '2021-12-23 02:35:34', NULL);
INSERT INTO `users` VALUES (54, 'Sơn Lê Quang', 'https://lh3.googleusercontent.com/a/AATXAJwvdYq3-qEiG0ctoDW9BrAkeOiWbnEX6xSMaZS8=s96-c', NULL, NULL, NULL, 'sonweb2001@gmail.com', '2021-12-23 08:37:45', '115572497117022465026', 'Active', 'Male', 0, 1, NULL, '2021-12-23 08:37:45', '2021-12-23 08:37:45', NULL);
INSERT INTO `users` VALUES (55, 'Vu Tien Chat', 'https://lh3.googleusercontent.com/a/AATXAJz3eLir2TlZ0aUt8fv5X1cvkXAdYhUvTow7J7zhFQ=s96-c', NULL, NULL, NULL, 'chatvtph11586@fpt.edu.vn', '2021-12-28 18:06:08', '107582119587738956534', 'Active', 'Male', 0, 1, NULL, '2021-12-28 18:06:08', '2021-12-28 18:06:08', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
