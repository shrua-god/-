/*
Navicat MySQL Data Transfer

Source Server         : FinancingProduct
Source Server Version : 50037
Source Host           : 127.0.0.1:3306
Source Database       : shopping

Target Server Type    : MYSQL
Target Server Version : 50037
File Encoding         : 65001

Date: 2020-09-24 11:22:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `accountid` int(11) NOT NULL auto_increment,
  `accounttime` date NOT NULL,
  `accounttype` varchar(255) NOT NULL,
  `accountmoney` int(11) NOT NULL,
  `remark` varchar(255) default NULL,
  `state` varchar(255) NOT NULL,
  PRIMARY KEY  (`accountid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addressid` int(11) NOT NULL,
  `addressname` varchar(255) NOT NULL,
  `adresscity` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  PRIMARY KEY  (`addressid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL auto_increment,
  `city_name` varchar(255) NOT NULL,
  `province_id` int(11) NOT NULL,
  PRIMARY KEY  (`city_id`),
  KEY `province_id` (`province_id`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of city
-- ----------------------------

-- ----------------------------
-- Table structure for configuration
-- ----------------------------
DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration` (
  `configurationid` int(11) NOT NULL auto_increment,
  `configurationname` varchar(255) NOT NULL,
  PRIMARY KEY  (`configurationid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of configuration
-- ----------------------------

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL auto_increment,
  `county-name` varchar(255) NOT NULL,
  PRIMARY KEY  (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of country
-- ----------------------------

-- ----------------------------
-- Table structure for deal
-- ----------------------------
DROP TABLE IF EXISTS `deal`;
CREATE TABLE `deal` (
  `dealid` int(11) NOT NULL,
  `goodsid` int(11) NOT NULL,
  `dealtime` datetime NOT NULL,
  `dealmoney` int(11) NOT NULL,
  `dealnumber` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `configurationid` int(11) NOT NULL,
  `paymentid` int(11) NOT NULL,
  PRIMARY KEY  (`dealid`),
  KEY `goodsid` (`goodsid`),
  KEY `userid` (`userid`),
  KEY `configurationid` (`configurationid`),
  KEY `paymentid` (`paymentid`),
  CONSTRAINT `deal_ibfk_4` FOREIGN KEY (`paymentid`) REFERENCES `payment` (`paymentid`),
  CONSTRAINT `deal_ibfk_1` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsid`),
  CONSTRAINT `deal_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  CONSTRAINT `deal_ibfk_3` FOREIGN KEY (`configurationid`) REFERENCES `configuration` (`configurationid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of deal
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goodsid` int(11) NOT NULL,
  `goodsname` varchar(255) NOT NULL,
  `goodsmoney` varchar(255) NOT NULL,
  `goodsmiaoshu` varchar(255) NOT NULL,
  `goodsmuch` int(11) NOT NULL,
  `goodsphoto` varchar(255) NOT NULL,
  `goodstaste` varchar(255) default NULL,
  `goodsproperty` varchar(255) NOT NULL,
  PRIMARY KEY  (`goodsid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of goods
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderid` int(11) NOT NULL,
  `ordertime` date NOT NULL,
  `ordernumber` int(11) NOT NULL,
  `ordermoney` int(11) NOT NULL,
  `stateid` int(11) NOT NULL,
  `shoppingid` int(11) NOT NULL,
  `paymentid` int(11) NOT NULL,
  `orderstate` varchar(255) NOT NULL,
  PRIMARY KEY  (`orderid`),
  KEY `shoppingid` (`shoppingid`),
  KEY `stateid` (`stateid`),
  KEY `paymentid` (`paymentid`),
  CONSTRAINT `order_ibfk_3` FOREIGN KEY (`paymentid`) REFERENCES `payment` (`paymentid`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`shoppingid`) REFERENCES `shopping` (`shoppingid`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`stateid`) REFERENCES `state` (`stateid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `paymentid` int(11) NOT NULL auto_increment,
  `paymentname` varchar(255) NOT NULL,
  PRIMARY KEY  (`paymentid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `province_id` int(11) NOT NULL auto_increment,
  `province_name` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY  (`province_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `province_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of province
-- ----------------------------

-- ----------------------------
-- Table structure for sales
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  `goodsid` int(11) NOT NULL,
  `goodssales` int(11) NOT NULL,
  `goodszong` int(11) NOT NULL,
  KEY `goodsid` (`goodsid`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of sales
-- ----------------------------

-- ----------------------------
-- Table structure for shopping
-- ----------------------------
DROP TABLE IF EXISTS `shopping`;
CREATE TABLE `shopping` (
  `shoppingid` int(11) NOT NULL,
  `goodsid` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY  (`shoppingid`),
  KEY `goodsid` (`goodsid`),
  KEY `userid` (`userid`),
  CONSTRAINT `shopping_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  CONSTRAINT `shopping_ibfk_1` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of shopping
-- ----------------------------

-- ----------------------------
-- Table structure for state
-- ----------------------------
DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `stateid` int(11) NOT NULL,
  `statedescribe` varchar(255) NOT NULL,
  PRIMARY KEY  (`stateid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of state
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `userpass` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `usernumber` varchar(255) NOT NULL,
  `userbirthday` varchar(255) NOT NULL,
  `userpaymima` varchar(255) NOT NULL,
  `useridentity` varchar(255) NOT NULL,
  PRIMARY KEY  (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user
-- ----------------------------
