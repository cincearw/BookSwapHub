-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 08, 2025 at 04:24 AM
-- Server version: 8.0.39
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookswap3`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` bigint NOT NULL,
  `author` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `genre` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `owner_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `image_url` varchar(350) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `author`, `description`, `genre`, `title`, `owner_id`, `user_id`, `image_url`) VALUES
(1, 'F. Scott Fitzgerald', 'A story about the American dream and the mysterious Jay Gatsby.', 'Classic', 'The Great Gatsby', 1, 3, '/assets/img/book1.jpg\r\n'),
(2, 'Harper Lee', 'To Kill a Mockingbird is a 1960 Southern Gothic novel by American author Harper Lee. It became instantly successful after its release; in the United States, it is widely read in high schools and middle schools', 'Thriller, Fiction', 'To Kill A Mockingbird ', 8, 8, '/assets/img/book2.jpg'),
(3, 'George Orwell', 'Nineteen Eighty-Four is a dystopian novel and cautionary tale by English writer George Orwell. It was published on 8 June 1949 by Secker & Warburg as Orwell\'s ninth and final completed book.', 'Science Fiction', '1984', 8, 8, '/assets/img/book3.jpg'),
(9, 'Jane Austen', 'Pride and Prejudice is the second novel by English author Jane Austen, published in 1813. It follows the character development of Elizabeth Bennet, the protagonist of the book, who learns about the repercussions of hasty judgments.', 'Romance', 'Pride & Prejudice', 8, 8, '/assets/img/book4.jpg'),
(10, 'J.D. Salinger', 'Originally intended for adults, it is often read by adolescents for its themes of angst and alienation, and as a critique of superficiality in society.', 'Coming-of-Age', 'The Catcher In The Rye', 8, 8, '/assets/img/book5.jpg'),
(11, 'Nathaniel Philbrick', 'The book is centered on the sailor Ishmael\'s narrative of the maniacal quest of Ahab, captain of the whaling ship Pequod, for vengeance against Moby Dick, the giant white sperm whale that bit off his leg on the ship\'s previous voyage.', 'Adventure Fiction', 'Moby-Dick', 8, 8, '/assets/img/book6.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` bigint NOT NULL,
  `content` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `receiver_id` bigint DEFAULT NULL,
  `sender_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `content`, `created_at`, `status`, `receiver_id`, `sender_id`) VALUES
(1, 'Hey, are you available to swap the book?', '2025-04-03', 'unread', 3, 1),
(2, 'can we swap?', '2025-05-03', 'unread', 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` bigint NOT NULL,
  `comment` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `rating` int NOT NULL,
  `book_id` bigint DEFAULT NULL,
  `reviewer_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `comment`, `created_at`, `rating`, `book_id`, `reviewer_id`) VALUES
(1, 'This book was incredible!', '2025-04-03', 5, 1, 2),
(2, 'gergerv', '2025-04-21', 5, 1, 1),
(3, 'verth4jn ', '2025-04-21', 3, 1, 2),
(4, 'gerge regergv', '2025-04-22', 2, 1, 2),
(5, 'really not as interesting book as everyone says. ', '2025-04-22', 1, 1, 1),
(6, 'okay read not thast interesting. ', '2025-04-22', 4, 1, 1),
(7, 'amazing read!', '2025-05-03', 5, 1, 7),
(8, 'blah blah boring', '2025-05-07', 1, 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `swaps`
--

CREATE TABLE `swaps` (
  `swap_id` bigint NOT NULL,
  `requested_at` date DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `book_id` bigint DEFAULT NULL,
  `requester_id` bigint DEFAULT NULL,
  `provider_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `swaps`
--

INSERT INTO `swaps` (`swap_id`, `requested_at`, `status`, `updated_at`, `book_id`, `requester_id`, `provider_id`) VALUES
(1, '2025-04-03', 'pending', '2025-04-03', 1, 2, NULL),
(2, '2025-05-03', 'pending', '2025-05-03', 1, 7, NULL),
(3, '2025-05-07', 'pending', '2025-05-07', 2, 9, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `dtype` varchar(31) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `created_at` date DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bio` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `favorite_genres` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`dtype`, `user_id`, `created_at`, `email`, `name`, `password`, `role`, `username`, `bio`, `favorite_genres`) VALUES
('User', 1, '2025-04-03', 'saniyah@example.com', 'Saniyah', 'password123', 'Customer', 'saniyah123', NULL, NULL),
('User', 2, '2025-04-03', 'sarah@example.com', 'Sarah', 'pord123', 'Customer', 'sah123', NULL, NULL),
('Provider', 3, '2025-04-03', 'provider@example.com', 'Jane Doe', 'securePassword', 'Provider', 'provider123', NULL, NULL),
('User', 7, '2025-05-02', 'cute123@gmail.com', 'cutesyBCi\'mCute', 'blahblah123', 'Customer', 'cutesy123', 'New York, New York', 'romance, action, classic'),
('Provider', 8, '2025-05-03', 'pro123@gmail.com', 'provider123', 'pro123', 'Provider', 'pro123', NULL, NULL),
('User', 9, '2025-05-07', 'sk@example.com', 'Saniyah K', '1234', 'Customer', 'saniyaaaa', 'Baltimore, Maryland', 'Romcom');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `FKqhbjpnph6e33p08wfax7dd475` (`owner_id`),
  ADD KEY `FKcykkh3hxh89ammmwch0gw5o1s` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `FKt05r0b6n0iis8u7dfna4xdh73` (`receiver_id`),
  ADD KEY `FK4ui4nnwntodh6wjvck53dbk9m` (`sender_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `FK6a9k6xvev80se5rreqvuqr7f9` (`book_id`),
  ADD KEY `FKd1isgfajhtdl8mgg29up6mofi` (`reviewer_id`);

--
-- Indexes for table `swaps`
--
ALTER TABLE `swaps`
  ADD PRIMARY KEY (`swap_id`),
  ADD KEY `FKs79amo2274y0nfkhlg4gn95hj` (`book_id`),
  ADD KEY `FKbb3crsyo83plvjvstfxm1wxpj` (`requester_id`),
  ADD KEY `FKe9lkavtsctucksa3okvqad4nq` (`provider_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `swaps`
--
ALTER TABLE `swaps`
  MODIFY `swap_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `FKcykkh3hxh89ammmwch0gw5o1s` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `FKqhbjpnph6e33p08wfax7dd475` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `FK4ui4nnwntodh6wjvck53dbk9m` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `FKt05r0b6n0iis8u7dfna4xdh73` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `FK6a9k6xvev80se5rreqvuqr7f9` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `FKd1isgfajhtdl8mgg29up6mofi` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `swaps`
--
ALTER TABLE `swaps`
  ADD CONSTRAINT `FKbb3crsyo83plvjvstfxm1wxpj` FOREIGN KEY (`requester_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `FKe9lkavtsctucksa3okvqad4nq` FOREIGN KEY (`provider_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `FKs79amo2274y0nfkhlg4gn95hj` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
