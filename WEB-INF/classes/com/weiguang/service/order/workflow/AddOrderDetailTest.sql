/*
MySQL Data Transfer
Source Host: localhost
Source Database: orderpage
Target Host: localhost
Target Database: orderpage
Date: 2013-11-28 10:50:47
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for skutest
-- ----------------------------
CREATE TABLE `skutest` (
  `price` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `unitName` varchar(255) default NULL,
  `productName` varchar(255) default NULL,
  `cid` varchar(255) NOT NULL default '',
  `SuitDistributionCid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_orderdetail
-- ----------------------------
CREATE TABLE `wg_orderdetail` (
  `count` int(11) default NULL,
  `alias` varchar(128) default NULL,
  `usePrice` varchar(256) default NULL,
  `skuName` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `price` varchar(256) default NULL,
  `unitName` varchar(256) default NULL,
  `opertime` bigint(20) default NULL,
  `productName` varchar(256) default NULL,
  `skuid` varchar(256) default NULL,
  `productType` varchar(256) default NULL,
  `skualias` varchar(40) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_orderdetail_copy1
-- ----------------------------
CREATE TABLE `wg_orderdetail_copy1` (
  `count` int(11) default NULL,
  `alias` varchar(128) default NULL,
  `usePrice` varchar(256) default NULL,
  `skuName` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `price` varchar(256) default NULL,
  `unitName` varchar(256) default NULL,
  `opertime` bigint(20) default NULL,
  `productName` varchar(256) default NULL,
  `skuid` varchar(256) default NULL,
  `productType` varchar(256) default NULL,
  `skualias` varchar(40) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_ordersuitdistribution
-- ----------------------------
CREATE TABLE `wg_ordersuitdistribution` (
  `receiveDate` bigint(20) default NULL,
  `alias` varchar(128) default NULL,
  `receiveTime` bigint(20) default NULL,
  `displayName` varchar(256) default NULL,
  `receiveStatus` varchar(256) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_ordersuitlist
-- ----------------------------
CREATE TABLE `wg_ordersuitlist` (
  `count` int(11) default NULL,
  `alias` varchar(128) default NULL,
  `unitName` varchar(256) default NULL,
  `skuName` varchar(256) default NULL,
  `skuid` varchar(256) default NULL,
  `productName` varchar(256) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `wmsID` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  `skualias` varchar(200) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_suitdistribution
-- ----------------------------
CREATE TABLE `wg_suitdistribution` (
  `settingArray` varchar(128) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `skutest` VALUES ('10', 'name', 'aaa', 'bb', '1', '1');
INSERT INTO `wg_orderdetail_copy1` VALUES ('2', 'OrderDetail', '10', 'name', '1', '1', null, '10', 'aaa', null, 'bb', '1', '1', 'skualis');
INSERT INTO `wg_suitdistribution` VALUES ('[1,3,5]', '1');
