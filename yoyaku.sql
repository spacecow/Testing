-- MySQL dump 10.11
--
-- Host: localhost    Database: yoyaku_development
-- ------------------------------------------------------
-- Server version	5.0.67-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `classrooms` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `description` text,
  `inactive` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `classrooms`
--

LOCK TABLES `classrooms` WRITE;
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
INSERT INTO `classrooms` VALUES (1,'1','','',0,'','2009-05-13 14:03:01','2009-05-13 14:03:01'),(2,'2','','',0,'','2009-05-13 14:03:34','2009-05-13 14:03:34'),(3,'3','','',0,'','2009-05-13 14:03:38','2009-05-13 14:03:38'),(4,'4','','',0,'','2009-05-15 12:17:08','2009-05-15 12:17:08');
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_times`
--

DROP TABLE IF EXISTS `course_times`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_times` (
  `id` int(11) NOT NULL auto_increment,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `text` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `course_times`
--

LOCK TABLES `course_times` WRITE;
/*!40000 ALTER TABLE `course_times` DISABLE KEYS */;
INSERT INTO `course_times` VALUES (1,'13:00:00','13:50:00','13:00 -- 13:50','2009-05-07 09:37:00','2009-05-07 09:37:00'),(2,'14:00:00','16:00:00','14:00 -- 16:00','2009-05-07 10:54:58','2009-05-07 10:54:58'),(3,'15:00:00','17:00:00','15:00 -- 17:00','2009-05-07 14:38:52','2009-05-07 14:38:52'),(4,'14:00:00','14:50:00','14:00 -- 14:50','2009-05-07 14:39:26','2009-05-07 14:39:26'),(5,'12:00:00','12:50:00','12:00 -- 12:50','2009-05-07 14:39:57','2009-05-07 14:39:57'),(6,'13:00:00','15:00:00','13:00 -- 15:00','2009-05-07 14:40:31','2009-05-07 14:40:31'),(7,'11:50:00','13:50:00','11:50 -- 13:50','2009-05-07 14:48:31','2009-05-07 14:48:31'),(8,'10:50:00','11:40:00','10:50 -- 11:40','2009-05-07 14:48:57','2009-05-07 14:48:57'),(9,'17:50:00','18:40:00','17:50 -- 18:40','2009-05-07 14:55:45','2009-05-07 14:55:45'),(11,'18:50:00','20:50:00','18:50 -- 20:50','2009-05-07 14:58:04','2009-05-07 14:58:04'),(12,'16:50:00','17:40:00','16:50 -- 17:40','2009-05-07 15:36:04','2009-05-07 15:36:04'),(13,'18:50:00','19:40:00','18:50 -- 19:40','2009-05-07 15:37:38','2009-05-07 15:37:38'),(14,'19:50:00','20:40:00','19:50 -- 20:40','2009-05-07 15:37:55','2009-05-19 02:59:22'),(15,'14:10:00','16:10:00','14:10 -- 16:10','2009-05-08 09:44:05','2009-05-08 09:44:05'),(16,'16:30:00','18:30:00','16:30 -- 18:30','2009-05-08 09:44:29','2009-05-08 09:44:29'),(17,'16:30:00','17:20:00','16:30 -- 17:20','2009-05-08 09:58:00','2009-05-08 09:58:00'),(18,'17:30:00','18:20:00','17:30 -- 18:20','2009-05-08 09:58:22','2009-05-08 09:58:22'),(20,'18:19:00','18:21:00','18:19 -- 18:21','2009-05-18 10:32:28','2009-05-18 10:32:28'),(21,'19:00:00','21:00:00','19:00 -- 21:00','2009-05-19 03:06:18','2009-05-19 03:06:18'),(22,'16:30:00','17:30:00','16:30 -- 17:30','2009-05-19 04:12:44','2009-05-19 04:12:44'),(23,'17:00:00','18:00:00','17:00 -- 18:00','2009-05-19 04:13:03','2009-05-19 04:13:03'),(24,'21:10:00','22:10:00','21:10 -- 22:10','2009-05-19 04:13:21','2009-05-19 04:13:21'),(25,'19:00:00','20:00:00','19:00 -- 20:00','2009-05-21 04:12:05','2009-05-21 04:12:05'),(26,'20:10:00','21:10:00','20:10 -- 21:10','2009-05-21 04:12:26','2009-05-21 04:12:26'),(27,'15:30:00','17:30:00','15:30 -- 17:30','2009-05-21 04:14:19','2009-05-21 04:14:19'),(28,'16:40:00','17:40:00','16:40 -- 17:40','2009-05-21 04:14:40','2009-05-21 04:14:40'),(29,'13:30:00','14:30:00','13:30 -- 14:30','2009-05-22 03:15:31','2009-05-22 03:15:31'),(30,'14:45:00','15:45:00','14:45 -- 15:45','2009-05-22 03:15:49','2009-05-22 03:15:49'),(31,'16:00:00','17:00:00','16:00 -- 17:00','2009-05-22 03:16:07','2009-05-22 03:16:07'),(32,'15:30:00','16:30:00','15:30 -- 16:30','2009-05-22 03:16:27','2009-05-22 03:16:27'),(33,'17:40:00','18:40:00','17:40 -- 18:40','2009-05-22 03:16:48','2009-05-22 03:16:48');
/*!40000 ALTER TABLE `course_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `inactive` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'入門 I','',0,'','2009-05-07 09:36:19','2009-05-14 11:20:01'),(2,'入門 II','',0,'','2009-05-07 10:54:18','2009-05-14 11:24:52'),(3,'初級 I','',0,'','2009-05-07 10:54:38','2009-05-14 11:25:04'),(4,'初級 II','',0,'','2009-05-07 14:30:33','2009-05-14 11:25:15'),(5,'中級 I','',0,'','2009-05-07 14:31:21','2009-05-14 11:25:25'),(6,'中級 II','',0,'','2009-05-14 11:15:28','2009-05-14 11:15:28'),(7,'中国語 中I','',0,'','2009-05-18 10:26:56','2009-05-18 10:26:56'),(8,'中国語 中II','',0,'','2009-05-19 03:05:50','2009-05-19 03:05:50'),(9,'個別','',0,'','2009-05-19 04:11:34','2009-05-19 04:11:34'),(10,'韓国語 中III','',0,'','2009-05-21 04:10:54','2009-05-21 04:10:54'),(11,'個別 英語','',0,'','2009-05-21 04:24:33','2009-05-21 04:24:33'),(12,'個別 韓国','',0,'','2009-05-21 04:26:41','2009-05-22 03:13:44'),(13,'中国語 中III (中)','',0,'','2009-05-22 03:12:08','2009-05-22 03:12:08'),(14,'個別 中国','',0,'','2009-05-22 03:13:23','2009-05-22 03:13:23');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `klasses`
--

DROP TABLE IF EXISTS `klasses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `klasses` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) default NULL,
  `teacher_id` int(11) default NULL,
  `classroom_id` int(11) default NULL,
  `capacity` int(11) default NULL,
  `date` datetime default NULL,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `cancel` tinyint(1) default NULL,
  `mail_sending` int(11) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `tostring` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `klasses`
--

LOCK TABLES `klasses` WRITE;
/*!40000 ALTER TABLE `klasses` DISABLE KEYS */;
INSERT INTO `klasses` VALUES (1,2,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','入門 II-17:50-18:40'),(2,1,2,1,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 08:01:03','入門 I-18:50-20:50'),(3,3,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','初級 I-18:50-20:50'),(4,4,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','初級 II-17:50-18:40'),(5,6,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','中級 II-17:50-18:40'),(6,5,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','中級 I-18:50-20:50'),(7,2,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','入門 II-17:50-18:40'),(8,1,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','入門 I-18:50-20:50'),(9,3,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','初級 I-18:50-20:50'),(10,4,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','初級 II-17:50-18:40'),(11,5,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','中級 I-18:50-20:50'),(12,6,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','中級 II-17:50-18:40'),(13,10,NULL,NULL,NULL,'2009-05-21 00:00:00','19:00:00','20:00:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','韓国語 中III-19:00-20:00'),(14,10,NULL,NULL,NULL,'2009-05-21 00:00:00','20:10:00','21:10:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','韓国語 中III-20:10-21:10'),(15,11,NULL,NULL,NULL,'2009-05-21 00:00:00','15:30:00','17:30:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','個別 英語-15:30-17:30'),(16,12,NULL,NULL,NULL,'2009-05-21 00:00:00','16:30:00','18:30:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','個別 韓語-16:30-18:30'),(17,11,NULL,NULL,NULL,'2009-05-21 00:00:00','16:40:00','17:40:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','個別 英語-16:40-17:40'),(18,2,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','入門 II-17:50-18:40'),(19,1,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','入門 I-18:50-20:50'),(20,3,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','初級 I-18:50-20:50'),(21,4,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','初級 II-17:50-18:40'),(22,6,NULL,NULL,NULL,'2009-05-22 00:00:00','16:50:00','17:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','中級 II-16:50-17:40'),(23,6,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','19:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','中級 II-18:50-19:40'),(24,6,NULL,NULL,NULL,'2009-05-22 00:00:00','19:50:00','20:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','中級 II-19:50-20:40'),(25,5,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 I-18:50-20:50'),(26,2,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','入門 II-17:50-18:40'),(27,1,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','入門 I-18:50-20:50'),(28,4,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','初級 II-17:50-18:40'),(29,3,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','初級 I-18:50-20:50'),(30,5,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 I-18:50-20:50'),(31,6,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','19:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 II-18:50-19:40'),(32,6,NULL,NULL,NULL,'2009-05-22 00:00:00','19:50:00','20:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 II-19:50-20:40'),(33,13,NULL,NULL,NULL,'2009-05-22 00:00:00','19:00:00','20:00:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中国語 中III (中)-19:00-20:00'),(34,13,NULL,NULL,NULL,'2009-05-22 00:00:00','20:10:00','21:10:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中国語 中III (中)-20:10-21:10'),(35,11,NULL,NULL,NULL,'2009-05-22 00:00:00','13:30:00','14:30:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-13:30-14:30'),(36,11,5,NULL,NULL,'2009-05-22 00:00:00','14:45:00','15:45:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-14:45-15:45'),(37,11,5,NULL,NULL,'2009-05-22 00:00:00','16:00:00','17:00:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-16:00-17:00'),(38,11,NULL,NULL,NULL,'2009-05-22 00:00:00','15:30:00','16:30:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-15:30-16:30'),(39,11,NULL,NULL,NULL,'2009-05-22 00:00:00','16:40:00','17:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-16:40-17:40'),(40,14,NULL,NULL,NULL,'2009-05-22 00:00:00','17:40:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 中国-17:40-18:40'),(41,11,NULL,NULL,NULL,'2009-05-22 00:00:00','17:40:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-17:40-18:40'),(42,1,NULL,NULL,NULL,'2009-05-23 00:00:00','11:50:00','13:50:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 I-11:50-13:50'),(43,2,NULL,NULL,NULL,'2009-05-23 00:00:00','10:50:00','11:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 II-10:50-11:40'),(44,3,NULL,NULL,NULL,'2009-05-23 00:00:00','11:50:00','13:50:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','初級 I-11:50-13:50'),(45,4,NULL,NULL,NULL,'2009-05-23 00:00:00','10:50:00','11:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','初級 II-10:50-11:40'),(46,2,NULL,NULL,NULL,'2009-05-23 00:00:00','16:50:00','17:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 II-16:50-17:40'),(47,2,NULL,NULL,NULL,'2009-05-23 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 II-17:50-18:40'),(48,1,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 I-18:50-20:50'),(49,4,NULL,NULL,NULL,'2009-05-23 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 II-17:50-18:40'),(50,4,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','19:40:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 II-18:50-19:40'),(51,4,NULL,NULL,NULL,'2009-05-23 00:00:00','19:50:00','20:40:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 II-19:50-20:40'),(52,3,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 I-18:50-20:50'),(53,3,NULL,NULL,NULL,'2009-05-23 00:00:00','14:10:00','16:10:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 I-14:10-16:10'),(54,3,NULL,NULL,NULL,'2009-05-23 00:00:00','16:30:00','18:30:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 I-16:30-18:30'),(55,5,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','中級 I-18:50-20:50'),(56,6,NULL,NULL,NULL,'2009-05-23 00:00:00','16:30:00','17:20:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','中級 II-16:30-17:20'),(57,6,NULL,NULL,NULL,'2009-05-23 00:00:00','17:30:00','18:20:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','中級 II-17:30-18:20');
/*!40000 ALTER TABLE `klasses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `people` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `family_name` varchar(255) default NULL,
  `first_name` varchar(255) default NULL,
  `family_name_kana` varchar(255) default NULL,
  `first_name_kana` varchar(255) default NULL,
  `gender` tinyint(4) default NULL,
  `address1` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `home_phone` varchar(10) default NULL,
  `mobile_phone` varchar(11) default NULL,
  `mail_address_mobile` varchar(255) default NULL,
  `mail_address_pc` varchar(255) default NULL,
  `ritei` tinyint(1) default NULL,
  `last_login` datetime default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `inactive` tinyint(1) default NULL,
  `status` smallint(6) default NULL,
  `tostring` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (4,'koizumi_junichirou','','小泉','純一郎','コイズミ','ジュンイチロウ',1,'','','','','prime_minister@ezweb.ne.jp','',0,NULL,'','2009-05-11 09:26:59','2009-05-18 10:14:05',NULL,NULL,'小泉 純一郎'),(11,'johan_sveholm','','Sveholm','Johan','スベホルム','ヨハン',1,'','','','08052206600','jsveholm@gmail.com','',0,NULL,'','2009-05-12 11:14:22','2009-05-13 14:35:30',0,1,'Sveholm Johan'),(12,'thomas_osburg','','Osburg','Thomas','オスブルグ','トーマス',1,'','','','','thomas_osburg@softbank.ne.jp','',0,NULL,'','2009-05-13 14:42:33','2009-05-13 16:11:21',0,1,'Osburg Thomas'),(20,'suzuki_ichirou','','鈴木','一郎','スズキ','イチロウ',1,'','','','','ichirou@docomo.ne.jp','',0,NULL,'','2009-05-20 08:58:08','2009-05-20 08:58:08',0,2,'鈴木 一郎'),(23,'komatsu_aya','','小松','あや','コマツ','アヤ',2,'','','','','aya@docomo.ne.jp','',0,NULL,'','2009-05-20 09:08:53','2009-05-20 09:08:53',0,1,'小松 あや'),(24,'koda_kumiko','','神田','來未子','コダ','クミコ',2,'','','','','cold_beauty@docomo.ne.jp','',0,NULL,'','2009-05-20 09:12:54','2009-05-20 09:12:54',0,2,'神田 來未子'),(25,'akira_kurosawa','','黒澤','明','クロサワ','アキラ',1,'','','','','akira@docomo.ne.jp','',0,NULL,'','2009-05-22 03:39:57','2009-05-22 03:39:57',0,2,'黒澤 明'),(26,'asada_mao','','浅田','真央','アサダ','マオ',2,'','','','','mao@ezweb.ne.jp','',0,NULL,'','2009-05-22 03:41:19','2009-05-22 03:41:19',0,2,'浅田 真央'),(27,'アリ','','some','あり','ソム','アリ',1,'','','','','ali@softbank.ne.jp','',0,NULL,'','2009-05-22 06:40:20','2009-05-22 06:40:20',0,1,'some あり');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090506050154'),('20090506053152'),('20090506063956'),('20090506124432'),('20090509102806'),('20090510152348'),('20090511143923'),('20090512095933'),('20090512104601'),('20090512114908'),('20090513140420'),('20090515130716'),('20090519031737'),('20090520064434'),('20090521043834'),('20090521052406');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'86c818430abe6504a68fbd888578afef','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-09 11:43:15','2009-05-09 14:36:02'),(2,'e6ab5932a840b1ffa5cf79dd0000d421','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-11 08:17:30','2009-05-11 10:20:48'),(3,'e62ca998d64865f8a6fea1a99373cfb9','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-12 09:52:33','2009-05-12 11:53:42'),(4,'bf5e574ae9aa44b10c4d81ae0e8083c4','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-12 09:52:44','2009-05-12 09:52:44'),(5,'739d6f547cccd935bcef83fdbe7bc540','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7BjoLbm90aWNlIiRLbGFzcyB3\nYXMgc3VjY2Vzc2Z1bGx5IGNyZWF0ZWQuBjoKQHVzZWR7BjsIVA==\n','2009-05-13 13:11:49','2009-05-13 16:35:16'),(6,'fe625215396f4fd80228bd427f82aa1c','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-14 10:01:44','2009-05-14 10:01:44'),(7,'dcc234fbab7a87674fa854f6d50824ab','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-14 10:01:51','2009-05-14 15:32:01'),(8,'8b52358e75a8fa88c18e9ec154628497','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-15 09:55:37','2009-05-15 12:01:52'),(9,'f67be3ef3234f19dcd8a890ac2425eb7','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-15 12:09:25','2009-05-15 12:09:25'),(10,'b5b6a8908578bda49393bd0e9fdadd7f','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-15 12:09:42','2009-05-15 13:31:38'),(11,'90ad685a6c0d09d3191f7fab82bfd739','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-15 13:37:24','2009-05-15 14:55:40'),(12,'ff1110db5f925ae8889437b64f160cbd','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7BjoLbm90aWNlIiNDb2NrIHdh\ncyBzdWNjZXNzZnVsbHkgY3JlYXRlZC4GOgpAdXNlZHsGOwhU\n','2009-05-18 10:06:03','2009-05-18 08:17:09'),(13,'56e9d7a8eaf6d6ca4d18d7bf261159f7','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-18 08:18:46','2009-05-18 08:41:43'),(14,'136cb0be0c627c3e6236256cea41cfc3','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-19 02:52:34','2009-05-19 04:23:35'),(15,'ed27375537fc175c78fe7fd412c60739','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-19 09:59:23','2009-05-19 09:59:23'),(16,'d5369a1cc0e8a0ea29a086d8963a4c03','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-19 09:59:24','2009-05-19 11:11:43'),(17,'e022c418e05b93ee1dd12b1b5815a394','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-20 02:46:44','2009-05-20 09:12:58'),(18,'7ffc86c77aebc3ac8dafdcd4acdf17d6','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-21 04:00:10','2009-05-21 08:13:53'),(19,'eef137bea9159f6e3e765c3ecb849046','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-22 03:08:47','2009-05-22 08:22:23');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_classes`
--

DROP TABLE IF EXISTS `student_classes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `student_classes` (
  `id` int(11) NOT NULL auto_increment,
  `student_id` int(11) default NULL,
  `klass_id` int(11) default NULL,
  `cancel` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `student_classes`
--

LOCK TABLES `student_classes` WRITE;
/*!40000 ALTER TABLE `student_classes` DISABLE KEYS */;
INSERT INTO `student_classes` VALUES (2,8,2,0,'','2009-05-21 06:53:57','2009-05-21 08:10:53'),(3,8,2,0,'','2009-05-21 06:54:09','2009-05-21 06:54:20'),(5,9,28,NULL,NULL,'2009-05-22 03:26:55','2009-05-22 08:23:31');
/*!40000 ALTER TABLE `student_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courses`
--

DROP TABLE IF EXISTS `student_courses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `student_courses` (
  `id` int(11) NOT NULL auto_increment,
  `student_id` int(11) default NULL,
  `course_id` int(11) default NULL,
  `cancel` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `student_courses`
--

LOCK TABLES `student_courses` WRITE;
/*!40000 ALTER TABLE `student_courses` DISABLE KEYS */;
INSERT INTO `student_courses` VALUES (1,NULL,NULL,0,'','2009-05-21 05:15:48','2009-05-21 05:15:48');
/*!40000 ALTER TABLE `student_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `students` (
  `id` int(11) NOT NULL auto_increment,
  `person_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (6,20,'2009-05-20 08:58:08','2009-05-20 08:58:08'),(8,24,'2009-05-20 09:12:54','2009-05-20 09:12:54'),(9,25,'2009-05-22 03:39:57','2009-05-22 03:39:57'),(10,26,'2009-05-22 03:41:19','2009-05-22 03:41:19');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `teachers` (
  `id` int(11) NOT NULL auto_increment,
  `person_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (2,11,'2009-05-12 11:14:23','2009-05-12 11:14:23'),(3,12,'2009-05-13 14:42:33','2009-05-13 14:42:33'),(5,23,'2009-05-20 09:08:53','2009-05-20 09:08:53'),(6,27,'2009-05-22 06:40:20','2009-05-22 06:40:20');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_classes`
--

DROP TABLE IF EXISTS `template_classes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `template_classes` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) default NULL,
  `course_time_id` int(11) default NULL,
  `day` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `inactive` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `teacher_id` int(11) default NULL,
  `classroom_id` int(11) default NULL,
  `capacity` int(11) default NULL,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `mail_sending` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `template_classes`
--

LOCK TABLES `template_classes` WRITE;
/*!40000 ALTER TABLE `template_classes` DISABLE KEYS */;
INSERT INTO `template_classes` VALUES (9,3,2,'Monday','','',0,'','2009-05-07 12:50:35','2009-05-07 12:50:35',NULL,NULL,NULL,NULL,NULL,NULL),(11,1,2,'Monday','','',0,'','2009-05-07 14:28:51','2009-05-07 14:28:51',NULL,NULL,NULL,NULL,NULL,NULL),(12,2,1,'Monday','','',0,'','2009-05-07 14:30:02','2009-05-07 14:30:02',NULL,NULL,NULL,NULL,NULL,NULL),(13,4,1,'Monday','','',0,'','2009-05-07 14:32:49','2009-05-07 14:32:49',NULL,NULL,NULL,NULL,NULL,NULL),(14,1,3,'Tuesday','','',0,'','2009-05-07 14:41:27','2009-05-07 14:41:27',NULL,NULL,NULL,NULL,NULL,NULL),(15,2,4,'Tuesday','','',0,'','2009-05-07 14:43:57','2009-05-07 14:43:57',NULL,NULL,NULL,NULL,NULL,NULL),(16,3,3,'Tuesday','','',0,'','2009-05-07 14:44:24','2009-05-19 03:14:48',2,NULL,NULL,'15:00:00','17:00:00',NULL),(17,4,4,'Tuesday','','',0,'','2009-05-07 14:44:39','2009-05-07 14:44:39',NULL,NULL,NULL,NULL,NULL,NULL),(18,1,6,'Wednesday','','',0,'','2009-05-07 14:45:19','2009-05-07 14:45:19',NULL,NULL,NULL,NULL,NULL,NULL),(19,2,5,'Wednesday','','',0,'','2009-05-07 14:45:56','2009-05-07 14:45:56',NULL,NULL,NULL,NULL,NULL,NULL),(20,3,6,'Wednesday','','',0,'','2009-05-07 14:46:15','2009-05-07 14:46:15',NULL,NULL,NULL,NULL,NULL,NULL),(21,4,5,'Wednesday','','',0,'','2009-05-07 14:47:36','2009-05-07 14:47:37',NULL,NULL,NULL,NULL,NULL,NULL),(24,1,7,'Saturday','','',0,'','2009-05-07 14:50:50','2009-05-07 14:50:50',NULL,NULL,NULL,NULL,NULL,NULL),(25,2,8,'Saturday','','',0,'','2009-05-07 14:51:06','2009-05-07 14:51:06',NULL,NULL,NULL,NULL,NULL,NULL),(26,3,7,'Saturday','','',0,'','2009-05-07 14:51:17','2009-05-07 14:51:17',NULL,NULL,NULL,NULL,NULL,NULL),(27,4,8,'Saturday','','',0,'','2009-05-07 14:51:26','2009-05-07 14:51:26',NULL,NULL,NULL,NULL,NULL,NULL),(28,2,9,'Monday','','',0,'','2009-05-07 14:58:33','2009-05-07 14:58:34',NULL,NULL,NULL,NULL,NULL,NULL),(29,1,11,'Monday','','',0,'','2009-05-07 14:59:43','2009-05-07 14:59:43',NULL,NULL,NULL,NULL,NULL,NULL),(30,4,9,'Monday','','',0,'','2009-05-07 15:00:05','2009-05-07 15:00:06',NULL,NULL,NULL,NULL,NULL,NULL),(31,3,11,'Monday','','',0,'','2009-05-07 15:00:13','2009-05-07 15:00:13',NULL,NULL,NULL,NULL,NULL,NULL),(32,2,9,'Tuesday','','',0,'','2009-05-07 15:00:44','2009-05-07 15:00:44',NULL,NULL,NULL,NULL,NULL,NULL),(33,1,11,'Tuesday','','',0,'','2009-05-07 15:01:02','2009-05-07 15:01:02',NULL,NULL,NULL,NULL,NULL,NULL),(34,3,11,'Tuesday','','',0,'','2009-05-07 15:01:10','2009-05-07 15:01:11',NULL,NULL,NULL,NULL,NULL,NULL),(35,4,9,'Tuesday','','',0,'','2009-05-07 15:01:17','2009-05-07 15:01:17',NULL,NULL,NULL,NULL,NULL,NULL),(36,2,9,'Thursday','','',0,'','2009-05-07 15:01:35','2009-05-07 15:01:35',NULL,NULL,NULL,NULL,NULL,NULL),(37,1,11,'Thursday','','',0,'','2009-05-07 15:01:45','2009-05-07 15:01:45',NULL,NULL,NULL,NULL,NULL,NULL),(38,3,11,'Thursday','','',0,'','2009-05-07 15:01:54','2009-05-07 15:01:54',NULL,NULL,NULL,NULL,NULL,NULL),(39,4,9,'Thursday','','',0,'','2009-05-07 15:02:01','2009-05-07 15:02:01',NULL,NULL,NULL,NULL,NULL,NULL),(40,2,9,'Friday','','',0,'','2009-05-07 15:02:26','2009-05-07 15:02:26',NULL,NULL,NULL,NULL,NULL,NULL),(41,1,11,'Friday','','',0,'','2009-05-07 15:02:46','2009-05-07 15:02:46',NULL,NULL,NULL,NULL,NULL,NULL),(42,3,11,'Friday','','',0,'','2009-05-07 15:02:53','2009-05-07 15:02:53',NULL,NULL,NULL,NULL,NULL,NULL),(43,4,9,'Friday','','',0,'','2009-05-07 15:02:59','2009-05-07 15:02:59',NULL,NULL,NULL,NULL,NULL,NULL),(44,6,12,'Monday','','',0,'','2009-05-07 15:36:28','2009-05-07 15:36:28',NULL,NULL,NULL,NULL,NULL,NULL),(45,6,12,'Friday','','',0,'','2009-05-07 15:37:13','2009-05-07 15:37:13',NULL,NULL,NULL,NULL,NULL,NULL),(46,6,13,'Friday','','',0,'','2009-05-07 15:38:21','2009-05-07 15:38:21',NULL,NULL,NULL,NULL,NULL,NULL),(47,6,14,'Friday','','',0,'','2009-05-07 15:38:48','2009-05-07 15:38:48',NULL,NULL,NULL,NULL,NULL,NULL),(48,5,11,'Friday','','',0,'','2009-05-07 15:40:08','2009-05-07 15:40:08',NULL,NULL,NULL,NULL,NULL,NULL),(49,6,9,'Monday','','',0,'','2009-05-07 15:40:53','2009-05-07 15:40:54',NULL,NULL,NULL,NULL,NULL,NULL),(50,5,11,'Monday','','',0,'','2009-05-07 15:41:00','2009-05-07 15:41:00',NULL,NULL,NULL,NULL,NULL,NULL),(51,6,9,'Tuesday','','',0,'','2009-05-07 15:41:11','2009-05-07 15:41:11',NULL,NULL,NULL,NULL,NULL,NULL),(52,5,11,'Tuesday','','',0,'','2009-05-07 15:41:17','2009-05-07 15:41:17',NULL,NULL,NULL,NULL,NULL,NULL),(53,6,9,'Thursday','','',0,'','2009-05-07 15:41:31','2009-05-07 15:41:31',NULL,NULL,NULL,NULL,NULL,NULL),(54,5,11,'Thursday','','',0,'','2009-05-07 15:41:37','2009-05-07 15:41:38',NULL,NULL,NULL,NULL,NULL,NULL),(55,2,13,'Wednesday','','',0,'','2009-05-07 15:42:17','2009-05-07 15:42:18',NULL,NULL,NULL,NULL,NULL,NULL),(56,4,13,'Wednesday','','',0,'','2009-05-07 15:42:30','2009-05-07 15:42:30',NULL,NULL,NULL,NULL,NULL,NULL),(57,2,14,'Wednesday','','',0,'','2009-05-07 15:42:49','2009-05-07 15:42:49',NULL,NULL,NULL,NULL,NULL,NULL),(58,4,14,'Wednesday','','',0,'','2009-05-07 15:42:56','2009-05-07 15:42:57',NULL,NULL,NULL,NULL,NULL,NULL),(59,6,9,'Wednesday','','',0,'','2009-05-07 15:43:57','2009-05-07 15:43:58',NULL,NULL,NULL,NULL,NULL,NULL),(60,2,12,'Saturday','','',0,'','2009-05-08 09:40:59','2009-05-08 09:40:59',NULL,NULL,NULL,NULL,NULL,NULL),(61,2,9,'Saturday','','',0,'','2009-05-08 09:41:17','2009-05-08 09:41:17',NULL,NULL,NULL,NULL,NULL,NULL),(62,1,11,'Saturday','','',0,'','2009-05-08 09:41:39','2009-05-08 09:41:39',NULL,NULL,NULL,NULL,NULL,NULL),(63,4,9,'Saturday','','',0,'','2009-05-08 09:41:53','2009-05-08 09:41:53',NULL,NULL,NULL,NULL,NULL,NULL),(64,4,13,'Saturday','','',0,'','2009-05-08 09:42:18','2009-05-08 09:42:18',NULL,NULL,NULL,NULL,NULL,NULL),(65,4,14,'Saturday','','',0,'','2009-05-08 09:42:57','2009-05-08 09:42:57',NULL,NULL,NULL,NULL,NULL,NULL),(66,3,11,'Saturday','','',0,'','2009-05-08 09:43:25','2009-05-08 09:43:25',NULL,NULL,NULL,NULL,NULL,NULL),(67,3,15,'Saturday','','',0,'','2009-05-08 09:44:53','2009-05-08 09:44:54',NULL,NULL,NULL,NULL,NULL,NULL),(68,3,16,'Saturday','','',0,'','2009-05-08 09:45:33','2009-05-08 09:45:33',NULL,NULL,NULL,NULL,NULL,NULL),(69,5,11,'Saturday','','',0,'','2009-05-08 09:56:08','2009-05-08 09:56:08',NULL,NULL,NULL,NULL,NULL,NULL),(70,6,17,'Saturday','','',0,'','2009-05-08 09:58:46','2009-05-08 09:58:47',NULL,NULL,NULL,NULL,NULL,NULL),(71,6,18,'Saturday','','',0,'','2009-05-08 09:59:33','2009-05-08 09:59:33',NULL,NULL,NULL,NULL,NULL,NULL),(72,8,21,'Tuesday','','',0,'','2009-05-19 03:06:50','2009-05-19 03:06:50',NULL,NULL,NULL,'19:00:00','21:00:00',NULL),(73,3,3,'Tuesday','','',0,'','2009-05-19 03:11:33','2009-05-19 03:15:01',3,NULL,NULL,'15:00:00','17:00:00',NULL),(75,4,4,'Tuesday','','',0,'','2009-05-19 03:15:25','2009-05-19 03:15:25',NULL,NULL,NULL,'14:00:00','14:50:00',NULL),(76,1,6,'Wednesday','','',0,'','2009-05-19 04:03:02','2009-05-19 04:03:02',NULL,NULL,NULL,'13:00:00','15:00:00',NULL),(77,2,5,'Wednesday','','',0,'','2009-05-19 04:03:18','2009-05-19 04:03:18',NULL,NULL,NULL,'12:00:00','12:50:00',NULL),(78,3,6,'Wednesday','','',0,'','2009-05-19 04:03:29','2009-05-19 04:03:29',NULL,NULL,NULL,'13:00:00','15:00:00',NULL),(79,4,5,'Wednesday','','',0,'','2009-05-19 04:03:42','2009-05-19 04:03:42',NULL,NULL,NULL,'12:00:00','12:50:00',NULL),(80,2,13,'Wednesday','','',0,'','2009-05-19 04:03:56','2009-05-19 04:03:56',NULL,NULL,NULL,'18:50:00','19:40:00',NULL),(81,2,14,'Wednesday','','',0,'','2009-05-19 04:04:09','2009-05-19 04:04:09',NULL,NULL,NULL,'19:50:00','20:40:00',NULL),(82,4,13,'Wednesday','','',0,'','2009-05-19 04:04:22','2009-05-19 04:04:22',NULL,NULL,NULL,'18:50:00','19:40:00',NULL),(83,4,14,'Wednesday','','',0,'','2009-05-19 04:04:31','2009-05-19 04:04:31',NULL,NULL,NULL,'19:50:00','20:40:00',NULL),(84,6,9,'Wednesday','','',0,'','2009-05-19 04:04:46','2009-05-19 04:04:46',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(85,7,21,'Wednesday','','',0,'','2009-05-19 04:09:15','2009-05-19 04:09:15',NULL,NULL,NULL,'19:00:00','21:00:00',NULL),(86,7,21,'Wednesday','','',0,'','2009-05-19 04:09:33','2009-05-19 04:09:33',NULL,NULL,NULL,'19:00:00','21:00:00',NULL),(87,9,22,'Wednesday','','',0,'','2009-05-19 04:15:40','2009-05-19 04:20:27',4,NULL,NULL,'16:30:00','17:30:00',NULL),(88,2,9,'Thursday','','',0,'','2009-05-21 04:02:26','2009-05-21 04:02:26',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(89,1,11,'Thursday','','',0,'','2009-05-21 04:02:39','2009-05-21 04:02:39',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(90,3,11,'Thursday','','',0,'','2009-05-21 04:03:06','2009-05-21 04:03:06',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(91,4,9,'Thursday','','',0,'','2009-05-21 04:03:20','2009-05-21 04:03:20',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(92,5,11,'Thursday','','',0,'','2009-05-21 04:03:30','2009-05-21 04:03:30',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(93,6,9,'Thursday','','',0,'','2009-05-21 04:03:40','2009-05-21 04:03:40',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(94,10,25,'Thursday','','',0,'','2009-05-21 04:13:04','2009-05-21 04:13:04',NULL,NULL,NULL,'19:00:00','20:00:00',NULL),(95,10,26,'Thursday','','',0,'','2009-05-21 04:13:27','2009-05-21 04:13:27',NULL,NULL,NULL,'20:10:00','21:10:00',NULL),(96,11,27,'Thursday','','',0,'','2009-05-21 04:15:16','2009-05-21 04:25:05',NULL,NULL,NULL,'15:30:00','17:30:00',NULL),(97,12,16,'Thursday','','',0,'','2009-05-21 04:22:30','2009-05-21 04:27:03',NULL,NULL,NULL,'16:30:00','18:30:00',NULL),(98,11,28,'Thursday','','',0,'','2009-05-21 04:22:56','2009-05-21 04:26:00',NULL,NULL,NULL,'16:40:00','17:40:00',NULL),(99,2,9,'Friday','','',0,'','2009-05-22 03:09:36','2009-05-22 03:09:36',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(100,1,11,'Friday','','',0,'','2009-05-22 03:09:47','2009-05-22 03:09:47',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(101,4,9,'Friday','','',0,'','2009-05-22 03:10:02','2009-05-22 03:10:02',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(102,3,11,'Friday','','',0,'','2009-05-22 03:10:17','2009-05-22 03:10:17',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(103,5,11,'Friday','','',0,'','2009-05-22 03:10:38','2009-05-22 03:10:38',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(104,6,13,'Friday','','',0,'','2009-05-22 03:10:51','2009-05-22 03:10:51',NULL,NULL,NULL,'18:50:00','19:40:00',NULL),(105,6,14,'Friday','','',0,'','2009-05-22 03:11:03','2009-05-22 03:11:03',NULL,NULL,NULL,'19:50:00','20:40:00',NULL),(106,13,25,'Friday','','',0,'','2009-05-22 03:14:22','2009-05-22 03:14:22',NULL,NULL,NULL,'19:00:00','20:00:00',NULL),(107,13,26,'Friday','','',0,'','2009-05-22 03:14:44','2009-05-22 03:14:44',NULL,NULL,NULL,'20:10:00','21:10:00',NULL),(108,11,29,'Friday','','',0,'','2009-05-22 03:17:19','2009-05-22 03:17:19',NULL,NULL,NULL,'13:30:00','14:30:00',NULL),(109,11,30,'Friday','','',0,'','2009-05-22 03:17:39','2009-05-22 03:17:39',5,NULL,NULL,'14:45:00','15:45:00',NULL),(110,11,31,'Friday','','',0,'','2009-05-22 03:18:02','2009-05-22 03:18:02',5,NULL,NULL,'16:00:00','17:00:00',NULL),(111,11,32,'Friday','','',0,'','2009-05-22 03:18:29','2009-05-22 03:18:29',NULL,NULL,NULL,'15:30:00','16:30:00',NULL),(112,11,28,'Friday','','',0,'','2009-05-22 03:18:48','2009-05-22 03:18:48',NULL,NULL,NULL,'16:40:00','17:40:00',NULL),(113,14,33,'Friday','','',0,'','2009-05-22 03:19:22','2009-05-22 03:19:22',NULL,NULL,NULL,'17:40:00','18:40:00',NULL),(114,11,33,'Friday','','',0,'','2009-05-22 03:19:46','2009-05-22 03:19:46',NULL,NULL,NULL,'17:40:00','18:40:00',NULL);
/*!40000 ALTER TABLE `template_classes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-05-22 12:05:52
