/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50037
Source Host           : 127.0.0.1:3306
Source Database       : fan

Target Server Type    : MYSQL
Target Server Version : 50037
File Encoding         : 65001

Date: 2020-09-25 15:17:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `accountid` int(11) NOT NULL auto_increment COMMENT 'id',
  `accounttime` date NOT NULL COMMENT '操作时间',
  `accounttype` varchar(255) NOT NULL COMMENT '操作类型',
  `accountmoney` int(11) NOT NULL COMMENT '操作金额',
  `remark` varchar(255) default NULL COMMENT '会员备注',
  `state` varchar(255) NOT NULL COMMENT 'state',
  `userid` int(11) NOT NULL,
  PRIMARY KEY  (`accountid`),
  KEY `userid` (`userid`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addressid` int(11) NOT NULL auto_increment COMMENT '地址id',
  `userid` int(11) NOT NULL,
  `adresscity` varchar(255) NOT NULL COMMENT '收货地址',
  `phone` varchar(255) NOT NULL COMMENT '手机号码',
  `code` varchar(255) NOT NULL COMMENT '邮政编码',
  `goodtime` datetime default NULL COMMENT '最佳送达时间',
  PRIMARY KEY  (`addressid`),
  KEY `userid` (`userid`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL auto_increment COMMENT 'id',
  `city_name` varchar(255) NOT NULL COMMENT '城市名称',
  `province_id` int(11) NOT NULL COMMENT '关联省份id',
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
  `configurationid` int(11) NOT NULL auto_increment COMMENT 'id',
  `configurationname` varchar(255) NOT NULL COMMENT '配送快递方式',
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
  `dealid` int(11) NOT NULL COMMENT '交易id',
  `goodsid` int(11) NOT NULL COMMENT '交易商品id',
  `dealtime` datetime NOT NULL COMMENT '交易时间',
  `dealmoney` int(11) NOT NULL COMMENT '交易金额',
  `dealnumber` int(11) NOT NULL COMMENT '订单编号',
  `userid` int(11) NOT NULL COMMENT '交易用户id',
  `configurationid` int(11) NOT NULL COMMENT '配送id',
  `paymentid` int(11) NOT NULL auto_increment COMMENT '支付id',
  PRIMARY KEY  (`dealid`),
  KEY `goodsid` (`goodsid`),
  KEY `userid` (`userid`),
  KEY `configurationid` (`configurationid`),
  KEY `paymentid` (`paymentid`),
  CONSTRAINT `deal_ibfk_1` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsid`),
  CONSTRAINT `deal_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  CONSTRAINT `deal_ibfk_3` FOREIGN KEY (`configurationid`) REFERENCES `configuration` (`configurationid`),
  CONSTRAINT `deal_ibfk_4` FOREIGN KEY (`paymentid`) REFERENCES `payment` (`paymentid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of deal
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goodsid` int(11) NOT NULL auto_increment COMMENT '商品id',
  `goodsname` varchar(255) NOT NULL COMMENT '商品名称',
  `goodsmoney` varchar(255) NOT NULL COMMENT '商品价格',
  `goodsmiaoshu` varchar(255) NOT NULL COMMENT '商品描述',
  `goodsmuch` int(11) NOT NULL COMMENT '商品积分',
  `goodsphoto` varchar(255) NOT NULL COMMENT '图片',
  `goodstaste` varchar(255) NOT NULL COMMENT '口味',
  `goodsproperty` varchar(255) NOT NULL COMMENT '属性',
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
  `orderid` int(11) NOT NULL auto_increment COMMENT '订单id',
  `ordertime` date NOT NULL COMMENT '下单时间',
  `addressid` int(11) NOT NULL COMMENT '收货地址id',
  `ordernumber` int(11) NOT NULL COMMENT '订单编号',
  `ordermoney` int(11) NOT NULL COMMENT '订单金额',
  `stateid` int(11) NOT NULL COMMENT '发货状态id',
  `shoppingid` int(11) NOT NULL COMMENT '购物车订单id',
  `paymentid` int(11) NOT NULL COMMENT '支付类型',
  `orderstate` varchar(255) NOT NULL COMMENT '订单状态',
  PRIMARY KEY  (`orderid`),
  KEY `shoppingid` (`shoppingid`),
  KEY `stateid` (`stateid`),
  KEY `paymentid` (`paymentid`),
  KEY `order_ibfk_4` (`addressid`),
  CONSTRAINT `order_ibfk_4` FOREIGN KEY (`addressid`) REFERENCES `address` (`addressid`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`shoppingid`) REFERENCES `shopping` (`shoppingid`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`stateid`) REFERENCES `state` (`stateid`),
  CONSTRAINT `order_ibfk_3` FOREIGN KEY (`paymentid`) REFERENCES `payment` (`paymentid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk COMMENT='InnoDB free: 906240 kB; (`shoppingid`) REFER `fan/shopping`(';

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `paymentid` int(11) NOT NULL auto_increment COMMENT 'id',
  `paymentname` varchar(255) NOT NULL COMMENT '支付方式',
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
  `province_id` int(11) NOT NULL auto_increment COMMENT 'id',
  `province_name` varchar(255) NOT NULL COMMENT '省份名称',
  PRIMARY KEY  (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of province
-- ----------------------------

-- ----------------------------
-- Table structure for sales
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  `goodsid` int(11) NOT NULL auto_increment COMMENT '商品id',
  `goodssales` int(11) NOT NULL COMMENT '商品月销量',
  `goodszong` int(11) NOT NULL COMMENT '累计销量',
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
  `shoppingid` int(11) NOT NULL auto_increment COMMENT '购物车表id',
  `goodsid` int(11) NOT NULL COMMENT '商品id',
  `score` int(11) NOT NULL COMMENT '数量',
  `userid` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY  (`shoppingid`),
  KEY `goodsid` (`goodsid`),
  KEY `userid` (`userid`),
  CONSTRAINT `shopping_ibfk_1` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsid`),
  CONSTRAINT `shopping_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of shopping
-- ----------------------------

-- ----------------------------
-- Table structure for state
-- ----------------------------
DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `stateid` int(11) NOT NULL auto_increment COMMENT '状态id',
  `statedescribe` varchar(255) NOT NULL COMMENT '状态',
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
  `userid` int(11) NOT NULL auto_increment COMMENT '用户id',
  `username` varchar(255) NOT NULL COMMENT '用户名称',
  `userpass` varchar(255) NOT NULL COMMENT '用户密码',
  `phone` varchar(255) NOT NULL COMMENT '手机号',
  `email` varchar(255) NOT NULL COMMENT '邮箱名',
  `usersex` varchar(255) NOT NULL COMMENT '性别',
  `userbirther` varchar(255) NOT NULL COMMENT '生日',
  `userpaymima` varchar(255) NOT NULL COMMENT '支付密码',
  `useridentity` varchar(255) NOT NULL COMMENT '身份证',
  PRIMARY KEY  (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user
-- ----------------------------
