CREATE DATABASE  IF NOT EXISTS `gamestore` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gamestore`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 192.168.99.100    Database: gamestore
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Table structure for table `OrderItem`
--

DROP TABLE IF EXISTS `OrderItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderItem` (
  `OrderItemId` int(11) NOT NULL AUTO_INCREMENT,
  `OrderId` int(11) DEFAULT NULL,
  `ProductId` varchar(50) DEFAULT NULL,
  `ProductName` varchar(50) DEFAULT NULL,
  `ProductType` int(11) DEFAULT NULL,
  `Price` double(10,2) DEFAULT NULL,
  `Image` varchar(50) DEFAULT NULL,
  `Maker` varchar(50) DEFAULT NULL,
  `Discount` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`OrderItemId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderItem`
--

LOCK TABLES `OrderItem` WRITE;
/*!40000 ALTER TABLE `OrderItem` DISABLE KEYS */;
INSERT INTO `OrderItem` VALUES (2,5,'wii','Wii',1,269.00,'consoles/wii.jpg','Nintendo',10,1),(3,6,'xboxone','XBox One',1,399.00,'consoles/xbox1.jpg','Microsoft',10,2),(4,6,'xboxone_wc','Controller',2,40.00,'accessories/XBOX controller.jpg','Microsoft',10,3),(5,7,'ps4','PS4',1,349.00,'consoles/PS4-console-bundle.jpg','Sony',10,23),(6,7,'wiiu_gc','GameCube Controller',2,29.99,'accessories/wiiu_gamecube.jpg','Nintendo',10,1),(7,4,'ap_ipadpro','iPad Pro 128GB',4,949.99,'tablets/ipadpro.jpg','Apple',10,2),(8,4,'xbox360_mr','Speeding Wheel',2,40.00,'accessories/XBOX360-SpeedWheel.jpg','Microsoft',10,3);
/*!40000 ALTER TABLE `OrderItem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `SalesOrder`
--

DROP TABLE IF EXISTS `SalesOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SalesOrder` (
  `OrderId` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `CreditCard` varchar(50) DEFAULT NULL,
  `ConfirmationNumber` varchar(50) DEFAULT NULL,
  `DeliveryDate` datetime DEFAULT NULL,
  PRIMARY KEY (`OrderId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SalesOrder`
--

LOCK TABLES `SalesOrder` WRITE;
/*!40000 ALTER TABLE `SalesOrder` DISABLE KEYS */;
INSERT INTO `SalesOrder` VALUES (4,'johnny','1st Jackson Ave,Chicago,IL','3101122033287498','johnny35337498','2016-06-08 00:00:00'),(5,'johnny','1st Jackson Ave,Chicago,IL','3101122033287498','johnny15117498','2016-06-07 00:00:00'),(6,'johnny','1 East jackson boulevard','3101122033281234','johnny65261234','2016-06-07 00:00:00'),(7,'customer','2241 S Archer Ave','3101122033281234','customer35231234','2016-06-07 00:00:00');
/*!40000 ALTER TABLE `SalesOrder` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-04  9:16:09
