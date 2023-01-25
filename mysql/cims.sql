-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 25, 2023 at 09:35 PM
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
(32, 'creekview', '27 Wickhay', 'Basildon', 'essex', 'ss15 5ae', 'United Kingdom', '2023-01-18 21:02:27');

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
(4, 'Sophia', 'Crumbles Pedicures', '75 Great Oxcroft', 'Leeds', 'Yorkshire', 'LS10 2HP', 'UK', '2023-01-25 20:28:57');

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
(7, 4, 7, '2023-01-25 20:28:57');

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
(7, 'hair cut', 'Fresh trim', 1, 30, 0, '2023-01-25 20:28:57');

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
(4, 4, 4, '2023-01-25 20:28:57');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_specifics`
--

CREATE TABLE `invoice_specifics` (
  `id` int(11) NOT NULL,
  `billing_date` date NOT NULL,
  `due_date` date NOT NULL,
  `order_number` varchar(256) NOT NULL,
  `footer` varchar(256) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_specifics`
--

INSERT INTO `invoice_specifics` (`id`, `billing_date`, `due_date`, `order_number`, `footer`, `date_added`) VALUES
(1, '2023-01-31', '2023-01-24', 'For some vape juice', 'invoice 1', '2023-01-24 21:41:53'),
(2, '2023-02-10', '2023-01-24', 'For Richard Website', 'Order 2', '2023-01-24 21:43:03'),
(3, '2023-01-26', '2023-01-25', 'To Russel from Micael', 'FJDIs434344', '2023-01-25 18:27:02'),
(4, '2057-04-30', '2057-04-30', 'For Sophia', '987654', '2023-01-25 20:28:57');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sku` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `free_issue` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_location`
--

CREATE TABLE `stock_location` (
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
(70, 'PK!TG1yu&pZP4S5b8KOQhS0*jVAXaIhjiDEEX-hxF$yuX$jM&C61674678541516');

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
(84, 'michael8t6@gmail.com', '7fee8b1ff1733876febc0d525ae88c5f28f605c08d11c61c109af63b05b4bf03', '2023-01-18 21:02:27');

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
(4, 84, 4, '2023-01-25 20:28:57');

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
  `user` int(11) NOT NULL,
  `token` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_token`
--

INSERT INTO `user_token` (`id`, `user`, `token`) VALUES
(52, 84, 70);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
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
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_location`
--
ALTER TABLE `stock_location`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `invoice_company`
--
ALTER TABLE `invoice_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `invoice_specific`
--
ALTER TABLE `invoice_specific`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `invoice_specifics`
--
ALTER TABLE `invoice_specifics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_location`
--
ALTER TABLE `stock_location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_stock`
--
ALTER TABLE `user_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
