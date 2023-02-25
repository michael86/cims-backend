-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 25, 2023 at 03:05 PM
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
(55, 'photomechanical', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-02-18 11:07:18');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `quantity`, `price`, `date_added`) VALUES
(1, 12345, 1299, '2023-02-25 13:07:23'),
(2, 12, 8000, '2023-02-25 13:07:23'),
(3, 123, 150, '2023-02-25 13:07:23'),
(4, 1000000, 100, '2023-02-25 13:07:23'),
(5, 45874, 100, '2023-02-25 13:07:23'),
(6, 98574, 100, '2023-02-25 13:07:23'),
(7, 4, 8, '2023-02-25 13:07:23'),
(8, 1, 1, '2023-02-25 13:07:23'),
(9, 1, 1, '2023-02-25 13:17:05'),
(10, 12, 1174, '2023-02-25 13:41:48');

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
(1, 1, 2),
(2, 2, 4),
(3, 3, 6),
(4, 4, 8),
(5, 5, 10),
(6, 6, 12),
(7, 7, 14),
(8, 8, 16),
(9, 9, 18),
(10, 10, 20);

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
(1, 'Lynda', 'evapo', 'unit 34 state square', 'basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-01-24 21:41:53'),
(2, 'Richard Smith', 'creekview', 'unit 2 Buckwins square', 'Basildon', 'Essex', 'SS13 2BJ', 'United Kingdom', '2023-01-24 21:43:03'),
(3, 'Russel', 'The Jump', '123 fake street', 'london', 'dreamland', 'swfhu', 'zimbabwa', '2023-01-25 18:27:02'),
(4, 'Sophia', 'Crumbles Pedicures', '75 Great Oxcroft', 'Leeds', 'Yorkshire', 'LS10 2HP', 'UK', '2023-01-25 20:28:57'),
(5, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-02-12 13:08:55'),
(6, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 13:14:27'),
(7, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 13:14:50'),
(8, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'es', 'ss15 5ae', 'United Kingdom', '2023-02-12 13:15:32'),
(9, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'es', 'ss15 5ae', 'United Kingdom', '2023-02-12 13:16:40'),
(10, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'es', 'ss15 5ae', 'United Kingdom', '2023-02-12 13:18:48'),
(11, 'Kiri', 'Kiri munrooooo', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 14:02:45'),
(12, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 14:52:05'),
(13, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 15:22:12'),
(14, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 15:23:20'),
(15, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'dsad', 'ss15 5ae', 'United Kingdom', '2023-02-12 15:24:11'),
(16, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 15:26:33'),
(17, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 15:29:11'),
(18, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'Essex', 'ss15 5ae', 'United Kingdom', '2023-02-12 15:31:18'),
(19, 'Kiri Munro', 'Kiris Reptiles', '74 great oxcroft', 'Baildon', 'Essex', 'ss15 6pn', 'United Kingdom', '2023-02-17 20:46:32'),
(20, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-02-24 21:25:44'),
(21, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-02-24 21:43:02'),
(22, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-02-24 21:44:32'),
(23, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-02-24 21:45:44'),
(24, 'Michael James Hodgson', 'creekview', '27 Wickhay', 'Basildon', 'America', 'ss15 5ae', 'United Kingdom', '2023-02-24 21:46:11');

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
(1, 1, 1, '2023-01-24 21:41:53'),
(2, 1, 2, '2023-01-24 21:41:53'),
(3, 1, 3, '2023-01-24 21:41:53'),
(4, 2, 4, '2023-01-24 21:43:03'),
(5, 3, 5, '2023-01-25 18:27:02'),
(6, 4, 6, '2023-01-25 20:28:57'),
(7, 4, 7, '2023-01-25 20:28:57'),
(8, 5, 8, '2023-02-12 13:08:55'),
(9, 6, 9, '2023-02-12 13:14:27'),
(10, 8, 10, '2023-02-12 13:15:32'),
(11, 9, 11, '2023-02-12 13:16:40'),
(12, 10, 12, '2023-02-12 13:18:48'),
(13, 10, 13, '2023-02-12 13:18:48'),
(14, 11, 14, '2023-02-12 14:02:45'),
(15, 12, 15, '2023-02-12 14:52:05'),
(16, 12, 16, '2023-02-12 14:52:05'),
(17, 13, 17, '2023-02-12 15:22:12'),
(18, 14, 18, '2023-02-12 15:23:20'),
(19, 15, 19, '2023-02-12 15:24:11'),
(20, 15, 20, '2023-02-12 15:24:11'),
(21, 16, 21, '2023-02-12 15:26:33'),
(22, 17, 22, '2023-02-12 15:29:11'),
(23, 18, 23, '2023-02-12 15:31:18'),
(24, 19, 24, '2023-02-17 20:46:32'),
(25, 23, 25, '2023-02-24 21:45:44'),
(26, 24, 26, '2023-02-24 21:46:11');

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
(1, 'orange and mango', 'orange and mango by fruitsome', 2, 12, 3, '2023-01-24 21:41:53'),
(2, 'lychee and mango', 'lychee and mango by fruitsome', 3, 12, 3, '2023-01-24 21:41:53'),
(3, 'passion fruit', 'passionfruit by fruitsome', 1, 20, 0, '2023-01-24 21:41:53'),
(4, 'web design', 'UX design for creekview', 1, 500, 5, '2023-01-24 21:43:03'),
(5, 'pencile', 'lead pencil', 10, 1, 0, '2023-01-25 18:27:02'),
(6, 'Pedicure', 'Naill cut, file, paint', 1, 12, 0, '2023-01-25 20:28:57'),
(7, 'hair cut', 'Fresh trim', 1, 30, 0, '2023-01-25 20:28:57'),
(8, '123', '123', 123, 123, 132, '2023-02-12 13:08:55'),
(9, '123', '123', 1233, 123, 13, '2023-02-12 13:14:27'),
(10, '15', '15', 15, 15, 15, '2023-02-12 13:15:32'),
(11, '15', '15', 15, 15, 15, '2023-02-12 13:16:40'),
(12, '15', '15', 15, 15, 15, '2023-02-12 13:18:48'),
(13, '15', '15', 15, 15, 15, '2023-02-12 13:18:48'),
(14, 'love', 'Not easy loving you', 0, 1000, 0, '2023-02-12 14:02:45'),
(15, '123', '123', 123, 124, 12, '2023-02-12 14:52:05'),
(16, '123', '123', 123, 124, 12, '2023-02-12 14:52:05'),
(17, '123', '123', 1233, 123, 123, '2023-02-12 15:22:12'),
(18, '12', '12', 12, 12, 1, '2023-02-12 15:23:20'),
(19, '111', '1', 11, 11, 11, '2023-02-12 15:24:11'),
(20, '111', '1', 11, 11, 11, '2023-02-12 15:24:11'),
(21, '12', '12', 12, 12, 12, '2023-02-12 15:26:33'),
(22, '4', '4', 4, 4, 4, '2023-02-12 15:29:11'),
(23, '1', '1', 1, 1, 1, '2023-02-12 15:31:18'),
(24, 'Manual Labour', 'Carried 2 x vivs to propety', 1, 50, 0, '2023-02-17 20:46:32'),
(25, 'Michael James Hodgson', '123', 1, 0, 1, '2023-02-24 21:45:44'),
(26, 'Michael James Hodgson', '123', 1, 0, 1, '2023-02-24 21:46:11');

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
(1, 1, 1, '2023-01-24 21:41:53'),
(2, 2, 2, '2023-01-24 21:43:03'),
(3, 3, 3, '2023-01-25 18:27:02'),
(4, 4, 4, '2023-01-25 20:28:57'),
(5, 5, 5, '2023-02-12 13:08:55'),
(6, 6, 6, '2023-02-12 13:14:27'),
(7, 8, 7, '2023-02-12 13:15:32'),
(8, 9, 8, '2023-02-12 13:16:40'),
(9, 10, 9, '2023-02-12 13:18:48'),
(10, 11, 10, '2023-02-12 14:02:45'),
(11, 12, 11, '2023-02-12 14:52:05'),
(12, 13, 12, '2023-02-12 15:22:12'),
(13, 14, 13, '2023-02-12 15:23:20'),
(14, 15, 14, '2023-02-12 15:24:11'),
(15, 16, 15, '2023-02-12 15:26:33'),
(16, 17, 16, '2023-02-12 15:29:11'),
(17, 18, 17, '2023-02-12 15:31:18'),
(18, 19, 18, '2023-02-17 20:46:32'),
(19, 23, 22, '2023-02-24 21:45:44'),
(20, 24, 23, '2023-02-24 21:46:11');

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
(1, 20230131, 20230124, 'For some vape juice', 'invoice 1', '2023-01-24 21:41:53'),
(2, 20230210, 20230124, 'For Richard Website', 'Order 2', '2023-01-24 21:43:03'),
(3, 20230126, 20230125, 'To Russel from Micael', 'FJDIs434344', '2023-01-25 18:27:02'),
(4, 20570430, 20570430, 'For Sophia', '987654', '2023-01-25 20:28:57'),
(5, 0, 0, '123', '123', '2023-02-12 13:08:55'),
(6, 0, 0, '123', '123', '2023-02-12 13:14:27'),
(7, 0, 0, '15', '15', '2023-02-12 13:15:32'),
(8, 2147483647, -1579046400, '15', '15', '2023-02-12 13:16:40'),
(9, 519523200, 522115200, '15', '15', '2023-02-12 13:18:48'),
(10, 1676160000, 1676246400, 'For loving me', 's3x1', '2023-02-12 14:02:45'),
(11, 519523200, 524793600, '123', '123', '2023-02-12 14:52:05'),
(12, 1675296000, 1643760000, '123', '123', '2023-02-12 15:22:12'),
(13, -2147483648, -2147483648, '12', '12', '2023-02-12 15:23:20'),
(14, -2147483648, -2147483648, '111', '11', '2023-02-12 15:24:11'),
(15, -2147483648, 2147483647, '12', '12', '2023-02-12 15:26:33'),
(16, 519523200, 519523200, '44', '444', '2023-02-12 15:29:11'),
(17, -2147483648, -2147483648, '1', '1', '2023-02-12 15:31:18'),
(18, 1676592000, 1676592000, 'Will take kisses as payment', '001', '2023-02-17 20:46:32'),
(19, 1706832000, 1704153600, '123', '111', '2023-02-24 21:25:44'),
(20, 1672531200, 1672531200, '123', '123', '2023-02-24 21:43:02'),
(21, 1672531200, 1672531200, '123', '123', '2023-02-24 21:44:32'),
(22, 1672531200, 1672531200, '123', '123', '2023-02-24 21:45:44'),
(23, 1672531200, 1672531200, '123', '123', '2023-02-24 21:46:11');

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
(20, '1', '2');

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
(51, 'qt2Oiv57aIL3gCO0eTsbmJzHtsglbceJUKfs03sM4WzHAyr6rG51676206192771');

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
(1, 'Nappies', 12345, 1299, 'null', 0, '2023-02-19 20:56:21'),
(2, 'cocal cola', 12, 805000, 'null', 0, '2023-02-22 20:51:50'),
(3, 'rubber ducks', 123, 15000, 'null', 0, '2023-02-22 20:46:38'),
(5, 'screwdrivers', 1000000, 100, 'null', 0, '2023-02-21 18:09:19'),
(6, 'toxic shit', 45874, 100, 'null', 0, '2023-02-21 18:09:34'),
(7, 'something else', 98574, 100, 'null', 0, '2023-02-21 18:09:47'),
(13, 'Nappies dfsdfsdf', 1, 1, 'null', 0, '2023-02-25 13:17:05'),
(14, 'test pennies', 12, 1174, 'null', 0, '2023-02-25 13:41:48');

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
(10, 14, 54);

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
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 5, 4),
(5, 6, 5),
(6, 7, 6),
(9, 13, 9),
(10, 14, 10);

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
(1, 1, 1),
(2, 2, 3),
(3, 3, 5),
(4, 5, 7),
(5, 6, 9),
(6, 7, 11),
(9, 13, 17),
(10, 14, 19);

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
(71, 'X+B473u%-0VWMtoYnAPllFSE0Cuf*3N+4\"6m4p1MZW3GUssiA*o1677333746361');

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
(84, 'michael8t6@gmail.com', '7fee8b1ff1733876febc0d525ae88c5f28f605c08d11c61c109af63b05b4bf03', '2023-02-12 12:50:19');

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
(30, 84, 32);

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
(1, 84, 1, '2023-01-24 21:41:53'),
(2, 84, 2, '2023-01-24 21:43:03'),
(3, 84, 3, '2023-01-25 18:27:02'),
(4, 84, 4, '2023-01-25 20:28:57'),
(5, 84, 5, '2023-02-12 13:08:55'),
(6, 84, 6, '2023-02-12 13:14:27'),
(7, 84, 8, '2023-02-12 13:15:32'),
(8, 84, 9, '2023-02-12 13:16:40'),
(9, 84, 10, '2023-02-12 13:18:48'),
(10, 84, 11, '2023-02-12 14:02:45'),
(11, 84, 12, '2023-02-12 14:52:05'),
(12, 84, 13, '2023-02-12 15:22:12'),
(13, 84, 14, '2023-02-12 15:23:20'),
(14, 84, 15, '2023-02-12 15:24:11'),
(15, 84, 16, '2023-02-12 15:26:33'),
(16, 84, 17, '2023-02-12 15:29:11'),
(17, 84, 18, '2023-02-12 15:31:18'),
(18, 84, 19, '2023-02-17 20:46:32'),
(19, 84, 23, '2023-02-24 21:45:44'),
(20, 84, 24, '2023-02-24 21:46:11');

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
(42, 84, 51);

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
(10, 84, 14);

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
(53, 84, 71);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `history_locations`
--
ALTER TABLE `history_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `invoice_company`
--
ALTER TABLE `invoice_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `invoice_specific`
--
ALTER TABLE `invoice_specific`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `invoice_specifics`
--
ALTER TABLE `invoice_specifics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `reset_tokens`
--
ALTER TABLE `reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `stock_company`
--
ALTER TABLE `stock_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stock_histories`
--
ALTER TABLE `stock_histories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stock_locations`
--
ALTER TABLE `stock_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `user_company`
--
ALTER TABLE `user_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `user_invoices`
--
ALTER TABLE `user_invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `user_reset`
--
ALTER TABLE `user_reset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `user_stock`
--
ALTER TABLE `user_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
