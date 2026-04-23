-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: peminjaman_buku
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bukus`
--

DROP TABLE IF EXISTS `bukus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bukus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kode_buku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_kategori` bigint unsigned NOT NULL,
  `judul` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `penulis` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `penerbit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tahun_terbit` int DEFAULT NULL,
  `stok` int NOT NULL,
  `gambar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `denda_per_hari` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bukus_kode_buku_unique` (`kode_buku`),
  KEY `bukus_id_kategori_foreign` (`id_kategori`),
  CONSTRAINT `bukus_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategoris` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bukus`
--

LOCK TABLES `bukus` WRITE;
/*!40000 ALTER TABLE `bukus` DISABLE KEYS */;
INSERT INTO `bukus` VALUES (1,'BK-MAT-101-713',1,'Buku Matematika Kelas 10 Semester 1','Tim Penulis Matematika','Kemendikbud',2020,35,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 07:11:15'),(2,'BK-MAT-102-876',1,'Buku Matematika Kelas 10 Semester 2','Tim Penulis Matematika','Erlangga',2021,30,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(3,'BK-MAT-111-439',1,'Buku Matematika Kelas 11 Semester 1','Tim Penulis Matematika','Gramedia',2022,19,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(4,'BK-MAT-112-913',1,'Buku Matematika Kelas 11 Semester 2','Tim Penulis Matematika','Erlangga',2019,31,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(5,'BK-MAT-121-847',1,'Buku Matematika Kelas 12 Semester 1','Tim Penulis Matematika','Kemendikbud',2021,31,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(6,'BK-MAT-122-653',1,'Buku Matematika Kelas 12 Semester 2','Tim Penulis Matematika','Gramedia',2023,34,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(7,'BK-BAH-101-939',2,'Buku Bahasa Indonesia Kelas 10 Semester 1','Tim Penulis Bahasa Indonesia','Gramedia',2024,24,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-23 01:17:53'),(8,'BK-BAH-102-656',2,'Buku Bahasa Indonesia Kelas 10 Semester 2','Tim Penulis Bahasa Indonesia','Erlangga',2020,21,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(9,'BK-BAH-111-642',2,'Buku Bahasa Indonesia Kelas 11 Semester 1','Tim Penulis Bahasa Indonesia','Gramedia',2024,27,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(10,'BK-BAH-112-621',2,'Buku Bahasa Indonesia Kelas 11 Semester 2','Tim Penulis Bahasa Indonesia','Gramedia',2018,16,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(11,'BK-BAH-121-582',2,'Buku Bahasa Indonesia Kelas 12 Semester 1','Tim Penulis Bahasa Indonesia','Kemendikbud',2022,13,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(12,'BK-BAH-122-814',2,'Buku Bahasa Indonesia Kelas 12 Semester 2','Tim Penulis Bahasa Indonesia','Kemendikbud',2024,14,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(13,'BK-BAH-101-286',3,'Buku Bahasa Inggris Kelas 10 Semester 1','Tim Penulis Bahasa Inggris','Yudhistira',2020,26,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(14,'BK-BAH-102-723',3,'Buku Bahasa Inggris Kelas 10 Semester 2','Tim Penulis Bahasa Inggris','Gramedia',2024,23,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(15,'BK-BAH-111-837',3,'Buku Bahasa Inggris Kelas 11 Semester 1','Tim Penulis Bahasa Inggris','Gramedia',2018,12,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(16,'BK-BAH-112-609',3,'Buku Bahasa Inggris Kelas 11 Semester 2','Tim Penulis Bahasa Inggris','Kemendikbud',2022,24,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(17,'BK-BAH-121-840',3,'Buku Bahasa Inggris Kelas 12 Semester 1','Tim Penulis Bahasa Inggris','Gramedia',2023,32,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(18,'BK-BAH-122-204',3,'Buku Bahasa Inggris Kelas 12 Semester 2','Tim Penulis Bahasa Inggris','Gramedia',2022,25,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(19,'BK-IPA-101-863',4,'Buku IPA Kelas 10 Semester 1','Tim Penulis IPA','Erlangga',2021,23,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(20,'BK-IPA-102-462',4,'Buku IPA Kelas 10 Semester 2','Tim Penulis IPA','Erlangga',2020,15,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(21,'BK-IPA-111-161',4,'Buku IPA Kelas 11 Semester 1','Tim Penulis IPA','Erlangga',2023,35,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(22,'BK-IPA-112-327',4,'Buku IPA Kelas 11 Semester 2','Tim Penulis IPA','Gramedia',2018,26,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(23,'BK-IPA-121-209',4,'Buku IPA Kelas 12 Semester 1','Tim Penulis IPA','Erlangga',2019,23,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(24,'BK-IPA-122-723',4,'Buku IPA Kelas 12 Semester 2','Tim Penulis IPA','Kemendikbud',2020,37,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(25,'BK-FIS-101-318',5,'Buku Fisika Kelas 10 Semester 1','Tim Penulis Fisika','Erlangga',2020,24,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(26,'BK-FIS-102-212',5,'Buku Fisika Kelas 10 Semester 2','Tim Penulis Fisika','Gramedia',2024,21,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(27,'BK-FIS-111-349',5,'Buku Fisika Kelas 11 Semester 1','Tim Penulis Fisika','Gramedia',2019,33,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(28,'BK-FIS-112-564',5,'Buku Fisika Kelas 11 Semester 2','Tim Penulis Fisika','Gramedia',2021,36,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 07:10:46'),(29,'BK-FIS-121-896',5,'Buku Fisika Kelas 12 Semester 1','Tim Penulis Fisika','Yudhistira',2023,36,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(30,'BK-FIS-122-309',5,'Buku Fisika Kelas 12 Semester 2','Tim Penulis Fisika','Erlangga',2022,14,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 07:10:57'),(31,'BK-KIM-101-596',6,'Buku Kimia Kelas 10 Semester 1','Tim Penulis Kimia','Gramedia',2022,35,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(32,'BK-KIM-102-283',6,'Buku Kimia Kelas 10 Semester 2','Tim Penulis Kimia','Gramedia',2022,34,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(33,'BK-KIM-111-221',6,'Buku Kimia Kelas 11 Semester 1','Tim Penulis Kimia','Erlangga',2019,30,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(34,'BK-KIM-112-866',6,'Buku Kimia Kelas 11 Semester 2','Tim Penulis Kimia','Yudhistira',2018,14,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(35,'BK-KIM-121-878',6,'Buku Kimia Kelas 12 Semester 1','Tim Penulis Kimia','Gramedia',2019,16,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(36,'BK-KIM-122-608',6,'Buku Kimia Kelas 12 Semester 2','Tim Penulis Kimia','Yudhistira',2022,39,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(37,'BK-BIO-101-716',7,'Buku Biologi Kelas 10 Semester 1','Tim Penulis Biologi','Yudhistira',2020,14,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(38,'BK-BIO-102-224',7,'Buku Biologi Kelas 10 Semester 2','Tim Penulis Biologi','Gramedia',2024,40,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(39,'BK-BIO-111-336',7,'Buku Biologi Kelas 11 Semester 1','Tim Penulis Biologi','Erlangga',2021,17,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(40,'BK-BIO-112-271',7,'Buku Biologi Kelas 11 Semester 2','Tim Penulis Biologi','Erlangga',2024,38,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(41,'BK-BIO-121-659',7,'Buku Biologi Kelas 12 Semester 1','Tim Penulis Biologi','Kemendikbud',2022,27,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(42,'BK-BIO-122-143',7,'Buku Biologi Kelas 12 Semester 2','Tim Penulis Biologi','Kemendikbud',2024,15,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(43,'BK-IPS-101-134',8,'Buku IPS Kelas 10 Semester 1','Tim Penulis IPS','Gramedia',2018,39,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(44,'BK-IPS-102-926',8,'Buku IPS Kelas 10 Semester 2','Tim Penulis IPS','Gramedia',2020,29,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(45,'BK-IPS-111-967',8,'Buku IPS Kelas 11 Semester 1','Tim Penulis IPS','Gramedia',2021,25,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(46,'BK-IPS-112-832',8,'Buku IPS Kelas 11 Semester 2','Tim Penulis IPS','Kemendikbud',2024,23,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(47,'BK-IPS-121-980',8,'Buku IPS Kelas 12 Semester 1','Tim Penulis IPS','Gramedia',2024,18,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(48,'BK-IPS-122-134',8,'Buku IPS Kelas 12 Semester 2','Tim Penulis IPS','Gramedia',2021,30,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(49,'BK-SEJ-101-952',9,'Buku Sejarah Kelas 10 Semester 1','Tim Penulis Sejarah','Kemendikbud',2022,26,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(50,'BK-SEJ-102-565',9,'Buku Sejarah Kelas 10 Semester 2','Tim Penulis Sejarah','Yudhistira',2023,31,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(51,'BK-SEJ-111-563',9,'Buku Sejarah Kelas 11 Semester 1','Tim Penulis Sejarah','Yudhistira',2020,40,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(52,'BK-SEJ-112-220',9,'Buku Sejarah Kelas 11 Semester 2','Tim Penulis Sejarah','Yudhistira',2018,31,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(53,'BK-SEJ-121-984',9,'Buku Sejarah Kelas 12 Semester 1','Tim Penulis Sejarah','Erlangga',2021,33,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(54,'BK-SEJ-122-185',9,'Buku Sejarah Kelas 12 Semester 2','Tim Penulis Sejarah','Erlangga',2021,28,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(55,'BK-GEO-101-150',10,'Buku Geografi Kelas 10 Semester 1','Tim Penulis Geografi','Yudhistira',2024,25,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(56,'BK-GEO-102-925',10,'Buku Geografi Kelas 10 Semester 2','Tim Penulis Geografi','Kemendikbud',2021,22,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(57,'BK-GEO-111-446',10,'Buku Geografi Kelas 11 Semester 1','Tim Penulis Geografi','Gramedia',2023,22,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(58,'BK-GEO-112-265',10,'Buku Geografi Kelas 11 Semester 2','Tim Penulis Geografi','Gramedia',2021,23,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(59,'BK-GEO-121-668',10,'Buku Geografi Kelas 12 Semester 1','Tim Penulis Geografi','Gramedia',2018,19,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(60,'BK-GEO-122-756',10,'Buku Geografi Kelas 12 Semester 2','Tim Penulis Geografi','Erlangga',2020,34,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(61,'BK-EKO-101-712',11,'Buku Ekonomi Kelas 10 Semester 1','Tim Penulis Ekonomi','Yudhistira',2020,31,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(62,'BK-EKO-102-595',11,'Buku Ekonomi Kelas 10 Semester 2','Tim Penulis Ekonomi','Kemendikbud',2022,36,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(63,'BK-EKO-111-802',11,'Buku Ekonomi Kelas 11 Semester 1','Tim Penulis Ekonomi','Kemendikbud',2021,26,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(64,'BK-EKO-112-573',11,'Buku Ekonomi Kelas 11 Semester 2','Tim Penulis Ekonomi','Kemendikbud',2019,24,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(65,'BK-EKO-121-265',11,'Buku Ekonomi Kelas 12 Semester 1','Tim Penulis Ekonomi','Kemendikbud',2022,24,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(66,'BK-EKO-122-277',11,'Buku Ekonomi Kelas 12 Semester 2','Tim Penulis Ekonomi','Gramedia',2023,30,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(67,'BK-PKN-101-901',12,'Buku PKN Kelas 10 Semester 1','Tim Penulis PKN','Gramedia',2024,33,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(68,'BK-PKN-102-320',12,'Buku PKN Kelas 10 Semester 2','Tim Penulis PKN','Kemendikbud',2018,30,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(69,'BK-PKN-111-353',12,'Buku PKN Kelas 11 Semester 1','Tim Penulis PKN','Yudhistira',2019,23,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(70,'BK-PKN-112-210',12,'Buku PKN Kelas 11 Semester 2','Tim Penulis PKN','Kemendikbud',2022,31,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(71,'BK-PKN-121-437',12,'Buku PKN Kelas 12 Semester 1','Tim Penulis PKN','Yudhistira',2024,40,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(72,'BK-PKN-122-666',12,'Buku PKN Kelas 12 Semester 2','Tim Penulis PKN','Yudhistira',2023,38,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(73,'BK-INF-101-448',13,'Buku Informatika Kelas 10 Semester 1','Tim Penulis Informatika','Kemendikbud',2019,35,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(74,'BK-INF-102-408',13,'Buku Informatika Kelas 10 Semester 2','Tim Penulis Informatika','Yudhistira',2019,37,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(75,'BK-INF-111-432',13,'Buku Informatika Kelas 11 Semester 1','Tim Penulis Informatika','Gramedia',2022,36,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(76,'BK-INF-112-918',13,'Buku Informatika Kelas 11 Semester 2','Tim Penulis Informatika','Erlangga',2022,24,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(77,'BK-INF-121-583',13,'Buku Informatika Kelas 12 Semester 1','Tim Penulis Informatika','Gramedia',2020,35,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(78,'BK-INF-122-454',13,'Buku Informatika Kelas 12 Semester 2','Tim Penulis Informatika','Kemendikbud',2022,16,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(79,'BK-SEN-101-840',14,'Buku Seni Budaya Kelas 10 Semester 1','Tim Penulis Seni Budaya','Erlangga',2019,31,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(80,'BK-SEN-102-292',14,'Buku Seni Budaya Kelas 10 Semester 2','Tim Penulis Seni Budaya','Yudhistira',2024,15,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(81,'BK-SEN-111-971',14,'Buku Seni Budaya Kelas 11 Semester 1','Tim Penulis Seni Budaya','Yudhistira',2021,17,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(82,'BK-SEN-112-763',14,'Buku Seni Budaya Kelas 11 Semester 2','Tim Penulis Seni Budaya','Yudhistira',2021,35,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(83,'BK-SEN-121-929',14,'Buku Seni Budaya Kelas 12 Semester 1','Tim Penulis Seni Budaya','Erlangga',2018,38,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(84,'BK-SEN-122-729',14,'Buku Seni Budaya Kelas 12 Semester 2','Tim Penulis Seni Budaya','Erlangga',2021,20,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(85,'BK-PJO-101-432',15,'Buku PJOK Kelas 10 Semester 1','Tim Penulis PJOK','Kemendikbud',2021,30,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(86,'BK-PJO-102-421',15,'Buku PJOK Kelas 10 Semester 2','Tim Penulis PJOK','Kemendikbud',2021,17,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:57'),(87,'BK-PJO-111-711',15,'Buku PJOK Kelas 11 Semester 1','Tim Penulis PJOK','Gramedia',2023,15,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(88,'BK-PJO-112-351',15,'Buku PJOK Kelas 11 Semester 2','Tim Penulis PJOK','Kemendikbud',2020,21,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(89,'BK-PJO-121-409',15,'Buku PJOK Kelas 12 Semester 1','Tim Penulis PJOK','Yudhistira',2019,15,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(90,'BK-PJO-122-605',15,'Buku PJOK Kelas 12 Semester 2','Tim Penulis PJOK','Erlangga',2018,39,'buku/default.png',1000,'2026-04-22 03:36:56','2026-04-22 03:36:56');
/*!40000 ALTER TABLE `bukus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('laravel-cache-5c785c036466adea360111aa28563bfd556b5fba','i:1;',1776917699),('laravel-cache-5c785c036466adea360111aa28563bfd556b5fba:timer','i:1776917699;',1776917699);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_siswas`
--

DROP TABLE IF EXISTS `data_siswas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_siswas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nisn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kelas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jurusan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun_angkatan` year NOT NULL,
  `tahun_ajaran` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_siswas_nisn_unique` (`nisn`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_siswas`
--

LOCK TABLES `data_siswas` WRITE;
/*!40000 ALTER TABLE `data_siswas` DISABLE KEYS */;
INSERT INTO `data_siswas` VALUES (1,'1000000001','Siswa 1','XI','BROADCASTING',2024,'2024/2025','aktif','2026-04-22 03:36:42','2026-04-22 03:36:42'),(2,'1000000002','Siswa 2','XI','TO',2024,'2024/2025','aktif','2026-04-22 03:36:42','2026-04-22 03:36:42'),(3,'1000000003','Siswa 3','XI','ANIMASI',2024,'2024/2025','aktif','2026-04-22 03:36:43','2026-04-22 03:36:43'),(4,'1000000004','Siswa 4','XII','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:43','2026-04-22 03:36:43'),(5,'1000000005','Siswa 5','XI','ANIMASI',2024,'2024/2025','aktif','2026-04-22 03:36:44','2026-04-22 03:36:44'),(6,'1000000006','Siswa 6','X','TO',2024,'2024/2025','aktif','2026-04-22 03:36:44','2026-04-22 03:36:44'),(7,'1000000007','Siswa 7','XI','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:45','2026-04-22 03:36:45'),(8,'1000000008','Siswa 8','XII','TPFL',2024,'2024/2025','aktif','2026-04-22 03:36:45','2026-04-22 03:36:45'),(9,'1000000009','Siswa 9','X','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:46','2026-04-22 03:36:46'),(10,'1000000010','Siswa 10','X','TPFL',2024,'2024/2025','aktif','2026-04-22 03:36:46','2026-04-22 03:36:46'),(11,'1000000011','Siswa 11','X','ANIMASI',2024,'2024/2025','aktif','2026-04-22 03:36:47','2026-04-22 03:36:47'),(12,'1000000012','Siswa 12','X','BROADCASTING',2024,'2024/2025','aktif','2026-04-22 03:36:47','2026-04-22 03:36:47'),(13,'1000000013','Siswa 13','XII','TPFL',2024,'2024/2025','aktif','2026-04-22 03:36:48','2026-04-22 03:36:48'),(14,'1000000014','Siswa 14','X','TPFL',2024,'2024/2025','aktif','2026-04-22 03:36:48','2026-04-22 03:36:48'),(15,'1000000015','Siswa 15','X','ANIMASI',2024,'2024/2025','aktif','2026-04-22 03:36:49','2026-04-22 03:36:49'),(16,'1000000016','Siswa 16','X','TPFL',2024,'2024/2025','aktif','2026-04-22 03:36:49','2026-04-22 03:36:49'),(17,'1000000017','Siswa 17','XII','TO',2024,'2024/2025','aktif','2026-04-22 03:36:49','2026-04-22 03:36:49'),(18,'1000000018','Siswa 18','X','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:50','2026-04-22 03:36:50'),(19,'1000000019','Siswa 19','XII','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:50','2026-04-22 03:36:50'),(20,'1000000020','Siswa 20','X','ANIMASI',2024,'2024/2025','aktif','2026-04-22 03:36:51','2026-04-22 03:36:51'),(21,'1000000021','Siswa 21','XI','ANIMASI',2024,'2024/2025','aktif','2026-04-22 03:36:51','2026-04-22 03:36:51'),(22,'1000000022','Siswa 22','X','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:52','2026-04-22 03:36:52'),(23,'1000000023','Siswa 23','X','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:52','2026-04-22 03:36:52'),(24,'1000000024','Siswa 24','XI','TPFL',2024,'2024/2025','aktif','2026-04-22 03:36:53','2026-04-22 03:36:53'),(25,'1000000025','Siswa 25','XII','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:53','2026-04-22 03:36:53'),(26,'1000000026','Siswa 26','X','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:54','2026-04-22 03:36:54'),(27,'1000000027','Siswa 27','XI','PPLG',2024,'2024/2025','aktif','2026-04-22 03:36:54','2026-04-22 03:36:54'),(28,'1000000028','Siswa 28','XII','TPFL',2024,'2024/2025','aktif','2026-04-22 03:36:55','2026-04-22 03:36:55'),(29,'1000000029','Siswa 29','XII','TO',2024,'2024/2025','aktif','2026-04-22 03:36:55','2026-04-22 03:36:55'),(30,'1000000030','Siswa 30','X','TO',2024,'2024/2025','aktif','2026-04-22 03:36:56','2026-04-22 03:36:56');
/*!40000 ALTER TABLE `data_siswas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dendas`
--

DROP TABLE IF EXISTS `dendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dendas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_pengembalian` bigint unsigned NOT NULL,
  `tarif_per_hari` int NOT NULL,
  `total_denda` int NOT NULL,
  `status` enum('belum_ditindak','diingatkan','dibayar') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'belum_ditindak',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dendas_id_pengembalian_foreign` (`id_pengembalian`),
  CONSTRAINT `dendas_id_pengembalian_foreign` FOREIGN KEY (`id_pengembalian`) REFERENCES `pengembalians` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dendas`
--

LOCK TABLES `dendas` WRITE;
/*!40000 ALTER TABLE `dendas` DISABLE KEYS */;
/*!40000 ALTER TABLE `dendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategoris`
--

DROP TABLE IF EXISTS `kategoris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategoris` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategoris`
--

LOCK TABLES `kategoris` WRITE;
/*!40000 ALTER TABLE `kategoris` DISABLE KEYS */;
INSERT INTO `kategoris` VALUES (1,'Matematika','Buku mata pelajaran Matematika','2026-04-22 03:36:56','2026-04-22 03:36:56'),(2,'Bahasa Indonesia','Buku mata pelajaran Bahasa Indonesia','2026-04-22 03:36:56','2026-04-22 03:36:56'),(3,'Bahasa Inggris','Buku mata pelajaran Bahasa Inggris','2026-04-22 03:36:56','2026-04-22 03:36:56'),(4,'IPA','Buku mata pelajaran IPA','2026-04-22 03:36:56','2026-04-22 03:36:56'),(5,'Fisika','Buku mata pelajaran Fisika','2026-04-22 03:36:56','2026-04-22 03:36:56'),(6,'Kimia','Buku mata pelajaran Kimia','2026-04-22 03:36:56','2026-04-22 03:36:56'),(7,'Biologi','Buku mata pelajaran Biologi','2026-04-22 03:36:56','2026-04-22 03:36:56'),(8,'IPS','Buku mata pelajaran IPS','2026-04-22 03:36:56','2026-04-22 03:36:56'),(9,'Sejarah','Buku mata pelajaran Sejarah','2026-04-22 03:36:56','2026-04-22 03:36:56'),(10,'Geografi','Buku mata pelajaran Geografi','2026-04-22 03:36:56','2026-04-22 03:36:56'),(11,'Ekonomi','Buku mata pelajaran Ekonomi','2026-04-22 03:36:56','2026-04-22 03:36:56'),(12,'PKN','Buku mata pelajaran PKN','2026-04-22 03:36:56','2026-04-22 03:36:56'),(13,'Informatika','Buku mata pelajaran Informatika','2026-04-22 03:36:56','2026-04-22 03:36:56'),(14,'Seni Budaya','Buku mata pelajaran Seni Budaya','2026-04-22 03:36:56','2026-04-22 03:36:56'),(15,'PJOK','Buku mata pelajaran PJOK','2026-04-22 03:36:56','2026-04-22 03:36:56');
/*!40000 ALTER TABLE `kategoris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_aktivitas`
--

DROP TABLE IF EXISTS `log_aktivitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_aktivitas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint unsigned NOT NULL,
  `aktivitas` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `waktu` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_aktivitas_id_user_foreign` (`id_user`),
  CONSTRAINT `log_aktivitas_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_aktivitas`
--

LOCK TABLES `log_aktivitas` WRITE;
/*!40000 ALTER TABLE `log_aktivitas` DISABLE KEYS */;
INSERT INTO `log_aktivitas` VALUES (1,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-22 03:39:50'),(2,1,'LOGOUT - Autentikasi - User \'Administrator\' keluar dari sistem','2026-04-22 03:40:20'),(3,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-22 03:48:19'),(4,1,'MENGUBAH - Denda Peminjaman - Melunasi denda (Kode PMJ-69e842594cd54) sebesar Rp 2.000','2026-04-22 03:48:36'),(5,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-22 06:36:22'),(6,1,'MENGUBAH - Peminjaman - Menolak pengajuan peminjaman buku (Kode PMJ-69e8425a02879)','2026-04-22 07:10:12'),(7,1,'MENGUBAH - Peminjaman - Menyetujui pengajuan peminjaman buku (Kode PMJ-69e8425a05071)','2026-04-22 07:10:46'),(8,1,'MENGUBAH - Peminjaman - Menyetujui pengajuan peminjaman buku (Kode PMJ-69e8425a000aa)','2026-04-22 07:10:57'),(9,1,'MENGUBAH - Peminjaman - Menyetujui pengajuan peminjaman buku (Kode PMJ-69e8425a3158e)','2026-04-22 07:11:15'),(10,2,'LOGIN - Autentikasi - User \'user1\' berhasil login ke sistem','2026-04-22 23:36:25'),(11,2,'LOGOUT - Autentikasi - User \'Siswa 1\' keluar dari sistem','2026-04-22 23:39:20'),(12,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-22 23:39:30'),(13,1,'LOGOUT - Autentikasi - User \'Administrator\' keluar dari sistem','2026-04-22 23:41:09'),(14,2,'LOGIN - Autentikasi - User \'user1\' berhasil login ke sistem','2026-04-22 23:41:38'),(15,2,'LOGOUT - Autentikasi - User \'Siswa 1\' keluar dari sistem','2026-04-22 23:42:01'),(16,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-22 23:42:15'),(17,1,'LOGOUT - Autentikasi - User \'Administrator\' keluar dari sistem','2026-04-23 00:03:53'),(18,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-23 00:04:03'),(19,2,'LOGIN - Autentikasi - User \'user1\' berhasil login ke sistem','2026-04-23 00:04:49'),(20,2,'MENAMBAHKAN - Peminjaman - Mengajukan peminjaman buku \'Buku Bahasa Indonesia Kelas 10 Semester 1\' sebanyak 1 unit (Kode PMJ-2026-0285)','2026-04-23 00:05:22'),(21,2,'MENAMBAHKAN - Peminjaman - Mengajukan peminjaman buku \'Buku Bahasa Indonesia Kelas 10 Semester 1\' sebanyak 1 unit (Kode PMJ-2026-0286)','2026-04-23 00:09:31'),(22,1,'MENGUBAH - Peminjaman - Menyetujui pengajuan peminjaman buku (Kode PMJ-2026-0286)','2026-04-23 01:17:53'),(23,1,'MENGUBAH - Denda Peminjaman - Melunasi denda (Kode PMJ-69e8425a4284f) sebesar Rp 30.564','2026-04-23 01:28:05'),(24,1,'MENGUBAH - Peminjaman - Menolak pengajuan peminjaman buku (Kode PMJ-2026-0285)','2026-04-23 01:39:15'),(25,1,'LOGOUT - Autentikasi - User \'Administrator\' keluar dari sistem','2026-04-23 01:39:21'),(26,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-23 01:39:32'),(27,2,'LOGOUT - Autentikasi - User \'Siswa 1\' keluar dari sistem','2026-04-23 01:39:54'),(28,32,'REGISTER - Autentikasi - Register user: \'Rofi Nugraha\'','2026-04-23 01:41:06'),(29,2,'LOGIN - Autentikasi - User \'user1\' berhasil login ke sistem','2026-04-23 01:44:55'),(30,2,'MENGUBAH - Profil Siswa - Memperbarui profil siswa \'Siswa 1\' (NISN: 1000000001)','2026-04-23 01:45:39'),(31,2,'MENAMBAHKAN - Peminjaman - Mengajukan peminjaman buku \'Buku Bahasa Indonesia Kelas 10 Semester 1\' sebanyak 1 unit (Kode PMJ-2026-0287)','2026-04-23 01:46:24'),(32,2,'MENGUBAH - Peminjaman - Membatalkan pengajuan peminjaman (Kode PMJ-2026-0287)','2026-04-23 01:46:46'),(33,2,'MENAMBAHKAN - Peminjaman - Mengajukan peminjaman buku \'Buku Bahasa Indonesia Kelas 10 Semester 1\' sebanyak 1 unit (Kode PMJ-2026-0288)','2026-04-23 01:47:26'),(34,2,'LOGOUT - Autentikasi - User \'Siswa 1\' keluar dari sistem','2026-04-23 01:47:30'),(35,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-23 01:47:42'),(36,1,'LOGOUT - Autentikasi - User \'Administrator\' keluar dari sistem','2026-04-23 01:53:57'),(37,29,'LOGIN - Autentikasi - User \'user28\' berhasil login ke sistem','2026-04-23 01:54:08'),(38,29,'LOGOUT - Autentikasi - User \'Siswa 28\' keluar dari sistem','2026-04-23 01:55:53'),(39,32,'LOGIN - Autentikasi - User \'rofinugraha\' berhasil login ke sistem','2026-04-23 02:09:55'),(40,32,'LOGOUT - Autentikasi - User \'Rofi Nugraha\' keluar dari sistem','2026-04-23 02:10:07'),(41,2,'LOGIN - Autentikasi - User \'user1\' berhasil login ke sistem','2026-04-23 02:12:13'),(42,2,'LOGOUT - Autentikasi - User \'Siswa 1\' keluar dari sistem','2026-04-23 02:27:35'),(43,2,'LOGIN - Autentikasi - User \'user1\' berhasil login ke sistem','2026-04-23 03:09:59'),(44,2,'LOGOUT - Autentikasi - User \'Siswa 1\' keluar dari sistem','2026-04-23 03:11:32'),(45,1,'LOGIN - Autentikasi - User \'admin\' berhasil login ke sistem','2026-04-23 03:12:52'),(46,1,'LOGOUT - Autentikasi - User \'Administrator\' keluar dari sistem','2026-04-23 04:07:25'),(47,2,'LOGIN - Autentikasi - User \'user1\' berhasil login ke sistem','2026-04-23 04:13:59'),(48,2,'MENAMBAHKAN - Peminjaman - Mengajukan peminjaman buku \'Buku Bahasa Indonesia Kelas 10 Semester 1\' sebanyak 1 unit (Kode PMJ-2026-0289)','2026-04-23 04:19:00');
/*!40000 ALTER TABLE `log_aktivitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'0001_01_01_000003_create_sessions_table',1),(5,'2026_02_03_035702_create_kategoris_table',1),(6,'2026_02_03_035800_create_bukus_table',1),(7,'2026_02_03_040010_create_peminjamans_table',1),(8,'2026_02_03_040211_create_pengembalians_table',1),(9,'2026_02_03_040337_create_log_aktivitas_table',1),(10,'2026_02_09_094939_create_peminjaman_items_table',1),(11,'2026_02_11_214746_create_dendas_table',1),(12,'2026_02_11_214806_create_notifications_table',1),(13,'2026_04_12_202915_pengembalian_items',1),(14,'2026_04_12_202940_data_siswas',1),(15,'2026_04_12_202956_profil_siswas',1),(16,'2026_04_21_145541_add_book_fields_to_bukus_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint unsigned NOT NULL,
  `judul` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pesan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `dibaca` tinyint(1) NOT NULL DEFAULT '0',
  `notifiable_id` bigint unsigned DEFAULT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_id_user_foreign` (`id_user`),
  CONSTRAINT `notifications_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,2,'Denda Lunas','Pembayaran denda telah diterima.',1,42,'App\\Models\\Peminjaman','2026-04-22 03:48:36','2026-04-22 23:37:31'),(2,26,'Denda Lunas','Pembayaran denda telah diterima.',0,125,'App\\Models\\Peminjaman','2026-04-23 01:28:05','2026-04-23 01:28:05'),(3,29,'Pengingat Denda Buku','Anda memiliki denda peminjaman buku sebesar Rp 2.000. Segera lakukan pembayaran.',1,1,'App\\Models\\Peminjaman','2026-04-23 01:53:52','2026-04-23 01:54:24');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peminjaman_items`
--

DROP TABLE IF EXISTS `peminjaman_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peminjaman_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_peminjaman` bigint unsigned NOT NULL,
  `id_buku` bigint unsigned NOT NULL,
  `qty` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `peminjaman_items_id_peminjaman_foreign` (`id_peminjaman`),
  KEY `peminjaman_items_id_buku_foreign` (`id_buku`),
  CONSTRAINT `peminjaman_items_id_buku_foreign` FOREIGN KEY (`id_buku`) REFERENCES `bukus` (`id`),
  CONSTRAINT `peminjaman_items_id_peminjaman_foreign` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjamans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peminjaman_items`
--

LOCK TABLES `peminjaman_items` WRITE;
/*!40000 ALTER TABLE `peminjaman_items` DISABLE KEYS */;
INSERT INTO `peminjaman_items` VALUES (1,1,24,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(2,2,66,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(3,3,41,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(4,4,3,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(5,5,36,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(6,6,11,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(7,7,13,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(8,8,86,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(9,9,53,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(10,10,14,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(11,11,51,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(12,12,3,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(13,13,64,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(14,14,80,2,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(15,15,61,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(16,16,82,1,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(17,17,85,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(18,18,34,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(19,19,12,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(20,20,18,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(21,21,26,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(22,22,54,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(23,23,49,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(24,24,35,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(25,25,42,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(26,26,60,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(27,27,88,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(28,28,73,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(29,29,8,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(30,30,13,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(31,31,9,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(32,32,80,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(33,33,77,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(34,34,71,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(35,35,4,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(36,36,88,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(37,37,37,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(38,38,52,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(39,39,81,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(40,40,54,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(41,41,53,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(42,42,8,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(43,43,6,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(44,44,55,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(45,45,68,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(46,46,50,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(47,47,13,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(48,48,60,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(49,49,50,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(50,50,76,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(51,51,56,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(52,52,41,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(53,53,66,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(54,54,19,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(55,55,86,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(56,56,13,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(57,57,51,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(58,58,19,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(59,59,69,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(60,60,5,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(61,61,19,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(62,62,83,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(63,63,15,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(64,64,46,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(65,65,66,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(66,66,56,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(67,67,77,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(68,68,79,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(69,69,43,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(70,70,72,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(71,71,59,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(72,72,86,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(73,73,48,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(74,74,37,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(75,75,22,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(76,76,7,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(77,77,3,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(78,78,39,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(79,79,18,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(80,80,14,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(81,81,29,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(82,82,9,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(83,83,28,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(84,84,61,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(85,85,43,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(86,86,76,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(87,87,58,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(88,88,66,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(89,89,15,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(90,90,39,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(91,91,80,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(92,92,54,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(93,93,81,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(94,94,40,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(95,95,37,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(96,96,23,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(97,97,66,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(98,98,42,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(99,99,10,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(100,100,6,1,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(101,101,24,2,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(102,102,30,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(103,103,45,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(104,104,28,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(105,105,40,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(106,106,29,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(107,107,39,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(108,108,26,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(109,109,12,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(110,110,15,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(111,111,6,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(112,112,10,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(113,113,13,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(114,114,77,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(115,115,37,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(116,116,2,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(117,117,38,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(118,118,43,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(119,119,1,2,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(120,120,41,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(121,121,77,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(122,122,41,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(123,123,27,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(124,124,30,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(125,125,34,1,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(126,126,7,1,'2026-04-23 00:05:22','2026-04-23 00:05:22'),(127,127,7,1,'2026-04-23 00:09:31','2026-04-23 00:09:31'),(128,128,7,1,'2026-04-23 01:46:24','2026-04-23 01:46:24'),(129,129,7,1,'2026-04-23 01:47:26','2026-04-23 01:47:26'),(130,130,7,1,'2026-04-23 04:19:00','2026-04-23 04:19:00');
/*!40000 ALTER TABLE `peminjaman_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peminjamans`
--

DROP TABLE IF EXISTS `peminjamans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peminjamans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kode_peminjaman` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_user` bigint unsigned NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `status` enum('menunggu','disetujui','ditolak','dibatalkan','kadaluarsa','dikembalikan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menunggu',
  `total_denda` int NOT NULL DEFAULT '0',
  `status_denda` enum('tidak_ada','belum','lunas') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tidak_ada',
  `approved_by` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejected_by` bigint unsigned DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `peminjamans_kode_peminjaman_unique` (`kode_peminjaman`),
  KEY `peminjamans_id_user_foreign` (`id_user`),
  KEY `peminjamans_approved_by_foreign` (`approved_by`),
  KEY `peminjamans_rejected_by_foreign` (`rejected_by`),
  CONSTRAINT `peminjamans_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `peminjamans_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`),
  CONSTRAINT `peminjamans_rejected_by_foreign` FOREIGN KEY (`rejected_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peminjamans`
--

LOCK TABLES `peminjamans` WRITE;
/*!40000 ALTER TABLE `peminjamans` DISABLE KEYS */;
INSERT INTO `peminjamans` VALUES (1,'PMJ-69e84258bff2d',29,'2026-04-17','2026-04-24','dikembalikan',2000,'belum',1,'2026-04-17 04:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(2,'PMJ-69e84258c73da',10,'2026-04-17','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:56','2026-04-23 00:03:24'),(3,'PMJ-69e84258ca290',15,'2026-04-22','2026-04-25','dikembalikan',2000,'belum',1,'2026-04-23 03:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(4,'PMJ-69e84258ce48b',21,'2026-04-22','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:56','2026-04-23 00:03:24'),(5,'PMJ-69e84258d0f97',22,'2026-04-17','2026-04-20','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:56','2026-04-23 00:03:24'),(6,'PMJ-69e84258d3b4b',4,'2026-04-20','2026-04-27','dikembalikan',88342,'belum',1,'2026-04-20 14:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(7,'PMJ-69e84258d6984',17,'2026-04-20','2026-04-25','dikembalikan',2000,'belum',1,'2026-04-20 23:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(8,'PMJ-69e84258d9942',24,'2026-04-18','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:56','2026-04-23 00:03:24'),(9,'PMJ-69e84258dc367',23,'2026-04-22','2026-04-28','ditolak',0,'tidak_ada',NULL,NULL,1,'2026-04-22 07:36:56','2026-04-22 03:36:56','2026-04-22 03:36:56'),(10,'PMJ-69e84258dedeb',5,'2026-04-20','2026-04-24','dikembalikan',101170,'belum',1,'2026-04-20 05:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(11,'PMJ-69e84258e23e6',6,'2026-04-21','2026-04-26','dikembalikan',1000,'belum',1,'2026-04-21 13:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(12,'PMJ-69e84258e6a82',28,'2026-04-17','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:56','2026-04-23 00:03:24'),(13,'PMJ-69e84258e947a',19,'2026-04-21','2026-04-27','dikembalikan',13728,'belum',1,'2026-04-21 08:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(14,'PMJ-69e84258ec732',30,'2026-04-17','2026-04-21','dikembalikan',194848,'belum',1,'2026-04-17 12:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(15,'PMJ-69e84258ef562',30,'2026-04-19','2026-04-26','dikembalikan',14139,'belum',1,'2026-04-20 03:36:56',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:58'),(16,'PMJ-69e84258f2a29',11,'2026-04-20','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:56','2026-04-23 00:03:24'),(17,'PMJ-69e84259010a4',20,'2026-04-21','2026-04-27','dikembalikan',121133,'belum',1,'2026-04-21 17:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(18,'PMJ-69e84259048cb',29,'2026-04-19','2026-04-25','ditolak',0,'tidak_ada',NULL,NULL,1,'2026-04-19 15:36:57','2026-04-22 03:36:57','2026-04-22 03:36:57'),(19,'PMJ-69e84259074ee',15,'2026-04-19','2026-04-24','dikembalikan',55966,'belum',1,'2026-04-19 18:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(20,'PMJ-69e842590a255',23,'2026-04-19','2026-04-25','dikembalikan',98164,'belum',1,'2026-04-19 17:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(21,'PMJ-69e842590d090',6,'2026-04-20','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(22,'PMJ-69e842590fb9b',22,'2026-04-19','2026-04-26','dikembalikan',18610,'belum',1,'2026-04-19 13:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(23,'PMJ-69e8425912dee',24,'2026-04-17','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(24,'PMJ-69e8425915cae',7,'2026-04-22','2026-04-28','dikembalikan',0,'tidak_ada',1,'2026-04-22 17:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(25,'PMJ-69e8425919221',3,'2026-04-22','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(26,'PMJ-69e842591bdc2',17,'2026-04-20','2026-04-26','dikembalikan',1000,'belum',1,'2026-04-20 15:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(27,'PMJ-69e842591fbf1',20,'2026-04-17','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(28,'PMJ-69e8425922d53',6,'2026-04-17','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(29,'PMJ-69e8425925ab3',12,'2026-04-17','2026-04-23','dikembalikan',0,'tidak_ada',1,'2026-04-17 08:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(30,'PMJ-69e8425928f84',10,'2026-04-22','2026-04-28','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(31,'PMJ-69e842592b7a4',18,'2026-04-19','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(32,'PMJ-69e842592e134',9,'2026-04-20','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(33,'PMJ-69e8425930e92',27,'2026-04-19','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(34,'PMJ-69e8425933990',30,'2026-04-21','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(35,'PMJ-69e8425936513',13,'2026-04-18','2026-04-23','dikembalikan',94060,'belum',1,'2026-04-18 07:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(36,'PMJ-69e8425939582',10,'2026-04-17','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(37,'PMJ-69e842593c05a',20,'2026-04-19','2026-04-25','dikembalikan',93533,'belum',1,'2026-04-19 05:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(38,'PMJ-69e842593f645',12,'2026-04-20','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(39,'PMJ-69e8425941f92',17,'2026-04-19','2026-04-24','dikembalikan',0,'tidak_ada',1,'2026-04-19 13:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(40,'PMJ-69e8425945da3',17,'2026-04-22','2026-04-28','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(41,'PMJ-69e842594953f',3,'2026-04-17','2026-04-22','dikembalikan',0,'tidak_ada',1,'2026-04-17 17:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(42,'PMJ-69e842594cd54',2,'2026-04-19','2026-04-24','dikembalikan',2000,'lunas',1,'2026-04-19 05:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:48:36'),(43,'PMJ-69e842594fcad',6,'2026-04-18','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(44,'PMJ-69e8425952742',19,'2026-04-17','2026-04-20','dikembalikan',206768,'belum',1,'2026-04-17 16:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(45,'PMJ-69e842595570f',9,'2026-04-20','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(46,'PMJ-69e84259580d8',24,'2026-04-19','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(47,'PMJ-69e842595a98c',29,'2026-04-19','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(48,'PMJ-69e842595d336',16,'2026-04-21','2026-04-27','dikembalikan',97725,'belum',1,'2026-04-21 08:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(49,'PMJ-69e842596007c',5,'2026-04-18','2026-04-23','dikembalikan',75463,'belum',1,'2026-04-18 06:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(50,'PMJ-69e842596338b',27,'2026-04-20','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(51,'PMJ-69e8425965ec9',16,'2026-04-22','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(52,'PMJ-69e842596897f',20,'2026-04-18','2026-04-21','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(53,'PMJ-69e842596b27e',13,'2026-04-22','2026-04-29','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(54,'PMJ-69e842596daef',14,'2026-04-21','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(55,'PMJ-69e8425970310',21,'2026-04-20','2026-04-25','dikembalikan',147335,'belum',1,'2026-04-21 01:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(56,'PMJ-69e8425973734',8,'2026-04-22','2026-04-25','dikembalikan',1000,'belum',1,'2026-04-22 05:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(57,'PMJ-69e842597705e',3,'2026-04-19','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(58,'PMJ-69e8425979aeb',19,'2026-04-20','2026-04-26','ditolak',0,'tidak_ada',NULL,NULL,1,'2026-04-21 00:36:57','2026-04-22 03:36:57','2026-04-22 03:36:57'),(59,'PMJ-69e842597c1d1',28,'2026-04-19','2026-04-23','dikembalikan',165486,'belum',1,'2026-04-19 23:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(60,'PMJ-69e842597f469',8,'2026-04-17','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(61,'PMJ-69e8425981d4f',16,'2026-04-19','2026-04-26','dikembalikan',48312,'belum',1,'2026-04-19 05:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(62,'PMJ-69e8425984d8a',25,'2026-04-21','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(63,'PMJ-69e84259879ad',30,'2026-04-18','2026-04-24','ditolak',0,'tidak_ada',NULL,NULL,1,'2026-04-19 03:36:57','2026-04-22 03:36:57','2026-04-22 03:36:57'),(64,'PMJ-69e842598aa1d',29,'2026-04-20','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(65,'PMJ-69e842598d8c0',22,'2026-04-18','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(66,'PMJ-69e842599028c',14,'2026-04-20','2026-04-24','dikembalikan',0,'tidak_ada',1,'2026-04-20 23:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(67,'PMJ-69e8425993ae7',8,'2026-04-19','2026-04-26','dikembalikan',23087,'belum',1,'2026-04-20 00:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(68,'PMJ-69e842599727b',27,'2026-04-19','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(69,'PMJ-69e8425999cff',14,'2026-04-22','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(70,'PMJ-69e842599c88c',13,'2026-04-22','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(71,'PMJ-69e842599f541',30,'2026-04-20','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(72,'PMJ-69e84259a2083',2,'2026-04-22','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(73,'PMJ-69e84259a4999',10,'2026-04-19','2026-04-26','dikembalikan',110307,'belum',1,'2026-04-19 21:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(74,'PMJ-69e84259a791f',7,'2026-04-20','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(75,'PMJ-69e84259aa258',14,'2026-04-20','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(76,'PMJ-69e84259acd0e',22,'2026-04-21','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(77,'PMJ-69e84259af440',9,'2026-04-18','2026-04-21','ditolak',0,'tidak_ada',NULL,NULL,1,'2026-04-18 21:36:57','2026-04-22 03:36:57','2026-04-22 03:36:57'),(78,'PMJ-69e84259b1e17',5,'2026-04-19','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(79,'PMJ-69e84259b4535',2,'2026-04-20','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(80,'PMJ-69e84259b6f02',2,'2026-04-20','2026-04-23','dikembalikan',21940,'belum',1,'2026-04-21 02:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(81,'PMJ-69e84259ba2f4',15,'2026-04-18','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(82,'PMJ-69e84259bcb5d',10,'2026-04-20','2026-04-27','dikembalikan',0,'tidak_ada',1,'2026-04-20 22:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(83,'PMJ-69e84259bfead',5,'2026-04-19','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(84,'PMJ-69e84259c26f3',5,'2026-04-18','2026-04-21','dikembalikan',24800,'belum',1,'2026-04-18 22:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(85,'PMJ-69e84259c5561',10,'2026-04-19','2026-04-26','dikembalikan',0,'tidak_ada',1,'2026-04-19 13:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(86,'PMJ-69e84259c884b',5,'2026-04-17','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(87,'PMJ-69e84259cb301',26,'2026-04-18','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(88,'PMJ-69e84259cde06',21,'2026-04-19','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(89,'PMJ-69e84259d0917',28,'2026-04-18','2026-04-24','dikembalikan',117283,'belum',1,'2026-04-19 03:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(90,'PMJ-69e84259d3936',25,'2026-04-22','2026-04-29','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(91,'PMJ-69e84259d6152',18,'2026-04-20','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(92,'PMJ-69e84259d891e',21,'2026-04-22','2026-04-28','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(93,'PMJ-69e84259dad64',12,'2026-04-18','2026-04-23','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(94,'PMJ-69e84259dd474',5,'2026-04-18','2026-04-25','dikembalikan',3000,'belum',1,'2026-04-19 03:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:57'),(95,'PMJ-69e84259e0bf3',24,'2026-04-20','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(96,'PMJ-69e84259e348b',4,'2026-04-19','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(97,'PMJ-69e84259e5e8a',13,'2026-04-19','2026-04-22','dikembalikan',132990,'belum',1,'2026-04-19 11:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(98,'PMJ-69e84259e8d1f',13,'2026-04-20','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(99,'PMJ-69e84259ebbed',31,'2026-04-18','2026-04-21','dikembalikan',3000,'belum',1,'2026-04-19 02:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(100,'PMJ-69e84259eed82',28,'2026-04-18','2026-04-25','dikembalikan',31867,'belum',1,'2026-04-18 07:36:57',NULL,NULL,'2026-04-22 03:36:57','2026-04-22 03:36:58'),(101,'PMJ-69e84259f1cdc',23,'2026-04-22','2026-04-26','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:57','2026-04-23 00:03:24'),(102,'PMJ-69e8425a000aa',2,'2026-04-22','2026-04-25','disetujui',0,'tidak_ada',1,'2026-04-22 07:10:57',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 07:10:57'),(103,'PMJ-69e8425a02879',2,'2026-04-22','2026-04-25','ditolak',0,'tidak_ada',NULL,NULL,1,'2026-04-22 07:10:12','2026-04-22 03:36:58','2026-04-22 07:10:12'),(104,'PMJ-69e8425a05071',2,'2026-04-18','2026-04-23','disetujui',0,'tidak_ada',1,'2026-04-22 07:10:46',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 07:10:46'),(105,'PMJ-69e8425a07e54',22,'2026-04-21','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(106,'PMJ-69e8425a0a766',2,'2026-04-17','2026-04-21','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(107,'PMJ-69e8425a0d10b',27,'2026-04-19','2026-04-22','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(108,'PMJ-69e8425a0fa8a',10,'2026-04-22','2026-04-26','dikembalikan',38426,'belum',1,'2026-04-22 21:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(109,'PMJ-69e8425a128ef',5,'2026-04-21','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(110,'PMJ-69e8425a152a6',13,'2026-04-20','2026-04-24','dikembalikan',102078,'belum',1,'2026-04-20 14:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(111,'PMJ-69e8425a19846',5,'2026-04-19','2026-04-22','dikembalikan',115307,'belum',1,'2026-04-19 10:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(112,'PMJ-69e8425a1c8e7',3,'2026-04-21','2026-04-25','dikembalikan',92301,'belum',1,'2026-04-21 14:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(113,'PMJ-69e8425a1f7dc',31,'2026-04-19','2026-04-26','dikembalikan',1000,'belum',1,'2026-04-19 17:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(114,'PMJ-69e8425a23339',21,'2026-04-20','2026-04-26','dikembalikan',3000,'belum',1,'2026-04-21 00:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(115,'PMJ-69e8425a261eb',14,'2026-04-20','2026-04-25','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(116,'PMJ-69e8425a29084',10,'2026-04-20','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(117,'PMJ-69e8425a2ba19',26,'2026-04-20','2026-04-26','dikembalikan',0,'tidak_ada',1,'2026-04-20 10:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(118,'PMJ-69e8425a2ed22',14,'2026-04-22','2026-04-27','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(119,'PMJ-69e8425a3158e',18,'2026-04-21','2026-04-25','disetujui',0,'tidak_ada',1,'2026-04-22 07:11:15',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 07:11:15'),(120,'PMJ-69e8425a33d82',23,'2026-04-17','2026-04-24','kadaluarsa',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-22 03:36:58','2026-04-23 00:03:24'),(121,'PMJ-69e8425a369ef',15,'2026-04-13','2026-04-21','dikembalikan',80394,'belum',1,'2026-04-13 05:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(122,'PMJ-69e8425a39779',18,'2026-04-15','2026-04-20','dikembalikan',106198,'belum',1,'2026-04-15 05:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(123,'PMJ-69e8425a3c67b',8,'2026-04-14','2026-04-19','dikembalikan',123867,'belum',1,'2026-04-14 05:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(124,'PMJ-69e8425a3f610',21,'2026-04-13','2026-04-20','dikembalikan',0,'tidak_ada',1,'2026-04-13 05:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(125,'PMJ-69e8425a4284f',26,'2026-04-13','2026-04-20','dikembalikan',30564,'lunas',1,'2026-04-13 05:36:58',NULL,NULL,'2026-04-22 03:36:58','2026-04-23 01:28:05'),(126,'PMJ-2026-0285',2,'2026-04-23','2026-04-23','ditolak',0,'tidak_ada',NULL,NULL,1,'2026-04-23 01:39:15','2026-04-23 00:05:22','2026-04-23 01:39:15'),(127,'PMJ-2026-0286',2,'2026-04-23','2026-04-30','disetujui',0,'tidak_ada',1,'2026-04-23 01:17:53',NULL,NULL,'2026-04-23 00:09:31','2026-04-23 01:17:53'),(128,'PMJ-2026-0287',2,'2026-04-23','2026-04-23','dibatalkan',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-23 01:46:24','2026-04-23 01:46:46'),(129,'PMJ-2026-0288',2,'2026-04-23','2026-04-23','menunggu',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-23 01:47:26','2026-04-23 01:47:26'),(130,'PMJ-2026-0289',2,'2026-04-23','2026-04-23','menunggu',0,'tidak_ada',NULL,NULL,NULL,NULL,'2026-04-23 04:19:00','2026-04-23 04:19:00');
/*!40000 ALTER TABLE `peminjamans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengembalian_items`
--

DROP TABLE IF EXISTS `pengembalian_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengembalian_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_pengembalian` bigint unsigned NOT NULL,
  `id_buku` bigint unsigned NOT NULL,
  `qty_baik` int NOT NULL DEFAULT '0',
  `qty_rusak` int NOT NULL DEFAULT '0',
  `qty_hilang` int NOT NULL DEFAULT '0',
  `denda` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pengembalian_items_id_pengembalian_foreign` (`id_pengembalian`),
  KEY `pengembalian_items_id_buku_foreign` (`id_buku`),
  CONSTRAINT `pengembalian_items_id_buku_foreign` FOREIGN KEY (`id_buku`) REFERENCES `bukus` (`id`),
  CONSTRAINT `pengembalian_items_id_pengembalian_foreign` FOREIGN KEY (`id_pengembalian`) REFERENCES `pengembalians` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengembalian_items`
--

LOCK TABLES `pengembalian_items` WRITE;
/*!40000 ALTER TABLE `pengembalian_items` DISABLE KEYS */;
INSERT INTO `pengembalian_items` VALUES (1,1,24,1,0,0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(2,2,11,0,2,0,87342,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(3,3,13,2,0,0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(4,4,14,0,2,0,99170,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(5,5,64,0,1,0,13728,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(6,6,80,0,0,2,191848,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(7,7,61,0,1,0,10139,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(8,8,85,0,0,1,121133,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(9,9,12,0,2,0,53966,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(10,10,18,0,1,1,93164,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(11,11,54,0,1,0,17610,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(12,12,8,1,0,0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(13,13,4,0,2,0,91060,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(14,14,37,0,1,1,93533,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(15,15,8,1,0,0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(16,16,55,0,0,2,202768,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(17,17,60,0,0,1,95725,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(18,18,50,0,0,1,74463,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(19,19,86,0,0,1,144335,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(20,20,69,0,1,1,162486,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(21,21,19,0,2,0,48312,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(22,22,77,0,1,0,21087,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(23,23,48,0,0,1,106307,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(24,24,14,0,1,0,19940,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(25,25,61,0,2,0,21800,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(26,26,15,0,0,1,116283,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(27,27,66,1,0,1,129990,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(28,28,10,1,0,0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(29,29,6,0,1,0,26867,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(30,30,26,0,1,0,34426,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(31,31,15,0,2,0,97078,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(32,32,6,0,0,1,110307,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(33,33,10,0,0,1,88301,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(34,34,77,2,0,0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(35,35,77,0,0,1,80394,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(36,36,41,0,0,1,102198,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(37,37,27,0,0,1,123867,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(38,38,30,1,0,0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(39,39,34,0,1,0,26564,'2026-04-22 03:36:58','2026-04-22 03:36:58');
/*!40000 ALTER TABLE `pengembalian_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengembalians`
--

DROP TABLE IF EXISTS `pengembalians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengembalians` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_peminjaman` bigint unsigned NOT NULL,
  `id_admin` bigint unsigned NOT NULL,
  `tgl_dikembalikan` date NOT NULL,
  `hari_telat` int NOT NULL DEFAULT '0',
  `denda_telat` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pengembalians_id_peminjaman_foreign` (`id_peminjaman`),
  KEY `pengembalians_id_admin_foreign` (`id_admin`),
  CONSTRAINT `pengembalians_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `users` (`id`),
  CONSTRAINT `pengembalians_id_peminjaman_foreign` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjamans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengembalians`
--

LOCK TABLES `pengembalians` WRITE;
/*!40000 ALTER TABLE `pengembalians` DISABLE KEYS */;
INSERT INTO `pengembalians` VALUES (1,1,1,'2026-04-26',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(2,6,1,'2026-04-28',1,1000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(3,7,1,'2026-04-27',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(4,10,1,'2026-04-26',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(5,13,1,'2026-04-27',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(6,14,1,'2026-04-24',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(7,15,1,'2026-04-30',4,4000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(8,17,1,'2026-04-27',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(9,19,1,'2026-04-26',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(10,20,1,'2026-04-30',5,5000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(11,22,1,'2026-04-27',1,1000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(12,29,1,'2026-04-23',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(13,35,1,'2026-04-26',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(14,37,1,'2026-04-25',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(15,42,1,'2026-04-26',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(16,44,1,'2026-04-24',4,4000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(17,48,1,'2026-04-29',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(18,49,1,'2026-04-24',1,1000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(19,55,1,'2026-04-28',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(20,59,1,'2026-04-26',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(21,61,1,'2026-04-26',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(22,67,1,'2026-04-28',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(23,73,1,'2026-04-30',4,4000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(24,80,1,'2026-04-25',2,2000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(25,84,1,'2026-04-24',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(26,89,1,'2026-04-25',1,1000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(27,97,1,'2026-04-25',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(28,99,1,'2026-04-24',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(29,100,1,'2026-04-30',5,5000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(30,108,1,'2026-04-30',4,4000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(31,110,1,'2026-04-29',5,5000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(32,111,1,'2026-04-27',5,5000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(33,112,1,'2026-04-29',4,4000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(34,114,1,'2026-04-29',3,3000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(35,121,1,'2026-04-21',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(36,122,1,'2026-04-24',4,4000,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(37,123,1,'2026-04-19',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(38,124,1,'2026-04-20',0,0,'2026-04-22 03:36:58','2026-04-22 03:36:58'),(39,125,1,'2026-04-24',4,4000,'2026-04-22 03:36:58','2026-04-22 03:36:58');
/*!40000 ALTER TABLE `pengembalians` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profil_siswas`
--

DROP TABLE IF EXISTS `profil_siswas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profil_siswas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `nisn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_hp_ortu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profil_siswas_user_id_foreign` (`user_id`),
  KEY `profil_siswas_nisn_foreign` (`nisn`),
  CONSTRAINT `profil_siswas_nisn_foreign` FOREIGN KEY (`nisn`) REFERENCES `data_siswas` (`nisn`) ON DELETE CASCADE,
  CONSTRAINT `profil_siswas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profil_siswas`
--

LOCK TABLES `profil_siswas` WRITE;
/*!40000 ALTER TABLE `profil_siswas` DISABLE KEYS */;
INSERT INTO `profil_siswas` VALUES (1,2,'1000000001','082187555497','082225485716','Jalan Dramaga Haji Abas RT 01/01','foto_siswa/S9JXTegzfYk6fm4NRoVqeqVNB5xNYWe0XodxDBQN.jpg','2026-04-22 03:36:42','2026-04-23 01:45:38'),(2,3,'1000000002','089984800945','086701912767','Alamat Siswa 2',NULL,'2026-04-22 03:36:42','2026-04-22 03:36:42'),(3,4,'1000000003','085774373272','085396076797','Alamat Siswa 3',NULL,'2026-04-22 03:36:43','2026-04-22 03:36:43'),(4,5,'1000000004','082395568152','088675848520','Alamat Siswa 4',NULL,'2026-04-22 03:36:43','2026-04-22 03:36:43'),(5,6,'1000000005','087078944813','089795254167','Alamat Siswa 5',NULL,'2026-04-22 03:36:44','2026-04-22 03:36:44'),(6,7,'1000000006','082299725535','087732436165','Alamat Siswa 6',NULL,'2026-04-22 03:36:44','2026-04-22 03:36:44'),(7,8,'1000000007','087104398721','089365701610','Alamat Siswa 7',NULL,'2026-04-22 03:36:45','2026-04-22 03:36:45'),(8,9,'1000000008','089147710965','088761515451','Alamat Siswa 8',NULL,'2026-04-22 03:36:45','2026-04-22 03:36:45'),(9,10,'1000000009','083914466754','082951276651','Alamat Siswa 9',NULL,'2026-04-22 03:36:46','2026-04-22 03:36:46'),(10,11,'1000000010','084635449245','084105140272','Alamat Siswa 10',NULL,'2026-04-22 03:36:46','2026-04-22 03:36:46'),(11,12,'1000000011','083066883332','081488123601','Alamat Siswa 11',NULL,'2026-04-22 03:36:47','2026-04-22 03:36:47'),(12,13,'1000000012','082711600156','089360490503','Alamat Siswa 12',NULL,'2026-04-22 03:36:47','2026-04-22 03:36:47'),(13,14,'1000000013','087137083105','088664794814','Alamat Siswa 13',NULL,'2026-04-22 03:36:48','2026-04-22 03:36:48'),(14,15,'1000000014','082510018442','088095374851','Alamat Siswa 14',NULL,'2026-04-22 03:36:48','2026-04-22 03:36:48'),(15,16,'1000000015','085212169329','084572890348','Alamat Siswa 15',NULL,'2026-04-22 03:36:49','2026-04-22 03:36:49'),(16,17,'1000000016','081540597643','083913666079','Alamat Siswa 16',NULL,'2026-04-22 03:36:49','2026-04-22 03:36:49'),(17,18,'1000000017','089070994602','088708236928','Alamat Siswa 17',NULL,'2026-04-22 03:36:49','2026-04-22 03:36:49'),(18,19,'1000000018','088772129500','088584536939','Alamat Siswa 18',NULL,'2026-04-22 03:36:50','2026-04-22 03:36:50'),(19,20,'1000000019','089917328944','086195099374','Alamat Siswa 19',NULL,'2026-04-22 03:36:50','2026-04-22 03:36:50'),(20,21,'1000000020','088827480249','085854845965','Alamat Siswa 20',NULL,'2026-04-22 03:36:51','2026-04-22 03:36:51'),(21,22,'1000000021','084342111302','083612816026','Alamat Siswa 21',NULL,'2026-04-22 03:36:51','2026-04-22 03:36:51'),(22,23,'1000000022','087406497580','083679240468','Alamat Siswa 22',NULL,'2026-04-22 03:36:52','2026-04-22 03:36:52'),(23,24,'1000000023','081179082576','081670950238','Alamat Siswa 23',NULL,'2026-04-22 03:36:52','2026-04-22 03:36:52'),(24,25,'1000000024','081898684617','088116461420','Alamat Siswa 24',NULL,'2026-04-22 03:36:53','2026-04-22 03:36:53'),(25,26,'1000000025','087012581848','084750540452','Alamat Siswa 25',NULL,'2026-04-22 03:36:53','2026-04-22 03:36:53'),(26,27,'1000000026','083230797895','083053073241','Alamat Siswa 26',NULL,'2026-04-22 03:36:54','2026-04-22 03:36:54'),(27,28,'1000000027','083381254441','086875327107','Alamat Siswa 27',NULL,'2026-04-22 03:36:54','2026-04-22 03:36:54'),(28,29,'1000000028','083002831890','086091880495','Alamat Siswa 28',NULL,'2026-04-22 03:36:55','2026-04-22 03:36:55'),(29,30,'1000000029','085754027410','081371472421','Alamat Siswa 29',NULL,'2026-04-22 03:36:55','2026-04-22 03:36:55'),(30,31,'1000000030','087457443995','084299382412','Alamat Siswa 30',NULL,'2026-04-22 03:36:56','2026-04-22 03:36:56');
/*!40000 ALTER TABLE `profil_siswas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('1EA8C99MXUejOR9EtdQLM2ZdsJfzKfauUTXVWGSf',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0','YTo0OntzOjY6Il90b2tlbiI7czo0MDoick5OWklPMDR1ejZkNUM1M2pZSUdTY2VNekJwQUtUYmZFcXF0ZllNZiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1776914151),('gaG71rneW2q9oOMkbwLkVXbCHJh0JvSe2KV3cTf1',2,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUkdaNW5aUmxZaW9KQWI5ODYzTDk3d2I3WlFYY1RTeVRtWEtFZGN2UyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9',1776918327);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','petugas','peminjam') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'peminjam',
  `otp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp_expired_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrator','admin','admin@gmail.com','$2y$12$07UEV6EzcfWG6QA1J9aV5uuLaVRR0kQDUBac/8lP0AP4iiywguMHa','admin',NULL,NULL,'2026-04-22 03:36:41','2026-04-22 03:36:41'),(2,'Siswa 1','user1','rofinugraha549@gmail.com','$2y$12$DoSUx6WThPSKG62A5A0Gg.cgJEjviY/qRpejIaIkJME5mPbMgjsU6','peminjam','246237','2026-04-23 04:13:48','2026-04-22 03:36:42','2026-04-23 04:08:48'),(3,'Siswa 2','user2','user2@gmail.com','$2y$12$jxOEsW1gLuNnIl1dKHNF1OLyGn0vOlPcYS9KaUYq.vGnF33RTQr3.','peminjam',NULL,NULL,'2026-04-22 03:36:42','2026-04-22 03:36:42'),(4,'Siswa 3','user3','user3@gmail.com','$2y$12$t3MNhU2Ii12Fiuid0qtL6.jyv/m9TGP5RZstQSswT3NTrPEP.dAVC','peminjam',NULL,NULL,'2026-04-22 03:36:43','2026-04-22 03:36:43'),(5,'Siswa 4','user4','user4@gmail.com','$2y$12$2RgD5XKk//dWnyW4ezsjI.KSCy/gqXSoQ4tR8JDwJd0nsK/Nvwpiu','peminjam',NULL,NULL,'2026-04-22 03:36:43','2026-04-22 03:36:43'),(6,'Siswa 5','user5','user5@gmail.com','$2y$12$sCvK2JzGDitMZcBRrOtxr.XRLuoMiQ.jvzyVUrgknfPlq9ZY3ka0e','peminjam',NULL,NULL,'2026-04-22 03:36:44','2026-04-22 03:36:44'),(7,'Siswa 6','user6','user6@gmail.com','$2y$12$XKiSmrxaiFPeQ7EQ0fFx.eF5acRdc2NHdGVehVceVsC9qV9ssgw6W','peminjam',NULL,NULL,'2026-04-22 03:36:44','2026-04-22 03:36:44'),(8,'Siswa 7','user7','user7@gmail.com','$2y$12$JeRcWu8Ul4Pe7c.OwqiYs.KrSGxSihOD9pwy4ujODBSToKQo.UBDW','peminjam',NULL,NULL,'2026-04-22 03:36:45','2026-04-22 03:36:45'),(9,'Siswa 8','user8','user8@gmail.com','$2y$12$RiIG9gqDI6VMcexoSjk2TOziJnuI6TjsyOsL66vCLmXlHUUf.aCme','peminjam',NULL,NULL,'2026-04-22 03:36:45','2026-04-22 03:36:45'),(10,'Siswa 9','user9','user9@gmail.com','$2y$12$zMN/rZvvu/1hmTIiR5J0eel.y4kfaoLVEynjp1LjkO3Li32WlDU9u','peminjam',NULL,NULL,'2026-04-22 03:36:46','2026-04-22 03:36:46'),(11,'Siswa 10','user10','user10@gmail.com','$2y$12$XSBf4J3d/pgOMIPhb6ZsLOQnsVC16QLFj7Y8Zz.7t.F80rKBjClG.','peminjam',NULL,NULL,'2026-04-22 03:36:46','2026-04-22 03:36:46'),(12,'Siswa 11','user11','user11@gmail.com','$2y$12$.Tj8NMKEF6V7hp3sA0Au6.noN89SVVwUhM4sGTs0JSqE2iUZGkU7G','peminjam',NULL,NULL,'2026-04-22 03:36:47','2026-04-22 03:36:47'),(13,'Siswa 12','user12','user12@gmail.com','$2y$12$Dx2qtSx/4Qzed.VcUB3fCeoWfCePh3KvN.qrfn0Ci753mMBy9g0py','peminjam',NULL,NULL,'2026-04-22 03:36:47','2026-04-22 03:36:47'),(14,'Siswa 13','user13','user13@gmail.com','$2y$12$nVIYooNloLNHpzGjQjPXROP2UzjhGoMDpEF9VvmUHLySAUDkAQYgW','peminjam',NULL,NULL,'2026-04-22 03:36:48','2026-04-22 03:36:48'),(15,'Siswa 14','user14','user14@gmail.com','$2y$12$zSCSb63wm1mpfeLqND77DenvPoJF4H.tw0e7VR/YzHOjNohWdKys6','peminjam',NULL,NULL,'2026-04-22 03:36:48','2026-04-22 03:36:48'),(16,'Siswa 15','user15','user15@gmail.com','$2y$12$A3PGY760CTuMdjasdjhDG.oYLne4iyioTSN0xNocSJwH8R342Gz1y','peminjam',NULL,NULL,'2026-04-22 03:36:49','2026-04-22 03:36:49'),(17,'Siswa 16','user16','user16@gmail.com','$2y$12$M7IuMtIIxlKhVAF9AkDgiuo3DeOkXvL38aQ6vAQAZxDIPHxYgL9M6','peminjam',NULL,NULL,'2026-04-22 03:36:49','2026-04-22 03:36:49'),(18,'Siswa 17','user17','user17@gmail.com','$2y$12$YNCkQWTh2aAde5a/I8hn2.vBJyN9KuCZd3qiZX6aMG3orBuPUZlOO','peminjam',NULL,NULL,'2026-04-22 03:36:49','2026-04-22 03:36:49'),(19,'Siswa 18','user18','user18@gmail.com','$2y$12$RLhnYEVvxp25N0EpcOQx0.RzDmDR.9xjJqV/HW8BYyBpy/U/UmOB.','peminjam',NULL,NULL,'2026-04-22 03:36:50','2026-04-22 03:36:50'),(20,'Siswa 19','user19','user19@gmail.com','$2y$12$BEzU4cLic.x8fevZHd1lN.xXmOaQ6OGVdrGP8T3.lW8moYfMBSzFW','peminjam',NULL,NULL,'2026-04-22 03:36:50','2026-04-22 03:36:50'),(21,'Siswa 20','user20','user20@gmail.com','$2y$12$Rv6LfO481g11HdNDoic6AOK70PxFCWdkhQQHyojSA0HWF0v.8t8E2','peminjam',NULL,NULL,'2026-04-22 03:36:51','2026-04-22 03:36:51'),(22,'Siswa 21','user21','user21@gmail.com','$2y$12$DTnxOSB/wS0QsVqcjJ9q6edSzlMXYO.HTQ.LjinHDgu1zfYpqFuLq','peminjam',NULL,NULL,'2026-04-22 03:36:51','2026-04-22 03:36:51'),(23,'Siswa 22','user22','user22@gmail.com','$2y$12$TX2vU9GCtkKRp4TADzGSmuKydx4dOTRIMbuleNvrPNzxIQAlD.QUi','peminjam',NULL,NULL,'2026-04-22 03:36:52','2026-04-22 03:36:52'),(24,'Siswa 23','user23','user23@gmail.com','$2y$12$f168dG0/Qnm1N2KUVRc/junwQIfHYtpd44/BS/b49hvzGFxvMF3T.','peminjam',NULL,NULL,'2026-04-22 03:36:52','2026-04-22 03:36:52'),(25,'Siswa 24','user24','user24@gmail.com','$2y$12$/UFDSxXhdtk6.ZZbnM0NVeS84PCYOVTRcP9zWMcbOoW8hBjEot6Ze','peminjam',NULL,NULL,'2026-04-22 03:36:53','2026-04-22 03:36:53'),(26,'Siswa 25','user25','user25@gmail.com','$2y$12$tMeyWhibp2OqejLdpdMil.jSOvpzWuJ./yITHgtHl6hAbxaeBII/m','peminjam',NULL,NULL,'2026-04-22 03:36:53','2026-04-22 03:36:53'),(27,'Siswa 26','user26','user26@gmail.com','$2y$12$WBa6QFEIMO8LxgxjqIlI3ObA8fIwlyi3BjnrfMZtFg8jgKPvrgNb6','peminjam',NULL,NULL,'2026-04-22 03:36:54','2026-04-22 03:36:54'),(28,'Siswa 27','user27','user27@gmail.com','$2y$12$tnqdbiVlnslqsd72NmxXJOKqzU.L7FVaNNhKrUC1a.SW/boNm2kUa','peminjam',NULL,NULL,'2026-04-22 03:36:54','2026-04-22 03:36:54'),(29,'Siswa 28','user28','user28@gmail.com','$2y$12$yTDRXDZECJsABEJ0C6QfH.nue8PaNm9LbM8pL3YS96U21TN9AaN0u','peminjam',NULL,NULL,'2026-04-22 03:36:55','2026-04-22 03:36:55'),(30,'Siswa 29','user29','user29@gmail.com','$2y$12$M1sUnQHxCzGIpUH1p.OhruR.KN620RDzCkwAiGA.x4w/xoJD.NnNS','peminjam',NULL,NULL,'2026-04-22 03:36:55','2026-04-22 03:36:55'),(31,'Siswa 30','user30','user30@gmail.com','$2y$12$.Wr7vb8emsF93Nyt3cGSsu2iuaMXVdYkoDJyaotMrv/hce4tyzoJa','peminjam',NULL,NULL,'2026-04-22 03:36:56','2026-04-22 03:36:56'),(32,'Rofi Nugraha','rofinugraha','rofinugraha03@gmail.com','$2y$12$OhBhc2JkKIk3mZGyz4jRbeteaWmlRcMmKchGVK.HI.ZyVL2gTU8LS','peminjam',NULL,NULL,'2026-04-23 01:41:06','2026-04-23 01:41:06');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'peminjaman_buku'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-23 11:54:30
