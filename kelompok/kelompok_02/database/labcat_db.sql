-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 13, 2026 at 06:47 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `labcat_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password_hash`, `created_at`) VALUES
(1, 'hafni dzaki', 'hafniudh@gmail.com', '$2y$10$F9HEtupF147Vz5gGJ2omCOGNQfApX40nq0ncTpGoxlLC3Zr8WS9oq', '2026-11-11 12:08:08');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'Glassware', 'Kelompok peralatan dasar laboratorium yang umumnya terbuat dari kaca borosilikat tahan panas, porselen, atau plastik khusus. Kategori ini berfungsi sebagai wadah utama untuk menampung, mencampur, melarutkan, mereaksikan, maupun memisahkan cairan dan sampel tanpa mengukur volumenya secara presisi tinggi.', '2026-11-13 06:25:19'),
(2, 'Alat Ukur & Presisi', 'Digunakan untuk mengukur volume, massa, panjang, suhu, maupun besaran listrik dengan tingkat ketelitian tertentu.', '2026-11-13 06:25:37'),
(3, 'Alat Pemanas & Pengatur Suhu', 'Digunakan untuk proses pemanasan, pengeringan, penguapan, inkubasi, atau sterilisasi alat dan bahan.', '2026-11-13 06:25:48'),
(4, 'Instrumen Analisis & Optik', 'Peralatan berbasis elektronik atau optik yang digunakan untuk pengamatan mikroskopis serta analisis komposisi sampel.', '2026-11-13 06:26:06'),
(5, 'Alat Bantu, Penyangga & Keselamatan (K3)', 'Digunakan untuk merakit rangkaian alat, memindahkan bahan dalam jumlah kecil, serta melindungi praktikan.', '2026-11-13 06:26:20');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int UNSIGNED NOT NULL,
  `equipment_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `equipment_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  `laboratory_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `specifications` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `equipment_code`, `equipment_name`, `category_id`, `laboratory_name`, `brand`, `model`, `description`, `specifications`, `image`, `created_at`, `updated_at`) VALUES
(1, 'G-001', 'Gelas Beker', 1, 'Laboraorium Kimia Dasar', 'IWAKI', 'Pyrex Low Form 250 mL / DURAN 2110636', 'Wadah silinder berbibir tuang untuk menampung, mencampur, dan memanaskan larutan dalam volume perkiraan.', 'Material: Kaca Borosilikat 3.3; Kapasitas: 250 mL; Dimensi: Ø 70 × T 95 mm; Ketahanan suhu: s/d 500 °C.', 'uploads/6625f83c0c87ac78c91530faa206bf30.jpg', '2026-11-13 06:33:44', '2026-11-13 06:33:44'),
(2, 'UP-001', 'Pipet volume', 2, 'Laboratorium Fisika Dasar', 'Brand', 'BlauBrand Class AS 10 mL', 'Pipet kaca dengan bagian tengah menggembung untuk mengambil satu ukuran volume larutan tertentu dengan akurasi sangat tinggi.', 'Kapasitas: 10 mL (1 tanda batas); Toleransi: ± 0,02 mL; Waktu alir (delivery time): 5–10 detik; Kalibrasi Ex (20 °C).', 'uploads/1188f1965f73e5f429ab0d82601019c5.jpg', '2026-11-13 06:35:44', '2026-11-13 06:40:33'),
(3, 'PPS-001', 'Pembakar Bunsen', 3, 'Laboratorim Mikrobiologi', 'Usbeck', 'Teclu', 'Pembakar berbahan bakar gas (LPG/butana) yang menghasilkan nyala api biru panas untuk pemanasan cepat dan sterilisasi jarum ose.', 'Bahan bakar: Gas LPG/Alam; Suhu api maksimal: ± 1300 °C; Material: Kuningan (brass) dengan pengatur suplai udara & gas.', 'uploads/78d97adc7d020b0cdea734018ebe548c.jpg', '2026-11-13 06:37:27', '2026-11-13 06:37:27'),
(4, 'AO-001', 'Mikroskop binokuler', 4, 'Laboratorium Instrumen Terpadu', 'Olympus', 'CX23', 'Instrumen optik berlensa okuler ganda untuk mengamati struktur sel, jaringan, dan mikroorganisme dengan perbesaran hingga 1000x.', 'Lensa okuler: 10x (FN 20); Lensa objektif Plan Achromat: 4x, 10x, 40x, 100x (Oil); Perbesaran total: 40x–1000x; Iluminasi: LED 0,5 W.', 'uploads/c370f28648a15e8c6706b811dad9ee18.webp', '2026-11-13 06:41:51', '2026-11-13 06:42:58'),
(5, 'K3-001', 'Penjepit Tabung Reaksi', 5, 'Ruang Penyimpanan Alat', 'Boeco', 'Wooden Clamp', 'Penjepit berbahan kayu atau logam untuk memegang tabung reaksi saat dipanaskan langsung di atas nyala api.', 'Material: Kayu keras (hardwood) dengan pegas baja; Panjang total: 180–200 mm; Kapasitas jepit tabung: Ø 10–25 mm.', 'uploads/31bc12d4eb3de56aded454efab467219.png', '2026-11-13 06:44:51', '2026-11-13 06:44:51');

-- --------------------------------------------------------

--
-- Table structure for table `equipment_images`
--

CREATE TABLE `equipment_images` (
  `id` int UNSIGNED NOT NULL,
  `equipment_id` int UNSIGNED NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `equipment_images`
--

INSERT INTO `equipment_images` (`id`, `equipment_id`, `image_path`, `sort_order`, `created_at`) VALUES
(1, 1, 'uploads/6625f83c0c87ac78c91530faa206bf30.jpg', 0, '2026-11-13 06:33:44'),
(2, 3, 'uploads/78d97adc7d020b0cdea734018ebe548c.jpg', 0, '2026-11-13 06:37:27'),
(3, 2, 'uploads/1188f1965f73e5f429ab0d82601019c5.jpg', 0, '2026-11-13 06:40:33'),
(4, 4, 'uploads/c370f28648a15e8c6706b811dad9ee18.webp', 0, '2026-11-13 06:42:58'),
(5, 5, 'uploads/31bc12d4eb3de56aded454efab467219.png', 0, '2026-11-13 06:44:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `equipment_code` (`equipment_code`),
  ADD KEY `idx_equipment_name` (`equipment_name`),
  ADD KEY `idx_equipment_code` (`equipment_code`),
  ADD KEY `idx_equipment_category` (`category_id`);

--
-- Indexes for table `equipment_images`
--
ALTER TABLE `equipment_images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_equipment_image_path` (`equipment_id`,`image_path`),
  ADD KEY `idx_equipment_images_order` (`equipment_id`,`sort_order`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `equipment_images`
--
ALTER TABLE `equipment_images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `fk_equipment_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `equipment_images`
--
ALTER TABLE `equipment_images`
  ADD CONSTRAINT `fk_equipment_images_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
