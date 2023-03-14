-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2023 at 10:56 PM
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
(32, 'dominoes', 'unit 45 Triangle Parade', 'Laindon', 'essex', 'ss11 2aa', 'United Kingdom', '2023-02-18 11:01:34'),
(54, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-02-18 11:04:50'),
(55, 'photomechanical', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-02-18 11:07:18'),
(56, 'Copping Gamer', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-06 21:16:11'),
(57, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:44:08'),
(58, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:46:06'),
(59, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:47:51'),
(60, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:48:38'),
(61, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:49:56'),
(62, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:50:50'),
(63, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:52:59'),
(64, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:53:48'),
(65, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:56:03'),
(66, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:57:18'),
(67, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:58:29'),
(68, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 21:59:25'),
(69, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:00:44'),
(70, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:01:27'),
(71, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:02:23'),
(72, 'fhnsdajf', 'KLFJSDL', 'FGKLDLG', 'kljklfdfsk', 'fdsfg', 'lfgkfsdl', '2023-03-08 22:03:35'),
(73, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:05:20'),
(74, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:07:16'),
(75, 'photomechanical', '123 disney land', 'sleep', 'is', 'now', 'needded', '2023-03-08 22:08:50'),
(76, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:11:54'),
(77, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:14:09'),
(78, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:15:05'),
(79, 'ndjdsh', 'njkndkj', 'njkkj', 'njk', 'kj', 'nkj', '2023-03-08 22:18:35'),
(80, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-08 22:23:54'),
(81, 'mdsaj', 'kfms', 'jiojvci', 'jioof', 'kof', 'joifd', '2023-03-09 18:13:45'),
(82, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-09 18:30:57'),
(83, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-10 23:15:56'),
(84, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-10 23:28:11'),
(85, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 11:33:29'),
(86, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:02:49'),
(87, 'my new company', '74 great oxcroft', 'Basildon', 'Essex', 'ss15 6pn', 'United Kingdom', '2023-03-11 12:04:25'),
(88, 'creekview', '75 little lullaway', 'Basildon', 'essex', 'rm17 6pp', 'United Kingdom', '2023-03-11 12:05:21'),
(89, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:50:05'),
(90, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:51:31'),
(91, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:52:05'),
(92, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:52:19'),
(93, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:52:41'),
(94, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:53:15'),
(95, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:54:25'),
(96, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-11 12:56:34'),
(97, 'creekview', '27 Wickhay', 'Basildon', 'florida', 'ss15 5ae', 'United Kingdom', '2023-03-11 13:00:56'),
(98, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-11 13:02:43'),
(99, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-11 13:03:24'),
(100, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-11 13:04:04'),
(101, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-11 13:04:23'),
(102, 'creekview', '27 Wickhay', 'Basildon', 'florida', 'ss15 5ae', 'United Kingdom', '2023-03-12 19:37:56'),
(103, 'creekview', '27 Wickhay', 'Basildon', 'florida', 'ss15 5ae', 'United Kingdom', '2023-03-12 19:39:22'),
(104, 'creekview', '27 Wickhay', 'Basildon', 'florida', 'ss15 5ae', 'United Kingdom', '2023-03-12 19:41:27'),
(105, 'creekview', '27 Wickhay', 'Basildon', 'florida', 'ss15 5ae', 'United Kingdom', '2023-03-12 19:42:23'),
(106, 'shitcunt', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-12 19:43:22'),
(107, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:40:47'),
(108, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:41:46'),
(109, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:42:23'),
(110, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:50:40'),
(111, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:53:26'),
(112, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:54:15'),
(113, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:54:57'),
(114, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 20:57:00'),
(115, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-03-12 21:03:40'),
(116, 'dsjkna', 'njk', 'nkj', 'nkjk', 'nkj', 'nkj', '2023-03-12 21:07:44'),
(117, 'fklsdj', 'nkji', 'nji', 'nji', 'nmjo', 'njoi', '2023-03-12 21:09:01'),
(118, 'nyu', 'nbh', 'ni', 'nji', 'ni', 'ni', '2023-03-12 21:09:33'),
(119, 'fdsa', 'mnoi', 'jui', 'jmio', 'jio', 'jmio', '2023-03-12 21:10:06'),
(120, 'niu', 'no', 'no', 'mnoo', 'mni', 'noi', '2023-03-12 21:11:28'),
(121, 'BHJUHGB', 'bhjbjuh', 'nbkhj', 'jk', 'h', 'hjk', '2023-03-12 21:34:51'),
(122, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-13 18:45:40'),
(123, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:05:31'),
(124, 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:06:01'),
(125, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:06:43'),
(126, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:09:31'),
(127, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:36:02'),
(128, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:36:54'),
(129, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:37:45'),
(130, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:37:58'),
(131, 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-03-13 19:39:58');

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
(47, 'kiri', 'PhotoMechanical', '123 disney land', 'Basildon', 'America', 'United Kingdom', 'ss15 5ae', '2023-03-14 21:36:48');

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
(48, 47, 60, '2023-03-14 21:36:48');

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
(60, 'hugs', 'cute', 1, 1, 0, '2023-03-14 21:36:48');

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
(41, 47, 62, '2023-03-14 21:36:48');

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
(62, 1709337600, 1680393600, 'second', 'sec  ond foro', '2023-03-14 21:36:48');

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
(64, 'box', '43');

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
  `price` int(11) NOT NULL,
  `image_name` varchar(255) NOT NULL,
  `free_issue` tinyint(1) NOT NULL,
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
(17, 'Go go juice', 6, 150, 'null', 0, '2023-03-06 21:16:11');

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
(12, 17, 56);

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
(49, 15, 64);

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
(71, '&N(Ke296l!H8\"SS4igQLU)2Q4F66ld6DD\"7e$ckOxqi&cr)1H-\"1678830794560'),
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
(42, 84, 47, '2023-03-14 21:36:48');

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
(9, 84, 13),
(10, 84, 14),
(11, 84, 15),
(12, 84, 17);

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
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `invoice_specific`
--
ALTER TABLE `invoice_specific`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `invoice_specifics`
--
ALTER TABLE `invoice_specifics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `reset_tokens`
--
ALTER TABLE `reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `stock_company`
--
ALTER TABLE `stock_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `stock_histories`
--
ALTER TABLE `stock_histories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stock_locations`
--
ALTER TABLE `stock_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `user_reset`
--
ALTER TABLE `user_reset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `user_stock`
--
ALTER TABLE `user_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
