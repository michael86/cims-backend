-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2023 at 01:13 PM
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
(1, 'creekview', '27 wickhay', 'basildon', 'essex', 'ss15 5ae', 'united kingdom', '2023-03-19 19:25:21'),
(28, 'photomechanical', '27 wickhay', 'basildon', 'essex', 'ss15 5ae', 'united kingdom', '2023-03-19 21:51:56'),
(31, 'some company', '27 wickhay', 'basildon', 'essex', 'ss15 5ae', 'united kingdom', '2023-03-19 21:59:46'),
(34, 'random company', '27 wickhay', 'basildon', 'essex', 'ss15 5ae', 'united kingdom', '2023-03-20 19:58:44'),
(35, 'crash magic', '27 downing street', 'basildon', 'essex', 'dsad 12341', 'united kingdom', '2023-03-20 20:00:15'),
(40, 'sddsdsd', 'sdds', 'dsdsd', 'sdsdds', 'dsdsd', 'dsdsdsdsdds', '2023-03-20 20:42:01');

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

-- --------------------------------------------------------

--
-- Table structure for table `history_locations`
--

CREATE TABLE `history_locations` (
  `id` int(11) NOT NULL,
  `history_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'Farah Goyette', 'sports direct', '5702 Cathey Route', 'West Mitchell', 'North Carolina', 'United States', '54322', '2023-04-22 10:35:04'),
(2, 'Ludivina Welch', 'amazon', '457 Kraig Forges', 'Darylside', 'Michigan', 'United States', '99543', '2023-04-22 10:35:04'),
(3, 'Woodrow Konopelski', 'twitter', '510 Pfeffer Port', 'Rennerport', 'Ohio', 'United States', '71574-9546', '2023-04-22 10:35:04'),
(4, 'Maren Harber', 'toys r us', '1239 Kuphal Stream', 'Purdyhaven', 'South Carolina', 'United States', '74099', '2023-04-22 10:35:04'),
(5, 'Edgar Blick', 'twitter', '686 Rosalba Route', 'South Rossside', 'Ohio', 'United States', '58132-3171', '2023-04-22 10:35:04'),
(6, 'Porfirio Luettgen', 'sports direct', '40696 Kuhlman View', 'Port Arnulfo', 'Kentucky', 'United States', '57557-4422', '2023-04-22 10:35:04'),
(7, 'Jean Thiel', 'sports direct', '17423 Heriberto Ridges', 'Wallymouth', 'Louisiana', 'United States', '84991-8232', '2023-04-22 10:35:04'),
(8, 'Jere Altenwerth', 'twitter', '16511 Waters Forge', 'East Awilda', 'Rhode Island', 'United States', '81595-1811', '2023-04-22 10:35:04'),
(9, 'Georgina Price', 'photomechanical', '5691 Meryl Union', 'North Marina', 'Pennsylvania', 'United States', '28615', '2023-04-22 10:35:04'),
(10, 'Leena Witting', 'amazon', '3832 Kertzmann Corners', 'Bartellport', 'Delaware', 'United States', '26268-9782', '2023-04-22 10:35:04'),
(11, 'Dennis Hermiston', 'vape lounge', '5073 Marian Springs', 'East Shirlymouth', 'Wyoming', 'United States', '07350-6280', '2023-04-22 10:35:05'),
(12, 'Rene Daniel', 'evapo', '5254 Rath Mountains', 'Carlenaton', 'Alabama', 'United States', '96067', '2023-04-22 10:35:05'),
(13, 'Adriene Skiles', 'jd sport', '1599 Hiram Freeway', 'Cristmouth', 'Indiana', 'United States', '00929-8342', '2023-04-22 10:35:05'),
(14, 'Nolan Mann', 'facebook', '67232 Connelly Neck', 'Rosenbaumview', 'Maryland', 'United States', '23188-1892', '2023-04-22 10:35:05'),
(15, 'Lashell Weissnat', 'the jump', '65167 Barton Spur', 'West Arlenside', 'Montana', 'United States', '54252', '2023-04-22 10:35:05'),
(16, 'Chang Halvorson', 'twitter', '4681 Nicolas Gardens', 'West Jeremiah', 'Massachusetts', 'United States', '64580', '2023-04-22 10:35:05'),
(17, 'Genny Schmidt', 'the jump', '7816 Kieth Pike', 'Port Darenburgh', 'Washington', 'United States', '77247-9048', '2023-04-22 10:35:05'),
(18, 'Irvin Pacocha', 'vape lounge', '407 Shona Place', 'Solomonbury', 'California', 'United States', '36046', '2023-04-22 10:35:05'),
(19, 'Jane Sipes', 'twitter', '7489 Kessler Island', 'Ankundingmouth', 'Pennsylvania', 'United States', '89869', '2023-04-22 10:35:05'),
(20, 'Clemente Ledner', 'photomechanical', '85598 Keeling Corner', 'North Melva', 'Hawaii', 'United States', '92397-9025', '2023-04-22 10:35:05'),
(21, 'Hoa Auer', 'twitter', '866 Murphy Islands', 'Moisesfurt', 'Indiana', 'United States', '95336-5716', '2023-04-22 10:35:05'),
(22, 'Logan Connelly', 'vape lounge', '752 Bauch Forest', 'Oliverstad', 'North Carolina', 'United States', '04293', '2023-04-22 10:35:05'),
(23, 'Wen Keeling', 'twitter', '762 Hickle Corner', 'New Arlenview', 'Massachusetts', 'United States', '91012-1826', '2023-04-22 10:35:05'),
(24, 'Malik Yost', 'photomechanical', '58181 Steuber Groves', 'East Pansy', 'South Dakota', 'United States', '62823-0593', '2023-04-22 10:35:05'),
(25, 'Jamel Frami', 'jd sport', '31588 Raleigh Ridges', 'West Floy', 'Louisiana', 'United States', '99760-2673', '2023-04-22 10:35:05'),
(26, 'Denny McKenzie', 'twitter', '4080 Oren Road', 'East Fredric', 'New Jersey', 'United States', '88322-0343', '2023-04-22 10:35:05'),
(27, 'Herbert Kuhic', 'toys r us', '6083 Houston Glens', 'Port Shaunfurt', 'Wyoming', 'United States', '08724', '2023-04-22 10:35:05'),
(28, 'Lashawn Wehner', 'toys r us', '6530 Pete Shores', 'West Isaac', 'Mississippi', 'United States', '58430-8791', '2023-04-22 10:35:05'),
(29, 'Salvatore Wyman', 'jd sport', '1967 Stroman Cliff', 'O\'Connelltown', 'Colorado', 'United States', '71210', '2023-04-22 10:35:05'),
(30, 'Man Mante', 'amazon', '9815 Sheryll Square', 'Port Vertie', 'West Virginia', 'United States', '28626-1102', '2023-04-22 10:35:05'),
(31, 'Carmen Crooks', 'amazon', '9883 Lauren Flats', 'Millerfurt', 'Arizona', 'United States', '57893', '2023-04-22 10:35:05'),
(32, 'Azalee Dare', 'twitter', '25341 Hong Branch', 'Almafurt', 'Rhode Island', 'United States', '89646', '2023-04-22 10:35:05'),
(33, 'Charles Witting', 'vape lounge', '270 Lupita Lodge', 'Haagshire', 'Texas', 'United States', '60722', '2023-04-22 10:35:05'),
(34, 'Clementina Schroeder', 'jd sport', '76332 Wisozk Port', 'West Michel', 'Rhode Island', 'United States', '53552', '2023-04-22 10:35:05'),
(35, 'Elvia Wilderman', 'twitter', '18920 Fredericka Burg', 'Zboncakville', 'Maine', 'United States', '92399', '2023-04-22 10:35:05'),
(36, 'Emmitt Stoltenberg', 'toys r us', '6186 Frances Wells', 'Port Kareembury', 'Arizona', 'United States', '38147', '2023-04-22 10:35:05'),
(37, 'Jena Robel', 'creekview', '735 Genevive Estate', 'West Stephenburgh', 'Connecticut', 'United States', '15249-8556', '2023-04-22 10:35:05'),
(38, 'Warner Beahan', 'twitter', '373 Howard Gateway', 'Emardborough', 'Idaho', 'United States', '47202-7565', '2023-04-22 10:35:05'),
(39, 'Wilton Rutherford', 'amazon', '3931 Kirlin Hills', 'Wizamouth', 'Montana', 'United States', '80850', '2023-04-22 10:35:05'),
(40, 'Sheri Thiel', 'the jump', '89703 Kris Crossroad', 'Walterton', 'Idaho', 'United States', '59649', '2023-04-22 10:35:05'),
(41, 'Nery Heidenreich', 'twitter', '146 MacGyver Trace', 'South Lucy', 'Idaho', 'United States', '79593', '2023-04-22 10:35:05'),
(42, 'Sol Kohler', 'creekview', '8624 Harber Rapid', 'Fredmouth', 'Colorado', 'United States', '42417', '2023-04-22 10:35:05'),
(43, 'Shane Rath', 'photomechanical', '89021 Shaneka Place', 'West Curtishaven', 'Minnesota', 'United States', '67559', '2023-04-22 10:35:05'),
(44, 'Shantell Howe', 'amazon', '6860 Hobert Prairie', 'West Roseanneton', 'Connecticut', 'United States', '40871-6114', '2023-04-22 10:35:05'),
(45, 'Antione Nolan', 'sports direct', '59888 Roderick Well', 'South Alfredburgh', 'Alaska', 'United States', '97318', '2023-04-22 10:35:05'),
(46, 'Lawrence Gislason', 'the jump', '8691 Lance Station', 'Schimmelmouth', 'Washington', 'United States', '36627', '2023-04-22 10:35:05'),
(47, 'Jim Ward', 'twitter', '604 West Camp', 'South Vitachester', 'Connecticut', 'United States', '95731-6254', '2023-04-22 10:35:05'),
(48, 'Florance Mertz', 'the jump', '625 Sherryl Inlet', 'Parkermouth', 'Oklahoma', 'United States', '73921', '2023-04-22 10:35:05'),
(49, 'Mike Crist', 'evapo', '953 Fay Lake', 'Kleinchester', 'Ohio', 'United States', '87932', '2023-04-22 10:35:05'),
(50, 'Kenyatta Hammes', 'vape lounge', '6959 Huel Forge', 'Donnellport', 'Ohio', 'United States', '40330-2155', '2023-04-22 10:35:05');

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
(1, 1, 1, '2023-04-22 10:35:04'),
(2, 1, 2, '2023-04-22 10:35:04'),
(3, 1, 3, '2023-04-22 10:35:04'),
(4, 1, 4, '2023-04-22 10:35:04'),
(5, 1, 5, '2023-04-22 10:35:04'),
(6, 2, 6, '2023-04-22 10:35:04'),
(7, 2, 7, '2023-04-22 10:35:04'),
(8, 2, 8, '2023-04-22 10:35:04'),
(9, 2, 9, '2023-04-22 10:35:04'),
(10, 2, 10, '2023-04-22 10:35:04'),
(11, 2, 11, '2023-04-22 10:35:04'),
(12, 3, 12, '2023-04-22 10:35:04'),
(13, 3, 13, '2023-04-22 10:35:04'),
(14, 3, 14, '2023-04-22 10:35:04'),
(15, 3, 15, '2023-04-22 10:35:04'),
(16, 3, 16, '2023-04-22 10:35:04'),
(17, 3, 17, '2023-04-22 10:35:04'),
(18, 3, 18, '2023-04-22 10:35:04'),
(19, 3, 19, '2023-04-22 10:35:04'),
(20, 4, 20, '2023-04-22 10:35:04'),
(21, 4, 21, '2023-04-22 10:35:04'),
(22, 4, 22, '2023-04-22 10:35:04'),
(23, 4, 23, '2023-04-22 10:35:04'),
(24, 4, 24, '2023-04-22 10:35:04'),
(25, 4, 25, '2023-04-22 10:35:04'),
(26, 5, 26, '2023-04-22 10:35:04'),
(27, 5, 27, '2023-04-22 10:35:04'),
(28, 5, 28, '2023-04-22 10:35:04'),
(29, 5, 29, '2023-04-22 10:35:04'),
(30, 5, 30, '2023-04-22 10:35:04'),
(31, 5, 31, '2023-04-22 10:35:04'),
(32, 6, 32, '2023-04-22 10:35:04'),
(33, 6, 33, '2023-04-22 10:35:04'),
(34, 6, 34, '2023-04-22 10:35:04'),
(35, 6, 35, '2023-04-22 10:35:04'),
(36, 6, 36, '2023-04-22 10:35:04'),
(37, 6, 37, '2023-04-22 10:35:04'),
(38, 6, 38, '2023-04-22 10:35:04'),
(39, 6, 39, '2023-04-22 10:35:04'),
(40, 6, 40, '2023-04-22 10:35:04'),
(41, 7, 41, '2023-04-22 10:35:04'),
(42, 7, 42, '2023-04-22 10:35:04'),
(43, 7, 43, '2023-04-22 10:35:04'),
(44, 7, 44, '2023-04-22 10:35:04'),
(45, 7, 45, '2023-04-22 10:35:04'),
(46, 7, 46, '2023-04-22 10:35:04'),
(47, 8, 47, '2023-04-22 10:35:04'),
(48, 8, 48, '2023-04-22 10:35:04'),
(49, 8, 49, '2023-04-22 10:35:04'),
(50, 8, 50, '2023-04-22 10:35:04'),
(51, 8, 51, '2023-04-22 10:35:04'),
(52, 8, 52, '2023-04-22 10:35:04'),
(53, 8, 53, '2023-04-22 10:35:04'),
(54, 8, 54, '2023-04-22 10:35:04'),
(55, 9, 55, '2023-04-22 10:35:04'),
(56, 9, 56, '2023-04-22 10:35:04'),
(57, 9, 57, '2023-04-22 10:35:04'),
(58, 9, 58, '2023-04-22 10:35:04'),
(59, 9, 59, '2023-04-22 10:35:04'),
(60, 9, 60, '2023-04-22 10:35:04'),
(61, 9, 61, '2023-04-22 10:35:04'),
(62, 9, 62, '2023-04-22 10:35:04'),
(63, 10, 63, '2023-04-22 10:35:05'),
(64, 10, 64, '2023-04-22 10:35:05'),
(65, 10, 65, '2023-04-22 10:35:05'),
(66, 10, 66, '2023-04-22 10:35:05'),
(67, 10, 67, '2023-04-22 10:35:05'),
(68, 11, 68, '2023-04-22 10:35:05'),
(69, 11, 69, '2023-04-22 10:35:05'),
(70, 11, 70, '2023-04-22 10:35:05'),
(71, 11, 71, '2023-04-22 10:35:05'),
(72, 11, 72, '2023-04-22 10:35:05'),
(73, 11, 73, '2023-04-22 10:35:05'),
(74, 11, 74, '2023-04-22 10:35:05'),
(75, 12, 75, '2023-04-22 10:35:05'),
(76, 12, 76, '2023-04-22 10:35:05'),
(77, 12, 77, '2023-04-22 10:35:05'),
(78, 12, 78, '2023-04-22 10:35:05'),
(79, 13, 79, '2023-04-22 10:35:05'),
(80, 13, 80, '2023-04-22 10:35:05'),
(81, 13, 81, '2023-04-22 10:35:05'),
(82, 13, 82, '2023-04-22 10:35:05'),
(83, 13, 83, '2023-04-22 10:35:05'),
(84, 13, 84, '2023-04-22 10:35:05'),
(85, 13, 85, '2023-04-22 10:35:05'),
(86, 14, 86, '2023-04-22 10:35:05'),
(87, 14, 87, '2023-04-22 10:35:05'),
(88, 14, 88, '2023-04-22 10:35:05'),
(89, 14, 89, '2023-04-22 10:35:05'),
(90, 14, 90, '2023-04-22 10:35:05'),
(91, 14, 91, '2023-04-22 10:35:05'),
(92, 14, 92, '2023-04-22 10:35:05'),
(93, 14, 93, '2023-04-22 10:35:05'),
(94, 14, 94, '2023-04-22 10:35:05'),
(95, 15, 95, '2023-04-22 10:35:05'),
(96, 15, 96, '2023-04-22 10:35:05'),
(97, 15, 97, '2023-04-22 10:35:05'),
(98, 15, 98, '2023-04-22 10:35:05'),
(99, 15, 99, '2023-04-22 10:35:05'),
(100, 15, 100, '2023-04-22 10:35:05'),
(101, 15, 101, '2023-04-22 10:35:05'),
(102, 15, 102, '2023-04-22 10:35:05'),
(103, 15, 103, '2023-04-22 10:35:05'),
(104, 16, 104, '2023-04-22 10:35:05'),
(105, 16, 105, '2023-04-22 10:35:05'),
(106, 16, 106, '2023-04-22 10:35:05'),
(107, 16, 107, '2023-04-22 10:35:05'),
(108, 16, 108, '2023-04-22 10:35:05'),
(109, 17, 109, '2023-04-22 10:35:05'),
(110, 17, 110, '2023-04-22 10:35:05'),
(111, 17, 111, '2023-04-22 10:35:05'),
(112, 17, 112, '2023-04-22 10:35:05'),
(113, 17, 113, '2023-04-22 10:35:05'),
(114, 17, 114, '2023-04-22 10:35:05'),
(115, 18, 115, '2023-04-22 10:35:05'),
(116, 18, 116, '2023-04-22 10:35:05'),
(117, 19, 117, '2023-04-22 10:35:05'),
(118, 19, 118, '2023-04-22 10:35:05'),
(119, 19, 119, '2023-04-22 10:35:05'),
(120, 19, 120, '2023-04-22 10:35:05'),
(121, 19, 121, '2023-04-22 10:35:05'),
(122, 19, 122, '2023-04-22 10:35:05'),
(123, 19, 123, '2023-04-22 10:35:05'),
(124, 19, 124, '2023-04-22 10:35:05'),
(125, 19, 125, '2023-04-22 10:35:05'),
(126, 20, 126, '2023-04-22 10:35:05'),
(127, 20, 127, '2023-04-22 10:35:05'),
(128, 20, 128, '2023-04-22 10:35:05'),
(129, 20, 129, '2023-04-22 10:35:05'),
(130, 20, 130, '2023-04-22 10:35:05'),
(131, 20, 131, '2023-04-22 10:35:05'),
(132, 20, 132, '2023-04-22 10:35:05'),
(133, 21, 133, '2023-04-22 10:35:05'),
(134, 21, 134, '2023-04-22 10:35:05'),
(135, 22, 135, '2023-04-22 10:35:05'),
(136, 22, 136, '2023-04-22 10:35:05'),
(137, 22, 137, '2023-04-22 10:35:05'),
(138, 22, 138, '2023-04-22 10:35:05'),
(139, 22, 139, '2023-04-22 10:35:05'),
(140, 22, 140, '2023-04-22 10:35:05'),
(141, 23, 141, '2023-04-22 10:35:05'),
(142, 23, 142, '2023-04-22 10:35:05'),
(143, 23, 143, '2023-04-22 10:35:05'),
(144, 23, 144, '2023-04-22 10:35:05'),
(145, 23, 145, '2023-04-22 10:35:05'),
(146, 23, 146, '2023-04-22 10:35:05'),
(147, 23, 147, '2023-04-22 10:35:05'),
(148, 23, 148, '2023-04-22 10:35:05'),
(149, 24, 149, '2023-04-22 10:35:05'),
(150, 24, 150, '2023-04-22 10:35:05'),
(151, 25, 151, '2023-04-22 10:35:05'),
(152, 25, 152, '2023-04-22 10:35:05'),
(153, 25, 153, '2023-04-22 10:35:05'),
(154, 25, 154, '2023-04-22 10:35:05'),
(155, 25, 155, '2023-04-22 10:35:05'),
(156, 26, 156, '2023-04-22 10:35:05'),
(157, 26, 157, '2023-04-22 10:35:05'),
(158, 26, 158, '2023-04-22 10:35:05'),
(159, 26, 159, '2023-04-22 10:35:05'),
(160, 27, 160, '2023-04-22 10:35:05'),
(161, 27, 161, '2023-04-22 10:35:05'),
(162, 27, 162, '2023-04-22 10:35:05'),
(163, 27, 163, '2023-04-22 10:35:05'),
(164, 27, 164, '2023-04-22 10:35:05'),
(165, 27, 165, '2023-04-22 10:35:05'),
(166, 27, 166, '2023-04-22 10:35:05'),
(167, 27, 167, '2023-04-22 10:35:05'),
(168, 27, 168, '2023-04-22 10:35:05'),
(169, 28, 169, '2023-04-22 10:35:05'),
(170, 28, 170, '2023-04-22 10:35:05'),
(171, 28, 171, '2023-04-22 10:35:05'),
(172, 29, 172, '2023-04-22 10:35:05'),
(173, 29, 173, '2023-04-22 10:35:05'),
(174, 29, 174, '2023-04-22 10:35:05'),
(175, 29, 175, '2023-04-22 10:35:05'),
(176, 30, 176, '2023-04-22 10:35:05'),
(177, 30, 177, '2023-04-22 10:35:05'),
(178, 30, 178, '2023-04-22 10:35:05'),
(179, 30, 179, '2023-04-22 10:35:05'),
(180, 31, 180, '2023-04-22 10:35:05'),
(181, 31, 181, '2023-04-22 10:35:05'),
(182, 31, 182, '2023-04-22 10:35:05'),
(183, 31, 183, '2023-04-22 10:35:05'),
(184, 31, 184, '2023-04-22 10:35:05'),
(185, 31, 185, '2023-04-22 10:35:05'),
(186, 31, 186, '2023-04-22 10:35:05'),
(187, 31, 187, '2023-04-22 10:35:05'),
(188, 31, 188, '2023-04-22 10:35:05'),
(189, 32, 189, '2023-04-22 10:35:05'),
(190, 32, 190, '2023-04-22 10:35:05'),
(191, 32, 191, '2023-04-22 10:35:05'),
(192, 32, 192, '2023-04-22 10:35:05'),
(193, 33, 193, '2023-04-22 10:35:05'),
(194, 33, 194, '2023-04-22 10:35:05'),
(195, 33, 195, '2023-04-22 10:35:05'),
(196, 33, 196, '2023-04-22 10:35:05'),
(197, 34, 197, '2023-04-22 10:35:05'),
(198, 34, 198, '2023-04-22 10:35:05'),
(199, 34, 199, '2023-04-22 10:35:05'),
(200, 34, 200, '2023-04-22 10:35:05'),
(201, 34, 201, '2023-04-22 10:35:05'),
(202, 34, 202, '2023-04-22 10:35:05'),
(203, 34, 203, '2023-04-22 10:35:05'),
(204, 35, 204, '2023-04-22 10:35:05'),
(205, 35, 205, '2023-04-22 10:35:05'),
(206, 35, 206, '2023-04-22 10:35:05'),
(207, 35, 207, '2023-04-22 10:35:05'),
(208, 35, 208, '2023-04-22 10:35:05'),
(209, 35, 209, '2023-04-22 10:35:05'),
(210, 35, 210, '2023-04-22 10:35:05'),
(211, 35, 211, '2023-04-22 10:35:05'),
(212, 35, 212, '2023-04-22 10:35:05'),
(213, 36, 213, '2023-04-22 10:35:05'),
(214, 36, 214, '2023-04-22 10:35:05'),
(215, 36, 215, '2023-04-22 10:35:05'),
(216, 36, 216, '2023-04-22 10:35:05'),
(217, 36, 217, '2023-04-22 10:35:05'),
(218, 36, 218, '2023-04-22 10:35:05'),
(219, 36, 219, '2023-04-22 10:35:05'),
(220, 37, 220, '2023-04-22 10:35:05'),
(221, 37, 221, '2023-04-22 10:35:05'),
(222, 38, 222, '2023-04-22 10:35:05'),
(223, 38, 223, '2023-04-22 10:35:05'),
(224, 38, 224, '2023-04-22 10:35:05'),
(225, 38, 225, '2023-04-22 10:35:05'),
(226, 38, 226, '2023-04-22 10:35:05'),
(227, 39, 227, '2023-04-22 10:35:05'),
(228, 39, 228, '2023-04-22 10:35:05'),
(229, 40, 229, '2023-04-22 10:35:05'),
(230, 40, 230, '2023-04-22 10:35:05'),
(231, 40, 231, '2023-04-22 10:35:05'),
(232, 40, 232, '2023-04-22 10:35:05'),
(233, 40, 233, '2023-04-22 10:35:05'),
(234, 40, 234, '2023-04-22 10:35:05'),
(235, 40, 235, '2023-04-22 10:35:05'),
(236, 41, 236, '2023-04-22 10:35:05'),
(237, 41, 237, '2023-04-22 10:35:05'),
(238, 41, 238, '2023-04-22 10:35:05'),
(239, 41, 239, '2023-04-22 10:35:05'),
(240, 41, 240, '2023-04-22 10:35:05'),
(241, 41, 241, '2023-04-22 10:35:05'),
(242, 42, 242, '2023-04-22 10:35:05'),
(243, 42, 243, '2023-04-22 10:35:05'),
(244, 43, 244, '2023-04-22 10:35:05'),
(245, 43, 245, '2023-04-22 10:35:05'),
(246, 43, 246, '2023-04-22 10:35:05'),
(247, 43, 247, '2023-04-22 10:35:05'),
(248, 43, 248, '2023-04-22 10:35:05'),
(249, 43, 249, '2023-04-22 10:35:05'),
(250, 43, 250, '2023-04-22 10:35:05'),
(251, 44, 251, '2023-04-22 10:35:05'),
(252, 44, 252, '2023-04-22 10:35:05'),
(253, 44, 253, '2023-04-22 10:35:05'),
(254, 44, 254, '2023-04-22 10:35:05'),
(255, 44, 255, '2023-04-22 10:35:05'),
(256, 44, 256, '2023-04-22 10:35:05'),
(257, 45, 257, '2023-04-22 10:35:05'),
(258, 45, 258, '2023-04-22 10:35:05'),
(259, 45, 259, '2023-04-22 10:35:05'),
(260, 45, 260, '2023-04-22 10:35:05'),
(261, 45, 261, '2023-04-22 10:35:05'),
(262, 46, 262, '2023-04-22 10:35:05'),
(263, 46, 263, '2023-04-22 10:35:05'),
(264, 46, 264, '2023-04-22 10:35:05'),
(265, 46, 265, '2023-04-22 10:35:05'),
(266, 46, 266, '2023-04-22 10:35:05'),
(267, 46, 267, '2023-04-22 10:35:05'),
(268, 46, 268, '2023-04-22 10:35:05'),
(269, 47, 269, '2023-04-22 10:35:05'),
(270, 47, 270, '2023-04-22 10:35:05'),
(271, 47, 271, '2023-04-22 10:35:05'),
(272, 47, 272, '2023-04-22 10:35:05'),
(273, 48, 273, '2023-04-22 10:35:05'),
(274, 48, 274, '2023-04-22 10:35:05'),
(275, 49, 275, '2023-04-22 10:35:05'),
(276, 49, 276, '2023-04-22 10:35:05'),
(277, 49, 277, '2023-04-22 10:35:05'),
(278, 49, 278, '2023-04-22 10:35:05'),
(279, 49, 279, '2023-04-22 10:35:05'),
(280, 49, 280, '2023-04-22 10:35:05'),
(281, 49, 281, '2023-04-22 10:35:05'),
(282, 49, 282, '2023-04-22 10:35:05'),
(283, 49, 283, '2023-04-22 10:35:05'),
(284, 50, 284, '2023-04-22 10:35:05'),
(285, 50, 285, '2023-04-22 10:35:05'),
(286, 50, 286, '2023-04-22 10:35:05'),
(287, 50, 287, '2023-04-22 10:35:05'),
(288, 50, 288, '2023-04-22 10:35:05'),
(289, 50, 289, '2023-04-22 10:35:05'),
(290, 50, 290, '2023-04-22 10:35:05'),
(291, 50, 291, '2023-04-22 10:35:05'),
(292, 50, 292, '2023-04-22 10:35:05');

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
(1, 'Toaster and toaster ovens', 'this would be a user description', 9359, 49, 3, '2023-04-22 10:35:04'),
(2, 'Tie press', 'this would be a user description', 6879, 12, 11, '2023-04-22 10:35:04'),
(3, 'Beverage opener', 'this would be a user description', 9715, 16, 9, '2023-04-22 10:35:04'),
(4, 'Humidifier', 'this would be a user description', 7715, 93, 7, '2023-04-22 10:35:04'),
(5, 'Hair dryer', 'this would be a user description', 8582, 59, 2, '2023-04-22 10:35:04'),
(6, 'Clothes iron', 'this would be a user description', 775, 20, 9, '2023-04-22 10:35:04'),
(7, 'Stove', 'this would be a user description', 8900, 39, 4, '2023-04-22 10:35:04'),
(8, 'Dishwasher', 'this would be a user description', 1281, 49, 6, '2023-04-22 10:35:04'),
(9, 'Forced-air', 'this would be a user description', 6698, 69, 2, '2023-04-22 10:35:04'),
(10, 'Humidifier', 'this would be a user description', 6322, 20, 9, '2023-04-22 10:35:04'),
(11, 'HVAC', 'this would be a user description', 2363, 30, 3, '2023-04-22 10:35:04'),
(12, 'Clothes iron', 'this would be a user description', 9531, 63, 3, '2023-04-22 10:35:04'),
(13, 'Forced-air', 'this would be a user description', 256, 90, 2, '2023-04-22 10:35:04'),
(14, 'Go-to-bed matchbox', 'this would be a user description', 2675, 56, 11, '2023-04-22 10:35:04'),
(15, 'Hair dryer', 'this would be a user description', 7367, 52, 5, '2023-04-22 10:35:04'),
(16, 'Exhaust hood', 'this would be a user description', 1904, 15, 9, '2023-04-22 10:35:04'),
(17, 'Solar water heater', 'this would be a user description', 8122, 65, 10, '2023-04-22 10:35:04'),
(18, 'Ceiling fan', 'this would be a user description', 6562, 44, 1, '2023-04-22 10:35:04'),
(19, 'Domestic robot', 'this would be a user description', 2895, 32, 7, '2023-04-22 10:35:04'),
(20, 'HVAC', 'this would be a user description', 1668, 75, 4, '2023-04-22 10:35:04'),
(21, 'Mousetrap', 'this would be a user description', 6127, 97, 0, '2023-04-22 10:35:04'),
(22, 'Appliance plug', 'this would be a user description', 8198, 10, 9, '2023-04-22 10:35:04'),
(23, 'Electric water boiler', 'this would be a user description', 9338, 90, 7, '2023-04-22 10:35:04'),
(24, 'Bachelor griller', 'this would be a user description', 2601, 78, 2, '2023-04-22 10:35:04'),
(25, 'Window fan', 'this would be a user description', 8442, 76, 7, '2023-04-22 10:35:04'),
(26, 'Combo washer dryer', 'this would be a user description', 5569, 27, 1, '2023-04-22 10:35:04'),
(27, 'Washing machine', 'this would be a user description', 1132, 46, 4, '2023-04-22 10:35:04'),
(28, 'Vacuum cleaner', 'this would be a user description', 8047, 53, 4, '2023-04-22 10:35:04'),
(29, 'Forced-air', 'this would be a user description', 6902, 40, 9, '2023-04-22 10:35:04'),
(30, 'Sump pump', 'this would be a user description', 5734, 83, 9, '2023-04-22 10:35:04'),
(31, 'Hair dryer', 'this would be a user description', 2348, 12, 9, '2023-04-22 10:35:04'),
(32, 'Exhaust hood', 'this would be a user description', 7781, 3, 0, '2023-04-22 10:35:04'),
(33, 'Domestic robot', 'this would be a user description', 9088, 50, 6, '2023-04-22 10:35:04'),
(34, 'Hair iron', 'this would be a user description', 355, 85, 11, '2023-04-22 10:35:04'),
(35, 'Box mangle', 'this would be a user description', 9115, 81, 8, '2023-04-22 10:35:04'),
(36, 'Humidifier', 'this would be a user description', 7913, 2, 8, '2023-04-22 10:35:04'),
(37, 'Washing machine', 'this would be a user description', 5108, 25, 6, '2023-04-22 10:35:04'),
(38, 'Mousetrap', 'this would be a user description', 4390, 45, 6, '2023-04-22 10:35:04'),
(39, 'Appliance plug', 'this would be a user description', 4044, 91, 2, '2023-04-22 10:35:04'),
(40, 'Hob (hearth)', 'this would be a user description', 5419, 93, 3, '2023-04-22 10:35:04'),
(41, 'Humidifier', 'this would be a user description', 9514, 36, 5, '2023-04-22 10:35:04'),
(42, 'Hob (hearth)', 'this would be a user description', 4800, 25, 2, '2023-04-22 10:35:04'),
(43, 'Toaster and toaster ovens', 'this would be a user description', 6737, 96, 5, '2023-04-22 10:35:04'),
(44, 'Appliance plug', 'this would be a user description', 2270, 92, 4, '2023-04-22 10:35:04'),
(45, 'Humidifier', 'this would be a user description', 689, 99, 0, '2023-04-22 10:35:04'),
(46, 'Tie press', 'this would be a user description', 8204, 1, 0, '2023-04-22 10:35:04'),
(47, 'HVAC', 'this would be a user description', 5856, 2, 9, '2023-04-22 10:35:04'),
(48, 'Humidifier', 'this would be a user description', 5400, 23, 2, '2023-04-22 10:35:04'),
(49, 'Mousetrap', 'this would be a user description', 1933, 84, 1, '2023-04-22 10:35:04'),
(50, 'Space heater', 'this would be a user description', 9277, 52, 2, '2023-04-22 10:35:04'),
(51, 'Flame supervision device', 'this would be a user description', 1546, 47, 0, '2023-04-22 10:35:04'),
(52, 'Futon dryer', 'this would be a user description', 6454, 53, 8, '2023-04-22 10:35:04'),
(53, 'Hob (hearth)', 'this would be a user description', 9800, 73, 8, '2023-04-22 10:35:04'),
(54, 'Home server', 'this would be a user description', 6953, 19, 0, '2023-04-22 10:35:04'),
(55, 'Humidifier', 'this would be a user description', 7996, 76, 8, '2023-04-22 10:35:04'),
(56, 'Vacuum cleaner', 'this would be a user description', 8151, 77, 0, '2023-04-22 10:35:04'),
(57, 'Air purifier', 'this would be a user description', 4142, 29, 5, '2023-04-22 10:35:04'),
(58, 'Stove', 'this would be a user description', 2511, 62, 5, '2023-04-22 10:35:04'),
(59, 'Stove', 'this would be a user description', 8330, 63, 11, '2023-04-22 10:35:04'),
(60, 'Space heater', 'this would be a user description', 9723, 65, 11, '2023-04-22 10:35:04'),
(61, 'Futon dryer', 'this would be a user description', 3723, 94, 0, '2023-04-22 10:35:04'),
(62, 'Oven', 'this would be a user description', 1994, 55, 11, '2023-04-22 10:35:04'),
(63, 'Tie press', 'this would be a user description', 5454, 48, 4, '2023-04-22 10:35:04'),
(64, 'Home server', 'this would be a user description', 9820, 41, 1, '2023-04-22 10:35:04'),
(65, 'Steam mop', 'this would be a user description', 2472, 51, 6, '2023-04-22 10:35:04'),
(66, 'Toaster and toaster ovens', 'this would be a user description', 7763, 91, 0, '2023-04-22 10:35:04'),
(67, 'Futon dryer', 'this would be a user description', 471, 74, 1, '2023-04-22 10:35:04'),
(68, 'Air ioniser', 'this would be a user description', 3681, 3, 8, '2023-04-22 10:35:05'),
(69, 'Oil heater', 'this would be a user description', 1334, 97, 5, '2023-04-22 10:35:05'),
(70, 'Water purifier', 'this would be a user description', 7020, 41, 8, '2023-04-22 10:35:05'),
(71, 'Dish draining closet', 'this would be a user description', 8655, 44, 4, '2023-04-22 10:35:05'),
(72, 'Drawer dishwasher', 'this would be a user description', 9839, 13, 4, '2023-04-22 10:35:05'),
(73, 'Forced-air', 'this would be a user description', 6437, 69, 10, '2023-04-22 10:35:05'),
(74, 'Domestic robot', 'this would be a user description', 7499, 70, 4, '2023-04-22 10:35:05'),
(75, 'Back boiler', 'this would be a user description', 5243, 60, 9, '2023-04-22 10:35:05'),
(76, 'Exhaust hood', 'this would be a user description', 2602, 2, 11, '2023-04-22 10:35:05'),
(77, 'Central vacuum cleaner', 'this would be a user description', 8592, 96, 1, '2023-04-22 10:35:05'),
(78, 'Domestic robot', 'this would be a user description', 4180, 87, 6, '2023-04-22 10:35:05'),
(79, 'Television', 'this would be a user description', 9340, 8, 5, '2023-04-22 10:35:05'),
(80, 'HVAC', 'this would be a user description', 2012, 45, 6, '2023-04-22 10:35:05'),
(81, 'Hair dryer', 'this would be a user description', 3178, 15, 11, '2023-04-22 10:35:05'),
(82, 'Washing machine', 'this would be a user description', 2228, 43, 0, '2023-04-22 10:35:05'),
(83, 'Can opener', 'this would be a user description', 2014, 61, 8, '2023-04-22 10:35:05'),
(84, 'Window fan', 'this would be a user description', 3690, 33, 3, '2023-04-22 10:35:05'),
(85, 'Beverage opener', 'this would be a user description', 4575, 18, 1, '2023-04-22 10:35:05'),
(86, 'Air purifier', 'this would be a user description', 7826, 25, 10, '2023-04-22 10:35:05'),
(87, 'Appliance plug', 'this would be a user description', 6872, 85, 7, '2023-04-22 10:35:05'),
(88, 'Clothes iron', 'this would be a user description', 7356, 34, 11, '2023-04-22 10:35:05'),
(89, 'Beverage opener', 'this would be a user description', 2103, 5, 10, '2023-04-22 10:35:05'),
(90, 'Cold-pressed juicer', 'this would be a user description', 2763, 30, 9, '2023-04-22 10:35:05'),
(91, 'Electric water boiler', 'this would be a user description', 2910, 88, 2, '2023-04-22 10:35:05'),
(92, 'Combo washer dryer', 'this would be a user description', 1360, 15, 5, '2023-04-22 10:35:05'),
(93, 'Hair dryer', 'this would be a user description', 5016, 10, 6, '2023-04-22 10:35:05'),
(94, 'Solar water heater', 'this would be a user description', 2002, 59, 10, '2023-04-22 10:35:05'),
(95, 'Solar water heater', 'this would be a user description', 8605, 40, 11, '2023-04-22 10:35:05'),
(96, 'Gas appliance', 'this would be a user description', 6586, 54, 5, '2023-04-22 10:35:05'),
(97, 'Central vacuum cleaner', 'this would be a user description', 1568, 81, 7, '2023-04-22 10:35:05'),
(98, 'Trouser press', 'this would be a user description', 6798, 6, 7, '2023-04-22 10:35:05'),
(99, 'Window fan', 'this would be a user description', 3296, 9, 1, '2023-04-22 10:35:05'),
(100, 'Domestic robot', 'this would be a user description', 1699, 23, 0, '2023-04-22 10:35:05'),
(101, 'Can opener', 'this would be a user description', 1240, 48, 4, '2023-04-22 10:35:05'),
(102, 'Attic fan', 'this would be a user description', 9014, 61, 6, '2023-04-22 10:35:05'),
(103, 'Kimchi refrigerator', 'this would be a user description', 1661, 54, 3, '2023-04-22 10:35:05'),
(104, 'Water purifier', 'this would be a user description', 431, 48, 6, '2023-04-22 10:35:05'),
(105, 'Kimchi refrigerator', 'this would be a user description', 5093, 45, 1, '2023-04-22 10:35:05'),
(106, 'Mousetrap', 'this would be a user description', 7655, 94, 7, '2023-04-22 10:35:05'),
(107, 'Mousetrap', 'this would be a user description', 4693, 22, 0, '2023-04-22 10:35:05'),
(108, 'Stove', 'this would be a user description', 4883, 71, 10, '2023-04-22 10:35:05'),
(109, 'Humidifier', 'this would be a user description', 728, 91, 3, '2023-04-22 10:35:05'),
(110, 'Oven', 'this would be a user description', 5508, 74, 2, '2023-04-22 10:35:05'),
(111, 'Sump pump', 'this would be a user description', 5931, 96, 6, '2023-04-22 10:35:05'),
(112, 'Central vacuum cleaner', 'this would be a user description', 2378, 88, 0, '2023-04-22 10:35:05'),
(113, 'Oven', 'this would be a user description', 6328, 62, 0, '2023-04-22 10:35:05'),
(114, 'Toaster and toaster ovens', 'this would be a user description', 6227, 69, 11, '2023-04-22 10:35:05'),
(115, 'Paper shredder', 'this would be a user description', 7969, 27, 1, '2023-04-22 10:35:05'),
(116, 'Patio heater', 'this would be a user description', 8623, 64, 1, '2023-04-22 10:35:05'),
(117, 'Dishwasher', 'this would be a user description', 5185, 23, 5, '2023-04-22 10:35:05'),
(118, 'Microwave oven', 'this would be a user description', 5616, 86, 10, '2023-04-22 10:35:05'),
(119, 'Drawer dishwasher', 'this would be a user description', 8011, 89, 8, '2023-04-22 10:35:05'),
(120, 'Evaporative cooler', 'this would be a user description', 429, 68, 7, '2023-04-22 10:35:05'),
(121, 'Solar water heater', 'this would be a user description', 348, 47, 5, '2023-04-22 10:35:05'),
(122, 'Forced-air', 'this would be a user description', 396, 41, 8, '2023-04-22 10:35:05'),
(123, 'Hair iron', 'this would be a user description', 6148, 80, 0, '2023-04-22 10:35:05'),
(124, 'Microwave oven', 'this would be a user description', 5368, 58, 11, '2023-04-22 10:35:05'),
(125, 'Mangle (machine)', 'this would be a user description', 9774, 36, 11, '2023-04-22 10:35:05'),
(126, 'Solar water heater', 'this would be a user description', 8285, 97, 9, '2023-04-22 10:35:05'),
(127, 'Back boiler', 'this would be a user description', 6805, 14, 7, '2023-04-22 10:35:05'),
(128, 'Air ioniser', 'this would be a user description', 9783, 68, 6, '2023-04-22 10:35:05'),
(129, 'Toaster and toaster ovens', 'this would be a user description', 4896, 70, 10, '2023-04-22 10:35:05'),
(130, 'Sewing machine', 'this would be a user description', 5279, 2, 6, '2023-04-22 10:35:05'),
(131, 'Oven', 'this would be a user description', 6196, 60, 7, '2023-04-22 10:35:05'),
(132, 'Electric water boiler', 'this would be a user description', 4099, 70, 5, '2023-04-22 10:35:05'),
(133, 'Oven', 'this would be a user description', 4575, 12, 11, '2023-04-22 10:35:05'),
(134, 'Ceiling fan', 'this would be a user description', 1036, 2, 9, '2023-04-22 10:35:05'),
(135, 'Patio heater', 'this would be a user description', 5033, 54, 3, '2023-04-22 10:35:05'),
(136, 'Back boiler', 'this would be a user description', 4394, 39, 0, '2023-04-22 10:35:05'),
(137, 'Radiator (heating)', 'this would be a user description', 4786, 21, 4, '2023-04-22 10:35:05'),
(138, 'Ceiling fan', 'this would be a user description', 9182, 72, 7, '2023-04-22 10:35:05'),
(139, 'Dish draining closet', 'this would be a user description', 2151, 91, 6, '2023-04-22 10:35:05'),
(140, 'Can opener', 'this would be a user description', 768, 9, 0, '2023-04-22 10:35:05'),
(141, 'Beverage opener', 'this would be a user description', 4778, 30, 11, '2023-04-22 10:35:05'),
(142, 'Box mangle', 'this would be a user description', 3702, 61, 1, '2023-04-22 10:35:05'),
(143, 'Dishwasher', 'this would be a user description', 2388, 93, 10, '2023-04-22 10:35:05'),
(144, 'Trouser press', 'this would be a user description', 9488, 95, 0, '2023-04-22 10:35:05'),
(145, 'Central vacuum cleaner', 'this would be a user description', 9157, 12, 3, '2023-04-22 10:35:05'),
(146, 'Electric water boiler', 'this would be a user description', 463, 35, 6, '2023-04-22 10:35:05'),
(147, 'Beverage opener', 'this would be a user description', 8823, 54, 9, '2023-04-22 10:35:05'),
(148, 'Aroma lamp', 'this would be a user description', 748, 99, 11, '2023-04-22 10:35:05'),
(149, 'Hob (hearth)', 'this would be a user description', 7391, 71, 11, '2023-04-22 10:35:05'),
(150, 'Drawer dishwasher', 'this would be a user description', 8117, 99, 7, '2023-04-22 10:35:05'),
(151, 'Blender', 'this would be a user description', 532, 96, 6, '2023-04-22 10:35:05'),
(152, 'Garbage disposal unit', 'this would be a user description', 9242, 13, 7, '2023-04-22 10:35:05'),
(153, 'Futon dryer', 'this would be a user description', 5694, 92, 11, '2023-04-22 10:35:05'),
(154, 'Central vacuum cleaner', 'this would be a user description', 9139, 4, 9, '2023-04-22 10:35:05'),
(155, 'HVAC', 'this would be a user description', 3464, 31, 3, '2023-04-22 10:35:05'),
(156, 'Domestic robot', 'this would be a user description', 9385, 62, 9, '2023-04-22 10:35:05'),
(157, 'Water heater', 'this would be a user description', 9120, 56, 8, '2023-04-22 10:35:05'),
(158, 'Television', 'this would be a user description', 174, 76, 3, '2023-04-22 10:35:05'),
(159, 'Fan heater', 'this would be a user description', 7747, 31, 1, '2023-04-22 10:35:05'),
(160, 'Combo washer dryer', 'this would be a user description', 8711, 25, 6, '2023-04-22 10:35:05'),
(161, 'Bachelor griller', 'this would be a user description', 9050, 93, 7, '2023-04-22 10:35:05'),
(162, 'Evaporative cooler', 'this would be a user description', 6419, 53, 7, '2023-04-22 10:35:05'),
(163, 'Vacuum cleaner', 'this would be a user description', 3280, 72, 3, '2023-04-22 10:35:05'),
(164, 'Humidifier', 'this would be a user description', 5367, 84, 8, '2023-04-22 10:35:05'),
(165, 'Television', 'this would be a user description', 9934, 92, 0, '2023-04-22 10:35:05'),
(166, 'Combo washer dryer', 'this would be a user description', 1743, 5, 0, '2023-04-22 10:35:05'),
(167, 'Bachelor griller', 'this would be a user description', 9146, 5, 8, '2023-04-22 10:35:05'),
(168, 'Water cooker', 'this would be a user description', 1294, 91, 11, '2023-04-22 10:35:05'),
(169, 'Can opener', 'this would be a user description', 7178, 64, 11, '2023-04-22 10:35:05'),
(170, 'Clothes dryer', 'this would be a user description', 2853, 82, 9, '2023-04-22 10:35:05'),
(171, 'Gas appliance', 'this would be a user description', 2020, 5, 1, '2023-04-22 10:35:05'),
(172, 'Fan heater', 'this would be a user description', 9535, 45, 11, '2023-04-22 10:35:05'),
(173, 'Hob (hearth)', 'this would be a user description', 7642, 25, 5, '2023-04-22 10:35:05'),
(174, 'Space heater', 'this would be a user description', 7784, 31, 10, '2023-04-22 10:35:05'),
(175, 'Sewing machine', 'this would be a user description', 3713, 41, 0, '2023-04-22 10:35:05'),
(176, 'Sewing machine', 'this would be a user description', 4482, 39, 6, '2023-04-22 10:35:05'),
(177, 'Air purifier', 'this would be a user description', 137, 3, 5, '2023-04-22 10:35:05'),
(178, 'Icebox', 'this would be a user description', 1537, 77, 6, '2023-04-22 10:35:05'),
(179, 'Paper shredder', 'this would be a user description', 1983, 95, 10, '2023-04-22 10:35:05'),
(180, 'Toaster and toaster ovens', 'this would be a user description', 4950, 86, 4, '2023-04-22 10:35:05'),
(181, 'Icebox', 'this would be a user description', 2143, 63, 9, '2023-04-22 10:35:05'),
(182, 'Central vacuum cleaner', 'this would be a user description', 7006, 61, 6, '2023-04-22 10:35:05'),
(183, 'Hair iron', 'this would be a user description', 1985, 92, 6, '2023-04-22 10:35:05'),
(184, 'Water heater', 'this would be a user description', 6182, 46, 5, '2023-04-22 10:35:05'),
(185, 'Paper shredder', 'this would be a user description', 1195, 3, 3, '2023-04-22 10:35:05'),
(186, 'Oil heater', 'this would be a user description', 2489, 85, 0, '2023-04-22 10:35:05'),
(187, 'Sewing machine', 'this would be a user description', 9406, 69, 6, '2023-04-22 10:35:05'),
(188, 'Back boiler', 'this would be a user description', 4738, 48, 8, '2023-04-22 10:35:05'),
(189, 'Garbage disposal unit', 'this would be a user description', 1980, 61, 10, '2023-04-22 10:35:05'),
(190, 'Mangle (machine)', 'this would be a user description', 3822, 49, 11, '2023-04-22 10:35:05'),
(191, 'Garbage disposal unit', 'this would be a user description', 5315, 38, 0, '2023-04-22 10:35:05'),
(192, 'Gas appliance', 'this would be a user description', 6074, 45, 2, '2023-04-22 10:35:05'),
(193, 'Toaster and toaster ovens', 'this would be a user description', 9413, 39, 0, '2023-04-22 10:35:05'),
(194, 'Vacuum cleaner', 'this would be a user description', 7369, 21, 10, '2023-04-22 10:35:05'),
(195, 'Hair dryer', 'this would be a user description', 8891, 56, 3, '2023-04-22 10:35:05'),
(196, 'Water purifier', 'this would be a user description', 1143, 96, 7, '2023-04-22 10:35:05'),
(197, 'Microwave oven', 'this would be a user description', 9605, 20, 5, '2023-04-22 10:35:05'),
(198, 'Steam mop', 'this would be a user description', 7908, 11, 8, '2023-04-22 10:35:05'),
(199, 'Drawer dishwasher', 'this would be a user description', 2483, 95, 8, '2023-04-22 10:35:05'),
(200, 'Stove', 'this would be a user description', 1599, 26, 3, '2023-04-22 10:35:05'),
(201, 'Clothes iron', 'this would be a user description', 9884, 97, 2, '2023-04-22 10:35:05'),
(202, 'Stove', 'this would be a user description', 6352, 10, 0, '2023-04-22 10:35:05'),
(203, 'Appliance plug', 'this would be a user description', 4051, 62, 9, '2023-04-22 10:35:05'),
(204, 'Water purifier', 'this would be a user description', 7994, 74, 6, '2023-04-22 10:35:05'),
(205, 'Mousetrap', 'this would be a user description', 6874, 70, 7, '2023-04-22 10:35:05'),
(206, 'HVAC', 'this would be a user description', 2947, 48, 3, '2023-04-22 10:35:05'),
(207, 'Trouser press', 'this would be a user description', 6171, 4, 6, '2023-04-22 10:35:05'),
(208, 'Hob (hearth)', 'this would be a user description', 1758, 33, 3, '2023-04-22 10:35:05'),
(209, 'Humidifier', 'this would be a user description', 314, 13, 5, '2023-04-22 10:35:05'),
(210, 'Window fan', 'this would be a user description', 7248, 71, 0, '2023-04-22 10:35:05'),
(211, 'Combo washer dryer', 'this would be a user description', 3689, 44, 5, '2023-04-22 10:35:05'),
(212, 'Appliance plug', 'this would be a user description', 2817, 52, 6, '2023-04-22 10:35:05'),
(213, 'Humidifier', 'this would be a user description', 3904, 4, 8, '2023-04-22 10:35:05'),
(214, 'Stove', 'this would be a user description', 6862, 43, 9, '2023-04-22 10:35:05'),
(215, 'Garbage disposal unit', 'this would be a user description', 4925, 37, 4, '2023-04-22 10:35:05'),
(216, 'Water cooker', 'this would be a user description', 1855, 10, 8, '2023-04-22 10:35:05'),
(217, 'Water purifier', 'this would be a user description', 7607, 94, 4, '2023-04-22 10:35:05'),
(218, 'Box mangle', 'this would be a user description', 3089, 40, 6, '2023-04-22 10:35:05'),
(219, 'Hob (hearth)', 'this would be a user description', 3790, 67, 0, '2023-04-22 10:35:05'),
(220, 'Sump pump', 'this would be a user description', 9621, 78, 4, '2023-04-22 10:35:05'),
(221, 'Microwave oven', 'this would be a user description', 2536, 99, 4, '2023-04-22 10:35:05'),
(222, 'Washing machine', 'this would be a user description', 8389, 45, 2, '2023-04-22 10:35:05'),
(223, 'Sump pump', 'this would be a user description', 1777, 7, 0, '2023-04-22 10:35:05'),
(224, 'Forced-air', 'this would be a user description', 6255, 99, 9, '2023-04-22 10:35:05'),
(225, 'Appliance plug', 'this would be a user description', 8566, 24, 3, '2023-04-22 10:35:05'),
(226, 'Home server', 'this would be a user description', 8536, 82, 11, '2023-04-22 10:35:05'),
(227, 'Hair dryer', 'this would be a user description', 5624, 9, 9, '2023-04-22 10:35:05'),
(228, 'Appliance plug', 'this would be a user description', 5913, 91, 8, '2023-04-22 10:35:05'),
(229, 'Space heater', 'this would be a user description', 8477, 67, 3, '2023-04-22 10:35:05'),
(230, 'Water purifier', 'this would be a user description', 6467, 13, 4, '2023-04-22 10:35:05'),
(231, 'Icebox', 'this would be a user description', 4711, 85, 8, '2023-04-22 10:35:05'),
(232, 'Micathermic heater', 'this would be a user description', 8333, 38, 10, '2023-04-22 10:35:05'),
(233, 'Futon dryer', 'this would be a user description', 4919, 72, 11, '2023-04-22 10:35:05'),
(234, 'Washing machine', 'this would be a user description', 3694, 46, 3, '2023-04-22 10:35:05'),
(235, 'Dish draining closet', 'this would be a user description', 9746, 88, 5, '2023-04-22 10:35:05'),
(236, 'Micathermic heater', 'this would be a user description', 6712, 49, 7, '2023-04-22 10:35:05'),
(237, 'Exhaust hood', 'this would be a user description', 2826, 51, 8, '2023-04-22 10:35:05'),
(238, 'Radiator (heating)', 'this would be a user description', 624, 66, 6, '2023-04-22 10:35:05'),
(239, 'Hair dryer', 'this would be a user description', 1639, 17, 4, '2023-04-22 10:35:05'),
(240, 'Water cooker', 'this would be a user description', 9222, 43, 10, '2023-04-22 10:35:05'),
(241, 'Patio heater', 'this would be a user description', 1943, 82, 3, '2023-04-22 10:35:05'),
(242, 'Washing machine', 'this would be a user description', 4344, 96, 11, '2023-04-22 10:35:05'),
(243, 'Beverage opener', 'this would be a user description', 7528, 66, 2, '2023-04-22 10:35:05'),
(244, 'Kimchi refrigerator', 'this would be a user description', 9207, 84, 3, '2023-04-22 10:35:05'),
(245, 'Refrigerator', 'this would be a user description', 9289, 83, 1, '2023-04-22 10:35:05'),
(246, 'Evaporative cooler', 'this would be a user description', 6609, 19, 9, '2023-04-22 10:35:05'),
(247, 'Flame supervision device', 'this would be a user description', 1518, 13, 0, '2023-04-22 10:35:05'),
(248, 'Attic fan', 'this would be a user description', 518, 61, 5, '2023-04-22 10:35:05'),
(249, 'Trouser press', 'this would be a user description', 4250, 90, 7, '2023-04-22 10:35:05'),
(250, 'Icebox', 'this would be a user description', 9404, 96, 2, '2023-04-22 10:35:05'),
(251, 'Stove', 'this would be a user description', 5916, 65, 7, '2023-04-22 10:35:05'),
(252, 'Mousetrap', 'this would be a user description', 7160, 2, 2, '2023-04-22 10:35:05'),
(253, 'Can opener', 'this would be a user description', 9631, 47, 7, '2023-04-22 10:35:05'),
(254, 'Cold-pressed juicer', 'this would be a user description', 8574, 5, 7, '2023-04-22 10:35:05'),
(255, 'Kimchi refrigerator', 'this would be a user description', 9530, 86, 6, '2023-04-22 10:35:05'),
(256, 'Central vacuum cleaner', 'this would be a user description', 1483, 89, 8, '2023-04-22 10:35:05'),
(257, 'Attic fan', 'this would be a user description', 6985, 74, 0, '2023-04-22 10:35:05'),
(258, 'Hair iron', 'this would be a user description', 2802, 86, 2, '2023-04-22 10:35:05'),
(259, 'Fan heater', 'this would be a user description', 3899, 93, 11, '2023-04-22 10:35:05'),
(260, 'Hair iron', 'this would be a user description', 5382, 64, 2, '2023-04-22 10:35:05'),
(261, 'Clothes dryer', 'this would be a user description', 1304, 61, 10, '2023-04-22 10:35:05'),
(262, 'Exhaust hood', 'this would be a user description', 2273, 35, 10, '2023-04-22 10:35:05'),
(263, 'Hob (hearth)', 'this would be a user description', 7369, 87, 2, '2023-04-22 10:35:05'),
(264, 'Humidifier', 'this would be a user description', 8252, 37, 0, '2023-04-22 10:35:05'),
(265, 'Air ioniser', 'this would be a user description', 6211, 20, 11, '2023-04-22 10:35:05'),
(266, 'Box mangle', 'this would be a user description', 2025, 86, 10, '2023-04-22 10:35:05'),
(267, 'Forced-air', 'this would be a user description', 3786, 45, 6, '2023-04-22 10:35:05'),
(268, 'Trouser press', 'this would be a user description', 2538, 51, 8, '2023-04-22 10:35:05'),
(269, 'Micathermic heater', 'this would be a user description', 947, 76, 6, '2023-04-22 10:35:05'),
(270, 'Steam mop', 'this would be a user description', 3505, 37, 10, '2023-04-22 10:35:05'),
(271, 'Icebox', 'this would be a user description', 6104, 84, 4, '2023-04-22 10:35:05'),
(272, 'Oven', 'this would be a user description', 7236, 4, 0, '2023-04-22 10:35:05'),
(273, 'Evaporative cooler', 'this would be a user description', 6396, 52, 9, '2023-04-22 10:35:05'),
(274, 'Washing machine', 'this would be a user description', 7387, 39, 10, '2023-04-22 10:35:05'),
(275, 'Radiator (heating)', 'this would be a user description', 6185, 20, 11, '2023-04-22 10:35:05'),
(276, 'Air ioniser', 'this would be a user description', 7721, 16, 10, '2023-04-22 10:35:05'),
(277, 'Back boiler', 'this would be a user description', 1668, 32, 5, '2023-04-22 10:35:05'),
(278, 'Vacuum cleaner', 'this would be a user description', 1076, 24, 4, '2023-04-22 10:35:05'),
(279, 'Stove', 'this would be a user description', 7377, 4, 9, '2023-04-22 10:35:05'),
(280, 'Clothes dryer', 'this would be a user description', 6410, 55, 5, '2023-04-22 10:35:05'),
(281, 'Window fan', 'this would be a user description', 9573, 66, 6, '2023-04-22 10:35:05'),
(282, 'Home server', 'this would be a user description', 9281, 45, 3, '2023-04-22 10:35:05'),
(283, 'Ceiling fan', 'this would be a user description', 5822, 13, 11, '2023-04-22 10:35:05'),
(284, 'Back boiler', 'this would be a user description', 2085, 88, 7, '2023-04-22 10:35:05'),
(285, 'Hair dryer', 'this would be a user description', 1088, 54, 10, '2023-04-22 10:35:05'),
(286, 'Window fan', 'this would be a user description', 5895, 83, 3, '2023-04-22 10:35:05'),
(287, 'Water cooker', 'this would be a user description', 936, 78, 1, '2023-04-22 10:35:05'),
(288, 'Cold-pressed juicer', 'this would be a user description', 5056, 54, 5, '2023-04-22 10:35:05'),
(289, 'Micathermic heater', 'this would be a user description', 4731, 87, 7, '2023-04-22 10:35:05'),
(290, 'HVAC', 'this would be a user description', 2901, 25, 0, '2023-04-22 10:35:05'),
(291, 'Box mangle', 'this would be a user description', 8205, 98, 9, '2023-04-22 10:35:05'),
(292, 'Central vacuum cleaner', 'this would be a user description', 6954, 5, 11, '2023-04-22 10:35:05');

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
(1, 1, 1, '2023-04-22 10:35:04'),
(2, 2, 2, '2023-04-22 10:35:04'),
(3, 3, 3, '2023-04-22 10:35:04'),
(4, 4, 4, '2023-04-22 10:35:04'),
(5, 5, 5, '2023-04-22 10:35:04'),
(6, 6, 6, '2023-04-22 10:35:04'),
(7, 7, 7, '2023-04-22 10:35:04'),
(8, 8, 8, '2023-04-22 10:35:04'),
(9, 9, 9, '2023-04-22 10:35:04'),
(10, 10, 10, '2023-04-22 10:35:05'),
(11, 11, 11, '2023-04-22 10:35:05'),
(12, 12, 12, '2023-04-22 10:35:05'),
(13, 13, 13, '2023-04-22 10:35:05'),
(14, 14, 14, '2023-04-22 10:35:05'),
(15, 15, 15, '2023-04-22 10:35:05'),
(16, 16, 16, '2023-04-22 10:35:05'),
(17, 17, 17, '2023-04-22 10:35:05'),
(18, 18, 18, '2023-04-22 10:35:05'),
(19, 19, 19, '2023-04-22 10:35:05'),
(20, 20, 20, '2023-04-22 10:35:05'),
(21, 21, 21, '2023-04-22 10:35:05'),
(22, 22, 22, '2023-04-22 10:35:05'),
(23, 23, 23, '2023-04-22 10:35:05'),
(24, 24, 24, '2023-04-22 10:35:05'),
(25, 25, 25, '2023-04-22 10:35:05'),
(26, 26, 26, '2023-04-22 10:35:05'),
(27, 27, 27, '2023-04-22 10:35:05'),
(28, 28, 28, '2023-04-22 10:35:05'),
(29, 29, 29, '2023-04-22 10:35:05'),
(30, 30, 30, '2023-04-22 10:35:05'),
(31, 31, 31, '2023-04-22 10:35:05'),
(32, 32, 32, '2023-04-22 10:35:05'),
(33, 33, 33, '2023-04-22 10:35:05'),
(34, 34, 34, '2023-04-22 10:35:05'),
(35, 35, 35, '2023-04-22 10:35:05'),
(36, 36, 36, '2023-04-22 10:35:05'),
(37, 37, 37, '2023-04-22 10:35:05'),
(38, 38, 38, '2023-04-22 10:35:05'),
(39, 39, 39, '2023-04-22 10:35:05'),
(40, 40, 40, '2023-04-22 10:35:05'),
(41, 41, 41, '2023-04-22 10:35:05'),
(42, 42, 42, '2023-04-22 10:35:05'),
(43, 43, 43, '2023-04-22 10:35:05'),
(44, 44, 44, '2023-04-22 10:35:05'),
(45, 45, 45, '2023-04-22 10:35:05'),
(46, 46, 46, '2023-04-22 10:35:05'),
(47, 47, 47, '2023-04-22 10:35:05'),
(48, 48, 48, '2023-04-22 10:35:05'),
(49, 49, 49, '2023-04-22 10:35:05'),
(50, 50, 50, '2023-04-22 10:35:05');

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
(1, 1092467110, 527468483, '998620', 'this would be sent by user', '2023-04-22 10:35:04'),
(2, 1105768780, 892922256, '831335', 'this would be sent by user', '2023-04-22 10:35:04'),
(3, 1111359830, 1325388563, '757510', 'this would be sent by user', '2023-04-22 10:35:04'),
(4, 458359748, 871429775, '206755', 'this would be sent by user', '2023-04-22 10:35:04'),
(5, 616539488, 1148927036, '396006', 'this would be sent by user', '2023-04-22 10:35:04'),
(6, 1200260084, 555962520, '717303', 'this would be sent by user', '2023-04-22 10:35:04'),
(7, 338162487, 913165077, '497959', 'this would be sent by user', '2023-04-22 10:35:04'),
(8, 323977433, 651725, '8234', 'this would be sent by user', '2023-04-22 10:35:04'),
(9, 571077718, 126570971, '925613', 'this would be sent by user', '2023-04-22 10:35:04'),
(10, 45813025, 948602710, '216102', 'this would be sent by user', '2023-04-22 10:35:04'),
(11, 645820266, 604048631, '923251', 'this would be sent by user', '2023-04-22 10:35:05'),
(12, 1429940047, 703116198, '808877', 'this would be sent by user', '2023-04-22 10:35:05'),
(13, 227598675, 1240854164, '369364', 'this would be sent by user', '2023-04-22 10:35:05'),
(14, 1357586154, 570681516, '203973', 'this would be sent by user', '2023-04-22 10:35:05'),
(15, 1544590141, 1058000526, '599048', 'this would be sent by user', '2023-04-22 10:35:05'),
(16, 895598757, 1219021078, '516597', 'this would be sent by user', '2023-04-22 10:35:05'),
(17, 967914250, 981762170, '894240', 'this would be sent by user', '2023-04-22 10:35:05'),
(18, 1306007837, 70123062, '736477', 'this would be sent by user', '2023-04-22 10:35:05'),
(19, 455859310, 1309253297, '947921', 'this would be sent by user', '2023-04-22 10:35:05'),
(20, 999458640, 1059382821, '662585', 'this would be sent by user', '2023-04-22 10:35:05'),
(21, 1373651241, 487871068, '206224', 'this would be sent by user', '2023-04-22 10:35:05'),
(22, 1195538683, 765968026, '931796', 'this would be sent by user', '2023-04-22 10:35:05'),
(23, 960476221, 240712323, '796361', 'this would be sent by user', '2023-04-22 10:35:05'),
(24, 238811917, 1230169544, '301340', 'this would be sent by user', '2023-04-22 10:35:05'),
(25, 191995628, 1589106124, '601346', 'this would be sent by user', '2023-04-22 10:35:05'),
(26, 300991065, 312863276, '361212', 'this would be sent by user', '2023-04-22 10:35:05'),
(27, 1619176995, 396555511, '935770', 'this would be sent by user', '2023-04-22 10:35:05'),
(28, 278648944, 1525790942, '814512', 'this would be sent by user', '2023-04-22 10:35:05'),
(29, 1461509849, 1256016321, '12781', 'this would be sent by user', '2023-04-22 10:35:05'),
(30, 935372988, 1407373863, '571599', 'this would be sent by user', '2023-04-22 10:35:05'),
(31, 1275846021, 1146206420, '613303', 'this would be sent by user', '2023-04-22 10:35:05'),
(32, 1298316324, 476423464, '890360', 'this would be sent by user', '2023-04-22 10:35:05'),
(33, 432585635, 1138582093, '488711', 'this would be sent by user', '2023-04-22 10:35:05'),
(34, 486088184, 1331321395, '568764', 'this would be sent by user', '2023-04-22 10:35:05'),
(35, 678636238, 757515830, '416941', 'this would be sent by user', '2023-04-22 10:35:05'),
(36, 868301291, 825354049, '582041', 'this would be sent by user', '2023-04-22 10:35:05'),
(37, 852510446, 516498471, '888333', 'this would be sent by user', '2023-04-22 10:35:05'),
(38, 359564550, 48596143, '332487', 'this would be sent by user', '2023-04-22 10:35:05'),
(39, 626507342, 402993252, '557729', 'this would be sent by user', '2023-04-22 10:35:05'),
(40, 479146390, 800353436, '142245', 'this would be sent by user', '2023-04-22 10:35:05'),
(41, 1095493816, 1124942623, '233055', 'this would be sent by user', '2023-04-22 10:35:05'),
(42, 1009162922, 422804650, '936625', 'this would be sent by user', '2023-04-22 10:35:05'),
(43, 1331746541, 1116560096, '923207', 'this would be sent by user', '2023-04-22 10:35:05'),
(44, 1511486380, 1456730149, '914907', 'this would be sent by user', '2023-04-22 10:35:05'),
(45, 1270022850, 1650520957, '599157', 'this would be sent by user', '2023-04-22 10:35:05'),
(46, 1341199337, 1406604012, '422120', 'this would be sent by user', '2023-04-22 10:35:05'),
(47, 184031764, 824058998, '454212', 'this would be sent by user', '2023-04-22 10:35:05'),
(48, 637027686, 238912361, '657395', 'this would be sent by user', '2023-04-22 10:35:05'),
(49, 912110687, 1277348370, '642422', 'this would be sent by user', '2023-04-22 10:35:05'),
(50, 1364037284, 849404302, '899740', 'this would be sent by user', '2023-04-22 10:35:05');

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
(30, '1', '1'),
(16, '10', '10'),
(1, '11', '11'),
(4, '12', '12'),
(21, '13', '13'),
(14, '14', '14'),
(10, '15', '15'),
(7, '16', '16'),
(6, '17', '17'),
(3, '18', '18'),
(8, '19', '19'),
(5, '2', '2'),
(18, '20', '20'),
(2, '3', '3'),
(11, '4', '4'),
(27, '5', '5'),
(25, '6', '6'),
(12, '7', '7'),
(41, '8', '8'),
(15, '9', '9');

-- --------------------------------------------------------

--
-- Table structure for table `reset_tokens`
--

CREATE TABLE `reset_tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `date_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_company`
--

CREATE TABLE `stock_company` (
  `id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_histories`
--

CREATE TABLE `stock_histories` (
  `id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `history_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_locations`
--

CREATE TABLE `stock_locations` (
  `id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'vH7Fk8QlF*h£Wf\"BGV5ZMnOcBV67YH\"6g0P4hloiVZ\"\"OHCoX!g1682161931291');

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
(84, 'michael8t6@gmail.com', '51475b76dda6383493d7ca1286fcffb9efaaee6b05e63de02cef5a1939a3a68f', '2023-03-13 18:44:09');

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
(1, 84, 1);

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
(1, 84, 1, '2023-04-22 10:35:04'),
(2, 84, 2, '2023-04-22 10:35:04'),
(3, 84, 3, '2023-04-22 10:35:04'),
(4, 84, 4, '2023-04-22 10:35:04'),
(5, 84, 5, '2023-04-22 10:35:04'),
(6, 84, 6, '2023-04-22 10:35:04'),
(7, 84, 7, '2023-04-22 10:35:04'),
(8, 84, 8, '2023-04-22 10:35:04'),
(9, 84, 9, '2023-04-22 10:35:04'),
(10, 84, 10, '2023-04-22 10:35:04'),
(11, 84, 11, '2023-04-22 10:35:05'),
(12, 84, 12, '2023-04-22 10:35:05'),
(13, 84, 13, '2023-04-22 10:35:05'),
(14, 84, 14, '2023-04-22 10:35:05'),
(15, 84, 15, '2023-04-22 10:35:05'),
(16, 84, 16, '2023-04-22 10:35:05'),
(17, 84, 17, '2023-04-22 10:35:05'),
(18, 84, 18, '2023-04-22 10:35:05'),
(19, 84, 19, '2023-04-22 10:35:05'),
(20, 84, 20, '2023-04-22 10:35:05'),
(21, 84, 21, '2023-04-22 10:35:05'),
(22, 84, 22, '2023-04-22 10:35:05'),
(23, 84, 23, '2023-04-22 10:35:05'),
(24, 84, 24, '2023-04-22 10:35:05'),
(25, 84, 25, '2023-04-22 10:35:05'),
(26, 84, 26, '2023-04-22 10:35:05'),
(27, 84, 27, '2023-04-22 10:35:05'),
(28, 84, 28, '2023-04-22 10:35:05'),
(29, 84, 29, '2023-04-22 10:35:05'),
(30, 84, 30, '2023-04-22 10:35:05'),
(31, 84, 31, '2023-04-22 10:35:05'),
(32, 84, 32, '2023-04-22 10:35:05'),
(33, 84, 33, '2023-04-22 10:35:05'),
(34, 84, 34, '2023-04-22 10:35:05'),
(35, 84, 35, '2023-04-22 10:35:05'),
(36, 84, 36, '2023-04-22 10:35:05'),
(37, 84, 37, '2023-04-22 10:35:05'),
(38, 84, 38, '2023-04-22 10:35:05'),
(39, 84, 39, '2023-04-22 10:35:05'),
(40, 84, 40, '2023-04-22 10:35:05'),
(41, 84, 41, '2023-04-22 10:35:05'),
(42, 84, 42, '2023-04-22 10:35:05'),
(43, 84, 43, '2023-04-22 10:35:05'),
(44, 84, 44, '2023-04-22 10:35:05'),
(45, 84, 45, '2023-04-22 10:35:05'),
(46, 84, 46, '2023-04-22 10:35:05'),
(47, 84, 47, '2023-04-22 10:35:05'),
(48, 84, 48, '2023-04-22 10:35:05'),
(49, 84, 49, '2023-04-22 10:35:05'),
(50, 84, 50, '2023-04-22 10:35:05');

-- --------------------------------------------------------

--
-- Table structure for table `user_reset`
--

CREATE TABLE `user_reset` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_stock`
--

CREATE TABLE `user_stock` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_token`
--

CREATE TABLE `user_token` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_token`
--

INSERT INTO `user_token` (`id`, `user_id`, `token_id`) VALUES
(1, 84, 1);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `history_id` (`history_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `location` (`name`,`value`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `history_id` (`history_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134738;

--
-- AUTO_INCREMENT for table `history_locations`
--
ALTER TABLE `history_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403545;

--
-- AUTO_INCREMENT for table `invoice_company`
--
ALTER TABLE `invoice_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- AUTO_INCREMENT for table `invoice_specific`
--
ALTER TABLE `invoice_specific`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `invoice_specifics`
--
ALTER TABLE `invoice_specifics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403545;

--
-- AUTO_INCREMENT for table `reset_tokens`
--
ALTER TABLE `reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `stock_company`
--
ALTER TABLE `stock_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `stock_histories`
--
ALTER TABLE `stock_histories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134738;

--
-- AUTO_INCREMENT for table `stock_locations`
--
ALTER TABLE `stock_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT for table `user_company`
--
ALTER TABLE `user_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_invoices`
--
ALTER TABLE `user_invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `user_reset`
--
ALTER TABLE `user_reset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_stock`
--
ALTER TABLE `user_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
