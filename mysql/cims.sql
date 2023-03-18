-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2023 at 01:01 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cims`
--

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `county` varchar(255) NOT NULL,
  `postcode` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `address`, `city`, `county`, `postcode`, `country`, `date`) VALUES
(54, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-02-18 11:04:50'),
(55, 'photomechanical', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-02-18 11:07:18'),
(56, 'Copping Gamer', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-06 21:16:11'),
(72, 'fhnsdajf', 'KLFJSDL', 'FGKLDLG', 'kljklfdfsk', 'fdsfg', 'lfgkfsdl', '2023-03-08 22:03:35'),
(79, 'ndjdsh', 'njkndkj', 'njkkj', 'njk', 'kj', 'nkj', '2023-03-08 22:18:35'),
(87, 'my new company', '74 great oxcroft', 'Basildon', 'Essex', 'ss15 6pn', 'United Kingdom', '2023-03-11 12:04:25'),
(106, 'shitcunt', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-12 19:43:22'),
(116, 'dsjkna', 'njk', 'nkj', 'nkjk', 'nkj', 'nkj', '2023-03-12 21:07:44'),
(117, 'fklsdj', 'nkji', 'nji', 'nji', 'nmjo', 'njoi', '2023-03-12 21:09:01'),
(118, 'nyu', 'nbh', 'ni', 'nji', 'ni', 'ni', '2023-03-12 21:09:33'),
(119, 'fdsa', 'mnoi', 'jui', 'jmio', 'jio', 'jmio', '2023-03-12 21:10:06'),
(120, 'niu', 'no', 'no', 'mnoo', 'mni', 'noi', '2023-03-12 21:11:28'),
(121, 'BHJUHGB', 'bhjbjuh', 'nbkhj', 'jk', 'h', 'hjk', '2023-03-12 21:34:51'),
(134, 'the jump', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-18 00:01:02');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `sku`, `quantity`, `price`, `date_added`) VALUES
(1, 'cup of go go juicedddd', 17, 9941, '2023-03-07 20:12:20'),
(2, 'some sku', 1, 2, '2023-03-07 20:16:04');

-- --------------------------------------------------------

--
-- Table structure for table `history_locations`
--

CREATE TABLE `history_locations` (
  `id` int(11) NOT NULL,
  `history_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history_locations`
--

INSERT INTO `history_locations` (`id`, `history_id`, `location_id`) VALUES
(1, 1, 51),
(2, 1, 58),
(3, 1, 59),
(4, 1, 60),
(5, 2, 45);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_company`
--

CREATE TABLE `invoice_company` (
  `id` int(11) NOT NULL,
  `contact` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `address` varchar(256) NOT NULL,
  `city` varchar(256) NOT NULL,
  `state` varchar(256) NOT NULL,
  `country` varchar(256) NOT NULL,
  `postcode` varchar(256) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_company`
--

INSERT INTO `invoice_company` (`id`, `contact`, `name`, `address`, `city`, `state`, `country`, `postcode`, `date_added`) VALUES
(46, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'United Kingdom', 'ss15 5ae', '2023-03-14 21:35:26'),
(47, 'kiri', 'PhotoMechanical', '123 disney land', 'Basildon', 'America', 'United Kingdom', 'ss15 5ae', '2023-03-14 21:36:48'),
(48, 'Kiri Munro', 'Kiris Reptiles', '74 Great Oxcroft', 'Laindon', 'Essex', 'United Kingdom', 'SS15 6PN', '2023-03-16 22:25:04'),
(51, 'Michael Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'United Kingdom', 'ss15 5ae', '2023-03-17 23:57:52');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_item`
--

CREATE TABLE `invoice_item` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_item`
--

INSERT INTO `invoice_item` (`id`, `invoice_id`, `item_id`, `date`) VALUES
(46, 46, 58, '2023-03-14 21:35:26'),
(47, 46, 59, '2023-03-14 21:35:26'),
(48, 47, 60, '2023-03-14 21:36:48'),
(49, 48, 61, '2023-03-16 22:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(11) NOT NULL,
  `sku` varchar(256) NOT NULL,
  `description` varchar(256) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `tax` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `sku`, `description`, `quantity`, `price`, `tax`, `date_added`) VALUES
(58, 'peas', 'green', 100, 50, 0, '2023-03-14 21:35:26'),
(59, 'brussels', 'also green', 10, 198, 0, '2023-03-14 21:35:26'),
(60, 'hugs', 'cute', 1, 1, 0, '2023-03-14 21:36:48'),
(61, 'Stress', 'For putting me under stress with your amazing looks', 1, 9999, 6, '2023-03-16 22:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_specific`
--

CREATE TABLE `invoice_specific` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `specific_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_specific`
--

INSERT INTO `invoice_specific` (`id`, `invoice_id`, `specific_id`, `date`) VALUES
(40, 46, 61, '2023-03-14 21:35:26'),
(41, 47, 62, '2023-03-14 21:36:48'),
(42, 48, 63, '2023-03-16 22:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_specifics`
--

CREATE TABLE `invoice_specifics` (
  `id` int(11) NOT NULL,
  `billing_date` int(11) NOT NULL,
  `due_date` int(11) NOT NULL,
  `order_number` varchar(256) NOT NULL,
  `footer` varchar(256) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_specifics`
--

INSERT INTO `invoice_specifics` (`id`, `billing_date`, `due_date`, `order_number`, `footer`, `date_added`) VALUES
(61, 1678752000, 1678752000, 'my first invocie', 'my first invocie footer', '2023-03-14 21:35:26'),
(62, 1709337600, 1680393600, 'second', 'sec  ond foro', '2023-03-14 21:36:48'),
(63, 1678924800, 1679011200, '555', 'Please pay as soon as possible', '2023-03-16 22:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `value`) VALUES
(1, '1', '2'),
(2, '1', '2'),
(3, 'shelf', 'A3'),
(4, 'shelf', 'A3'),
(5, 'draw', 'top'),
(6, 'draw', 'top'),
(7, '1', '2'),
(8, '1', '2'),
(9, 'Michael James Hodgson', '2'),
(10, 'Michael James Hodgson', '2'),
(11, 'Michael James Hodgson', '3'),
(12, 'Michael James Hodgson', '3'),
(13, '1', '2'),
(14, '1', '2'),
(15, '12', '21'),
(16, '12', '21'),
(17, 'Michael James Hodgson', '2'),
(18, 'Michael James Hodgson', '2'),
(19, '1', '2'),
(20, '1', '2'),
(21, '1', '2'),
(22, '2', '1'),
(23, '1', '2'),
(24, '2', '1'),
(25, '3', '4'),
(26, 'new', 'shit'),
(27, 'jjj', 'kkkk'),
(28, '65', '76'),
(29, '87', '45'),
(30, 'aisle', 'B'),
(31, 'shelf', 'J'),
(32, 'box', 'C5'),
(33, 'Container', '45'),
(34, 'my New Locations', 'DSADASD'),
(35, 'shelf', 'A'),
(36, 'drawer', '23'),
(37, 'shelf', 'A'),
(38, 'drawer', '23'),
(39, '12', '25'),
(40, '25', '25'),
(41, '34', '54'),
(42, '5', '6'),
(43, '5', '6'),
(44, '34', '4'),
(45, '5', '6'),
(46, '4', '3'),
(47, '3', '4'),
(48, '65', '65'),
(49, '65', '76'),
(50, '56', '56'),
(51, '6', '5'),
(52, '76', '67'),
(53, '87', '98'),
(54, '56', '65'),
(55, '7', '8'),
(56, '3', '4'),
(57, '4', '3'),
(58, '3', '4'),
(59, '6', '7'),
(60, '6', '7'),
(61, '1', '2'),
(62, 'aisle', '53'),
(63, 'shelf', 'b'),
(64, 'box', '43'),
(65, 'Michael James Hodgson', '54'),
(66, 'Michael James Hodgson', '1'),
(67, 'Michael James Hodgson', '1'),
(68, 'Michael James Hodgson', '1'),
(69, 'Michael James Hodgson', '1'),
(70, 'Michael James Hodgson', '1'),
(71, 'Michael James Hodgson', '2'),
(72, 'Michael James Hodgson', '2'),
(73, 'Michael James Hodgson', '2'),
(74, 'Michael James Hodgson', '2'),
(75, 'Michael James Hodgson', '2'),
(76, 'Michael James Hodgson', '2'),
(77, 'Michael James Hodgson', '2'),
(78, 'Michael James Hodgson', '2'),
(79, 'Michael James Hodgson', '2'),
(80, 'Michael James Hodgson', '2'),
(81, 'Michael James Hodgson', '2'),
(82, 'Michael James Hodgson', '2');

-- --------------------------------------------------------

--
-- Table structure for table `reset_tokens`
--

CREATE TABLE `reset_tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reset_tokens`
--

INSERT INTO `reset_tokens` (`id`, `token`) VALUES
(78, 'bEczBJsBILxzDuIRslcaOet2pagmj2raV2dmyspJRoHUAVm17qM1678657078271'),
(79, 'XnDeNMf7obX0Cu5roLLnz2b2fzDWElw5ehdsfTQ7zRlzrbdY1dH1678823896964');

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `id` int(11) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `free_issue` tinyint(1) NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`id`, `sku`, `quantity`, `price`, `image_name`, `free_issue`, `date`) VALUES
(1, 'cup of go go juice', 99500, 1698, 'null', 0, '2023-03-06 21:17:37'),
(2, 'cup of go go juicedddd', 17, 9941, 'null', 0, '2023-03-07 20:08:27'),
(3, 'rubber ducksaaaa', 123, 15000, 'null', 0, '2023-03-07 19:43:44'),
(5, 'screwdrivers', 2, 89, 'null', 0, '2023-03-04 11:54:19'),
(6, 'toxic shit', 45874, 100, 'null', 0, '2023-02-21 18:09:34'),
(7, 'something else', 98574, 100, 'null', 0, '2023-02-21 18:09:47'),
(13, 'Nappies dfsdfsdf', 1, 1, 'null', 0, '2023-02-25 13:17:05'),
(14, 'test pennies', 12, 1174, 'null', 0, '2023-02-25 13:41:48'),
(15, 'was some sku', 10, 10000, 'null', 0, '2023-03-07 20:16:04'),
(17, 'Go go juice', 6, 150, 'null', 0, '2023-03-06 21:16:11'),
(18, 'Nappies', 1, 1, NULL, 0, '2023-03-17 20:54:04'),
(19, 'Nappies', 5, 2, NULL, 0, '2023-03-17 20:56:10'),
(20, 'Nappies', 1, 0, NULL, 1, '2023-03-17 20:57:25'),
(21, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:09:49'),
(22, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:10:23'),
(23, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:10:38'),
(24, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:11:01'),
(25, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:11:15'),
(26, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:15:23'),
(27, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:16:45'),
(28, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:17:07'),
(29, 'Nappies', 0, 1, NULL, 0, '2023-03-17 21:17:21'),
(30, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:21:58'),
(31, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:22:35'),
(32, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:22:57'),
(33, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:32:09'),
(34, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:32:46'),
(35, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:33:05'),
(36, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:33:42'),
(37, 'Nappies2', 1, 2, NULL, 0, '2023-03-17 21:33:57'),
(38, 'Nappies3', 1, 2, NULL, 0, '2023-03-17 21:34:25'),
(39, 'Nappies4', 1, 2, NULL, 0, '2023-03-17 21:41:51'),
(40, 'Nappies5', 1, 2, NULL, 0, '2023-03-17 21:43:01'),
(41, 'Nappies6', 1, 2, NULL, 0, '2023-03-17 23:23:08');

-- --------------------------------------------------------

--
-- Table structure for table `stock_company`
--

CREATE TABLE `stock_company` (
  `id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_company`
--

INSERT INTO `stock_company` (`id`, `stock_id`, `company_id`) VALUES
(1, 1, 54),
(2, 2, 54),
(3, 3, 54),
(4, 5, 54),
(5, 6, 54),
(6, 7, 54),
(9, 13, 54),
(10, 14, 54),
(11, 15, 54),
(12, 17, 56),
(13, 0, 54),
(15, 21, 54),
(16, 22, 54),
(17, 23, 54),
(18, 24, 54),
(19, 25, 54),
(22, 26, 54),
(23, 27, 54),
(24, 28, 54),
(25, 29, 54),
(27, 30, 54),
(28, 31, 54),
(29, 32, 54),
(30, 37, 54),
(31, 38, 54),
(32, 39, 54),
(33, 40, 54),
(34, 41, 54);

-- --------------------------------------------------------

--
-- Table structure for table `stock_histories`
--

CREATE TABLE `stock_histories` (
  `id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `history_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_histories`
--

INSERT INTO `stock_histories` (`id`, `stock_id`, `history_id`) VALUES
(1, 2, 1),
(2, 15, 2);

-- --------------------------------------------------------

--
-- Table structure for table `stock_locations`
--

CREATE TABLE `stock_locations` (
  `id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_locations`
--

INSERT INTO `stock_locations` (`id`, `stock_id`, `location_id`) VALUES
(5, 6, 9),
(9, 13, 17),
(20, 14, 33),
(22, 17, 35),
(23, 17, 36),
(24, 1, 39),
(25, 1, 40),
(27, 7, 42),
(28, 5, 43),
(29, 1, 44),
(31, 3, 46),
(46, 2, 61),
(47, 15, 62),
(48, 15, 63),
(49, 15, 64),
(50, 0, 65),
(51, 21, 66),
(52, 22, 67),
(53, 23, 68),
(54, 24, 69),
(55, 25, 70),
(56, 26, 71),
(57, 27, 72),
(58, 28, 73),
(59, 29, 74),
(60, 30, 75),
(61, 31, 76),
(62, 32, 77),
(63, 37, 78),
(64, 38, 79),
(65, 39, 80),
(66, 40, 81),
(67, 41, 82);

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `token`) VALUES
(71, 'PZR&Z0fFbo20_Oyit^vj8XH!LRUk0sFkOa5sR8VpG3*QhAygHRQ1679095388584'),
(88, ''),
(89, ''),
(90, ''),
(91, 'TRNbwJot&2G2OeH9i*K\"KD!JS$jXR&pB£drezUmMw5xMwA*aOS\"1678490967302'),
(92, 'MKgzTCYlqG(!XHZ-IffsotWn4Rn8H(q+-1BKOJU50Y3PNvgW7ik1678535362681'),
(93, '0o*T\"-EtEE)DX_lAGU4A$8DE$9ZTUexG2!FJ3cTEkj^)Ehqx_)s1678539394209'),
(94, 'a^H3Y\"L4hkmL7BV^YP-H+(ggxV6SbY£yXGBHz8gF5L_H1h)2okb1678654406715'),
(95, 'JJx_O^)+44-Ir*%07eQu+8sfCc!g5_A2XOWSyDhOPTWobhOZx£k1678654455641'),
(96, 'RH5\"SDAFl*^dmyJC£nJF!hUPqUL-0GAgAqT+%B^\"IrRZJRrUPx^1678654497051'),
(97, ''),
(98, ''),
(99, ''),
(100, ''),
(101, ''),
(102, ''),
(103, ''),
(104, '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(320) NOT NULL,
  `password` varchar(256) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `date`) VALUES
(84, 'michael8t6@gmail.com', '51475b76dda6383493d7ca1286fcffb9efaaee6b05e63de02cef5a1939a3a68f', '2023-03-13 18:44:09'),
(169, 'm@m.m', '7fee8b1ff1733876febc0d525ae88c5f28f605c08d11c61c109af63b05b4bf03', '2023-03-12 21:34:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_company`
--

CREATE TABLE `user_company` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_company`
--

INSERT INTO `user_company` (`id`, `user_id`, `company_id`) VALUES
(30, 84, 32),
(50, 131, 81),
(51, 133, 82),
(52, 134, 83),
(53, 135, 84),
(54, 168, 120),
(55, 169, 121);

-- --------------------------------------------------------

--
-- Table structure for table `user_invoices`
--

CREATE TABLE `user_invoices` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_invoices`
--

INSERT INTO `user_invoices` (`id`, `user_id`, `invoice_id`, `date`) VALUES
(41, 84, 46, '2023-03-14 21:35:26'),
(42, 84, 47, '2023-03-14 21:36:48'),
(43, 84, 48, '2023-03-16 22:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `user_reset`
--

CREATE TABLE `user_reset` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_reset`
--

INSERT INTO `user_reset` (`id`, `user_id`, `token_id`) VALUES
(52, 169, 78),
(53, 84, 79);

-- --------------------------------------------------------

--
-- Table structure for table `user_stock`
--

CREATE TABLE `user_stock` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_stock`
--

INSERT INTO `user_stock` (`id`, `user_id`, `stock_id`) VALUES
(1, 84, 1),
(2, 84, 2),
(3, 84, 3),
(4, 84, 5),
(5, 84, 6),
(6, 84, 7),
(9, 85, 13),
(10, 84, 14),
(11, 84, 15),
(12, 84, 17),
(13, 84, 26),
(14, 84, 37),
(15, 84, 38),
(16, 84, 39),
(17, 84, 40),
(18, 84, 41);

-- --------------------------------------------------------

--
-- Table structure for table `user_token`
--

CREATE TABLE `user_token` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `token` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_token`
--

INSERT INTO `user_token` (`id`, `user`, `token`) VALUES
(54, 84, 71),
(66, 131, 88),
(67, 133, 89),
(68, 134, 90),
(69, 135, 91),
(70, 136, 92),
(71, 137, 93),
(72, 159, 96),
(73, 161, 97),
(74, 163, 98),
(75, 164, 99),
(76, 165, 100),
(77, 166, 101),
(78, 167, 102),
(79, 168, 103),
(80, 169, 104);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `company` (`name`,`postcode`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history_locations`
--
ALTER TABLE `history_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_company`
--
ALTER TABLE `invoice_company`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `company` (`contact`,`name`,`postcode`);

--
-- Indexes for table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_specific`
--
ALTER TABLE `invoice_specific`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_specifics`
--
ALTER TABLE `invoice_specifics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reset_tokens`
--
ALTER TABLE `reset_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_company`
--
ALTER TABLE `stock_company`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stock_id` (`stock_id`);

--
-- Indexes for table `stock_histories`
--
ALTER TABLE `stock_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_locations`
--
ALTER TABLE `stock_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_company`
--
ALTER TABLE `user_company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_invoices`
--
ALTER TABLE `user_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_reset`
--
ALTER TABLE `user_reset`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_stock`
--
ALTER TABLE `user_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_token`
--
ALTER TABLE `user_token`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `history_locations`
--
ALTER TABLE `history_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `invoice_company`
--
ALTER TABLE `invoice_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `invoice_specific`
--
ALTER TABLE `invoice_specific`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `invoice_specifics`
--
ALTER TABLE `invoice_specifics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `reset_tokens`
--
ALTER TABLE `reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `stock_company`
--
ALTER TABLE `stock_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `stock_histories`
--
ALTER TABLE `stock_histories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stock_locations`
--
ALTER TABLE `stock_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT for table `user_company`
--
ALTER TABLE `user_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `user_invoices`
--
ALTER TABLE `user_invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `user_reset`
--
ALTER TABLE `user_reset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `user_stock`
--
ALTER TABLE `user_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
