-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstore
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `book_tag`
--

DROP TABLE IF EXISTS `book_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_tag` (
  `book_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`book_id`,`tag_id`),
  KEY `book_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `book_tag_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `book_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_tag`
--

LOCK TABLES `book_tag` WRITE;
/*!40000 ALTER TABLE `book_tag` DISABLE KEYS */;
INSERT INTO `book_tag` VALUES (1,1),(2,1),(4,1),(5,1),(9,1),(13,1),(14,1),(15,1),(22,1),(29,1),(6,2),(11,2),(12,2),(14,2),(15,2),(17,2),(18,2),(19,2),(24,2),(25,2),(26,2),(27,2),(1,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(10,3),(12,3),(13,3),(16,3),(17,3),(20,3),(23,3),(26,3),(29,3),(30,3),(2,4),(3,4),(11,4),(19,4),(21,4),(22,4),(28,4),(30,4);
/*!40000 ALTER TABLE `book_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isbn` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int NOT NULL DEFAULT '0',
  `pages` int DEFAULT NULL,
  `published_year` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_slug_unique` (`slug`),
  KEY `books_supplier_id_foreign` (`supplier_id`),
  KEY `books_category_id_foreign` (`category_id`),
  CONSTRAINT `books_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `books_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,1,2,'Non quis deleniti','non-quis-deleniti-95761','Maryjane Metz','978-604-49-4109-0','https://placehold.co/300x450/e2e8f0/1e293b?text=Non+quis+deleniti.',219000.00,204000.00,88,537,2023,'Voluptas quasi qui aut sit tenetur. Ipsum assumenda enim molestiae excepturi non rerum commodi. Sint non et id minus neque ut id. Similique voluptas aut quas.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(2,1,2,'Perspiciatis et ipsa ut','perspiciatis-et-ipsa-ut-92077','Lilyan Runolfsson','978-604-47-6476-3','https://placehold.co/300x450/e2e8f0/1e293b?text=Perspiciatis+et+ip...',60000.00,NULL,21,547,2019,'Modi architecto aut amet eligendi aut iste. Consequatur doloremque veniam ex in quis atque modi sunt. Pariatur minus cum voluptatum quis omnis molestiae.',1,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(3,1,1,'Et et repudiandae consequatur','et-et-repudiandae-consequatur-1656','Mr. Dagmar Kuvalis PhD','978-604-20-3726-1','https://placehold.co/300x450/e2e8f0/1e293b?text=Et+et+repudiandae...',238000.00,NULL,118,123,2026,'Est cupiditate cumque vitae assumenda aut et velit. Quasi rem praesentium mollitia maxime. Exercitationem voluptas repellendus molestias est eos dolorum fugit.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(4,1,5,'Nostrum odit dolores','nostrum-odit-dolores-4480','Elisa O\'Reilly','978-604-09-6388-6','https://placehold.co/300x450/e2e8f0/1e293b?text=Nostrum+odit+dolor...',106000.00,91000.00,111,223,2020,'Eum enim excepturi quia illo sit cum. Et labore esse voluptatem consequatur vitae et. Ducimus enim est harum quibusdam.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(5,1,2,'Expedita placeat enim consequuntur quia','expedita-placeat-enim-consequuntur-quia-13994','Mary Paucek','978-604-72-9837-4','https://placehold.co/300x450/e2e8f0/1e293b?text=Expedita+placeat+e...',335000.00,NULL,91,426,2026,'Debitis aut sit ut porro. Facilis vel ab ut. Ut aperiam quasi eos cupiditate iure. Repellat quisquam et eius voluptatem natus fugiat.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(6,2,5,'Sit modi non molestiae','sit-modi-non-molestiae-33671','Nash Gottlieb','978-604-60-0396-3','https://placehold.co/300x450/e2e8f0/1e293b?text=Sit+modi+non+moles...',77000.00,NULL,38,636,2025,'Debitis ea doloremque architecto porro ea. Debitis ipsam porro velit voluptatem. Ipsam esse quia inventore omnis est iure. Est rerum officia earum quam alias quibusdam aliquid.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(7,2,4,'Aut autem id omnis','aut-autem-id-omnis-10856','Abigayle Herzog IV','978-604-34-9603-9','https://placehold.co/300x450/e2e8f0/1e293b?text=Aut+autem+id+omnis...',105000.00,NULL,149,342,2023,'Laboriosam qui ducimus sit pariatur. Esse ipsam ab delectus ut qui reprehenderit et.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(8,2,4,'Esse dolor et dignissimos sint','esse-dolor-et-dignissimos-sint-67301','Jerry Deckow','978-604-91-7872-1','https://placehold.co/300x450/e2e8f0/1e293b?text=Esse+dolor+et+dign...',284000.00,NULL,67,270,2019,'Est facere illum qui accusamus esse doloremque. Enim ut et et nesciunt facilis. Quis consequatur facilis laboriosam quaerat blanditiis ut est. Dolore soluta veritatis fuga sit eos nesciunt quis.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(9,2,1,'Aspernatur et ipsa modi corrupti','aspernatur-et-ipsa-modi-corrupti-16495','Ms. Sophie Weimann Jr.','978-604-31-5404-8','https://placehold.co/300x450/e2e8f0/1e293b?text=Aspernatur+et+ipsa...',242000.00,NULL,63,614,2025,'Error deserunt consequatur vero mollitia. Fugiat architecto alias dolor optio. Ipsam et est rerum sunt tenetur quis esse. Est id quisquam rerum optio quis in.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(10,2,5,'Ex sapiente est est adipisci','ex-sapiente-est-est-adipisci-13850','Prof. Anahi Strosin Jr.','978-604-92-1390-5','https://placehold.co/300x450/e2e8f0/1e293b?text=Ex+sapiente+est+es...',279000.00,NULL,144,330,2024,'Iste quas fugiat veritatis quaerat dolorum magni eum. Est odit in nostrum reiciendis dolorum. Soluta quo eum nam rerum doloribus non. Ut provident est id voluptatibus.',1,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(11,3,3,'Velit porro nihil molestiae commodi','velit-porro-nihil-molestiae-commodi-23872','Dr. Don Bode','978-604-53-6601-1','https://placehold.co/300x450/e2e8f0/1e293b?text=Velit+porro+nihil...',332000.00,NULL,56,490,2026,'Aut sed cum veniam ab dolorem praesentium. Nobis voluptates fuga laudantium labore dolore sed. Et ea similique molestiae ea veniam rerum. Ratione aut temporibus id alias harum est. Natus tempora quia earum delectus rem.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(12,3,2,'Rerum omnis qui quod praesentium','rerum-omnis-qui-quod-praesentium-66087','Julio Konopelski','978-604-53-0296-0','https://placehold.co/300x450/e2e8f0/1e293b?text=Rerum+omnis+qui+qu...',109000.00,94000.00,72,595,2019,'Quod dolor velit perferendis natus in et quasi. Labore voluptatem omnis aut neque. Ut est laborum voluptas eveniet laudantium.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(13,3,2,'In quis dolore accusamus repellat','in-quis-dolore-accusamus-repellat-50579','Ray Hand','978-604-49-6269-0','https://placehold.co/300x450/e2e8f0/1e293b?text=In+quis+dolore+acc...',257000.00,NULL,109,577,2022,'Quis amet cupiditate excepturi libero. Nihil delectus debitis suscipit explicabo ipsam est. Sed officiis sit temporibus suscipit qui. Ipsa et dolores quia mollitia eveniet porro.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(14,3,5,'Nostrum voluptatem quam expedita possimus','nostrum-voluptatem-quam-expedita-possimus-94144','Gregoria Lubowitz','978-604-32-3362-0','https://placehold.co/300x450/e2e8f0/1e293b?text=Nostrum+voluptatem...',203000.00,188000.00,63,422,2024,'Laboriosam velit et tempore possimus. Iusto est voluptatibus quae voluptatem. Pariatur accusantium quasi id voluptatum et dolores.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(15,3,2,'Incidunt officiis eum temporibus aspernatur alias','incidunt-officiis-eum-temporibus-aspernatur-alias-30555','Dr. Deron Haag','978-604-30-2028-4','https://placehold.co/300x450/e2e8f0/1e293b?text=Incidunt+officiis...',275000.00,NULL,50,343,2023,'Ut fugit excepturi in consequatur voluptatibus ea in. Beatae cum earum voluptatem ut quae. Suscipit corporis blanditiis labore quia qui at ut. Porro omnis qui quas eligendi.',1,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(16,4,4,'Praesentium totam inventore','praesentium-totam-inventore-98289','Casper Jacobi I','978-604-65-9230-8','https://placehold.co/300x450/e2e8f0/1e293b?text=Praesentium+totam...',271000.00,NULL,63,604,2019,'Fuga voluptates alias distinctio maxime. Libero quia iure non iusto.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(17,4,5,'Expedita voluptatem qui corrupti itaque','expedita-voluptatem-qui-corrupti-itaque-51627','Mazie Barrows V','978-604-66-7236-8','https://placehold.co/300x450/e2e8f0/1e293b?text=Expedita+voluptate...',139000.00,NULL,75,613,2019,'Quam earum molestias voluptatum quasi debitis. Consequatur officia ex accusamus natus quam alias.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(18,4,5,'Voluptatibus necessitatibus officia','voluptatibus-necessitatibus-officia-18814','Deonte Nitzsche MD','978-604-97-4194-9','https://placehold.co/300x450/e2e8f0/1e293b?text=Voluptatibus+neces...',131000.00,116000.00,110,494,2022,'Tempora accusamus sit quas. Ea corrupti debitis optio sit iste. Porro est voluptatem unde sed soluta. Maxime ex et ex.',1,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(19,4,1,'Reiciendis aperiam cupiditate voluptas voluptatum','reiciendis-aperiam-cupiditate-voluptas-voluptatum-89207','Dr. Augustus Hill III','978-604-17-8169-0','https://placehold.co/300x450/e2e8f0/1e293b?text=Reiciendis+aperiam...',90000.00,75000.00,142,284,2022,'Laboriosam velit quo in occaecati quam et velit. Fuga iusto iure corporis quo dolorem voluptas. Aut et aut et. Repellendus sed consequatur aspernatur est voluptatem rerum.',1,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(20,4,2,'Quia voluptatem explicabo consequuntur','quia-voluptatem-explicabo-consequuntur-83355','Miss Mireille Hill','978-604-31-7721-2','https://placehold.co/300x450/e2e8f0/1e293b?text=Quia+voluptatem+ex...',93000.00,78000.00,140,501,2024,'Deserunt laboriosam sunt vel delectus aliquam eveniet voluptatibus. Et ut culpa id magnam voluptatem. Minus quas omnis modi ut eos repellendus eos.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(21,5,5,'Non vel facilis amet iusto porro','non-vel-facilis-amet-iusto-porro-58504','Clementina Haley','978-604-46-3022-1','https://placehold.co/300x450/e2e8f0/1e293b?text=Non+vel+facilis+am...',324000.00,309000.00,120,598,2021,'Illo consequuntur libero ullam quae nobis quod illo. Quam debitis illo dolor ea fugiat.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(22,5,3,'Eum qui laborum fuga','eum-qui-laborum-fuga-81067','Dr. Jailyn Weissnat IV','978-604-19-0246-6','https://placehold.co/300x450/e2e8f0/1e293b?text=Eum+qui+laborum+fu...',221000.00,206000.00,44,353,2022,'Eius autem tempora illum tempore fuga ullam. Aut exercitationem nostrum quibusdam ipsam. Fugiat tenetur aut eius ut aut enim dignissimos veritatis. Id accusantium reiciendis non alias vero accusamus nulla.',1,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(23,5,2,'Aut soluta labore cupiditate iste','aut-soluta-labore-cupiditate-iste-75815','Nettie Terry','978-604-96-7312-4','https://placehold.co/300x450/e2e8f0/1e293b?text=Aut+soluta+labore...',90000.00,75000.00,142,201,2023,'Enim tenetur distinctio et voluptatem ut est autem deleniti. Est dolor veritatis laboriosam nobis beatae culpa hic.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(24,5,2,'Sint eum libero cupiditate et','sint-eum-libero-cupiditate-et-34660','Prof. Hillary Schneider PhD','978-604-53-8591-9','https://placehold.co/300x450/e2e8f0/1e293b?text=Sint+eum+libero+cu...',244000.00,NULL,137,219,2022,'Id culpa perspiciatis ut mollitia autem. Iusto unde eius cumque sit voluptatem consectetur. Eum voluptas enim magni in molestias fuga.',1,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(25,5,1,'Nam dignissimos consequatur aperiam praesentium hic','nam-dignissimos-consequatur-aperiam-praesentium-hic-52894','Rex DuBuque','978-604-17-0031-8','https://placehold.co/300x450/e2e8f0/1e293b?text=Nam+dignissimos+co...',120000.00,105000.00,24,121,2023,'Eligendi dolores possimus quas inventore quia velit vero. Sed iusto neque eius exercitationem sit. Molestias officia aut repellat quasi. Delectus dolores at omnis reiciendis odit tenetur ipsa.',0,1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(26,6,3,'Perferendis amet labore et','perferendis-amet-labore-et-34358','Dr. Dorian Kuhic','978-604-29-7562-4','https://placehold.co/300x450/e2e8f0/1e293b?text=Perferendis+amet+l...',179000.00,NULL,28,238,2025,'Veniam cumque aut laudantium nostrum. A quis nihil animi. Ipsa et laudantium eos dolores aspernatur dolores eligendi enim.',0,1,'2026-11-21 00:05:24','2026-11-21 00:05:24'),(27,6,2,'Quia eum deserunt omnis non','quia-eum-deserunt-omnis-non-85463','Adell Harris','978-604-69-2165-2','https://placehold.co/300x450/e2e8f0/1e293b?text=Quia+eum+deserunt...',275000.00,260000.00,64,302,2026,'Similique repudiandae excepturi deleniti laudantium expedita sapiente ut. Dicta odio quibusdam esse reiciendis vitae soluta. Aut voluptas velit officiis id laboriosam aperiam.',0,1,'2026-11-21 00:05:24','2026-11-21 00:05:24'),(28,6,2,'Illum dicta hic corrupti','illum-dicta-hic-corrupti-63766','Deonte Satterfield','978-604-45-9195-4','https://placehold.co/300x450/e2e8f0/1e293b?text=Illum+dicta+hic+co...',302000.00,287000.00,47,215,2019,'Excepturi ut eligendi veniam molestias quia. Nobis id molestias id provident debitis facilis repudiandae ut. Repellat et libero tempora quisquam beatae sint animi. Ex harum inventore magnam molestiae nihil.',0,1,'2026-11-21 00:05:24','2026-11-21 00:05:24'),(29,6,1,'Animi voluptas ex','animi-voluptas-ex-75679','Dr. Travon Ratke','978-604-49-0529-5','https://placehold.co/300x450/e2e8f0/1e293b?text=Animi+voluptas+ex.',199000.00,NULL,141,549,2023,'Corporis adipisci iure dicta. Ut harum recusandae eos. Repudiandae ducimus soluta illo vero. Corporis veniam animi eos totam eius saepe.',0,1,'2026-11-21 00:05:24','2026-11-21 00:05:24'),(30,6,3,'Voluptas error rerum eos est et','voluptas-error-rerum-eos-est-et-69502','Gail Jacobi','978-604-94-4333-6','https://placehold.co/300x450/e2e8f0/1e293b?text=Voluptas+error+rer...',278000.00,NULL,142,580,2025,'Necessitatibus soluta voluptatibus nisi et tempore non. Quo exercitationem ut consequatur vitae eum. Illo eaque aut tempora ea dolores.',0,1,'2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
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
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
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
  `expiration` bigint NOT NULL,
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
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_items_cart_id_book_id_unique` (`cart_id`,`book_id`),
  KEY `cart_items_book_id_foreign` (`book_id`),
  CONSTRAINT `cart_items_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (1,1,30,1,'2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carts_user_id_unique` (`user_id`),
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (1,2,'2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_name_unique` (`name`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Văn học','van-hoc','Chuyên mục sách Văn học chọn lọc.','2026-11-21 00:05:22','2026-11-21 00:05:22'),(2,'Kinh tế','kinh-te','Chuyên mục sách Kinh tế chọn lọc.','2026-11-21 00:05:22','2026-11-21 00:05:22'),(3,'Công nghệ thông tin','cong-nghe-thong-tin','Chuyên mục sách Công nghệ thông tin chọn lọc.','2026-11-21 00:05:22','2026-11-21 00:05:22'),(4,'Kỹ năng sống','ky-nang-song','Chuyên mục sách Kỹ năng sống chọn lọc.','2026-11-21 00:05:22','2026-11-21 00:05:22'),(5,'Thiếu nhi','thieu-nhi','Chuyên mục sách Thiếu nhi chọn lọc.','2026-11-21 00:05:22','2026-11-21 00:05:22');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
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
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
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
-- Table structure for table `import_receipt_details`
--

DROP TABLE IF EXISTS `import_receipt_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_receipt_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `import_receipt_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `import_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `import_receipt_details_import_receipt_id_foreign` (`import_receipt_id`),
  KEY `import_receipt_details_book_id_foreign` (`book_id`),
  CONSTRAINT `import_receipt_details_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `import_receipt_details_import_receipt_id_foreign` FOREIGN KEY (`import_receipt_id`) REFERENCES `import_receipts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_receipt_details`
--

LOCK TABLES `import_receipt_details` WRITE;
/*!40000 ALTER TABLE `import_receipt_details` DISABLE KEYS */;
INSERT INTO `import_receipt_details` VALUES (1,1,1,20,65000.00,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(2,2,6,20,65000.00,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(3,3,11,20,65000.00,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(4,4,16,20,65000.00,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(5,5,21,20,65000.00,'2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `import_receipt_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_receipts`
--

DROP TABLE IF EXISTS `import_receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_receipts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `import_receipts_supplier_id_foreign` (`supplier_id`),
  KEY `import_receipts_user_id_foreign` (`user_id`),
  CONSTRAINT `import_receipts_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `import_receipts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_receipts`
--

LOCK TABLES `import_receipts` WRITE;
/*!40000 ALTER TABLE `import_receipts` DISABLE KEYS */;
INSERT INTO `import_receipts` VALUES (1,1,1,1300000.00,'Nhập hàng đợt đầu từ NXB Trẻ','2026-11-21 00:05:23','2026-11-21 00:05:23'),(2,2,1,1300000.00,'Nhập hàng đợt đầu từ NXB Kim Đồng','2026-11-21 00:05:23','2026-11-21 00:05:23'),(3,3,1,1300000.00,'Nhập hàng đợt đầu từ Nhã Nam','2026-11-21 00:05:23','2026-11-21 00:05:23'),(4,4,1,1300000.00,'Nhập hàng đợt đầu từ Alpha Books','2026-11-21 00:05:23','2026-11-21 00:05:23'),(5,5,1,1300000.00,'Nhập hàng đợt đầu từ NXB Giáo Dục','2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `import_receipts` ENABLE KEYS */;
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
  `attempts` smallint unsigned NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_01_01_000001_create_suppliers_table',1),(5,'2025_01_01_000002_create_categories_table',1),(6,'2025_01_01_000003_create_books_table',1),(7,'2025_01_01_000004_create_tags_and_book_tag_tables',1),(8,'2025_01_01_000005_create_import_receipts_tables',1),(9,'2025_01_01_000006_create_orders_tables',1),(10,'2025_01_01_000007_create_carts_tables',1),(11,'2025_01_01_000008_create_reviews_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_book_id_foreign` (`book_id`),
  CONSTRAINT `order_items_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,24,2,244000.00,'2026-11-21 00:05:24','2026-11-21 00:05:24'),(2,1,28,1,302000.00,'2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_address` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payment_method` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cod',
  `payment_status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_code_unique` (`order_code`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'ORD-08CPV5',2,'Nguyễn Văn Khách','user@bookstore.vn','0912345678','123 Nguyễn Huệ, Quận 1, TP.HCM',790000.00,'cod','unpaid','pending','Giao hàng trong giờ hành chính giúp mình.','2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `rating` tinyint unsigned NOT NULL DEFAULT '5',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reviews_user_id_foreign` (`user_id`),
  KEY `reviews_book_id_foreign` (`book_id`),
  CONSTRAINT `reviews_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,2,24,5,'Sách in rất đẹp, đóng gói cẩn thận, giao hàng nhanh!',1,'2026-11-21 00:05:24','2026-11-21 00:05:24'),(2,3,28,4,'Nội dung sách hay, rất đáng đọc.',1,'2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
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
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `suppliers_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'NXB Trẻ','lienhe@nxbtre.com.vn','0901234561','0300521451','161B Lý Chính Thắng, Quận 3, TP.HCM',1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(2,'NXB Kim Đồng','info@nxbkimdong.com.vn','0901234562','0100112233','55 Quang Trung, Hai Bà Trưng, Hà Nội',1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(3,'Nhã Nam','contact@nhanam.vn','0901234563','0101859632','59 Đỗ Quang, Trung Hòa, Cầu Giấy, Hà Nội',1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(4,'Alpha Books','support@alphabooks.vn','0901234564','0102345678','176 Thái Hà, Đống Đa, Hà Nội',1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(5,'NXB Giáo Dục','contact@nxbgd.vn','0901234565','0100108543','81 Trần Hưng Đạo, Hoàn Kiếm, Hà Nội',1,'2026-11-21 00:05:23','2026-11-21 00:05:23'),(6,'First News - Trí Việt','triviet@firstnews.com.vn','0901234566','0302568974','11H Nguyễn Thị Minh Khai, Quận 1, TP.HCM',0,'2026-11-21 00:05:24','2026-11-21 00:05:24');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_name_unique` (`name`),
  UNIQUE KEY `tags_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Bán chạy','ban-chay','2026-11-21 00:05:22','2026-11-21 00:05:22'),(2,'Sách mới','sach-moi','2026-11-21 00:05:22','2026-11-21 00:05:22'),(3,'Khuyên đọc','khuyen-doc','2026-11-21 00:05:22','2026-11-21 00:05:22'),(4,'Giảm giá','giam-gia','2026-11-21 00:05:22','2026-11-21 00:05:22');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Quản trị viên Bookstore','admin@bookstore.vn','0909000111','268 Lý Thường Kiệt, Quận 10, TP.HCM',NULL,NULL,'$2y$12$kkdaucy5QrGRgfHnbWqs8OhhTvo5guSZxvGXW3jBk3nsq6T6QK0n6',1,1,NULL,'2026-11-21 00:05:21','2026-11-21 00:05:21'),(2,'Nguyễn Văn Khách','user@bookstore.vn','0912345678','123 Nguyễn Huệ, Quận 1, TP.HCM',NULL,NULL,'$2y$12$hGeqhEPTGyNwzWVvIcvuSuM/71OYr.TFok5iYIa2WzU3UOUe4I4lW',0,1,NULL,'2026-11-21 00:05:22','2026-11-21 00:05:22'),(3,'Trần Thị Minh Anh','minhanh@gmail.com','0987654321','45 Cầu Giấy, Hà Nội',NULL,NULL,'$2y$12$7V7LLPutXV99V..ml4eNDuENqiB/p2I8biHrVr8e4AIK7Yfad.8XO',0,1,NULL,'2026-11-21 00:05:22','2026-11-21 00:05:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-21 14:06:00
