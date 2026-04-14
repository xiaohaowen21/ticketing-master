
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
DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `adminid` int NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '管理员姓名',
  `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '管理员密码',
  `creattime` datetime NOT NULL COMMENT '创建时间',
  `flag` int NOT NULL COMMENT '管理员权限',
  `isuse` int NOT NULL COMMENT '管理员状态',
  `logintime` datetime NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`adminid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin','123456','2026-04-02 00:00:00',1,1,'2026-04-02 20:16:51');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `memberid` int NOT NULL AUTO_INCREMENT COMMENT '会员ID',
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '会员姓名',
  `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '会员密码',
  `registertime` datetime NOT NULL COMMENT '注册时间',
  `ifuse` int NOT NULL COMMENT '会员状态',
  `logintimes` datetime NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`memberid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (20,'Test1','123456','2026-04-02 20:07:09',1,'2026-04-14 23:20:29');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `pmember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pmember` (
  `pmemberid` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `memberid` int NOT NULL COMMENT '会员ID',
  `realname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '真实姓名',
  `sex` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '会员性别',
  `age` int NOT NULL COMMENT '会员年龄',
  `idcard` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  PRIMARY KEY (`pmemberid`) USING BTREE,
  KEY `mid` (`memberid`) USING BTREE,
  CONSTRAINT `pmember_ibfk_1` FOREIGN KEY (`memberid`) REFERENCES `member` (`memberid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `pmember` WRITE;
/*!40000 ALTER TABLE `pmember` DISABLE KEYS */;
INSERT INTO `pmember` VALUES (18,20,'张三','男',22,'410403222222222222');
/*!40000 ALTER TABLE `pmember` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `prep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prep` (
  `prepid` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `trainid` int NOT NULL COMMENT '车次id',
  `pmemberid` int NOT NULL COMMENT '会员信息ID',
  `startstation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起始站',
  `endstation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '终点站',
  `trainnumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '火车车次',
  `starttime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '开车时间',
  `endtime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '到站时间',
  `price` int NOT NULL COMMENT '车票价格',
  `way` bit(1) NOT NULL DEFAULT b'0' COMMENT '付款情况',
  `booktime` datetime NOT NULL COMMENT '订票时间',
  PRIMARY KEY (`prepid`) USING BTREE,
  KEY `trainid` (`trainid`) USING BTREE,
  KEY `pmemberid` (`pmemberid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `prep` WRITE;
/*!40000 ALTER TABLE `prep` DISABLE KEYS */;
/*!40000 ALTER TABLE `prep` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `trainid` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `trainnumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '车次',
  `startstation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '起始站',
  `endstation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '终点站',
  `starttime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '开车时间',
  `endtime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '到站时间',
  `price` int NOT NULL COMMENT '车票价格',
  `seatnumber` int NOT NULL COMMENT '座位数量',
  `addtime` datetime NOT NULL COMMENT '添加日期',
  PRIMARY KEY (`trainid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (335,'G1236','南京南','上海虹桥','2026-04-02 20:18:00','2026-04-17 20:18:00',576,800,'2026-04-02 20:18:24'),(336,'D2541','西安北','成都东','2026-04-02 09:30:00','2026-04-03 16:20:00',328,800,'2026-04-02 20:19:24');
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

