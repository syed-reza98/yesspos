-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: yesspos_dev
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_transactions`
--

DROP TABLE IF EXISTS `account_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_transactions` (
  `id` varchar(36) NOT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `account_id` varchar(36) NOT NULL,
  `to_account_id` varchar(36) DEFAULT NULL,
  `type` varchar(30) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `txn_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_transactions`
--

LOCK TABLES `account_transactions` WRITE;
/*!40000 ALTER TABLE `account_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` varchar(36) NOT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(50) NOT NULL,
  `account_number` varchar(60) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `branch` varchar(100) DEFAULT NULL,
  `opening_balance` decimal(12,2) DEFAULT 0.00,
  `current_balance` decimal(12,2) DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('ae5974b4-2870-42f8-bba3-1cf1c70dbfd2','00000000-0000-0000-0000-000000000002','bKash Merchant','mobile_money','01700000001',NULL,NULL,0.00,0.00,NULL,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('e6a244f0-3b01-4eed-b96d-7f64abc3fe8c','00000000-0000-0000-0000-000000000002','Cash Register (Main)','cash',NULL,NULL,NULL,5000.00,5000.00,'Default cash counter till',1,'2026-10-05 09:46:25','2026-10-05 09:46:25');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_settings`
--

DROP TABLE IF EXISTS `api_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_settings` (
  `id` varchar(36) NOT NULL,
  `provider` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `category` varchar(60) NOT NULL DEFAULT 'gateway',
  `base_url` text DEFAULT NULL,
  `api_key` text DEFAULT NULL,
  `api_secret` text DEFAULT NULL,
  `sender_id` varchar(60) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `extra` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`extra`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_settings`
--

LOCK TABLES `api_settings` WRITE;
/*!40000 ALTER TABLE `api_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_logs` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `username` varchar(60) DEFAULT NULL,
  `action` varchar(120) NOT NULL,
  `entity` varchar(60) DEFAULT NULL,
  `entity_id` varchar(64) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_accounts`
--

DROP TABLE IF EXISTS `auth_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_accounts` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `provider` varchar(255) NOT NULL,
  `provider_account_id` varchar(255) NOT NULL,
  `refresh_token` text DEFAULT NULL,
  `access_token` text DEFAULT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `token_type` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `id_token` text DEFAULT NULL,
  `session_state` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_accounts`
--

LOCK TABLES `auth_accounts` WRITE;
/*!40000 ALTER TABLE `auth_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_sessions`
--

DROP TABLE IF EXISTS `auth_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_sessions` (
  `session_token` varchar(255) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `expires` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`session_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_sessions`
--

LOCK TABLES `auth_sessions` WRITE;
/*!40000 ALTER TABLE `auth_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_verification_tokens`
--

DROP TABLE IF EXISTS `auth_verification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_verification_tokens` (
  `identifier` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_verification_tokens`
--

LOCK TABLES `auth_verification_tokens` WRITE;
/*!40000 ALTER TABLE `auth_verification_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_verification_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branches` (
  `id` varchar(36) NOT NULL,
  `name` varchar(120) NOT NULL,
  `code` varchar(30) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `branches_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES ('00000000-0000-0000-0000-000000000002','Main Store','MAIN','01700000000','Dhanmondi, Dhaka',1,1,'2026-10-05 09:46:24','2026-10-05 09:46:24');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brands` (
  `id` varchar(36) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `logo_url` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_settings`
--

DROP TABLE IF EXISTS `business_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_settings` (
  `id` varchar(36) NOT NULL,
  `shop_name` varchar(120) NOT NULL DEFAULT 'Bazar Bari',
  `address` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `currency_symbol` varchar(10) NOT NULL DEFAULT '৳',
  `currency_code` varchar(10) NOT NULL DEFAULT 'BDT',
  `vat_rate` decimal(5,2) DEFAULT 0.00,
  `receipt_header` text DEFAULT NULL,
  `receipt_footer` text DEFAULT NULL,
  `logo_url` text DEFAULT NULL,
  `extra` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`extra`)),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_settings`
--

LOCK TABLES `business_settings` WRITE;
/*!40000 ALTER TABLE `business_settings` DISABLE KEYS */;
INSERT INTO `business_settings` VALUES ('00000000-0000-0000-0000-000000000001','Bazar Bari','House #12, Road #4, Dhanmondi, Dhaka-1205','01700000000','info@bazarbari.com','৳','BDT',0.00,'বাজার বাড়ি - অনলাইন ও অফলাইন গ্রোসারি','আমাদের সাথে থাকার জন্য ধন্যবাদ!',NULL,NULL,'2026-10-05 09:46:24');
/*!40000 ALTER TABLE `business_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` varchar(36) NOT NULL,
  `name_en` varchar(120) NOT NULL,
  `name_bn` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `icon` varchar(60) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('11111111-1111-4111-8111-111111111111','Grocery','মুদি','grocery',NULL,NULL,1,'2026-10-05 09:46:25'),('12121212-1212-4121-8121-121212121212','Pet Care','পোষা প্রাণীর যত্ন','pet-care',NULL,NULL,1,'2026-10-05 09:46:25'),('22222222-2222-4222-8222-222222222222','Beverages','পানীয়','beverages',NULL,NULL,1,'2026-10-05 09:46:25'),('33333333-3333-4333-8333-333333333333','Snacks','স্ন্যাকস','snacks',NULL,NULL,1,'2026-10-05 09:46:25'),('44444444-4444-4444-8444-444444444444','Household','গৃহস্থালি','household',NULL,NULL,1,'2026-10-05 09:46:25'),('55555555-5555-4555-8555-555555555555','Fresh','ফ্রেশ / সবজি-মাছ-মাংস','fresh',NULL,NULL,1,'2026-10-05 09:46:25'),('66666666-6666-4666-8666-666666666666','Dairy','দুগ্ধজাত','dairy',NULL,NULL,1,'2026-10-05 09:46:25'),('77777777-7777-4777-8777-777777777777','Personal Care','পার্সোনাল কেয়ার','personal-care',NULL,NULL,1,'2026-10-05 09:46:25'),('88888888-8888-4888-8888-888888888888','Baby Care','বেবি কেয়ার','baby-care',NULL,NULL,1,'2026-10-05 09:46:25'),('99999999-9999-4999-8999-999999999999','Frozen','ফ্রোজেন','frozen',NULL,NULL,1,'2026-10-05 09:46:25'),('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','Stationery','স্টেশনারি','stationery',NULL,NULL,1,'2026-10-05 09:46:25'),('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb','Bakery & Egg','বেকারি ও ডিম','bakery-egg',NULL,NULL,1,'2026-10-05 09:46:25'),('cccccccc-cccc-4ccc-8ccc-cccccccccccc','Fruits','ফল','fruits',NULL,NULL,1,'2026-10-05 09:46:25'),('dddddddd-dddd-4ddd-8ddd-dddddddddddd','Meat & Fish','মাছ ও মাংস','meat-fish',NULL,NULL,1,'2026-10-05 09:46:25'),('eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee','Tea & Coffee','চা ও কফি','tea-coffee',NULL,NULL,1,'2026-10-05 09:46:25'),('ffffffff-ffff-4fff-8fff-ffffffffffff','Health Care','স্বাস্থ্য সুরক্ষা','health-care',NULL,NULL,1,'2026-10-05 09:46:25');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` varchar(36) NOT NULL,
  `type` varchar(30) NOT NULL DEFAULT 'customer',
  `name` varchar(120) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `balance` decimal(12,2) DEFAULT 0.00,
  `loyalty_points` int(11) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupons` (
  `id` varchar(36) NOT NULL,
  `code` varchar(60) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'fixed',
  `value` decimal(12,2) NOT NULL,
  `min_amount` decimal(12,2) DEFAULT 0.00,
  `max_discount` decimal(12,2) DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `usage_count` int(11) DEFAULT 0,
  `expires_on` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_addresses`
--

DROP TABLE IF EXISTS `customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_addresses` (
  `id` varchar(36) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `tag` varchar(60) DEFAULT 'Home',
  `address` text NOT NULL,
  `area` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_addresses`
--

LOCK TABLES `customer_addresses` WRITE;
/*!40000 ALTER TABLE `customer_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_notifications`
--

DROP TABLE IF EXISTS `customer_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_notifications` (
  `id` varchar(36) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `body` text NOT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `send_status` varchar(30) DEFAULT 'pending',
  `send_attempts` int(11) DEFAULT 0,
  `last_error` text DEFAULT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_attempt_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_notifications`
--

LOCK TABLES `customer_notifications` WRITE;
/*!40000 ALTER TABLE `customer_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_feedback`
--

DROP TABLE IF EXISTS `delivery_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_feedback` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 5,
  `comment` text DEFAULT NULL,
  `sla_minutes` int(11) DEFAULT NULL,
  `is_overdue` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_feedback`
--

LOCK TABLES `delivery_feedback` WRITE;
/*!40000 ALTER TABLE `delivery_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_order_events`
--

DROP TABLE IF EXISTS `delivery_order_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_order_events` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) NOT NULL,
  `status` varchar(30) NOT NULL,
  `notes` text DEFAULT NULL,
  `actor` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_order_events`
--

LOCK TABLES `delivery_order_events` WRITE;
/*!40000 ALTER TABLE `delivery_order_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_order_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_order_items`
--

DROP TABLE IF EXISTS `delivery_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_order_items` (
  `id` varchar(36) NOT NULL,
  `delivery_order_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` decimal(10,3) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `line_total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_order_items`
--

LOCK TABLES `delivery_order_items` WRITE;
/*!40000 ALTER TABLE `delivery_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_orders`
--

DROP TABLE IF EXISTS `delivery_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_orders` (
  `id` varchar(36) NOT NULL,
  `order_no` bigint(20) DEFAULT NULL,
  `customer_name` varchar(120) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `delivery_address` text NOT NULL,
  `zone_id` varchar(36) DEFAULT NULL,
  `delivery_slot` varchar(60) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `delivery_fee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(12,2) DEFAULT 0.00,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_method` varchar(50) NOT NULL DEFAULT 'cod',
  `payment_status` varchar(30) NOT NULL DEFAULT 'unpaid',
  `status` varchar(30) NOT NULL DEFAULT 'pending',
  `rider_id` varchar(36) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_orders`
--

LOCK TABLES `delivery_orders` WRITE;
/*!40000 ALTER TABLE `delivery_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_proofs`
--

DROP TABLE IF EXISTS `delivery_proofs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_proofs` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) NOT NULL,
  `order_no` int(11) DEFAULT NULL,
  `file_path` text NOT NULL,
  `status` varchar(30) DEFAULT 'submitted',
  `verified_by` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_proofs`
--

LOCK TABLES `delivery_proofs` WRITE;
/*!40000 ALTER TABLE `delivery_proofs` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_proofs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_riders`
--

DROP TABLE IF EXISTS `delivery_riders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_riders` (
  `id` varchar(36) NOT NULL,
  `name` varchar(120) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `vehicle` varchar(60) DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_riders`
--

LOCK TABLES `delivery_riders` WRITE;
/*!40000 ALTER TABLE `delivery_riders` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_riders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_slot_capacity`
--

DROP TABLE IF EXISTS `delivery_slot_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_slot_capacity` (
  `id` varchar(36) NOT NULL,
  `slot_date` date NOT NULL,
  `slot_key` varchar(50) NOT NULL,
  `capacity` int(11) NOT NULL DEFAULT 50,
  `booked` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_slot_capacity`
--

LOCK TABLES `delivery_slot_capacity` WRITE;
/*!40000 ALTER TABLE `delivery_slot_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_slot_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_zones`
--

DROP TABLE IF EXISTS `delivery_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_zones` (
  `id` varchar(36) NOT NULL,
  `name_en` varchar(120) NOT NULL,
  `name_bn` varchar(120) NOT NULL,
  `delivery_fee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `min_order` decimal(12,2) NOT NULL DEFAULT 0.00,
  `free_delivery_above` decimal(12,2) DEFAULT NULL,
  `eta_minutes` int(11) DEFAULT 60,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_zones`
--

LOCK TABLES `delivery_zones` WRITE;
/*!40000 ALTER TABLE `delivery_zones` DISABLE KEYS */;
INSERT INTO `delivery_zones` VALUES ('33b6adb0-aa1e-4596-8942-837b5825512e','Dhanmondi','ধানমন্ডি',29.00,100.00,500.00,60,1,'2026-10-05 09:46:25'),('9ca51de7-6553-4a78-8907-31b7368ee047','Bashundhara R/A','বসুন্ধরা আ/এ',49.00,200.00,900.00,120,1,'2026-10-05 09:46:25'),('a8e0f47d-dc9a-4fa1-97df-2ed9c41b2b0b','Uttara','উত্তরা',39.00,150.00,700.00,90,1,'2026-10-05 09:46:25'),('d69998be-0df6-4b6b-8de6-399d52f5d844','Gulshan','গুলশান',29.00,100.00,500.00,60,1,'2026-10-05 09:46:25'),('ef050cfd-2821-4657-940d-0f3c01cbbd58','Mirpur','মিরপুর',39.00,150.00,700.00,90,1,'2026-10-05 09:46:25'),('f649730d-bf5d-46bc-b155-c1c391e81dfb','Mohammadpur','মোহাম্মদপুর',29.00,100.00,500.00,75,1,'2026-10-05 09:46:25');
/*!40000 ALTER TABLE `delivery_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_categories`
--

DROP TABLE IF EXISTS `expense_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_categories` (
  `id` varchar(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(40) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_categories`
--

LOCK TABLES `expense_categories` WRITE;
/*!40000 ALTER TABLE `expense_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses` (
  `id` varchar(36) NOT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `account_id` varchar(36) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `spent_on` date NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `receipt_url` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_entries`
--

DROP TABLE IF EXISTS `journal_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_entries` (
  `id` varchar(36) NOT NULL,
  `entry_no` varchar(60) NOT NULL,
  `entry_date` date NOT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_entries`
--

LOCK TABLES `journal_entries` WRITE;
/*!40000 ALTER TABLE `journal_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_lines`
--

DROP TABLE IF EXISTS `journal_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_lines` (
  `id` varchar(36) NOT NULL,
  `journal_entry_id` varchar(36) NOT NULL,
  `ledger_account_id` varchar(36) NOT NULL,
  `debit` decimal(12,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(12,2) NOT NULL DEFAULT 0.00,
  `memo` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_lines`
--

LOCK TABLES `journal_lines` WRITE;
/*!40000 ALTER TABLE `journal_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ledger_accounts`
--

DROP TABLE IF EXISTS `ledger_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ledger_accounts` (
  `id` varchar(36) NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(40) NOT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `balance` decimal(12,2) DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ledger_accounts_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ledger_accounts`
--

LOCK TABLES `ledger_accounts` WRITE;
/*!40000 ALTER TABLE `ledger_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ledger_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loyalty_ledger`
--

DROP TABLE IF EXISTS `loyalty_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loyalty_ledger` (
  `id` varchar(36) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `sale_id` varchar(36) DEFAULT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `points_earned` int(11) DEFAULT 0,
  `points_redeemed` int(11) DEFAULT 0,
  `points_balance` int(11) DEFAULT 0,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loyalty_ledger`
--

LOCK TABLES `loyalty_ledger` WRITE;
/*!40000 ALTER TABLE `loyalty_ledger` DISABLE KEYS */;
/*!40000 ALTER TABLE `loyalty_ledger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_assets`
--

DROP TABLE IF EXISTS `media_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_assets` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_path` text NOT NULL,
  `file_type` varchar(60) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `category` varchar(60) DEFAULT 'general',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_assets`
--

LOCK TABLES `media_assets` WRITE;
/*!40000 ALTER TABLE `media_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` varchar(36) NOT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `contact_id` varchar(36) DEFAULT NULL,
  `sale_id` varchar(36) DEFAULT NULL,
  `purchase_id` varchar(36) DEFAULT NULL,
  `account_id` varchar(36) DEFAULT NULL,
  `type` varchar(30) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `method` varchar(50) NOT NULL DEFAULT 'cash',
  `trx_id` varchar(100) DEFAULT NULL,
  `payment_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_reviews` (
  `id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_phone` varchar(30) DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 5,
  `review_text` text DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_stock`
--

DROP TABLE IF EXISTS `product_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_stock` (
  `id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `cost_price` decimal(12,2) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_stock`
--

LOCK TABLES `product_stock` WRITE;
/*!40000 ALTER TABLE `product_stock` DISABLE KEYS */;
INSERT INTO `product_stock` VALUES ('013abd09-dc22-4253-9cd4-ea1b9a8349c8','6d9fdf83-38b4-479b-86cd-05ee505e9387','00000000-0000-0000-0000-000000000002',21,390.00,'2026-10-05 09:46:25'),('05cf6825-85ae-4cc5-9e27-2031964aed3c','8d5dc3eb-0d62-4924-b5ec-0a2f501f03a3','00000000-0000-0000-0000-000000000002',150,48.00,'2026-10-05 09:46:25'),('05e796ef-aef6-406f-88ec-0a3dc524017b','964a9077-87d5-4db0-9404-f5296891e0a5','00000000-0000-0000-0000-000000000002',108,120.00,'2026-10-05 09:46:25'),('06d72d06-fd2f-4592-8d80-9d09b48446a6','36a9665f-428f-40ab-8b25-4d19b3d0dda7','00000000-0000-0000-0000-000000000002',29,180.00,'2026-10-05 09:46:26'),('0a3b4df3-2d9d-4605-8472-e0e4487f371f','0d206ee1-aeed-4e6f-bf7b-623966077227','00000000-0000-0000-0000-000000000002',40,205.00,'2026-10-05 09:46:25'),('0caee671-5e27-45c3-9689-f71eb59a592c','8a7cf121-6004-44ec-9814-e6636a8f9dfb','00000000-0000-0000-0000-000000000002',102,46.00,'2026-10-05 09:46:25'),('13564628-705d-40f3-a109-eaf3338fa42e','3b83cebb-87a6-4053-ac61-8a0c3ae7ef13','00000000-0000-0000-0000-000000000002',180,32.00,'2026-10-05 09:46:25'),('13bb5f77-d036-461c-b0a6-63c226bb05aa','545738ba-b0ea-4d62-be77-c99e5c9e2883','00000000-0000-0000-0000-000000000002',25,375.00,'2026-10-05 09:46:25'),('142c4e73-f602-4d76-8d53-0d18c1ec0882','3ef8c6d7-36a2-4317-aa50-b1ce651d9ab1','00000000-0000-0000-0000-000000000002',80,158.00,'2026-10-05 09:46:25'),('1acfc471-846c-43cc-b5bd-41c5adce07a1','f8b534f3-88fc-4080-a743-aa0f0927fa56','00000000-0000-0000-0000-000000000002',85,46.00,'2026-10-05 09:46:25'),('1b5ddc09-6866-41c4-a36c-3c4b21f95c22','0df34d16-f9a4-4378-9961-1ff0f119356a','00000000-0000-0000-0000-000000000002',25,480.00,'2026-10-05 09:46:25'),('1d9b1eda-4fb5-4b45-bca9-2009bea759a9','0dd2e969-8dba-4072-a552-1ccc9f5e9f35','00000000-0000-0000-0000-000000000002',45,215.00,'2026-10-05 09:46:25'),('1f68313a-1f3e-4ccb-a6e5-f60b1dd27fd6','e98427b3-1935-46f6-8ea7-e5ade9101f61','00000000-0000-0000-0000-000000000002',35,152.00,'2026-10-05 09:46:25'),('20632c4c-3648-4240-aa5e-c302f42fb07a','af3c93a6-6afb-43f6-946d-af60422889a7','00000000-0000-0000-0000-000000000002',70,165.00,'2026-10-05 09:46:25'),('284dc8b2-0062-4808-8c74-f913adaa8c2b','1bd6d3cc-3261-46f2-b1d2-8009336ca67e','00000000-0000-0000-0000-000000000002',45,205.00,'2026-10-05 09:46:25'),('2aa61c64-6549-409b-a637-362836aecf0d','9d517bfd-ada3-4247-bc11-2381d7ea819c','00000000-0000-0000-0000-000000000002',200,32.00,'2026-10-05 09:46:25'),('2bc4daf8-8e66-439b-b938-bf457d7dc011','09efeba7-0196-40d4-bc75-11466fd79d28','00000000-0000-0000-0000-000000000002',80,82.00,'2026-10-05 09:46:25'),('2f3ea794-0436-489a-9136-8f947d61eb1f','71ff2354-3d93-4da7-b48b-b042ee37f04c','00000000-0000-0000-0000-000000000002',25,650.00,'2026-10-05 09:46:25'),('2febb0a1-446d-47d6-be1e-69b33ba27235','1a6c5e09-f8b5-4a22-8bcd-cd05bdae525f','00000000-0000-0000-0000-000000000002',90,145.00,'2026-10-05 09:46:25'),('301b771c-44a9-47e3-83a3-01a70b991711','42010b96-3986-4c93-a654-3f0e89bb1ea1','00000000-0000-0000-0000-000000000002',95,68.00,'2026-10-05 09:46:25'),('3254c058-33cf-4c38-adaa-0829a58baa22','5c8a975e-4769-4004-b208-abf1277c416b','00000000-0000-0000-0000-000000000002',100,72.00,'2026-10-05 09:46:26'),('37a27007-2a9e-4ba6-b62e-91d8cc8548cc','936c5288-7a08-45d0-b5fd-8e9a8a365de7','00000000-0000-0000-0000-000000000002',50,200.00,'2026-10-05 09:46:25'),('38c374fa-421d-4078-b7e9-f84270a866b2','3cc54717-1492-4049-8d46-d4a6caffce6a','00000000-0000-0000-0000-000000000002',120,125.00,'2026-10-05 09:46:25'),('39c437f8-0e2a-4e5e-81c7-22b595ff0e4c','6ab3cc0b-82f5-4398-b801-41ce85cd2d73','00000000-0000-0000-0000-000000000002',60,175.00,'2026-10-05 09:46:26'),('3a29116c-160d-4885-a662-22f06a5c05f2','4a4a5793-0317-40da-8287-5dc70703aef2','00000000-0000-0000-0000-000000000002',65,108.00,'2026-10-05 09:46:25'),('3a7e5a75-1a5d-413b-a3b0-f73982fa33d5','eaf7740f-b755-4ad1-889b-a41041c7d152','00000000-0000-0000-0000-000000000002',140,45.00,'2026-10-05 09:46:25'),('3aaa23c0-992d-4264-986f-934840b7a3d1','32a75e34-51bf-4981-8540-1f93ceb76b08','00000000-0000-0000-0000-000000000002',78,36.00,'2026-10-05 09:46:25'),('40aba58e-a4e0-417d-99cc-ac3aebee67e9','63b4a5e3-d33b-45bb-9ef7-920382a2ab77','00000000-0000-0000-0000-000000000002',35,245.00,'2026-10-05 09:46:26'),('422b6e88-6c37-41c7-987b-f76a1d60d5d3','592e940d-0c63-4faa-8e31-d42be94c028b','00000000-0000-0000-0000-000000000002',20,800.00,'2026-10-05 09:46:25'),('46dc6685-86cf-45fc-b19e-4c25b6104803','9dd252a8-0cee-4e84-8066-d7081ea24200','00000000-0000-0000-0000-000000000002',250,62.00,'2026-10-05 09:46:25'),('48c42286-7242-4be6-8a1e-40c81526c742','390c4daf-2c2c-4577-bd5d-f271226279a8','00000000-0000-0000-0000-000000000002',45,72.00,'2026-10-05 09:46:25'),('48f56c48-0d21-4de0-98dd-28187349fbf4','61e12309-55c2-4c58-9406-4f4ceeedb2ff','00000000-0000-0000-0000-000000000002',28,295.00,'2026-10-05 09:46:25'),('4ad9f70c-9b3d-4b57-bba2-0a45be52e7dc','d8aa3362-9d16-4d1a-81e3-66072097457d','00000000-0000-0000-0000-000000000002',120,65.00,'2026-10-05 09:46:25'),('4c08d543-d211-488e-82a5-2ab4e8a48a25','5f53d59b-47fa-442a-a755-71ef3d3862dc','00000000-0000-0000-0000-000000000002',45,110.00,'2026-10-05 09:46:25'),('4c0da216-c688-46f4-85cf-ea3cd78ffc46','da3868b9-94a5-4d85-8710-56d4a73b6d98','00000000-0000-0000-0000-000000000002',75,78.00,'2026-10-05 09:46:25'),('4eaba4ae-4cb5-4201-b254-a4d99519a26f','1648820b-d62e-4954-943b-f39bac0527ef','00000000-0000-0000-0000-000000000002',80,35.00,'2026-10-05 09:46:26'),('5145e972-dd02-4f37-b265-34f8bf1a6975','bd6b1968-e933-4ffe-8f97-171e3ba222ef','00000000-0000-0000-0000-000000000002',50,152.00,'2026-10-05 09:46:25'),('53da750a-f930-4627-9f86-ba420ac556f7','7deb47a4-1dc9-4102-b21a-f985972852d6','00000000-0000-0000-0000-000000000002',20,1000.00,'2026-10-05 09:46:25'),('544b10ab-ab28-4796-904e-bfeb1f289c53','ba632f29-d301-45c7-8596-3622ab2703c9','00000000-0000-0000-0000-000000000002',30,450.00,'2026-10-05 09:46:25'),('551e6a5d-d002-494a-a63c-5b8f11937394','a9db22a7-474c-419a-942c-f43fa8815d8d','00000000-0000-0000-0000-000000000002',30,740.00,'2026-10-05 09:46:26'),('56c59b76-a46d-4e64-bf3d-e19f166cd565','e66a2dee-e2bf-4763-ae37-4957d75acd1c','00000000-0000-0000-0000-000000000002',45,280.00,'2026-10-05 09:46:26'),('57fa65b7-61d1-4ebf-a08e-670dfcc6cd58','2c6331a6-2cee-45f8-9e49-5956e637970e','00000000-0000-0000-0000-000000000002',15,1450.00,'2026-10-05 09:46:26'),('5f900008-4457-4d6b-afa1-f24761c27d02','8a57cbbb-c050-452a-bb66-d00afb381d10','00000000-0000-0000-0000-000000000002',40,158.00,'2026-10-05 09:46:25'),('60473d65-88a9-4e18-8c87-1eac895536bf','555789ff-bd46-473d-9408-f00bbd2b4e93','00000000-0000-0000-0000-000000000002',40,480.00,'2026-10-05 09:46:25'),('605c6243-61c9-485c-8d17-2f5154a74b2c','aa78e067-8b35-43f7-b020-f0d73cec2133','00000000-0000-0000-0000-000000000002',127,15.00,'2026-10-05 09:46:25'),('62d293a9-96b2-409a-8559-6f21fd6c55e5','672fb795-9794-41a3-931f-c620fc1e78d4','00000000-0000-0000-0000-000000000002',60,150.00,'2026-10-05 09:46:25'),('632884d8-c65a-4310-87b7-d12ead8fe952','d609319e-dadf-4f58-94fb-c7fadabef925','00000000-0000-0000-0000-000000000002',28,340.00,'2026-10-05 09:46:25'),('63f5c47f-5c00-4c44-b30f-9fd864ab9cc8','41f4b138-6c84-4d0f-9133-1b1f12ffa704','00000000-0000-0000-0000-000000000002',80,102.00,'2026-10-05 09:46:25'),('63fdae9f-8749-4566-80a7-8d56f0162357','2a03a206-b888-44d9-921d-60333a55f61c','00000000-0000-0000-0000-000000000002',70,190.00,'2026-10-05 09:46:25'),('64cfea57-fc8f-4b73-b882-999209d1589f','114e57ad-c07c-4409-aea4-b0cd1243846e','00000000-0000-0000-0000-000000000002',40,225.00,'2026-10-05 09:46:26'),('66c062b9-fbbf-4899-b01b-897706c9b52c','7862267d-77fb-4e96-9579-d8b4857d8840','00000000-0000-0000-0000-000000000002',120,80.00,'2026-10-05 09:46:25'),('69475bfa-7cf7-4244-bb99-34ab6899e1b2','d94930c1-a00f-4e07-a80f-618e3e763c4c','00000000-0000-0000-0000-000000000002',18,740.00,'2026-10-05 09:46:25'),('705e48af-5076-4344-9f68-6036d79e2f94','4d177753-65cc-4e9b-8e75-936c621b1cf8','00000000-0000-0000-0000-000000000002',23,90.00,'2026-10-05 09:46:26'),('71e66b62-e898-4718-b2e9-003e92e78112','ad24f158-0653-46c2-964d-e22212499618','00000000-0000-0000-0000-000000000002',180,24.00,'2026-10-05 09:46:25'),('7292d0af-87c9-41b7-9030-e2ebdf545f8a','50c90e57-89d7-417a-838f-bec0d20d8ef3','00000000-0000-0000-0000-000000000002',25,560.00,'2026-10-05 09:46:26'),('7337d2e1-2fae-444c-8e65-083c12b6f8bd','b4aa9a6c-6fdf-43fd-b5ad-d894da180866','00000000-0000-0000-0000-000000000002',60,125.00,'2026-10-05 09:46:25'),('7494bf4f-5578-412e-a337-3cb652dc47ed','da7cb8ca-9f0d-427b-be8e-3c2d06c2b04f','00000000-0000-0000-0000-000000000002',80,84.00,'2026-10-05 09:46:25'),('76d27dd8-7c2a-4828-a386-ee413cbe93a7','cc09be66-73e4-4e4f-a327-d0e10e4e3e3c','00000000-0000-0000-0000-000000000002',23,860.00,'2026-10-05 09:46:25'),('76e29a11-7000-430f-bd1a-d638e02b0aa6','1e6e712c-ad05-4318-87b9-cb05238b6a24','00000000-0000-0000-0000-000000000002',70,135.00,'2026-10-05 09:46:25'),('77d3e45d-3233-4032-8195-c73739d88d99','8251fc46-a58f-4fb2-b1fd-c150b3200fa1','00000000-0000-0000-0000-000000000002',65,41.00,'2026-10-05 09:46:25'),('7884b57d-6f7e-4986-a4f6-ebd84ee083f5','94ffbd55-e48a-4b59-9c5f-625a213d5c0c','00000000-0000-0000-0000-000000000002',60,92.00,'2026-10-05 09:46:25'),('797c2cb5-f494-4370-b44d-014d36f6e79a','043f4aa1-7166-4342-9e84-589003b4ebb9','00000000-0000-0000-0000-000000000002',15,1450.00,'2026-10-05 09:46:25'),('7a3d90eb-77c1-4772-90a4-39cacde6fff5','c9c33d0d-1ac5-49c2-ba12-0c6fbd310a83','00000000-0000-0000-0000-000000000002',29,84.00,'2026-10-05 09:46:25'),('80fb7d16-9475-4fbf-a858-ea44d42c1054','514140d0-5d0f-4ae6-85e9-a5e4d7b0ed14','00000000-0000-0000-0000-000000000002',115,29.00,'2026-10-05 09:46:25'),('84e13dd1-8ebd-46d3-b0da-a303b7f9a2ee','8b95df28-2e98-40e8-9bcd-a836b16fb525','00000000-0000-0000-0000-000000000002',60,142.00,'2026-10-05 09:46:26'),('879bce0d-dd44-4339-a528-96b46e21aad1','9e77287c-bbb1-48d1-80d1-83a10133a6ac','00000000-0000-0000-0000-000000000002',45,255.00,'2026-10-05 09:46:26'),('8a16e0ed-7b58-403f-bf66-58ebbf44ab5a','4c6e5fba-81ea-421d-9649-de5018661509','00000000-0000-0000-0000-000000000002',100,92.00,'2026-10-05 09:46:25'),('8bb8db9e-00d4-4655-9cc8-e39c8e037d9b','4e01edd7-1530-4d70-80fa-ca58cd6a9f64','00000000-0000-0000-0000-000000000002',39,1900.00,'2026-10-05 09:46:25'),('8c5aa4d7-3eed-4d7f-a2a9-ebdd9d427f19','2bed9a38-744e-40cb-9b92-91e1abd7949b','00000000-0000-0000-0000-000000000002',0,72.00,'2026-10-05 09:46:25'),('8d77f2fe-3d7c-44f3-9cff-049f319e9d46','08ac3ff5-fa73-4433-a5db-ffe27623ed05','00000000-0000-0000-0000-000000000002',15,120.00,'2026-10-05 09:46:25'),('8fc3f42d-43df-4dd7-8373-c6d42be5af3c','4a7f533f-1b13-4049-82ad-762bc9c47007','00000000-0000-0000-0000-000000000002',40,375.00,'2026-10-05 09:46:25'),('92200b74-ea67-4abb-9ea3-25379b180354','9c34cd57-fa1b-4126-bdee-506027c9261b','00000000-0000-0000-0000-000000000002',23,345.00,'2026-10-05 09:46:25'),('93256d68-1027-4ccc-b8e2-4a3fb5971adb','e5057cc6-81f2-4d4b-8f04-bba7231c7004','00000000-0000-0000-0000-000000000002',30,180.00,'2026-10-05 09:46:26'),('9431cd61-8593-445a-85e8-0f5dacff29f8','6d9c9762-219f-4886-9e14-f14c4c6cda28','00000000-0000-0000-0000-000000000002',59,100.00,'2026-10-05 09:46:25'),('9aaf538a-cdce-4f94-b38f-dc2161a0ef58','ae10a61f-9056-41a5-a474-6e000b973608','00000000-0000-0000-0000-000000000002',55,190.00,'2026-10-05 09:46:25'),('9c4e5f34-5e8a-4834-a8cd-75d762739dbe','6757d6e5-adfa-43d2-ab66-8a222a720035','00000000-0000-0000-0000-000000000002',90,60.00,'2026-10-05 09:46:25'),('9f6fefb9-e596-498a-ac62-0765bb965584','87985c89-0f62-4a0d-a2db-daddc1dc446d','00000000-0000-0000-0000-000000000002',40,265.00,'2026-10-05 09:46:25'),('a14fe76b-019d-4f4e-ac17-b3c76d84c80e','e0d62154-cd8b-4c37-b0fd-81844e3afbb2','00000000-0000-0000-0000-000000000002',40,112.00,'2026-10-05 09:46:25'),('a473b7ad-4aff-4d7c-bfe5-70e199558190','4cefa5a8-1a12-4eaa-ae31-da2f03ebc3af','00000000-0000-0000-0000-000000000002',36,100.00,'2026-10-05 09:46:25'),('a63ee104-8b1e-483a-a7fa-5b6b3fb359c1','773c5be3-8cc5-4ad9-8524-b6dda39e9484','00000000-0000-0000-0000-000000000002',11,115.00,'2026-10-05 09:46:25'),('a8c1540b-5e10-4a0b-b674-83a5e5b05ef2','cd4885e5-3536-49a0-b18b-19febb59551a','00000000-0000-0000-0000-000000000002',70,155.00,'2026-10-05 09:46:25'),('a8f3a0ee-9f87-47ec-aa86-9e73c34d57d5','71f948f9-f231-4e13-828e-28d6dab0a129','00000000-0000-0000-0000-000000000002',300,28.00,'2026-10-05 09:46:25'),('a953a925-6fad-403a-87e2-e69559dc0ae9','6c52b46d-bb86-40c2-9b59-b45c099449fd','00000000-0000-0000-0000-000000000002',30,300.00,'2026-10-05 09:46:25'),('ab461ebf-91dd-49eb-b84c-bde6bfba5855','3610f2bd-18e2-410d-b3a1-43336aa96541','00000000-0000-0000-0000-000000000002',35,385.00,'2026-10-05 09:46:25'),('ac8b92f4-a9d0-49ca-8bb9-714d64f907e3','5c06d8e7-ef16-4dd3-98c6-8df0bcfe2033','00000000-0000-0000-0000-000000000002',40,175.00,'2026-10-05 09:46:25'),('aea8bed2-60ce-49f6-9a3c-94675c62451a','d2fdef65-0da4-4677-9f8c-ab1b65fd6ffd','00000000-0000-0000-0000-000000000002',40,66.00,'2026-10-05 09:46:25'),('b1d6b4a8-0e65-496c-bd44-d10abf80882d','24a8fe15-34a1-418b-8498-4a2960fce191','00000000-0000-0000-0000-000000000002',45,285.00,'2026-10-05 09:46:26'),('b2e9aef1-9f34-46fc-aa72-79f709e76edb','252ae0af-71ea-46b0-8fa8-8eba4b565903','00000000-0000-0000-0000-000000000002',50,270.00,'2026-10-05 09:46:25'),('b4fdd46f-4ce2-46be-be3a-90a344ea5b8d','339a8a33-6283-42d5-8318-c5e4dd19ac2f','00000000-0000-0000-0000-000000000002',150,29.00,'2026-10-05 09:46:25'),('b8178d1e-4eac-4f26-a96f-935ef0a7031f','019805ce-8c57-460c-b461-b059485f779f','00000000-0000-0000-0000-000000000002',50,830.00,'2026-10-05 09:46:25'),('b8899a6d-ce0d-49a6-aacf-a9ac990fd53f','0d2c1551-823f-4a1b-a5dd-d6c0291e70b1','00000000-0000-0000-0000-000000000002',70,98.00,'2026-10-05 09:46:25'),('bb30edb9-8f38-4de2-877b-ea0d0e745247','f5bcb4d2-a403-4c81-a85c-6b2235e603fd','00000000-0000-0000-0000-000000000002',35,280.00,'2026-10-05 09:46:26'),('bcb477b9-2c0b-45c6-aa6c-6cd3b093c648','fbe2f010-f702-418e-a2cf-4558902d15cf','00000000-0000-0000-0000-000000000002',40,580.00,'2026-10-05 09:46:25'),('bd5e2972-f08c-41d5-b27d-a8476d80e666','b86cffe6-15da-4812-ae14-e17f40e871c7','00000000-0000-0000-0000-000000000002',181,19.00,'2026-10-05 09:46:25'),('bfc74295-b708-49f4-9216-aecba160e39b','633e663b-5b8c-4f32-a77b-7c66b8d35657','00000000-0000-0000-0000-000000000002',66,75.00,'2026-10-05 09:46:25'),('c088ba5d-03ea-4621-9da3-147b2cd12425','4daaae07-e5ea-4a15-a361-98e643e1d4cd','00000000-0000-0000-0000-000000000002',60,470.00,'2026-10-05 09:46:25'),('c4e4c3c8-23ad-48b0-a682-9bd3a6409d36','f5d8c26e-c719-415f-98bb-aabeffc65245','00000000-0000-0000-0000-000000000002',55,82.00,'2026-10-05 09:46:25'),('c6960fc9-94a8-4fc6-8891-7d5dcfc1b2e5','60941924-b3ff-489f-b8e8-b2f0e9290756','00000000-0000-0000-0000-000000000002',20,370.00,'2026-10-05 09:46:25'),('c8ef41ee-bfe4-429b-822e-4a8887ad5659','a2dc0782-9e99-4d29-85e6-8d5b59a5b012','00000000-0000-0000-0000-000000000002',25,480.00,'2026-10-05 09:46:26'),('c9de3fe9-f70f-4a63-835d-e08843d45449','d1f36709-1dc6-43ee-8275-6c4fb85643d9','00000000-0000-0000-0000-000000000002',78,24.00,'2026-10-05 09:46:25'),('cb3e7ac8-59d1-4a7a-9319-7e264c58da3c','0e715fad-eb53-4021-8fc1-38da2a3dd404','00000000-0000-0000-0000-000000000002',30,360.00,'2026-10-05 09:46:25'),('cb7f88a5-f37e-40a4-b60f-b24480b9a370','35e84bc8-b398-4a54-9395-84441bddf0e1','00000000-0000-0000-0000-000000000002',80,78.00,'2026-10-05 09:46:25'),('ce5f22b9-2b29-4fcf-8aff-15a902b42668','318d3c02-b051-47da-99a9-2b74feaa6611','00000000-0000-0000-0000-000000000002',60,112.00,'2026-10-05 09:46:25'),('cf5dbe13-bb19-4281-bc16-c81f390fbd36','dd67c0da-72c0-4d3e-b53e-698b09ba8738','00000000-0000-0000-0000-000000000002',55,200.00,'2026-10-05 09:46:25'),('d035ed62-5884-4883-b4d5-c33eaf833d7f','96de1367-8ee6-4dd7-b40e-e478bf157e7a','00000000-0000-0000-0000-000000000002',30,255.00,'2026-10-05 09:46:25'),('d10d5ae4-d220-4c55-b629-b46e734949bd','87b578fc-cee0-41a4-957b-273a1464553b','00000000-0000-0000-0000-000000000002',60,145.00,'2026-10-05 09:46:25'),('d2142b3e-39e0-485d-b801-b0d76787cf36','831ffa8d-9f77-418d-ac64-04257eef0bba','00000000-0000-0000-0000-000000000002',0,190.00,'2026-10-05 09:46:25'),('d64a13c3-b676-49ad-ab93-03fea955ba41','3b20079b-65b1-4d2e-b7bd-e33e15d068cf','00000000-0000-0000-0000-000000000002',70,102.00,'2026-10-05 09:46:26'),('d89b7e34-54f6-4382-b88e-b070cfc6af36','23bfdce7-43ed-4779-8e5a-99194730dfa9','00000000-0000-0000-0000-000000000002',200,20.00,'2026-10-05 09:46:25'),('da003d9f-b169-48d7-b116-31176fbae322','330b86c0-41a9-4017-9de4-ecbd79d8a562','00000000-0000-0000-0000-000000000002',90,95.00,'2026-10-05 09:46:25'),('daea1ca3-abdb-404f-8832-a5f1540126f3','ec6a3838-d30b-4bc4-8492-ca368ffccac9','00000000-0000-0000-0000-000000000002',60,58.00,'2026-10-05 09:46:25'),('dc08108d-f7a4-4047-9c7f-17cf7ebe467b','95e89cd7-3fd5-44e2-bcfb-7505eeb1df9f','00000000-0000-0000-0000-000000000002',34,1820.00,'2026-10-05 09:46:25'),('de1bbc9e-dbf4-4f21-9582-54df2f841572','44fd4bb2-0812-4315-9e54-0e9be524a40a','00000000-0000-0000-0000-000000000002',89,80.00,'2026-10-05 09:46:26'),('e4921b1a-a038-4ee1-8bb9-1dda2731608f','0f6a2942-45e0-4af4-9ac1-056e982efc76','00000000-0000-0000-0000-000000000002',80,46.00,'2026-10-05 09:46:25'),('e9fe10b7-d661-4c69-a5ec-53c20d112995','29f90a85-0d80-4914-8185-1b6ec9c63ffb','00000000-0000-0000-0000-000000000002',30,280.00,'2026-10-05 09:46:25'),('ea113c31-bb5b-4662-b954-124963c86043','af71cff7-3b16-43b5-9d3b-27d0a08b8270','00000000-0000-0000-0000-000000000002',35,720.00,'2026-10-05 09:46:25'),('ecc43918-2aa9-4bce-8dc2-c6474a54b25a','6687050a-0132-41c8-8706-d6b005a7fd4c','00000000-0000-0000-0000-000000000002',100,132.00,'2026-10-05 09:46:26'),('ee201213-44e8-4d5d-89ca-bca0dd92e69d','c00716f6-0e99-4246-a437-34bc39e454f1','00000000-0000-0000-0000-000000000002',60,245.00,'2026-10-05 09:46:25'),('ee75cc60-02bc-4811-9950-2881ce5b90c6','ce9abe15-5af3-496a-94b9-9e4ea4b026cd','00000000-0000-0000-0000-000000000002',51,162.00,'2026-10-05 09:46:25'),('f0b2b8af-cfb5-43d4-a72b-f513bb89d53f','78ac42e2-29c0-4f8b-96a0-8479a71ec959','00000000-0000-0000-0000-000000000002',100,54.00,'2026-10-05 09:46:25'),('f5dbe9af-414b-480c-bcff-71845cd730f6','189c5c40-9b46-4752-a789-7d9d0f8a34ea','00000000-0000-0000-0000-000000000002',45,125.00,'2026-10-05 09:46:25'),('f88a6e92-3956-481b-9dff-d76d3c6aa4a2','d61ff31f-cf35-4c4a-ad95-7e38304a4dd1','00000000-0000-0000-0000-000000000002',50,190.00,'2026-10-05 09:46:26'),('f9c804a9-5836-4acd-be58-2e636782970f','49e64c81-5296-46b1-aa0a-41aea4e8cd99','00000000-0000-0000-0000-000000000002',120,76.00,'2026-10-05 09:46:25'),('fbbc8cb8-5998-487f-808f-86a4a486c7e0','288f7029-d154-4599-9c8d-1a049fe1fcad','00000000-0000-0000-0000-000000000002',25,540.00,'2026-10-05 09:46:25'),('fc156c00-4840-4ab9-a9ed-0c552c6514e8','0cddb446-b173-4a5f-a284-d84cf6914de4','00000000-0000-0000-0000-000000000002',40,370.00,'2026-10-05 09:46:26'),('fe1de137-b6f4-4b20-8c66-0a1f73176c1f','c4fe49a9-1ff9-4ae0-88c5-8342c1c748e9','00000000-0000-0000-0000-000000000002',80,338.00,'2026-10-05 09:46:26');
/*!40000 ALTER TABLE `product_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` varchar(36) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_bn` varchar(255) NOT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `brand` varchar(120) DEFAULT NULL,
  `unit` varchar(30) DEFAULT 'pcs',
  `pack_size` varchar(60) DEFAULT NULL,
  `cost_price` decimal(12,2) DEFAULT 0.00,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `mrp` decimal(12,2) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `alert_quantity` int(11) DEFAULT 5,
  `image_url` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `seq` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('019805ce-8c57-460c-b461-b059485f779f','Rupchanda Soyabean Oil 5L','রূপচাঁদা সয়াবিন তেল ৫ লিটার','SKU-5005','88015005','11111111-1111-4111-8111-111111111111','Rupchanda','pcs','5 L',830.00,880.00,NULL,50,10,'/products/rupchanda-soyabean-oil-5l.jpg',NULL,25,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('043f4aa1-7166-4342-9e84-589003b4ebb9','Hilsa Fish 1kg','ইলিশ মাছ ১ কেজি','SKU-6012',NULL,'dddddddd-dddd-4ddd-8ddd-dddddddddddd','Padma','kg','1 kg',1450.00,1650.00,NULL,15,5,'/products/hilsa-1kg.jpg',NULL,112,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('08ac3ff5-fa73-4433-a5db-ffe27623ed05','Masoor Dal 1kg','মসুর ডাল ১ কেজি','SKU-1003',NULL,'11111111-1111-4111-8111-111111111111','Teer','kg','1 kg',120.00,135.00,NULL,15,5,'/products/masoor-dal-1kg.jpg',NULL,14,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('09efeba7-0196-40d4-bc75-11466fd79d28','Khesari Dal 1kg','খেসারি ডাল ১ কেজি','SKU-5011','88015011','11111111-1111-4111-8111-111111111111','Local','kg','1 kg',82.00,95.00,NULL,80,10,'/products/khesari-dal-1kg.jpg',NULL,27,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('0cddb446-b173-4a5f-a284-d84cf6914de4','Rui Fish 1kg','রুই মাছ ১ কেজি','SKU-5065','88015065','55555555-5555-4555-8555-555555555555','Local','kg','1 kg',370.00,420.00,NULL,40,10,'/products/rui-fish-1kg.jpg',NULL,84,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('0d206ee1-aeed-4e6f-bf7b-623966077227','Green Tea Bag 25pcs','গ্রিন টি ব্যাগ ২৫ পিস','SKU-5030','88015030','22222222-2222-4222-8222-222222222222','Kazi & Kazi','pcs','25 pcs',205.00,240.00,NULL,40,10,'/products/green-tea-bag-25pcs.jpg',NULL,46,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('0d2c1551-823f-4a1b-a5dd-d6c0291e70b1','Toothbrush 2pcs','টুথব্রাশ ২ পিস','SKU-5076','88015076','77777777-7777-4777-8777-777777777777','Systema','pcs','2 pcs',98.00,120.00,NULL,70,10,'/products/toothbrush-2pcs.jpg',NULL,91,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('0dd2e969-8dba-4072-a552-1ccc9f5e9f35','Masala Tea 200g','মসলা চা ২০০ গ্রাম','SKU-6023',NULL,'eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee','Tetley','pcs','200 g',215.00,260.00,NULL,45,5,'/products/masala-tea-200g.jpg',NULL,117,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('0df34d16-f9a4-4378-9961-1ff0f119356a','Shrimp 500g','চিংড়ি ৫০০ গ্রাম','SKU-6014',NULL,'dddddddd-dddd-4ddd-8ddd-dddddddddddd','Fresh','pcs','500 g',480.00,560.00,NULL,25,5,'/products/shrimp-500g.jpg',NULL,114,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('0e715fad-eb53-4021-8fc1-38da2a3dd404','Rui Fish Cut 1kg','রুই মাছ কাটা ১ কেজি','SKU-6011',NULL,'dddddddd-dddd-4ddd-8ddd-dddddddddddd','Fresh','kg','1 kg',360.00,420.00,NULL,30,5,'/products/rui-fish-1kg.jpg',NULL,111,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('0f6a2942-45e0-4af4-9ac1-056e982efc76','Milk Vita Milk 500ml','মিল্ক ভিটা দুধ ৫০০ মিলি','SKU-5049','88015049','66666666-6666-4666-8666-666666666666','Milk Vita','pcs','500 ml',46.00,55.00,NULL,80,10,'/products/milk-vita-milk-500ml.jpg',NULL,69,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('114e57ad-c07c-4409-aea4-b0cd1243846e','Floor Cleaner 1L','ফ্লোর ক্লিনার ১ লিটার','SKU-5082','88015082','44444444-4444-4444-8444-444444444444','Harpic','pcs','1 L',225.00,260.00,NULL,40,10,'/products/floor-cleaner-1l.jpg',NULL,99,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('1648820b-d62e-4954-943b-f39bac0527ef','Green Chili 250g','কাঁচা মরিচ ২৫০ গ্রাম','SKU-5061','88015061','55555555-5555-4555-8555-555555555555','Local','kg','250 g',35.00,45.00,NULL,80,10,'/products/green-chili-250g.jpg',NULL,75,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('189c5c40-9b46-4752-a789-7d9d0f8a34ea','Garbage Bag 30pcs','গার্বেজ ব্যাগ ৩০ পিস','SKU-5086','88015086','44444444-4444-4444-8444-444444444444','Bashundhara','pcs','30 pcs',125.00,150.00,NULL,45,10,'/products/garbage-bag-30pcs.jpg',NULL,101,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('1a6c5e09-f8b5-4a22-8bcd-cd05bdae525f','Mug Dal 1kg','মুগ ডাল ১ কেজি','SKU-5009','88015009','11111111-1111-4111-8111-111111111111','Pran','kg','1 kg',145.00,165.00,NULL,90,10,'/products/mug-dal-1kg.jpg',NULL,29,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('1bd6d3cc-3261-46f2-b1d2-8009336ca67e','Rice Bran Oil 1L','রাইস ব্রান তেল ১ লিটার','SKU-5008','88015008','11111111-1111-4111-8111-111111111111','Teer','pcs','1 L',205.00,230.00,NULL,45,10,'/products/rice-bran-oil-1l.jpg',NULL,22,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('1e6e712c-ad05-4318-87b9-cb05238b6a24','Pepsi 2L','পেপসি ২ লিটার','SKU-5032','88015032','22222222-2222-4222-8222-222222222222','Pepsi','pcs','2 L',135.00,150.00,NULL,70,10,'/products/pepsi-2l.jpg',NULL,53,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('23bfdce7-43ed-4779-8e5a-99194730dfa9','Speed Energy Drink 250ml','স্পিড এনার্জি ড্রিংক ২৫০ মিলি','SKU-5035','88015035','22222222-2222-4222-8222-222222222222','Akij','pcs','250 ml',20.00,25.00,NULL,200,10,'/products/speed-energy-drink-250ml.jpg',NULL,50,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('24a8fe15-34a1-418b-8498-4a2960fce191','Frozen Paratha 20pcs','ফ্রোজেন পরোটা ২০ পিস','SKU-5070','88015070','99999999-9999-4999-8999-999999999999','Golden Harvest','pcs','20 pcs',285.00,320.00,NULL,45,10,'/products/frozen-paratha-20pcs.jpg',NULL,89,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('252ae0af-71ea-46b0-8fa8-8eba4b565903','Orange 1kg','কমলা ১ কেজি','SKU-6002',NULL,'cccccccc-cccc-4ccc-8ccc-cccccccccccc','Imported','kg','1 kg',270.00,320.00,NULL,50,5,'/products/orange-1kg.jpg',NULL,108,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('288f7029-d154-4599-9c8d-1a049fe1fcad','Dates Premium 1kg','খেজুর প্রিমিয়াম ১ কেজি','SKU-5025','88015025','11111111-1111-4111-8111-111111111111','Imported','kg','1 kg',540.00,620.00,NULL,25,10,'/products/dates-premium-1kg.jpg',NULL,43,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('29f90a85-0d80-4914-8185-1b6ec9c63ffb','Digital Thermometer','ডিজিটাল থার্মোমিটার','SKU-6034',NULL,'ffffffff-ffff-4fff-8fff-ffffffffffff','Omron','pcs','1 pc',280.00,350.00,NULL,30,5,'/products/digital-thermometer.jpg',NULL,122,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('2a03a206-b888-44d9-921d-60333a55f61c','Surgical Face Mask 50pcs','সার্জিক্যাল মাস্ক ৫০ পিস','SKU-6032',NULL,'ffffffff-ffff-4fff-8fff-ffffffffffff','Getwell','pcs','50 pcs',190.00,250.00,NULL,70,5,'/products/face-mask-50pcs.jpg',NULL,120,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('2bed9a38-744e-40cb-9b92-91e1abd7949b','Tissue Box','টিস্যু বক্স','SKU-4004',NULL,'44444444-4444-4444-8444-444444444444','Bashundhara','box','100 pcs',72.00,85.00,NULL,0,5,'/products/tissue-box.jpg',NULL,10,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('2c6331a6-2cee-45f8-9e49-5956e637970e','Ilish Fish 1kg','ইলিশ মাছ ১ কেজি','SKU-5066','88015066','55555555-5555-4555-8555-555555555555','Local','kg','1 kg',1450.00,1600.00,NULL,15,10,'/products/ilish-fish-1kg.jpg',NULL,83,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('318d3c02-b051-47da-99a9-2b74feaa6611','Frutika Mango 1L','ফ্রুটিকা ম্যাংগো ১ লিটার','SKU-5037','88015037','22222222-2222-4222-8222-222222222222','Akij','pcs','1 L',112.00,130.00,NULL,60,10,'/products/frutika-mango-1l.jpg',NULL,56,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('32a75e34-51bf-4981-8540-1f93ceb76b08','Salt 1kg','লবণ ১ কেজি','SKU-1005',NULL,'11111111-1111-4111-8111-111111111111','ACI','kg','1 kg',36.00,42.00,NULL,78,5,'/products/salt-1kg.jpg',NULL,2,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('330b86c0-41a9-4017-9de4-ecbd79d8a562','Chanachur 350g','চানাচুর ৩৫০ গ্রাম','SKU-5041','88015041','33333333-3333-4333-8333-333333333333','Bombay Sweets','pcs','350 g',95.00,110.00,NULL,90,10,'/products/chanachur-350g.jpg',NULL,60,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('339a8a33-6283-42d5-8318-c5e4dd19ac2f','Mojo 500ml','মোজো ৫০০ মিলি','SKU-5034','88015034','22222222-2222-4222-8222-222222222222','Akij','pcs','500 ml',29.00,35.00,NULL,150,10,'/products/mojo-500ml.jpg',NULL,51,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('35e84bc8-b398-4a54-9395-84441bddf0e1','Notebook 200 page','খাতা ২০০ পৃষ্ঠা','SKU-5087','88015087','aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','Bashundhara','pcs','200 pages',78.00,95.00,NULL,80,10,'/products/notebook-200page.jpg',NULL,106,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('3610f2bd-18e2-410d-b3a1-43336aa96541','Coffee Creamer 400g','কফি ক্রিমার ৪০০ গ্রাম','SKU-6022',NULL,'eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee','Coffee Mate','pcs','400 g',385.00,450.00,NULL,35,5,'/products/coffee-creamer-400g.jpg',NULL,116,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('36a9665f-428f-40ab-8b25-4d19b3d0dda7','Aluminium Foil 10m','অ্যালুমিনিয়াম ফয়েল ১০ মিটার','SKU-5085','88015085','44444444-4444-4444-8444-444444444444','Fresh','pcs','10 m',180.00,210.00,NULL,29,10,'/products/aluminium-foil-10m.jpg',NULL,102,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('390c4daf-2c2c-4577-bd5d-f271226279a8','Ripe Papaya 1pc','পাকা পেঁপে ১টি','SKU-6004',NULL,'cccccccc-cccc-4ccc-8ccc-cccccccccccc','Local','pcs','1 pc',72.00,95.00,NULL,45,5,'/products/papaya-1pc.jpg',NULL,110,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('3b20079b-65b1-4d2e-b7bd-e33e15d068cf','Digestive Biscuit 250g','ডাইজেস্টিভ বিস্কুট ২৫০ গ্রাম','SKU-5043','88015043','33333333-3333-4333-8333-333333333333','Danish','pcs','250 g',102.00,120.00,NULL,70,10,'/products/digestive-biscuit-250g.jpg',NULL,58,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('3b83cebb-87a6-4053-ac61-8a0c3ae7ef13','Mum Water 2L','মাম পানি ২ লিটার','SKU-5036','88015036','22222222-2222-4222-8222-222222222222','Partex','pcs','2 L',32.00,40.00,NULL,180,10,'/products/mum-water-2l.jpg',NULL,49,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('3cc54717-1492-4049-8d46-d4a6caffce6a','Chinigura Rice 1kg','চিনিগুঁড়া চাল ১ কেজি','SKU-5003','88015003','11111111-1111-4111-8111-111111111111','Pran','pcs','1 kg',125.00,145.00,NULL,120,10,'/products/chinigura-rice-1kg.jpg',NULL,19,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('3ef8c6d7-36a2-4317-aa50-b1ce651d9ab1','Mr. Noodles 8 pack','মি. নুডলস ৮ প্যাক','SKU-5045','88015045','33333333-3333-4333-8333-333333333333','Pran','pcs','8 x 62 g',158.00,180.00,NULL,80,10,'/products/mr-noodles-8pack.jpg',NULL,64,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('41f4b138-6c84-4d0f-9133-1b1f12ffa704','Cumin Powder 100g','জিরা গুঁড়া ১০০ গ্রাম','SKU-5018','88015018','11111111-1111-4111-8111-111111111111','Radhuni','pcs','100 g',102.00,120.00,NULL,80,10,'/products/cumin-powder-100g.jpg',NULL,33,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('42010b96-3986-4c93-a654-3f0e89bb1ea1','Maida 1kg','ময়দা ১ কেজি','SKU-5021','88015021','11111111-1111-4111-8111-111111111111','Fresh','pcs','1 kg',68.00,78.00,NULL,95,10,'/products/maida-1kg.jpg',NULL,39,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('44fd4bb2-0812-4315-9e54-0e9be524a40a','Ball Pen 10pcs','বলপেন ১০ পিস','SKU-5088','88015088','aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','Matador','pcs','10 pcs',80.00,100.00,NULL,89,10,'/products/ball-pen-10pcs.jpg',NULL,105,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('49e64c81-5296-46b1-aa0a-41aea4e8cd99','KitKat Chocolate','কিটক্যাট চকলেট','SKU-5044','88015044','33333333-3333-4333-8333-333333333333','Nestle','pcs','41.5 g',76.00,90.00,NULL,120,10,'/products/kitkat-chocolate.jpg',NULL,57,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('4a4a5793-0317-40da-8287-5dc70703aef2','Cocola Egg Noodles 500g','কোকোলা এগ নুডলস ৫০০ গ্রাম','SKU-5046','88015046','33333333-3333-4333-8333-333333333333','Cocola','pcs','500 g',108.00,125.00,NULL,65,10,'/products/cocola-egg-noodles-500g.jpg',NULL,63,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('4a7f533f-1b13-4049-82ad-762bc9c47007','Shampoo 340ml','শ্যাম্পু ৩৪০ মিলি','SKU-5073','88015073','77777777-7777-4777-8777-777777777777','Sunsilk','pcs','340 ml',375.00,420.00,NULL,40,10,'/products/shampoo.jpg',NULL,94,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('4c6e5fba-81ea-421d-9649-de5018661509','Chola Boot 1kg','ছোলা বুট ১ কেজি','SKU-5010','88015010','11111111-1111-4111-8111-111111111111','Fresh','kg','1 kg',92.00,105.00,NULL,100,10,'/products/chola-boot-1kg.jpg',NULL,28,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('4cefa5a8-1a12-4eaa-ae31-da2f03ebc3af','Detergent Powder 500g','ডিটারজেন্ট পাউডার ৫০০ গ্রাম','SKU-4001',NULL,'44444444-4444-4444-8444-444444444444','Surf Excel','pkt','500 g',100.00,115.00,NULL,36,5,'/products/detergent-powder-500g.jpg',NULL,13,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('4d177753-65cc-4e9b-8e75-936c621b1cf8','Fresh Milk 1L','ফ্রেশ দুধ ১ লিটার','SKU-2003',NULL,'22222222-2222-4222-8222-222222222222','Aarong','pkt','1 L',90.00,100.00,NULL,23,5,'/products/fresh-milk-1l.jpg',NULL,15,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('4daaae07-e5ea-4a15-a361-98e643e1d4cd','Katari Bhog Rice 5kg','কাটারিভোগ চাল ৫ কেজি','SKU-5004','88015004','11111111-1111-4111-8111-111111111111','Teer','bag','5 kg',470.00,520.00,NULL,60,10,'/products/katari-bhog-rice-5kg.jpg',NULL,18,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('4e01edd7-1530-4d70-80fa-ca58cd6a9f64','Nazirshail Rice 25kg','নাজিরশাইল চাল ২৫ কেজি','SKU-5001','88015001','11111111-1111-4111-8111-111111111111','Rashid','bag','25 kg',1900.00,2050.00,NULL,39,10,'/products/nazirshail-rice-25kg.jpg',NULL,21,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('50c90e57-89d7-417a-838f-bec0d20d8ef3','A4 Paper 500 sheet','এ৪ পেপার ৫০০ শিট','SKU-5089','88015089','aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','Double A','ream','500 sheets',560.00,620.00,NULL,25,10,'/products/a4-paper-500-sheet.jpg',NULL,104,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('514140d0-5d0f-4ae6-85e9-a5e4d7b0ed14','Pran Mango Juice','প্রাণ ম্যাংগো জুস','SKU-2002',NULL,'22222222-2222-4222-8222-222222222222','Pran','pcs','250 ml',29.00,35.00,NULL,115,5,'/products/pran-mango-juice-250ml.jpg',NULL,16,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('545738ba-b0ea-4d62-be77-c99e5c9e2883','Cheese Slice 200g','চিজ স্লাইস ২০০ গ্রাম','SKU-5053','88015053','66666666-6666-4666-8666-666666666666','Kraft','pcs','200 g',375.00,420.00,NULL,25,10,'/products/cheese-slice-200g.jpg',NULL,65,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('555789ff-bd46-473d-9408-f00bbd2b4e93','Instant Coffee 100g','ইনস্ট্যান্ট কফি ১০০ গ্রাম','SKU-6021',NULL,'eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee','Nescafe','pcs','100 g',480.00,560.00,NULL,40,5,'/products/instant-coffee-100g.jpg',NULL,115,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('592e940d-0c63-4faa-8e31-d42be94c028b','Dog Food 1.5kg','কুকুরের খাবার ১.৫ কেজি','SKU-6042',NULL,'12121212-1212-4121-8121-121212121212','Pedigree','pcs','1.5 kg',800.00,950.00,NULL,20,5,'/products/dog-food-1500g.jpg',NULL,124,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('5c06d8e7-ef16-4dd3-98c6-8df0bcfe2033','Green Grapes 500g','সবুজ আঙুর ৫০০ গ্রাম','SKU-6003',NULL,'cccccccc-cccc-4ccc-8ccc-cccccccccccc','Imported','pcs','500 g',175.00,210.00,NULL,40,5,'/products/grapes-500g.jpg',NULL,109,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('5c8a975e-4769-4004-b208-abf1277c416b','Marie Biscuit 300g','মেরি বিস্কুট ৩০০ গ্রাম','SKU-5042','88015042','33333333-3333-4333-8333-333333333333','Olympic','pcs','300 g',72.00,85.00,NULL,100,10,'/products/marie-biscuit-300g.jpg',NULL,59,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('5f53d59b-47fa-442a-a755-71ef3d3862dc','Sweet Yogurt 500g','মিষ্টি দই ৫০০ গ্রাম','SKU-5051','88015051','66666666-6666-4666-8666-666666666666','Aarong','pcs','500 g',110.00,130.00,NULL,45,10,'/products/sweet-yogurt-500g.jpg',NULL,67,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('60941924-b3ff-489f-b8e8-b2f0e9290756','Cashew Nut 250g','কাজু বাদাম ২৫০ গ্রাম','SKU-5026','88015026','11111111-1111-4111-8111-111111111111','Imported','pcs','250 g',370.00,420.00,NULL,20,10,'/products/cashew-nut-250g.jpg',NULL,42,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('61e12309-55c2-4c58-9406-4f4ceeedb2ff','Baby Wipes 80pcs','বেবি ওয়াইপস ৮০ পিস','SKU-5079','88015079','88888888-8888-4888-8888-888888888888','Johnson','pcs','80 pcs',295.00,340.00,NULL,28,10,'/products/baby-wipes-80pcs.jpg',NULL,96,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('633e663b-5b8c-4f32-a77b-7c66b8d35657','Anchor Dal 1kg','অ্যাংকর ডাল ১ কেজি','SKU-5012','88015012','11111111-1111-4111-8111-111111111111','Local','kg','1 kg',75.00,88.00,NULL,66,10,'/products/anchor-dal-1kg.jpg',NULL,26,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('63b4a5e3-d33b-45bb-9ef7-920382a2ab77','Chicken Nugget 250g','চিকেন নাগেট ২৫০ গ্রাম','SKU-5071','88015071','99999999-9999-4999-8999-999999999999','CP','pcs','250 g',245.00,280.00,NULL,35,10,'/products/chicken-nugget-250g.jpg',NULL,88,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('6687050a-0132-41c8-8706-d6b005a7fd4c','Farm Egg 12pcs','ফার্মের ডিম ১২ পিস','SKU-5054','88015054','bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb','Local','dozen','12 pcs',132.00,145.00,NULL,100,10,'/products/farm-egg-12pcs.jpg',NULL,74,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('672fb795-9794-41a3-931f-c620fc1e78d4','Himsagar Mango 1kg','হিমসাগর আম ১ কেজি','SKU-6001',NULL,'cccccccc-cccc-4ccc-8ccc-cccccccccccc','Local','kg','1 kg',150.00,180.00,NULL,60,5,'/products/mango-1kg.jpg',NULL,107,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('6757d6e5-adfa-43d2-ab66-8a222a720035','Coriander Powder 200g','ধনিয়া গুঁড়া ২০০ গ্রাম','SKU-5017','88015017','11111111-1111-4111-8111-111111111111','Pran','pcs','200 g',60.00,72.00,NULL,90,10,'/products/coriander-powder-200g.jpg',NULL,34,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('6ab3cc0b-82f5-4398-b801-41ce85cd2d73','Broiler Chicken 1kg','ব্রয়লার মুরগি ১ কেজি','SKU-5068','88015068','55555555-5555-4555-8555-555555555555','Local','kg','1 kg',175.00,195.00,NULL,60,10,'/products/broiler-chicken-1kg.jpg',NULL,86,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('6c52b46d-bb86-40c2-9b59-b45c099449fd','Nescafe Classic 50g','নেসক্যাফে ক্লাসিক ৫০ গ্রাম','SKU-5031','88015031','22222222-2222-4222-8222-222222222222','Nestle','pcs','50 g',300.00,340.00,NULL,30,10,'/products/nescafe-classic-50g.jpg',NULL,45,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('6d9c9762-219f-4886-9e14-f14c4c6cda28','Banana 1 dozen','কলা ১ ডজন','SKU-5062','88015062','55555555-5555-4555-8555-555555555555','Local','dozen','12 pcs',100.00,120.00,NULL,59,10,'/products/banana.jpg',NULL,81,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('6d9fdf83-38b4-479b-86cd-05ee505e9387','Miniket Rice 5kg','মিনিকেট চাল ৫ কেজি','SKU-1001',NULL,'11111111-1111-4111-8111-111111111111','Teer','bag','5 kg',390.00,420.00,NULL,21,5,'/products/miniket-rice-5kg.jpg',NULL,12,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('71f948f9-f231-4e13-828e-28d6dab0a129','Potato 1kg','আলু ১ কেজি','SKU-5058','88015058','55555555-5555-4555-8555-555555555555','Local','kg','1 kg',28.00,35.00,NULL,300,10,'/products/potato.jpg',NULL,78,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('71ff2354-3d93-4da7-b48b-b042ee37f04c','Cat Food 1kg','বিড়ালের খাবার ১ কেজি','SKU-6041',NULL,'12121212-1212-4121-8121-121212121212','Whiskas','pcs','1 kg',650.00,780.00,NULL,25,5,'/products/cat-food-1kg.jpg',NULL,123,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('773c5be3-8cc5-4ad9-8524-b6dda39e9484','Sugar 1kg','চিনি ১ কেজি','SKU-1004',NULL,'11111111-1111-4111-8111-111111111111','Fresh','kg','1 kg',115.00,125.00,NULL,11,5,'/products/sugar-1kg.jpg',NULL,9,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('7862267d-77fb-4e96-9579-d8b4857d8840','Chili Powder 200g','মরিচ গুঁড়া ২০০ গ্রাম','SKU-5016','88015016','11111111-1111-4111-8111-111111111111','Radhuni','pcs','200 g',80.00,95.00,NULL,120,10,'/products/chili-powder-200g.jpg',NULL,35,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('78ac42e2-29c0-4f8b-96a0-8479a71ec959','Garam Masala 50g','গরম মসলা ৫০ গ্রাম','SKU-5019','88015019','11111111-1111-4111-8111-111111111111','Radhuni','pcs','50 g',54.00,65.00,NULL,100,10,'/products/garam-masala-50g.jpg',NULL,32,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('7deb47a4-1dc9-4102-b21a-f985972852d6','Mutton 1kg','খাসির মাংস ১ কেজি','SKU-6013',NULL,'dddddddd-dddd-4ddd-8ddd-dddddddddddd','Fresh','kg','1 kg',1000.00,1150.00,NULL,20,5,'/products/mutton-1kg.jpg',NULL,113,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('8251fc46-a58f-4fb2-b1fd-c150b3200fa1','Chocolate Bar','চকলেট বার','SKU-3003',NULL,'33333333-3333-4333-8333-333333333333','Cadbury','pcs','50 g',41.00,50.00,NULL,65,5,'/products/chocolate-bar.jpg',NULL,5,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('831ffa8d-9f77-418d-ac64-04257eef0bba','Tea Leaf 400g','চা পাতা ৪০০ গ্রাম','SKU-2004',NULL,'22222222-2222-4222-8222-222222222222','Ispahani','pkt','400 g',190.00,210.00,NULL,0,5,'/products/tea-leaf-400g.jpg',NULL,8,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('87985c89-0f62-4a0d-a2db-daddc1dc446d','Vitamin C Tablet 30pcs','ভিটামিন সি ট্যাবলেট ৩০ পিস','SKU-6033',NULL,'ffffffff-ffff-4fff-8fff-ffffffffffff','Square','pcs','30 pcs',265.00,320.00,NULL,40,5,'/products/vitamin-c-30pcs.jpg',NULL,121,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('87b578fc-cee0-41a4-957b-273a1464553b','Hand Sanitizer 250ml','হ্যান্ড স্যানিটাইজার ২৫০ মিলি','SKU-6031',NULL,'ffffffff-ffff-4fff-8fff-ffffffffffff','Savlon','pcs','250 ml',145.00,180.00,NULL,60,5,'/products/hand-sanitizer-250ml.jpg',NULL,119,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('8a57cbbb-c050-452a-bb66-d00afb381d10','Shezan Apple Juice 1L','শেজান আপেল জুস ১ লিটার','SKU-5039','88015039','22222222-2222-4222-8222-222222222222','Shezan','pcs','1 L',158.00,180.00,NULL,40,10,'/products/shezan-apple-juice-1l.jpg',NULL,54,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('8a7cf121-6004-44ec-9814-e6636a8f9dfb','Bath Soap','গোসলের সাবান','SKU-4002',NULL,'44444444-4444-4444-8444-444444444444','Lifebuoy','pcs','100 g',46.00,55.00,NULL,102,5,'/products/bath-soap.jpg',NULL,3,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('8b95df28-2e98-40e8-9bcd-a836b16fb525','Dishwash Liquid 500ml','ডিশওয়াশ লিকুইড ৫০০ মিলি','SKU-5081','88015081','44444444-4444-4444-8444-444444444444','Vim','pcs','500 ml',142.00,165.00,NULL,60,10,'/products/dishwash-liquid-500ml.jpg',NULL,100,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('8d5dc3eb-0d62-4924-b5ec-0a2f501f03a3','Tomato 1kg','টমেটো ১ কেজি','SKU-5060','88015060','55555555-5555-4555-8555-555555555555','Local','kg','1 kg',48.00,60.00,NULL,150,10,'/products/tomato.jpg',NULL,76,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('936c5288-7a08-45d0-b5fd-8e9a8a365de7','Coffee Sachet 20pcs','কফি স্যাশে ২০ পিস','SKU-6024',NULL,'eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee','Nescafe','pcs','20 pcs',200.00,240.00,NULL,50,5,'/products/coffee-sachet-20pcs.jpg',NULL,118,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('94ffbd55-e48a-4b59-9c5f-625a213d5c0c','Pasteurized Milk 1L','পাস্তুরিত দুধ ১ লিটার','SKU-5048','88015048','66666666-6666-4666-8666-666666666666','Aarong','pcs','1 L',92.00,105.00,NULL,60,10,'/products/pasteurized-milk-1l.jpg',NULL,70,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('95e89cd7-3fd5-44e2-bcfb-7505eeb1df9f','Miniket Rice 25kg','মিনিকেট চাল ২৫ কেজি','SKU-5002','88015002','11111111-1111-4111-8111-111111111111','ACI','bag','25 kg',1820.00,1950.00,NULL,34,10,'/products/miniket-rice-25kg.jpg',NULL,20,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('964a9077-87d5-4db0-9404-f5296891e0a5','Atta 2kg','আটা ২ কেজি','SKU-5020','88015020','11111111-1111-4111-8111-111111111111','Teer','pcs','2 kg',120.00,135.00,NULL,108,10,'/products/atta-2kg.jpg',NULL,40,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('96de1367-8ee6-4dd7-b40e-e478bf157e7a','Butter 200g','বাটার ২০০ গ্রাম','SKU-5052','88015052','66666666-6666-4666-8666-666666666666','Aarong','pcs','200 g',255.00,290.00,NULL,30,10,'/products/butter-200g.jpg',NULL,66,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('9c34cd57-fa1b-4126-bdee-506027c9261b','Baby Lotion 200ml','বেবি লোশন ২০০ মিলি','SKU-5080','88015080','88888888-8888-4888-8888-888888888888','Johnson','pcs','200 ml',345.00,395.00,NULL,23,10,'/products/baby-lotion-200ml.jpg',NULL,95,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('9d517bfd-ada3-4247-bc11-2381d7ea819c','Iodine Salt 1kg','আয়োডিন লবণ ১ কেজি','SKU-5014','88015014','11111111-1111-4111-8111-111111111111','ACI','pcs','1 kg',32.00,40.00,NULL,200,10,'/products/iodine-salt-1kg.jpg',NULL,30,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('9dd252a8-0cee-4e84-8066-d7081ea24200','Onion 1kg','পেঁয়াজ ১ কেজি','SKU-5059','88015059','55555555-5555-4555-8555-555555555555','Local','kg','1 kg',62.00,75.00,NULL,250,10,'/products/onion.jpg',NULL,77,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('9e77287c-bbb1-48d1-80d1-83a10133a6ac','Malta 1kg','মাল্টা ১ কেজি','SKU-5064','88015064','55555555-5555-4555-8555-555555555555','Imported','kg','1 kg',255.00,290.00,NULL,45,10,'/products/malta-1kg.jpg',NULL,79,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('a2dc0782-9e99-4d29-85e6-8d5b59a5b012','Shrimp 500g','চিংড়ি ৫০০ গ্রাম','SKU-5067','88015067','55555555-5555-4555-8555-555555555555','Local','kg','500 g',480.00,550.00,NULL,25,10,'/products/shrimp-500g.jpg',NULL,82,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('a9db22a7-474c-419a-942c-f43fa8815d8d','Beef 1kg','গরুর মাংস ১ কেজি','SKU-5069','88015069','55555555-5555-4555-8555-555555555555','Local','kg','1 kg',740.00,790.00,NULL,30,10,'/products/beef-1kg.jpg',NULL,85,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('aa78e067-8b35-43f7-b020-f0d73cec2133','Potato Crackers','পটেটো ক্র্যাকার্স','SKU-3001',NULL,'33333333-3333-4333-8333-333333333333','Bombay Sweets','pcs','100 g',15.00,20.00,NULL,127,5,'/products/potato-crackers.jpg',NULL,17,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('ad24f158-0653-46c2-964d-e22212499618','Pran Orange Juice 250ml','প্রাণ অরেঞ্জ জুস ২৫০ মিলি','SKU-5038','88015038','22222222-2222-4222-8222-222222222222','Pran','pcs','250 ml',24.00,30.00,NULL,180,10,'/products/pran-orange-juice-250ml.jpg',NULL,55,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('ae10a61f-9056-41a5-a474-6e000b973608','Taaza Tea 400g','তাজা চা ৪০০ গ্রাম','SKU-5029','88015029','22222222-2222-4222-8222-222222222222','Taaza','pcs','400 g',190.00,215.00,NULL,55,10,'/products/taaza-tea-400g.jpg',NULL,47,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('af3c93a6-6afb-43f6-946d-af60422889a7','Mustard Oil 500ml','সরিষার তেল ৫০০ মিলি','SKU-5007','88015007','11111111-1111-4111-8111-111111111111','Radhuni','pcs','500 ml',165.00,185.00,NULL,70,10,'/products/mustard-oil-500ml.jpg',NULL,23,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('af71cff7-3b16-43b5-9d3b-27d0a08b8270','Powder Milk 1kg','গুঁড়া দুধ ১ কেজি','SKU-5050','88015050','66666666-6666-4666-8666-666666666666','Danish','pcs','1 kg',720.00,790.00,NULL,35,10,'/products/powder-milk-1kg.jpg',NULL,68,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('b4aa9a6c-6fdf-43fd-b5ad-d894da180866','Hand Wash 200ml','হ্যান্ড ওয়াশ ২০০ মিলি','SKU-5075','88015075','77777777-7777-4777-8777-777777777777','Lifebuoy','pcs','200 ml',125.00,145.00,NULL,60,10,'/products/hand-wash-200ml.jpg',NULL,92,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('b86cffe6-15da-4812-ae14-e17f40e871c7','Instant Noodles','ইনস্ট্যান্ট নুডলস','SKU-3004',NULL,'33333333-3333-4333-8333-333333333333','Cocola','pkt','62 g',19.00,24.00,NULL,181,5,'/products/instant-noodles.jpg',NULL,1,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('ba632f29-d301-45c7-8596-3622ab2703c9','Honey 500g','মধু ৫০০ গ্রাম','SKU-5024','88015024','11111111-1111-4111-8111-111111111111','Dabur','pcs','500 g',450.00,520.00,NULL,30,10,'/products/honey.jpg',NULL,44,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('bd6b1968-e933-4ffe-8f97-171e3ba222ef','Shaving Razor 3pcs','শেভিং রেজর ৩ পিস','SKU-5077','88015077','77777777-7777-4777-8777-777777777777','Gillette','pcs','3 pcs',152.00,180.00,NULL,50,10,'/products/shaving-razor-3pcs.jpg',NULL,90,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('c00716f6-0e99-4246-a437-34bc39e454f1','Ispahani Mirzapore Tea 500g','ইস্পাহানি মির্জাপুর চা ৫০০ গ্রাম','SKU-5028','88015028','22222222-2222-4222-8222-222222222222','Ispahani','pcs','500 g',245.00,275.00,NULL,60,10,'/products/ispahani-mirzapore-tea-500g.jpg',NULL,48,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('c4fe49a9-1ff9-4ae0-88c5-8342c1c748e9','Fresh Soyabean Oil 2L','ফ্রেশ সয়াবিন তেল ২ লিটার','SKU-5006','88015006','11111111-1111-4111-8111-111111111111','Fresh','pcs','2 L',338.00,360.00,NULL,80,10,'/products/fresh-soyabean-oil-2l.jpg',NULL,24,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('c9c33d0d-1ac5-49c2-ba12-0c6fbd310a83','Coca-Cola 1.25L','কোকা-কোলা ১.২৫ লি','SKU-2001',NULL,'22222222-2222-4222-8222-222222222222','Coca-Cola','btl','1.25 L',84.00,95.00,NULL,29,5,'/products/coca-cola-125l.jpg',NULL,6,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('cc09be66-73e4-4e4f-a327-d0e10e4e3e3c','Baby Diaper M 30pcs','বেবি ডায়াপার এম ৩০ পিস','SKU-5078','88015078','88888888-8888-4888-8888-888888888888','Pampers','pcs','30 pcs',860.00,950.00,NULL,23,10,'/products/baby-diaper-m-30pcs.jpg',NULL,97,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('cd4885e5-3536-49a0-b18b-19febb59551a','Toilet Tissue 4 roll','টয়লেট টিস্যু ৪ রোল','SKU-5084','88015084','44444444-4444-4444-8444-444444444444','Bashundhara','pcs','4 rolls',155.00,180.00,NULL,70,10,'/products/toilet-tissue-4roll.jpg',NULL,103,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('ce9abe15-5af3-496a-94b9-9e4ea4b026cd','Soyabean Oil 1L','সয়াবিন তেল ১ লিটার','SKU-1002',NULL,'11111111-1111-4111-8111-111111111111','Rupchanda','btl','1 L',162.00,175.00,NULL,51,5,'/products/soyabean-oil-1l.jpg',NULL,11,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('d1f36709-1dc6-43ee-8275-6c4fb85643d9','Biscuit Energy Plus','এনার্জি প্লাস বিস্কুট','SKU-3002',NULL,'33333333-3333-4333-8333-333333333333','Olympic','pkt','200 g',24.00,30.00,NULL,78,5,'/products/biscuit-energy-plus.jpg',NULL,4,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('d2fdef65-0da4-4677-9f8c-ab1b65fd6ffd','Bun 6pcs','বান ৬ পিস','SKU-5057','88015057','bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb','Coopers','pcs','6 pcs',66.00,80.00,NULL,40,10,'/products/bun-6pcs.jpg',NULL,71,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('d609319e-dadf-4f58-94fb-c7fadabef925','Pet Shampoo 200ml','পেট শ্যাম্পু ২০০ মিলি','SKU-6044',NULL,'12121212-1212-4121-8121-121212121212','Beaphar','pcs','200 ml',340.00,420.00,NULL,28,5,'/products/pet-shampoo-200ml.jpg',NULL,126,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('d61ff31f-cf35-4c4a-ad95-7e38304a4dd1','Deshi Egg 12pcs','দেশি ডিম ১২ পিস','SKU-5055','88015055','bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb','Local','dozen','12 pcs',190.00,210.00,NULL,50,10,'/products/deshi-egg-12pcs.jpg',NULL,73,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('d8aa3362-9d16-4d1a-81e3-66072097457d','Turmeric Powder 200g','হলুদ গুঁড়া ২০০ গ্রাম','SKU-5015','88015015','11111111-1111-4111-8111-111111111111','Radhuni','pcs','200 g',65.00,78.00,NULL,120,10,'/products/turmeric-powder-200g.jpg',NULL,36,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('d94930c1-a00f-4e07-a80f-618e3e763c4c','Cat Litter 5kg','ক্যাট লিটার ৫ কেজি','SKU-6043',NULL,'12121212-1212-4121-8121-121212121212','Kit Cat','pcs','5 kg',740.00,890.00,NULL,18,5,'/products/cat-litter-5kg.jpg',NULL,125,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('da3868b9-94a5-4d85-8710-56d4a73b6d98','Besan 500g','বেসন ৫০০ গ্রাম','SKU-5023','88015023','11111111-1111-4111-8111-111111111111','Radhuni','pcs','500 g',78.00,90.00,NULL,75,10,'/products/besan-500g.jpg',NULL,37,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('da7cb8ca-9f0d-427b-be8e-3c2d06c2b04f','Sprite 1.25L','স্প্রাইট ১.২৫ লিটার','SKU-5033','88015033','22222222-2222-4222-8222-222222222222','Coca-Cola','pcs','1.25 L',84.00,95.00,NULL,80,10,'/products/sprite-125l.jpg',NULL,52,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('dd67c0da-72c0-4d3e-b53e-698b09ba8738','Washing Powder 1kg','ওয়াশিং পাউডার ১ কেজি','SKU-5083','88015083','44444444-4444-4444-8444-444444444444','Surf Excel','pcs','1 kg',200.00,230.00,NULL,55,10,'/products/washing-powder-1kg.jpg',NULL,98,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('e0d62154-cd8b-4c37-b0fd-81844e3afbb2','Toothpaste 100g','টুথপেস্ট ১০০ গ্রাম','SKU-4003',NULL,'44444444-4444-4444-8444-444444444444','Pepsodent','pcs','100 g',112.00,130.00,NULL,40,5,'/products/toothpaste-100g.jpg',NULL,7,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('e5057cc6-81f2-4d4b-8f04-bba7231c7004','Frozen Singara 12pcs','ফ্রোজেন সিঙ্গারা ১২ পিস','SKU-5072','88015072','99999999-9999-4999-8999-999999999999','Golden Harvest','pcs','12 pcs',180.00,210.00,NULL,30,10,'/products/frozen-singara-12pcs.jpg',NULL,87,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('e66a2dee-e2bf-4763-ae37-4957d75acd1c','Apple 1kg','আপেল ১ কেজি','SKU-5063','88015063','55555555-5555-4555-8555-555555555555','Imported','kg','1 kg',280.00,320.00,NULL,45,10,'/products/apple-1kg.jpg',NULL,80,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('e98427b3-1935-46f6-8ea7-e5ade9101f61','Raisin 200g','কিসমিস ২০০ গ্রাম','SKU-5027','88015027','11111111-1111-4111-8111-111111111111','Imported','pcs','200 g',152.00,180.00,NULL,35,10,'/products/raisin-200g.jpg',NULL,41,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('eaf7740f-b755-4ad1-889b-a41041c7d152','Potato Chips 100g','পটেটো চিপস ১০০ গ্রাম','SKU-5040','88015040','33333333-3333-4333-8333-333333333333','Bombay Sweets','pcs','100 g',45.00,55.00,NULL,140,10,'/products/potato-chips-100g.jpg',NULL,61,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('ec6a3838-d30b-4bc4-8492-ca368ffccac9','Milk Bread 500g','মিল্ক ব্রেড ৫০০ গ্রাম','SKU-5056','88015056','bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb','Well Food','pcs','500 g',58.00,70.00,NULL,60,10,'/products/milk-bread-500g.jpg',NULL,72,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('f5bcb4d2-a403-4c81-a85c-6b2235e603fd','Body Lotion 200ml','বডি লোশন ২০০ মিলি','SKU-5074','88015074','77777777-7777-4777-8777-777777777777','Vaseline','pcs','200 ml',280.00,320.00,NULL,35,10,'/products/body-lotion-200ml.jpg',NULL,93,1,'2026-10-05 09:46:26','2026-10-05 09:46:26'),('f5d8c26e-c719-415f-98bb-aabeffc65245','Spaghetti Pasta 400g','স্প্যাগেটি পাস্তা ৪০০ গ্রাম','SKU-5047','88015047','33333333-3333-4333-8333-333333333333','Pran','pcs','400 g',82.00,95.00,NULL,55,10,'/products/spaghetti-pasta-400g.jpg',NULL,62,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('f8b534f3-88fc-4080-a743-aa0f0927fa56','Suji 500g','সুজি ৫০০ গ্রাম','SKU-5022','88015022','11111111-1111-4111-8111-111111111111','Teer','pcs','500 g',46.00,55.00,NULL,85,10,'/products/suji-500g.jpg',NULL,38,1,'2026-10-05 09:46:25','2026-10-05 09:46:25'),('fbe2f010-f702-418e-a2cf-4558902d15cf','Sugar 5kg','চিনি ৫ কেজি','SKU-5013','88015013','11111111-1111-4111-8111-111111111111','Fresh','bag','5 kg',580.00,610.00,NULL,40,10,'/products/sugar-5kg.jpg',NULL,31,1,'2026-10-05 09:46:25','2026-10-05 09:46:25');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` varchar(36) NOT NULL,
  `full_name` varchar(120) DEFAULT NULL,
  `username` varchar(60) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES ('00000000-0000-0000-0000-000000000003','Super Admin','admin','01711111111','00000000-0000-0000-0000-000000000002','2026-10-05 09:46:25','2026-10-05 09:46:25');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions` (
  `id` varchar(36) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `banner_url` text DEFAULT NULL,
  `target_url` text DEFAULT NULL,
  `badge` varchar(60) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_items`
--

DROP TABLE IF EXISTS `purchase_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_items` (
  `id` varchar(36) NOT NULL,
  `purchase_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `quantity` decimal(10,3) NOT NULL,
  `purchase_price` decimal(12,2) NOT NULL,
  `line_total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_items`
--

LOCK TABLES `purchase_items` WRITE;
/*!40000 ALTER TABLE `purchase_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_items`
--

DROP TABLE IF EXISTS `purchase_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_items` (
  `id` varchar(36) NOT NULL,
  `purchase_order_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `quantity` decimal(10,3) NOT NULL,
  `estimated_price` decimal(12,2) DEFAULT NULL,
  `line_total` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_items`
--

LOCK TABLES `purchase_order_items` WRITE;
/*!40000 ALTER TABLE `purchase_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_orders`
--

DROP TABLE IF EXISTS `purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_orders` (
  `id` varchar(36) NOT NULL,
  `order_no` varchar(60) NOT NULL,
  `supplier_id` varchar(36) DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT 0.00,
  `status` varchar(30) NOT NULL DEFAULT 'pending',
  `expected_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_orders`
--

LOCK TABLES `purchase_orders` WRITE;
/*!40000 ALTER TABLE `purchase_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_return_items`
--

DROP TABLE IF EXISTS `purchase_return_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_return_items` (
  `id` varchar(36) NOT NULL,
  `purchase_return_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `quantity` decimal(10,3) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `line_total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_return_items`
--

LOCK TABLES `purchase_return_items` WRITE;
/*!40000 ALTER TABLE `purchase_return_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_return_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_returns`
--

DROP TABLE IF EXISTS `purchase_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_returns` (
  `id` varchar(36) NOT NULL,
  `return_no` varchar(60) NOT NULL,
  `purchase_id` varchar(36) DEFAULT NULL,
  `supplier_id` varchar(36) DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `total_refund` decimal(12,2) DEFAULT 0.00,
  `reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_returns`
--

LOCK TABLES `purchase_returns` WRITE;
/*!40000 ALTER TABLE `purchase_returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `id` varchar(36) NOT NULL,
  `purchase_no` varchar(60) DEFAULT NULL,
  `supplier_id` varchar(36) DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `paid` decimal(12,2) NOT NULL DEFAULT 0.00,
  `due` decimal(12,2) DEFAULT 0.00,
  `status` varchar(30) NOT NULL DEFAULT 'received',
  `purchase_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_items`
--

DROP TABLE IF EXISTS `sale_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_items` (
  `id` varchar(36) NOT NULL,
  `sale_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `quantity` decimal(10,3) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `cost_price` decimal(12,2) DEFAULT 0.00,
  `discount` decimal(12,2) DEFAULT 0.00,
  `line_total` decimal(12,2) NOT NULL,
  `name_snapshot` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_items`
--

LOCK TABLES `sale_items` WRITE;
/*!40000 ALTER TABLE `sale_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_return_items`
--

DROP TABLE IF EXISTS `sale_return_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_return_items` (
  `id` varchar(36) NOT NULL,
  `sale_return_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `quantity` decimal(10,3) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `line_total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_return_items`
--

LOCK TABLES `sale_return_items` WRITE;
/*!40000 ALTER TABLE `sale_return_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_return_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_returns`
--

DROP TABLE IF EXISTS `sale_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_returns` (
  `id` varchar(36) NOT NULL,
  `sale_id` varchar(36) NOT NULL,
  `return_no` varchar(60) DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `refund_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `reason` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_returns`
--

LOCK TABLES `sale_returns` WRITE;
/*!40000 ALTER TABLE `sale_returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales` (
  `id` varchar(36) NOT NULL,
  `invoice_no` bigint(20) DEFAULT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `customer_id` varchar(36) DEFAULT NULL,
  `customer_name` varchar(120) DEFAULT NULL,
  `customer_phone` varchar(30) DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(12,2) DEFAULT 0.00,
  `tax` decimal(12,2) DEFAULT 0.00,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `paid` decimal(12,2) NOT NULL DEFAULT 0.00,
  `due` decimal(12,2) DEFAULT 0.00,
  `payment_method` varchar(50) DEFAULT 'cash',
  `status` varchar(30) NOT NULL DEFAULT 'final',
  `notes` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_content`
--

DROP TABLE IF EXISTS `site_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_content` (
  `id` varchar(36) NOT NULL,
  `key` varchar(100) NOT NULL,
  `label` varchar(150) DEFAULT NULL,
  `value_bn` text DEFAULT NULL,
  `value_en` text DEFAULT NULL,
  `category` varchar(60) DEFAULT 'general',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_content_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_content`
--

LOCK TABLES `site_content` WRITE;
/*!40000 ALTER TABLE `site_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_adjustments`
--

DROP TABLE IF EXISTS `stock_adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_adjustments` (
  `id` varchar(36) NOT NULL,
  `adjustment_no` varchar(60) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `type` varchar(30) NOT NULL,
  `quantity` int(11) NOT NULL,
  `reason` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_adjustments`
--

LOCK TABLES `stock_adjustments` WRITE;
/*!40000 ALTER TABLE `stock_adjustments` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_adjustments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_count_items`
--

DROP TABLE IF EXISTS `stock_count_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_count_items` (
  `id` varchar(36) NOT NULL,
  `stock_count_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `system_stock` int(11) NOT NULL,
  `counted_stock` int(11) NOT NULL,
  `difference` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_count_items`
--

LOCK TABLES `stock_count_items` WRITE;
/*!40000 ALTER TABLE `stock_count_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_count_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_counts`
--

DROP TABLE IF EXISTS `stock_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_counts` (
  `id` varchar(36) NOT NULL,
  `count_no` varchar(60) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_counts`
--

LOCK TABLES `stock_counts` WRITE;
/*!40000 ALTER TABLE `stock_counts` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_transfer_items`
--

DROP TABLE IF EXISTS `stock_transfer_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_transfer_items` (
  `id` varchar(36) NOT NULL,
  `stock_transfer_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_transfer_items`
--

LOCK TABLES `stock_transfer_items` WRITE;
/*!40000 ALTER TABLE `stock_transfer_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_transfer_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_transfers`
--

DROP TABLE IF EXISTS `stock_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_transfers` (
  `id` varchar(36) NOT NULL,
  `transfer_no` varchar(60) NOT NULL,
  `from_branch_id` varchar(36) NOT NULL,
  `to_branch_id` varchar(36) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_transfers`
--

LOCK TABLES `stock_transfers` WRITE;
/*!40000 ALTER TABLE `stock_transfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_transfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` varchar(36) NOT NULL,
  `name` varchar(60) NOT NULL,
  `code` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES ('006d93c2-8c65-4ea5-8339-3a6a40e42bb2','Piece','pcs','2026-10-05 09:46:25'),('70816c08-861d-4bfa-ad1f-af5e2d15a86d','Kilogram','kg','2026-10-05 09:46:25'),('83f1a99c-2d4c-4ba2-a50d-8e63d027c15f','Liter','ltr','2026-10-05 09:46:25'),('e73bc29c-94c8-4e8a-a716-dde7f55aee58','Gram','g','2026-10-05 09:46:25');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_carts`
--

DROP TABLE IF EXISTS `user_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_carts` (
  `id` varchar(36) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`items`)),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_carts_customer_phone_unique` (`customer_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_carts`
--

LOCK TABLES `user_carts` WRITE;
/*!40000 ALTER TABLE `user_carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `role` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES ('9d3ed1f8-cad9-4253-8231-95eeb7594a08','00000000-0000-0000-0000-000000000003','super_admin','2026-10-05 09:46:25');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` varchar(36) NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `username` varchar(60) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `user_type` varchar(20) NOT NULL DEFAULT 'staff',
  `role` varchar(30) NOT NULL DEFAULT 'staff',
  `branch_id` varchar(36) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_phone_unique` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('00000000-0000-0000-0000-000000000003','Super Admin','admin','admin@bazarbari.local','01711111111','$2b$10$rXSvavod5RonqymFREweX.E2WPP0tRVUDgwM.ujLKkWoMdpEF4wEy','staff','super_admin','00000000-0000-0000-0000-000000000002',NULL,1,'2026-10-05 09:46:25','2026-10-05 09:46:25');
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

-- Dump completed on 2026-10-05 16:04:00
