-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 01, 2019 at 03:49 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sekretarya`
--

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `company_name` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `company_phone` char(11) COLLATE utf8_turkish_ci NOT NULL,
  `company_address` varchar(75) COLLATE utf8_turkish_ci NOT NULL,
  `customer_name` varchar(25) COLLATE utf8_turkish_ci NOT NULL,
  `comment` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `company_name`, `company_phone`, `company_address`, `customer_name`, `comment`) VALUES
(1, 'EyBiSi Teknoloji', '5352881209', 'Gül Mah Lale Sok No 12 Avcılar/Istanbul', 'Ali Duran', 'Bazı işlemler yapılacak'),
(2, 'Codex', '5552229911', 'Manavgat/Antalya', 'Orhan Noyan', 'Oyun yazılımı hk.'),
(3, 'Atom Yazılım', '5352221199', 'Beylikdüzü Mah Yakuplu Sok B/23 D:12 Avcılar/Istanbul', 'Berkan Yanardağ', 'Son yapılan güncelleştirmeler de mevcut hata çözümü hk.'),
(15, 'Zamir Teknoloji', '05332914402', 'Şahinbey/Gaziantep', 'Mustafa Oruç', 'Verilen destek hk.'),
(31, 'IPAS Program', '5359991100', 'Bağlum/Ankara', 'Burak Güngöroğlu', 'Toplantı'),
(44, 'Archive Tech', '2129001020', 'Bodrum/Muğla', 'Doğukan Arıcan', 'Kod yapısıda'),
(62, 'Gitcall Service', '2129991122', 'Kemer/Antalya', 'Mehmet Şahin', 'Personel sıkıntısı'),
(64, '', '', '', '', ''),
(65, 'x', 'd', 'd', 'd', 'd');

-- --------------------------------------------------------

--
-- Table structure for table `secretary_tasks`
--

CREATE TABLE `secretary_tasks` (
  `id` int(11) NOT NULL,
  `task_date` date NOT NULL,
  `task` text COLLATE utf8_turkish_ci NOT NULL,
  `task_situation` varchar(10) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `secretary_tasks`
--

INSERT INTO `secretary_tasks` (`id`, `task_date`, `task`, `task_situation`) VALUES
(1, '2019-07-08', 'Rıfat Bey ile görüşülecek.', 'red'),
(2, '2019-07-08', 'Ahmet Beyin verdiği evrakların teslimi', 'green'),
(3, '2019-07-09', 'Teklif değerlendirilecek', '#F7FF00'),
(4, '2019-07-09', 'İnsan Kaynakları ile toplantı', 'red'),
(5, '2019-07-09', 'Yeni gelen ürünlerin analiz evrakını teslim', '#F7FF00'),
(6, '2019-07-10', 'Aydın Bey ile işin teferruatı görüşülecek.', 'green'),
(7, '2019-07-10', 'Aydın Bey\'den alınan sonuca göre Ali Bey\'e danışılacak', 'green'),
(8, '2019-07-11', 'Hukuk bürosu ile işlemler', '#F7FF00'),
(10, '2019-07-11', 'Holding Bilgi İşlem Toplantısı', 'green'),
(11, '2019-07-11', 'Yazılım Birimi ile hususi görüşme', '#F7FF00'),
(12, '2019-07-10', 'Son alınan kararların istişaresi', 'red'),
(13, '2019-07-12', 'Platform çeşitliliğinin arttırılması hk.', 'red'),
(14, '2019-07-12', 'Genel Müdür ile toplantı', '#F7FF00'),
(15, '2019-07-12', 'Güncelleştirmelerin açıklamaları hk.', '#F7FF00'),
(16, '2019-07-10', 'Mehmet Acar iş sonlandırması', 'red'),
(30, '2019-08-11', '1 ay sonunda genel toplantı', '#F7FF00'),
(37, '2019-08-12', 'Toplantı', '#F7FF00'),
(38, '2019-08-12', 'Görüşme', 'red'),
(40, '2019-07-13', 'Genel Toplantı sonrası hususi toplantı', '#F7FF00'),
(44, '2019-07-14', 'g1', 'red'),
(45, '2019-07-14', 'g2', '#F7FF00'),
(46, '2019-07-14', 'g3', 'red'),
(47, '2019-09-01', 'asd', ''),
(48, '2019-09-01', 'saddaw', 'red'),
(49, '2019-09-01', 'ewqeq', ''),
(50, '2019-09-01', 'wwww', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_fullname` varchar(25) COLLATE utf8_turkish_ci NOT NULL,
  `user_email` varchar(25) COLLATE utf8_turkish_ci NOT NULL,
  `username` varchar(15) COLLATE utf8_turkish_ci NOT NULL,
  `password` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_fullname`, `user_email`, `username`, `password`) VALUES
(12, 'Ahmet Çakıcı', 'ahmetcakici@gmail.com', 'abugra', '$5$rounds=535000$oOphrt6je4aVz5Gk$di0TQzQDFpsFkQtQdJw3PB6ep2b806if0epOn1Z.LBB'),
(13, 'ah', 'ahmetbcakici@gmail.com', 'ahmet', '$5$rounds=535000$ns66eoRe7RXXhH5a$QSh1DvY5bs/7xVD0.c7K0PP8UGlVChFqb9PosyBD1T8'),
(14, 'aaa', 'b@m.com', 'abc', '$5$rounds=535000$m8FYekjKqy6WpNMi$rb9FxFTbgYI0f.s0/rFGKHBipsh/CLg5HdZXLnGPdG3'),
(15, 'Bay Anon', 'ahmetcakici@gmail.com', 'abc', '$5$rounds=535000$JZs/4AqF1CABbm6a$9XtLkGrf.f8DYYvpWYn/O7pU8D.USuRIPExHMZx8Vg6'),
(16, 'Deneme Hesap', 'denemehesap@mail.com', 'denemehesap', '$5$rounds=535000$jYOwZinPkya5JbhT$qYx/VHJC3we6cUOcZ8f65z7fL2wZloVELe31/0IeIE9');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `secretary_tasks`
--
ALTER TABLE `secretary_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
--
-- AUTO_INCREMENT for table `secretary_tasks`
--
ALTER TABLE `secretary_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
