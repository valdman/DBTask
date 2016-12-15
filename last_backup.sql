CREATE DATABASE  IF NOT EXISTS `developersteam_valdman` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `developersteam_valdman`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: developersteam_valdman
-- ------------------------------------------------------
-- Server version	5.7.13-log

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `AccountId` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `Email` varchar(45) NOT NULL,
  `Password` varchar(90) NOT NULL,
  `IsHidden` int(11) DEFAULT '0',
  PRIMARY KEY (`AccountId`),
  UNIQUE KEY `Id_UNIQUE` (`AccountId`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'Boris','Valdman','my@mail.ru','d8578edf8458ce06fbc5bb76a58c5ca4',0),(2,'Holy','Mosh','holy@const.com','81dc9bdb52d04dc20036dbd8313ed055',0),(3,'Max','Da Queen','tambov@rileeva.com','1f32aa4c9a1d2ea010adcf2348166a04',0),(4,'Ilya','Tooth','skyteether@mail.ru','20e43b79d8e1f2c9424239455e3aed01',0),(5,'Zhambul','Ermagambet','zham@bul.kz','37583e4f49b50bfe4618b18cb9043040',1),(6,'Test','OfPass','asd@xyz.ru','b0ce6c1ea07a61ac4da7c50e2a190c44',1),(7,'Vlad','Peshkun','peskun@rambler.ru','51d708d3ffca85280376ee9facce18b2',1),(8,'Ivan','Ivanov','jeqwfoiw@jhniufcw.com','182bfeb3d397befad12d54bdc5b01804',0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onAccountCreated` before insert on `account`
for each row
set new.Password = md5(new.Password) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onAccountUpdated` before update on `account`
for each row
begin
	if(new.Password != old.Password) then
		set new.Password = md5(new.Password);
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onTryingToDeleteAccount` after delete on `account`
for each row
begin
	#update account set IsDeleted=1 where account.AccountId=old.AccountId; #Нельзя в MySql!
    insert into account_old values (null, old.FirstName, old.LastName, old.Email, old.Password, 1);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `account_old`
--

DROP TABLE IF EXISTS `account_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_old` (
  `AccountId` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `Email` varchar(45) NOT NULL,
  `Password` varchar(90) NOT NULL,
  `IsDeleted` int(11) DEFAULT '0',
  PRIMARY KEY (`AccountId`),
  UNIQUE KEY `Id_UNIQUE` (`AccountId`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_old`
--

LOCK TABLES `account_old` WRITE;
/*!40000 ALTER TABLE `account_old` DISABLE KEYS */;
INSERT INTO `account_old` VALUES (8,'Nikita','Korovyansky','nik@yugiu.ru','22c43f38cd055baf51efd8d29471b36b',0);
/*!40000 ALTER TABLE `account_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_project`
--

DROP TABLE IF EXISTS `account_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_project` (
  `AccountId` int(11) NOT NULL,
  `ProjectId` int(11) NOT NULL,
  KEY `FK_AcPr_Account_idx` (`AccountId`),
  KEY `FK_AcPr_Project_idx` (`ProjectId`),
  CONSTRAINT `FK_AcPr_Account` FOREIGN KEY (`AccountId`) REFERENCES `account` (`AccountId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AcPr_Project` FOREIGN KEY (`ProjectId`) REFERENCES `project` (`ProjectId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_project`
--

LOCK TABLES `account_project` WRITE;
/*!40000 ALTER TABLE `account_project` DISABLE KEYS */;
INSERT INTO `account_project` VALUES (4,1),(3,2),(2,3),(2,8);
/*!40000 ALTER TABLE `account_project` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onAccountDeletedFromProject` before delete on `account_project`
for each row
begin
	set @developersLeft = (select count(*) from account_project where account_project.ProjectId=old.ProjectId);
    set @projectToLeaveId = old.ProjectId;
    set @projectToLeaveStatusCode = (select ProjectStatusCode from project where ProjectId = @projectToLeaveId);
    if (@developersLeft=1 and @projectToLeaveStatusCode !=3) then
		update project set ProjectStatusCode = 4 where ProjectId = @projectToLeaveId;
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank` (
  `BankId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Adress` varchar(45) NOT NULL,
  PRIMARY KEY (`BankId`),
  UNIQUE KEY `BankId_UNIQUE` (`BankId`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  UNIQUE KEY `Adress_UNIQUE` (`Adress`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank`
--

LOCK TABLES `bank` WRITE;
/*!40000 ALTER TABLE `bank` DISABLE KEYS */;
INSERT INTO `bank` VALUES (1,'Sberbank','60-Letiya Oktyabra 15'),(2,'Alpha Bank','Petrovsko-Razumovskaya 88'),(3,'Rocketbank','Moroseika 4');
/*!40000 ALTER TABLE `bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `ClientId` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `SecondName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ClientId`),
  UNIQUE KEY `ClientId_UNIQUE` (`ClientId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Natalya','Trigub'),(2,'Lena','Savina'),(3,'Dmitry','Polevoy'),(4,'Vitaly','Margelov'),(5,'Alex','White'),(6,'Alex','Larin'),(7,'Rustem','Shaidulin');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_clientpool`
--

DROP TABLE IF EXISTS `client_clientpool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_clientpool` (
  `ClientId` int(11) NOT NULL,
  `ClientpoolId` int(11) NOT NULL,
  KEY `FK_ClClpool_Client_idx` (`ClientId`),
  KEY `FK_ClClpool_Clientpool_idx` (`ClientpoolId`),
  CONSTRAINT `FK_ClClpool_Client` FOREIGN KEY (`ClientId`) REFERENCES `client` (`ClientId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ClClpool_Clientpool` FOREIGN KEY (`ClientpoolId`) REFERENCES `clientpool` (`ClientpoolId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_clientpool`
--

LOCK TABLES `client_clientpool` WRITE;
/*!40000 ALTER TABLE `client_clientpool` DISABLE KEYS */;
INSERT INTO `client_clientpool` VALUES (4,1),(5,1),(6,1),(7,1),(1,2),(2,3),(1,3);
/*!40000 ALTER TABLE `client_clientpool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientpool`
--

DROP TABLE IF EXISTS `clientpool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientpool` (
  `ClientpoolId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ClientpoolId`),
  UNIQUE KEY `ClientpoolId_UNIQUE` (`ClientpoolId`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientpool`
--

LOCK TABLES `clientpool` WRITE;
/*!40000 ALTER TABLE `clientpool` DISABLE KEYS */;
INSERT INTO `clientpool` VALUES (3,'Girls'),(1,'LigaAndFriends'),(2,'Prepods');
/*!40000 ALTER TABLE `clientpool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientpool_order`
--

DROP TABLE IF EXISTS `clientpool_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientpool_order` (
  `ClientpoolId` int(11) NOT NULL,
  `OrderId` int(11) NOT NULL,
  KEY `FK_ClOr_Clientpool_idx` (`ClientpoolId`),
  KEY `FK_ClOr_Order_idx` (`OrderId`),
  CONSTRAINT `FK_ClOr_Clientpool` FOREIGN KEY (`ClientpoolId`) REFERENCES `clientpool` (`ClientpoolId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ClOr_Order` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientpool_order`
--

LOCK TABLES `clientpool_order` WRITE;
/*!40000 ALTER TABLE `clientpool_order` DISABLE KEYS */;
INSERT INTO `clientpool_order` VALUES (2,2),(3,1),(1,3),(1,4);
/*!40000 ALTER TABLE `clientpool_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract` (
  `ContractId` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) DEFAULT NULL,
  `ContractSum` decimal(12,2) NOT NULL,
  `OrderId` int(11) DEFAULT NULL,
  `FullyPaied` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ContractId`),
  UNIQUE KEY `ContractId_UNIQUE` (`ContractId`),
  KEY `FK_Contract_Order_idx` (`OrderId`),
  CONSTRAINT `FK_Contract_Order` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (1,'Site for ENDOW',100801.00,2,0),(2,'Some rich stuff',8560000.00,1,0),(3,'Third contract',185001.00,3,0);
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_partnershipcontract`
--

DROP TABLE IF EXISTS `contract_partnershipcontract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_partnershipcontract` (
  `ContractId` int(11) NOT NULL,
  `Partnershipcontract` int(11) NOT NULL,
  KEY `FK_CoPa_Contract_idx` (`ContractId`),
  KEY `FK_CoPa_Partnershipcontract_idx` (`Partnershipcontract`),
  CONSTRAINT `FK_CoPa_Contract` FOREIGN KEY (`ContractId`) REFERENCES `contract` (`ContractId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_CoPa_Partnershipcontract` FOREIGN KEY (`Partnershipcontract`) REFERENCES `partnershipcontract` (`PartnershipContractId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_partnershipcontract`
--

LOCK TABLES `contract_partnershipcontract` WRITE;
/*!40000 ALTER TABLE `contract_partnershipcontract` DISABLE KEYS */;
INSERT INTO `contract_partnershipcontract` VALUES (2,1),(2,4),(1,3),(3,3);
/*!40000 ALTER TABLE `contract_partnershipcontract` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onContractPartnershipIns` after insert on `contract_partnershipcontract`
for each row
begin
	set @ammount = (select Ammount from partnershipcontract where PartnershipContractId=new.Partnershipcontract);
    update contract set ContractSum = ContractSum + @ammount where contract.ContractId=new.ContractId;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery` (
  `AccountId` int(11) NOT NULL,
  `EventInfoId` int(11) NOT NULL,
  `WasRead` int(1) DEFAULT '0',
  KEY `FK_Delivery_Account_idx` (`AccountId`),
  KEY `FK_Delivery_EventInfo_idx` (`EventInfoId`),
  CONSTRAINT `FK_Delivery_Account` FOREIGN KEY (`AccountId`) REFERENCES `account` (`AccountId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Delivery_EventInfo` FOREIGN KEY (`EventInfoId`) REFERENCES `eventinfo` (`EventId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,1,0),(1,2,1),(1,3,0),(2,2,1),(2,3,0),(5,2,0),(5,3,1),(3,1,0),(4,1,0),(4,2,0),(1,9,1),(2,9,1),(3,9,0),(4,9,0),(1,12,1),(2,12,1),(3,12,0),(4,12,1),(1,13,0),(2,13,1),(3,13,1),(4,13,1),(1,14,1),(2,14,0),(3,14,1),(4,14,1),(1,15,0),(2,15,0),(3,15,1),(4,15,0),(1,16,1),(2,16,1),(3,16,0),(4,16,1),(1,25,0),(2,25,0),(3,25,0),(4,25,1),(8,25,1),(1,26,1),(2,26,1),(3,26,1),(4,26,1),(8,26,0),(1,27,1),(2,27,1),(3,27,0),(4,27,0),(8,27,1),(5,27,0),(6,27,0),(7,27,1),(1,28,1),(2,28,0),(3,28,0),(4,28,1),(8,28,0),(5,28,1),(6,28,0),(7,28,0);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventinfo`
--

DROP TABLE IF EXISTS `eventinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventinfo` (
  `EventId` int(11) NOT NULL AUTO_INCREMENT,
  `OccuredOn` datetime NOT NULL,
  `Text` varchar(10000) NOT NULL,
  `EventTypeId` int(11) NOT NULL,
  PRIMARY KEY (`EventId`),
  UNIQUE KEY `EventId_UNIQUE` (`EventId`),
  KEY `FK_EventInfo_EventType_idx` (`EventTypeId`),
  CONSTRAINT `FK_EventInfo_EventType` FOREIGN KEY (`EventTypeId`) REFERENCES `eventtype` (`EventTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventinfo`
--

LOCK TABLES `eventinfo` WRITE;
/*!40000 ALTER TABLE `eventinfo` DISABLE KEYS */;
INSERT INTO `eventinfo` VALUES (1,'2016-09-12 00:00:00','Rustem left',3),(2,'2016-10-08 00:00:00','ENDW wanna site',1),(3,'2016-12-01 00:00:00','Imaginarium finished',5),(4,'2016-12-01 21:32:12','TestTrigg project added!',6),(7,'2016-12-01 21:33:01','LodCore project added!',6),(8,'2016-12-01 22:39:58','ItHappened project added!',6),(9,'2016-12-02 15:12:55','MisisBooks project added!',6),(10,'0000-00-00 00:00:00','TestEvent',5),(12,'2016-12-02 15:21:35','MisisBooks2 project added!',6),(13,'2016-12-02 15:22:17','ManuallyEvent',1),(14,'2016-12-02 16:14:07','DamnEvent',2),(15,'2016-12-02 15:30:19','DamnProject project added!',6),(16,'2016-12-02 18:41:37',' project added!',6),(25,'2016-12-15 15:11:17','Test1 project added!',6),(26,'2016-12-15 15:12:27',' project added!',6),(27,'2016-12-15 15:38:28','Admin said: Test broadcast',7),(28,'2016-12-15 15:40:16','Admin said: Test broadcast',7);
/*!40000 ALTER TABLE `eventinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onEventAdded` after insert on `eventinfo`
for each row
begin
	set @newEventId = new.EventId;
    insert into delivery (select AccountId, EventId, 0 from account join eventinfo
	where account.IsHidden = 0 and eventinfo.EventId = @newEventId);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `eventtype`
--

DROP TABLE IF EXISTS `eventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventtype` (
  `EventTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) NOT NULL DEFAULT 'Sample Event Type',
  PRIMARY KEY (`EventTypeId`),
  UNIQUE KEY `EventTypeId_UNIQUE` (`EventTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventtype`
--

LOCK TABLES `eventtype` WRITE;
/*!40000 ALTER TABLE `eventtype` DISABLE KEYS */;
INSERT INTO `eventtype` VALUES (1,'NewOrderPlaced'),(2,'NewDeveloperOnproject'),(3,'DeveloperLeftProject'),(4,'NewProjectStarted'),(5,'ProjectFinished'),(6,'NewProjectStarted'),(7,'AdminBroadcast');
/*!40000 ALTER TABLE `eventtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `OrderId` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) DEFAULT 'Sample Description',
  PRIMARY KEY (`OrderId`),
  UNIQUE KEY `OrderId_UNIQUE` (`OrderId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'1 Sample Description'),(2,'ENDOW site'),(3,'3 Sample Description'),(4,'4 Sample Description'),(5,'TriggerOrderte'),(7,'TestOrderPlaced');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onOrderCreated` after insert on `order`
for each row
begin
	insert into project values (null, "", new.Description, 1);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order_project`
--

DROP TABLE IF EXISTS `order_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_project` (
  `OrderId` int(11) NOT NULL,
  `ProjectId` int(11) DEFAULT NULL,
  KEY `FK_OrPr_Order_idx` (`OrderId`),
  KEY `FK_OrPr_Project_idx` (`ProjectId`),
  CONSTRAINT `FK_OrPr_Order` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OrPr_Project` FOREIGN KEY (`ProjectId`) REFERENCES `project` (`ProjectId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_project`
--

LOCK TABLES `order_project` WRITE;
/*!40000 ALTER TABLE `order_project` DISABLE KEYS */;
INSERT INTO `order_project` VALUES (2,1),(1,2),(4,3);
/*!40000 ALTER TABLE `order_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partnershipcontract`
--

DROP TABLE IF EXISTS `partnershipcontract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partnershipcontract` (
  `PartnershipContractId` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerName` varchar(45) DEFAULT 'Sample Partner',
  `ProductName` varchar(45) DEFAULT 'Sample PartnerProduct',
  `Ammount` varchar(45) DEFAULT '110000',
  PRIMARY KEY (`PartnershipContractId`),
  UNIQUE KEY `PartnershipContractId_UNIQUE` (`PartnershipContractId`),
  UNIQUE KEY `PartnerName_UNIQUE` (`PartnerName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partnershipcontract`
--

LOCK TABLES `partnershipcontract` WRITE;
/*!40000 ALTER TABLE `partnershipcontract` DISABLE KEYS */;
INSERT INTO `partnershipcontract` VALUES (1,'Microsoft','SQLServer','12000'),(2,'JetBrains','ReSharper','800'),(3,'Oracle','JVM','1'),(4,'Apple','iPad','60000');
/*!40000 ALTER TABLE `partnershipcontract` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onPartnershipDel` before delete on `partnershipcontract`
for each row
begin
	set @pcontractID = old.PartnershipContractId;
    set @pcontractSum = old.Ammount;
	
    SET SQL_SAFE_UPDATES = 0;
	update contract join contract_partnershipcontract on(contract.ContractId=contract_partnershipcontract.ContractId)
	set contract.ContractSum = contract.ContractSum - @pcontractSum
    where contract_partnershipcontract.Partnershipcontract = @pcontractID;
    
	delete from contract_partnershipcontract where contract_partnershipcontract.Partnershipcontract=@pcontractID;
    SET SQL_SAFE_UPDATES = 1;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `PaymentId` int(11) NOT NULL AUTO_INCREMENT,
  `Ammount` decimal(12,2) NOT NULL,
  `BankId` int(11) NOT NULL,
  `ContractId` int(11) NOT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `FK_Payment_Bank_idx` (`BankId`),
  KEY `FK_Payment_Contract_idx` (`ContractId`),
  CONSTRAINT `FK_Payment_Bank` FOREIGN KEY (`BankId`) REFERENCES `bank` (`BankId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Payment_Contract` FOREIGN KEY (`ContractId`) REFERENCES `contract` (`ContractId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,20000.00,1,1),(2,30000.00,2,1),(3,5000.00,3,1),(4,8500000.00,2,2),(5,25000.00,3,3),(7,44000.00,2,1),(8,100801.00,1,1);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onPaymentAdded` after insert on `payment`
for each row
begin
	set @sumOfPaymentsByContracts = (select sum(Ammount) from payment where payment.ContractId=new.ContractId);
    set @contractSum = (select contract.ContractSum from contract where contract.ContractId=new.ContractId);
    if @sumOfPaymentsByContracts >= @contractSum then
		update contract set contract.FullyPaied=1 where contract.ContractId=new.ContractId;
	else 
		update contract set contract.FullyPaied=0 where contract.ContractId=new.ContractId;
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `ProjectId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL DEFAULT 'SamplePrjName',
  `Description` varchar(45) NOT NULL DEFAULT 'SamplePrjDesc',
  `ProjectStatusCode` int(11) DEFAULT NULL,
  PRIMARY KEY (`ProjectId`),
  KEY `FK_Project_ProjectStatus_idx` (`ProjectStatusCode`),
  CONSTRAINT `FK_Project_ProjectStatus` FOREIGN KEY (`ProjectStatusCode`) REFERENCES `projectstatus` (`ProjectStatusId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'Endowment Fund Website','For collect funds',2),(2,'Somename','somedescr',1),(3,'Imaginarium','Game for android',4),(6,'TestTrigg','TgTgtg',4),(7,'LodCore','Lod Website',3),(8,'ItHappened','For checking stats',2),(9,'MisisBooks2','For download books',3),(10,'DamnProject','!!!',4),(11,'','TriggerOrder',1),(16,'Test1','Testtest1',1),(17,'','TestOrderPlaced',1);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onProjectAdded` after insert on `project`
for each row
begin
	insert into eventinfo values (null, now(), concat(new.Name, " project added!"), 6);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbtask`@`localhost`*/ /*!50003 trigger `onProjectStatusUpdated` after update on `project`
for each row
begin
	if (old.ProjectStatusCode !=3 and new.ProjectStatusCode = 3) then
    begin
		SET SQL_SAFE_UPDATES = 0;
		delete from account_project where account_project.ProjectId = old.ProjectId;
		SET SQL_SAFE_UPDATES = 1;
	end;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `project_projecttype`
--

DROP TABLE IF EXISTS `project_projecttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_projecttype` (
  `ProjectId` int(11) NOT NULL,
  `ProjectTypeId` int(11) NOT NULL,
  KEY `FK_PrPr_Project_idx` (`ProjectId`),
  KEY `FK_PrPr_Projecttype_idx` (`ProjectTypeId`),
  CONSTRAINT `FK_PrPr_Project` FOREIGN KEY (`ProjectId`) REFERENCES `project` (`ProjectId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PrPr_Projecttype` FOREIGN KEY (`ProjectTypeId`) REFERENCES `projecttype` (`ProjectTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_projecttype`
--

LOCK TABLES `project_projecttype` WRITE;
/*!40000 ALTER TABLE `project_projecttype` DISABLE KEYS */;
INSERT INTO `project_projecttype` VALUES (1,1),(1,2),(2,4),(2,5),(3,3),(3,4);
/*!40000 ALTER TABLE `project_projecttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectstatus`
--

DROP TABLE IF EXISTS `projectstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectstatus` (
  `ProjectStatusId` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) NOT NULL DEFAULT 'Da sample status of project',
  PRIMARY KEY (`ProjectStatusId`),
  UNIQUE KEY `ProjectStatusId_UNIQUE` (`ProjectStatusId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectstatus`
--

LOCK TABLES `projectstatus` WRITE;
/*!40000 ALTER TABLE `projectstatus` DISABLE KEYS */;
INSERT INTO `projectstatus` VALUES (1,'Planed'),(2,'Ongoing'),(3,'Finished'),(4,'Freezed');
/*!40000 ALTER TABLE `projectstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projecttype`
--

DROP TABLE IF EXISTS `projecttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projecttype` (
  `ProjectTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) NOT NULL DEFAULT 'WebBack',
  PRIMARY KEY (`ProjectTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projecttype`
--

LOCK TABLES `projecttype` WRITE;
/*!40000 ALTER TABLE `projecttype` DISABLE KEYS */;
INSERT INTO `projecttype` VALUES (1,'Web'),(2,'Desktop'),(3,'Game'),(4,'Android'),(5,'iOs');
/*!40000 ALTER TABLE `projecttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `TestId` int(11) NOT NULL AUTO_INCREMENT,
  `Data` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`TestId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'12'),(2,'13'),(3,'14'),(4,'15'),(6,'16'),(7,'10 prjId is old'),(8,'10'),(17,'dbtask try to gain'),(19,'dbtask try to gain'),(21,'dbtask try to gain');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'developersteam_valdman'
--

--
-- Dumping routines for database 'developersteam_valdman'
--
/*!50003 DROP FUNCTION IF EXISTS `Authtorize` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` FUNCTION `Authtorize`(email varchar(255), passwd varchar(255)) RETURNS int(11)
begin
	set @resCountAuth = (select count(*) from account where Email = email and Password = md5(passwd));
    if(@resCountAuth = 1) then
		return (select AccountId from account where Email = email and Password = md5(passwd));
	else
		return -1;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CheckPasswordQuality` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` FUNCTION `CheckPasswordQuality`(passwd varchar(255)) RETURNS tinyint(1)
begin
	set @passLength = CHAR_LENGTH(passwd);
	return ( @passLength > 8 ) ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `DebtSumByContract` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` FUNCTION `DebtSumByContract`(contractIdToFind int(5)) RETURNS int(11)
begin
	set @sumOfPaymentsByContractsToFind = (select sum(Ammount) from payment where payment.ContractId=contractIdToFind);
    set @contractSumToFind = (select contract.ContractSum from contract where contract.ContractId=contractIdToFind);
    set @debtToRes =  @contractSumToFind - @sumOfPaymentsByContractsToFind;
    if (@debtToRes > 0) then
		return @debtToRes;
	else
		return 0;
	end if;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetCountOfUnreadEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` FUNCTION `GetCountOfUnreadEvents`(userId int(5)) RETURNS int(11)
begin
	return (select count(*) from delivery where AccountId = userId and WasRead = 0);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Broadcast` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` PROCEDURE `Broadcast`(text varchar(4000))
begin
	set SQL_SAFE_UPDATES = 0;
	insert into eventinfo 
    set eventinfo.EventId = null,
		eventinfo.OccuredOn = now(), 
		eventinfo.Text = concat('Admin said: ', text), 
        eventinfo.EventTypeId = 7;
    set @newEventId = LAST_INSERT_ID();
    insert into delivery (select AccountId, EventId, 0 as WasRead from account join eventinfo
	where account.IsHidden = 1 and eventinfo.EventId = @newEventId);
    set SQL_SAFE_UPDATES = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DebtSumByContract` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` PROCEDURE `DebtSumByContract`(contractIdToFind int(5))
begin
	set @sumOfPaymentsByContractsToFind = (select sum(Ammount) from payment where payment.ContractId=contractIdToFind);
    set @contractSumToFind = (select contract.ContractSum from contract where contract.ContractId=contractIdToFind);
    set @debtToRes =  @contractSumToFind - @sumOfPaymentsByContractsToFind;
    if (@debtToRes > 0) then
		select @debtToRes;
	else
		select 0;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FindOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` PROCEDURE `FindOrders`(strToFind varchar(255))
begin
	select OrderId from `developersteam_valdman`.`order` where Description like(concat("%", strToFind, "%"));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUnreadEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` PROCEDURE `GetUnreadEvents`(userId int(5))
begin
	select 
		eventinfo.EventId, eventinfo.EventTypeId, eventinfo.OccuredOn, eventinfo.Text
    from
		delivery join eventinfo on(delivery.EventInfoId = eventinfo.EventId)
	where
		delivery.WasRead = 0 and delivery.AccountId = userId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MarkAllDeliviriesAsRead` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbtask`@`localhost` PROCEDURE `MarkAllDeliviriesAsRead`(userId int(5))
begin
	set SQL_SAFE_UPDATES = 0;
    update delivery set WasRead = 1 where AccountId = userId;
    set SQL_SAFE_UPDATES = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-15 16:59:31
