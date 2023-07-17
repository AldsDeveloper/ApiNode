-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 17, 2023 at 05:47 AM
-- Server version: 10.11.3-MariaDB
-- PHP Version: 8.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `interview`
--

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `created_at`, `updated_at`) VALUES
(3, 'NuttieShop', '2023-07-03 09:08:09', '2023-07-03 09:08:09');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numerate` varchar(255) NOT NULL COMMENT 'percentile(%)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `numerate`, `created_at`, `updated_at`) VALUES
(1, '6', '2023-07-03 09:53:03', '2023-07-03 09:53:03'),
(2, '15', '2023-07-03 09:52:50', '2023-07-03 09:52:50'),
(3, '20', '2023-07-03 09:52:53', '2023-07-03 09:52:53'),
(4, '7', '2023-07-03 09:52:56', '2023-07-03 09:52:56'),
(6, '1', '2023-07-03 09:53:00', '2023-07-03 09:53:00'),
(7, '2', '2023-07-03 09:53:00', '2023-07-03 09:53:00');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_07_03_152816_create_companies_table', 1),
(6, '2023_07_03_153134_create_products_table', 2),
(7, '2023_07_03_153400_create_product_types_table', 3),
(8, '2023_07_03_153435_create_coupons_table', 4),
(9, '2023_07_03_153508_create_shops_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'API Access Token', 'af8756657236e92188711fcf9ffc77387a41d0e095b53f6aaa9aee0d7f246ce5', '[\"*\"]', NULL, NULL, '2023-07-05 08:58:59', '2023-07-05 08:58:59'),
(2, 'App\\Models\\User', 1, 'API Access Token', '9b01091f9cfcc0e16d3d2e2281751095798df4932333670a068058736d1a3489', '[\"*\"]', NULL, NULL, '2023-07-05 08:59:07', '2023-07-05 08:59:07'),
(3, 'App\\Models\\User', 1, 'API Access Token', '39ae4caa351606aa615cce9c14186738a3ff896b4ce7533f816b1a3b8d223120', '[\"*\"]', NULL, NULL, '2023-07-05 08:59:26', '2023-07-05 08:59:26'),
(4, 'App\\Models\\User', 1, 'API Access Token', '4708b135cdb418e3feeb4543d6f206968460da77a05b1f545c789a86531ffb54', '[\"*\"]', NULL, NULL, '2023-07-05 08:59:37', '2023-07-05 08:59:37'),
(5, 'App\\Models\\User', 1, 'API Access Token', '743c3c9fe184dee4727f33aee42ab9600bf11dc9e1e52cf76b1ca4ef4c952d5b', '[\"*\"]', NULL, NULL, '2023-07-05 09:01:26', '2023-07-05 09:01:26'),
(6, 'App\\Models\\User', 1, 'API Access Token', 'cc345c797526d1df6ed5c2171b100114ca5c2a3612f44acb65d048bd68177edd', '[\"*\"]', NULL, NULL, '2023-07-05 09:08:34', '2023-07-05 09:08:34'),
(7, 'App\\Models\\User', 1, 'API Access Token', 'c9d9003e4ba5f4bd8786a229ff5183c7c067fa9b5dc02e9ab1a19a8d4a916393', '[\"*\"]', NULL, NULL, '2023-07-05 09:11:03', '2023-07-05 09:11:03'),
(8, 'App\\Models\\User', 1, 'API Access Token', 'fd193ff6615f75da368ff956280ada9da54bc96eaee52404a3e10876207ce30f', '[\"*\"]', NULL, NULL, '2023-07-05 09:18:27', '2023-07-05 09:18:27'),
(9, 'App\\Models\\User', 1, 'API Access Token', 'a693d0d47cb5f6c6736b17d18153670c6e8884370a508f24039df0dec635994f', '[\"*\"]', NULL, NULL, '2023-07-05 09:19:04', '2023-07-05 09:19:04'),
(10, 'App\\Models\\User', 1, 'API Access Token', '5b7ee687d264170e98c410e919817344ee75fe0ab3d65250f2ec225166366fe0', '[\"*\"]', NULL, NULL, '2023-07-05 09:19:15', '2023-07-05 09:19:15'),
(11, 'App\\Models\\User', 1, 'API Access Token', '226478421bb3b7b9e599d70fc080f0f73685973dcaaa282aa3ebf4fc51fd5965', '[\"*\"]', NULL, NULL, '2023-07-05 09:21:34', '2023-07-05 09:21:34'),
(12, 'App\\Models\\User', 1, 'API Access Token', '9c60eeb9b74858ebb541adf70775885e805fcbeba216969552d45a61da544a84', '[\"*\"]', NULL, NULL, '2023-07-05 09:24:52', '2023-07-05 09:24:52'),
(13, 'App\\Models\\User', 1, 'API Access Token', '3b06a8c18b7777dd4f812ee18461c53b2b62b2787215ee181ce0e0f139ddf895', '[\"*\"]', NULL, NULL, '2023-07-05 09:28:07', '2023-07-05 09:28:07'),
(14, 'App\\Models\\User', 1, 'API Access Token', '516f38266b926f7e367246af09e63a4294cb0f5e406ed82bfc44db266b1ce029', '[\"*\"]', NULL, NULL, '2023-07-05 09:28:48', '2023-07-05 09:28:48'),
(15, 'App\\Models\\User', 1, 'API Access Token', '18ab869da2beeee7e98b391392620662f89e7f497e1d6b7357579961dc78232f', '[\"*\"]', NULL, NULL, '2023-07-05 09:29:01', '2023-07-05 09:29:01'),
(16, 'App\\Models\\User', 1, 'API Access Token', '8b6a0f1bcadaccdd674c910a273fed7ad3afd1424445d7009fa42b01cdfa2eb1', '[\"*\"]', NULL, NULL, '2023-07-05 09:30:13', '2023-07-05 09:30:13'),
(17, 'App\\Models\\User', 1, 'API Access Token', '2a073e3d232489a33e96028b3117177721042caa027bcc426129f2d65a0650bc', '[\"*\"]', NULL, NULL, '2023-07-05 09:31:21', '2023-07-05 09:31:21'),
(18, 'App\\Models\\User', 1, 'API Access Token', '7438b32c5c1237f41bb8413a01fae0105b2936f0266b4da94947ccbe1fcf4714', '[\"*\"]', NULL, NULL, '2023-07-05 09:31:38', '2023-07-05 09:31:38'),
(19, 'App\\Models\\User', 1, 'API Access Token', '3c97ac3766e5e23577ce12a5cc1089d845d30c458e5ebb00af09e05970cc1dc9', '[\"*\"]', NULL, NULL, '2023-07-05 09:33:52', '2023-07-05 09:33:52'),
(20, 'App\\Models\\User', 1, 'API Access Token', '87d3d6c9947a38671e27a5704d3d1389517429cb80efb0a1785c82a7265a2b71', '[\"*\"]', NULL, NULL, '2023-07-05 09:35:16', '2023-07-05 09:35:16'),
(21, 'App\\Models\\User', 1, 'API Access Token', 'd1d8c9f87f3ecaaac85b13ad17652e669015d2d3e47c96b1f7f9c9f973161f43', '[\"*\"]', NULL, NULL, '2023-07-05 09:36:03', '2023-07-05 09:36:03'),
(22, 'App\\Models\\User', 1, 'API Access Token', 'd9755809201e4e82868d4cefa1d5bdda9323c0fec0211039038efe0c310471cc', '[\"*\"]', NULL, NULL, '2023-07-05 09:36:30', '2023-07-05 09:36:30'),
(23, 'App\\Models\\User', 1, 'API Access Token', 'be015c1318dac49155095537621771e6a852b67e2ad6798e4d2ae353074579d6', '[\"*\"]', NULL, NULL, '2023-07-05 09:37:16', '2023-07-05 09:37:16'),
(24, 'App\\Models\\User', 1, 'API Access Token', '082f3980559716f6e4b2429df5e9b1f704ed11367275579f3512ae2d42298a52', '[\"*\"]', NULL, NULL, '2023-07-05 09:38:22', '2023-07-05 09:38:22'),
(25, 'App\\Models\\User', 1, 'API Access Token', '162c4be14913fc6979ccfd3f280a056e7bf1cb11986d0b5e2748cb509eeb2503', '[\"*\"]', NULL, NULL, '2023-07-05 09:39:00', '2023-07-05 09:39:00'),
(26, 'App\\Models\\User', 1, 'API Access Token', '6257fe7852739bd161371defb1c478a4f7cb7906e3c71326622f5d3e56e78fa4', '[\"*\"]', NULL, NULL, '2023-07-05 09:39:23', '2023-07-05 09:39:23'),
(27, 'App\\Models\\User', 1, 'API Access Token', '818fb5c49720edbea8589092ade96870a99b707709c3e3b44d9bf25b4af8ba92', '[\"*\"]', NULL, NULL, '2023-07-05 09:43:07', '2023-07-05 09:43:07'),
(28, 'App\\Models\\User', 1, 'API Access Token', 'c7eab59b0653d6a1def1f2ab4d8eb51fcde38be0ed931e878ff761b3eebeb603', '[\"*\"]', NULL, NULL, '2023-07-05 09:43:24', '2023-07-05 09:43:24'),
(29, 'App\\Models\\User', 1, 'API Access Token', 'cd3929ef6544c90a5d1d248c84dd7d74fc8b196e2582171aebfa23b0c4fd5704', '[\"*\"]', NULL, NULL, '2023-07-05 09:44:01', '2023-07-05 09:44:01'),
(30, 'App\\Models\\User', 1, 'API Access Token', 'd527922b845b667e6543ede49f85899b1926b486f685929c99b2a6c96b8c57a3', '[\"*\"]', NULL, NULL, '2023-07-05 09:44:17', '2023-07-05 09:44:17'),
(31, 'App\\Models\\User', 1, 'API Access Token', '7cca0308588e985eea04111df4d6686679a98bb92d6144a09cf09edd4a4a413e', '[\"*\"]', NULL, NULL, '2023-07-05 09:55:17', '2023-07-05 09:55:17'),
(32, 'App\\Models\\User', 1, 'API Access Token', 'c697459d53af589cd21022936413e8160aa468a70b5fa0cf0fcea4bce52521a6', '[\"*\"]', NULL, NULL, '2023-07-05 09:57:42', '2023-07-05 09:57:42'),
(33, 'App\\Models\\User', 1, 'API Access Token', '010f2ffb34edf56abfb769c5f09e0d971ebe5f968562a33e7b14adc09ceb5b3d', '[\"*\"]', NULL, NULL, '2023-07-05 09:58:02', '2023-07-05 09:58:02'),
(34, 'App\\Models\\User', 1, 'API Access Token', '9398dc4e2597adb2abe7d446cce40659b03b91f9c6e9a7f976cf1e13c8e0054b', '[\"*\"]', NULL, NULL, '2023-07-05 09:58:25', '2023-07-05 09:58:25'),
(35, 'App\\Models\\User', 1, 'API Access Token', '6bc88313c965bb314f305c1a19d639e1987cd00f6ba75a730b44fc97dad98ebd', '[\"*\"]', NULL, NULL, '2023-07-05 10:00:55', '2023-07-05 10:00:55'),
(36, 'App\\Models\\User', 1, 'API Access Token', '2b0223903f510b6b8df4bd871cc5a5a4fce404783eb1089bb8f4359ad3da8d16', '[\"*\"]', NULL, NULL, '2023-07-05 10:01:56', '2023-07-05 10:01:56'),
(37, 'App\\Models\\User', 1, 'API Access Token', '168df9872a1e8fe95d2b605c4276d3e758bde0b67f5f557e86a1eff57ca1a721', '[\"*\"]', NULL, NULL, '2023-07-05 10:02:41', '2023-07-05 10:02:41'),
(38, 'App\\Models\\User', 1, 'API Access Token', '6ce98f52b84f15801d8b456a9ed8a0c7ec76f4f15c976047b106340aede30297', '[\"*\"]', NULL, NULL, '2023-07-05 10:02:56', '2023-07-05 10:02:56'),
(39, 'App\\Models\\User', 1, 'API Access Token', 'aed77ed9069f505228d1abd2c6f1329fb133b862457e062a083f08c0e3629ca5', '[\"*\"]', NULL, NULL, '2023-07-05 10:03:27', '2023-07-05 10:03:27'),
(40, 'App\\Models\\User', 1, 'API Access Token', '141a5933caa659513e4b3264d50c80b5fd2d5918a3e38b6c30d1e448e7fd6ddb', '[\"*\"]', NULL, NULL, '2023-07-05 10:05:16', '2023-07-05 10:05:16'),
(41, 'App\\Models\\User', 1, 'API Access Token', '488ba0907ec4303e14e69d2a6418f41f17cebcaa457e77b78966b5427883546f', '[\"*\"]', NULL, NULL, '2023-07-05 10:07:50', '2023-07-05 10:07:50'),
(42, 'App\\Models\\User', 1, 'API Access Token', 'dffafe3ebb43f28edc6df72045ca83ffbaa643a00da9e8ba127f1df5e819501f', '[\"*\"]', NULL, NULL, '2023-07-05 10:13:04', '2023-07-05 10:13:04'),
(43, 'App\\Models\\User', 1, 'API Access Token', 'aa88bd810b36f14eae37a407aee5598be6eff46b6e4de287d7ad6262247346e1', '[\"*\"]', NULL, NULL, '2023-07-05 10:14:15', '2023-07-05 10:14:15'),
(44, 'App\\Models\\User', 1, 'API Access Token', 'c97646c5de3a2668d75a5faa44bb8a11a84dcd7b19bf8e744024bcca4bbb14b2', '[\"*\"]', NULL, NULL, '2023-07-05 10:17:42', '2023-07-05 10:17:42'),
(45, 'App\\Models\\User', 1, 'API Access Token', 'ccb5b70c01818bc90482ca5a991f7d81cdfef9ee38a1be9943a6d1d89619db9d', '[\"*\"]', NULL, NULL, '2023-07-09 06:47:23', '2023-07-09 06:47:23'),
(46, 'App\\Models\\User', 1, 'API Access Token', 'dbec0f53fbebfabd0ef89d78a086a8a83aace3f8ed1eb70fcce217eb3a018ad8', '[\"*\"]', NULL, NULL, '2023-07-09 06:47:54', '2023-07-09 06:47:54'),
(47, 'App\\Models\\User', 1, 'API Access Token', '363b2ee15b5ce0e53af2ac561a7508a0e99127772700a2ee7f9a135c321e8596', '[\"*\"]', NULL, NULL, '2023-07-09 06:56:25', '2023-07-09 06:56:25'),
(48, 'App\\Models\\User', 1, 'API Access Token', '80b1f57150d4ce15b9fb69ad930b9309b7411fb72073a03fb4f2ff8f6a5d2522', '[\"*\"]', NULL, NULL, '2023-07-09 06:57:30', '2023-07-09 06:57:30'),
(49, 'App\\Models\\User', 1, 'API Access Token', '571aca7025a5d64995591cf6cfc1adf7c934f85ee91cc32fad74d7cd2d03d6c1', '[\"*\"]', NULL, NULL, '2023-07-09 07:01:30', '2023-07-09 07:01:30'),
(50, 'App\\Models\\User', 1, 'API Access Token', 'be03da65d82392556ba4eefe85719fbae692b2951c630c68077681e64113ceb0', '[\"*\"]', NULL, NULL, '2023-07-09 07:09:47', '2023-07-09 07:09:47');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `product_type` bigint(20) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `coupon` bigint(20) DEFAULT NULL COMMENT 'ส่วนลด;',
  `status` varchar(255) NOT NULL COMMENT 'active:สามารถขายได้;\r\ninteractive:ไม่สามารถขายได้; ',
  `shop_id` bigint(20) NOT NULL,
  `due_date` date DEFAULT NULL,
  `due_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `product_type`, `price`, `coupon`, `status`, `shop_id`, `due_date`, `due_time`, `created_at`, `updated_at`) VALUES
(1, 'น้ำผึ้งเดือน 18', 5, 99.99, 7, 'active', 2, '2023-07-08', '23:12:14', '2023-07-03 10:18:50', '2023-07-05 07:14:57'),
(2, 'น้ำดื่ม ตรา ช้างสองตัว', 4, 20.40, 3, 'active', 3, '2023-07-08', '23:12:14', '2023-07-03 10:19:40', '2023-07-03 10:19:40'),
(3, 'เตาปิ้งย่างสไตล์เกาหลี', 4, 899.75, 6, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:20:25', '2023-07-03 10:20:25'),
(4, 'นมแพะสำหรับเด็กทารก', 5, 405.95, 5, 'active', 5, '2023-07-08', '23:12:14', '2023-07-03 10:21:18', '2023-07-03 10:21:18'),
(5, 'โน๊ตบุก X-SUS', 3, 24899.00, 5, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:22:37', '2023-07-03 10:22:37'),
(6, 'บริการหมอนวด', 3, 4000.75, 2, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:23:19', '2023-07-03 10:23:19'),
(7, 'รับจ้างตัดยาง', 3, 300.65, 3, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:23:54', '2023-07-03 10:23:54'),
(8, 'มาม่า ตรา แพะสองตัว', 3, 75.00, 7, 'active', 2, '2023-07-08', '23:12:14', '2023-07-03 10:24:32', '2023-07-05 07:14:57'),
(9, 'บะหมี่ ตรา นกกาเหว่า', 3, 75.00, 7, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:24:54', '2023-07-03 10:24:54'),
(10, 'ลูกอมความจำดี', 3, 89.00, 7, 'active', 3, '2023-07-08', '23:12:14', '2023-07-03 10:25:17', '2023-07-03 10:25:17'),
(11, 'Window XP', 3, 3000.20, 7, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:25:59', '2023-07-03 10:25:59'),
(12, 'บริการนวดฝาเท้า', 3, 2599.99, 7, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:26:26', '2023-07-03 10:26:26'),
(13, 'Macintosh OSX', 3, 5090.00, 7, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:27:02', '2023-07-03 10:27:02'),
(14, 'มอไซค์ ตรา คนถือมีด', 3, 40000.00, 7, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:27:45', '2023-07-03 10:27:45'),
(15, 'รถกระบะ 3 ล้อ', 3, 89999.00, 7, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:28:21', '2023-07-03 10:28:21'),
(16, 'มีดตัดความสัมพันธ์', 3, 99.99, 7, 'active', 1, '2023-07-08', '23:12:14', '2023-07-03 10:28:53', '2023-07-03 10:28:53'),
(17, 'ทดสอบ', 3, 7000.00, 1, 'active', 5, '2023-07-05', '23:12:14', '2023-07-05 07:30:59', '2023-07-05 07:33:38');

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

CREATE TABLE `product_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_types`
--

INSERT INTO `product_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'ขนม', '2023-07-03 10:02:33', '2023-07-03 10:08:04'),
(2, 'เครื่องดื่ม', '2023-07-03 10:02:56', '2023-07-03 10:02:56'),
(3, 'ลูกอม', '2023-07-03 10:03:02', '2023-07-03 10:03:02'),
(4, 'อาหารสำเร็จรูป', '2023-07-03 10:03:14', '2023-07-03 10:03:14'),
(5, 'ฮาร์ดแวร์', '2023-07-03 10:03:24', '2023-07-03 10:03:24'),
(6, 'บริการ', '2023-07-03 10:03:31', '2023-07-03 10:03:31'),
(7, 'ของเล่น', '2023-07-03 10:05:22', '2023-07-03 10:05:22'),
(8, 'เครื่องใช้ไฟฟ้า', '2023-07-03 10:05:47', '2023-07-03 10:05:47');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `company_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `name`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 'Franks Shop', '1', '2023-07-03 11:07:46', '2023-07-03 11:07:46'),
(2, 'Rudy Shop', '1', '2023-07-03 11:06:27', '2023-07-03 11:06:27'),
(3, 'Brownd Shop', '2', '2023-07-03 11:06:44', '2023-07-03 11:06:44'),
(4, 'Nuttie Shop', '2', '2023-07-03 11:06:55', '2023-07-03 11:06:55'),
(5, 'Msx Shop', '2', '2023-07-03 11:07:11', '2023-07-03 11:07:11'),
(6, 'Nueller Shop', '3', '2023-07-03 11:07:27', '2023-07-03 11:07:27'),
(7, 'Adele Shop', '3', '2023-07-03 11:07:37', '2023-07-03 11:07:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile` text DEFAULT 'default.png',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `profile`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Abdulloh Mukem', 'example@example.com', NULL, '$2b$10$UWADulWt9RGo535KF.f16eNOwaVyKO8rz2bmEw/COsDvEOyODeFlm', 'e30aa013-4356-4384-966e-04a18b42151a.png', 'be03da65d82392556ba4eefe85719fbae692b2951c630c68077681e64113ceb0', NULL, '2023-07-09 07:09:47'),
(2, 'Abdulloh Mukem', 'exam@example.com', NULL, '$2b$10$sxmjLqGDy9C56m66kcCE5eEYdLNlKkpZwxqGsub2z8PZLxX4maoFy', 'default.png', NULL, NULL, NULL),
(3, 'Abdulloh Mukem', 'exam@example.co.th', NULL, '$2b$10$tg6dzU.kFwxi/UU9jX8dqOrpeXS1HysY9MYEoOzna/2DO.aWtDCRq', 'default.png', NULL, NULL, NULL),
(4, 'Abdulloh Mukem', 'exam@example.co.thhih', NULL, '$2b$10$F.//RB0.t6KC05ZojRYJ4utDO2n5VhdoHeGcjbqmmbmn0YTcmQZFa', 'default.png', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `product_types`
--
ALTER TABLE `product_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
