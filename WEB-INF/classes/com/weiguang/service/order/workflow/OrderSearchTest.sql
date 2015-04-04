/*
MySQL Data Transfer
Source Host: localhost
Source Database: orderpage
Target Host: localhost
Target Database: orderpage
Date: 2013/11/23 11:00:41
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for order_view_test_testprocessbreezecontextqk1
-- ----------------------------
DROP TABLE IF EXISTS `_order1`;
CREATE TABLE `_order1` (
  `resultSet` varchar(10) default NULL,
  `length` int(10) default NULL,
  `start` int(10) default NULL,
  `ordername` varchar(20) default NULL,
  `desc` varchar(20) default NULL,
  `serverCenter` int(20) default NULL,
  `receiveDate` bigint(20) default NULL,
  `memo` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `orderType` int(11) default NULL,
  `receivePhone` varchar(256) default NULL,
  `consumeNo` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `orderNo` varchar(256) default NULL,
  `payStatus` varchar(256) default NULL,
  `receiveName` varchar(256) default NULL,
  `receiveAddress` varchar(256) default NULL,
  `orderPrice` varchar(256) default NULL,
  `chargeType` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `name` varchar(256) default NULL,
  `orderStatus` varchar(256) default NULL,
  `receiveTime` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_view_test_testprocessbreezecontextqk2
-- ----------------------------
DROP TABLE IF EXISTS `_order2`;
CREATE TABLE `_order2` (
  `resultSet` varchar(10) default NULL,
  `length` int(10) default NULL,
  `start` int(10) default NULL,
  `ordername` varchar(20) default NULL,
  `desc` varchar(20) default NULL,
  `serverCenter` int(20) default NULL,
  `receiveDate` bigint(20) default NULL,
  `memo` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `orderType` int(11) default NULL,
  `receivePhone` varchar(256) default NULL,
  `consumeNo` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `orderNo` varchar(256) default NULL,
  `payStatus` varchar(256) default NULL,
  `receiveName` varchar(256) default NULL,
  `receiveAddress` varchar(256) default NULL,
  `orderPrice` varchar(256) default NULL,
  `chargeType` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `name` varchar(256) default NULL,
  `orderStatus` varchar(256) default NULL,
  `receiveTime` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_view_test_testprocessbreezecontextqk3
-- ----------------------------
DROP TABLE IF EXISTS `_order3`;
CREATE TABLE `_order3` (
  `resultSet` varchar(10) default NULL,
  `length` int(10) default NULL,
  `start` int(10) default NULL,
  `ordername` varchar(20) default NULL,
  `desc` varchar(20) default NULL,
  `serverCenter` int(20) default NULL,
  `receiveDate` bigint(20) default NULL,
  `memo` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `orderType` int(11) default NULL,
  `receivePhone` varchar(256) default NULL,
  `consumeNo` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `orderNo` varchar(256) default NULL,
  `payStatus` varchar(256) default NULL,
  `receiveName` varchar(256) default NULL,
  `receiveAddress` varchar(256) default NULL,
  `orderPrice` varchar(256) default NULL,
  `chargeType` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `name` varchar(256) default NULL,
  `orderStatus` varchar(256) default NULL,
  `receiveTime` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_view_test_testprocessbreezecontextqk4
-- ----------------------------
DROP TABLE IF EXISTS `_order4`;
CREATE TABLE `_order4` (
  `resultSet` varchar(10) default NULL,
  `length` int(10) default NULL,
  `start` int(10) default NULL,
  `ordername` varchar(20) default NULL,
  `desc` varchar(20) default NULL,
  `serverCenter` int(20) default NULL,
  `receiveDate` bigint(20) default NULL,
  `memo` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `orderType` int(11) default NULL,
  `receivePhone` varchar(256) default NULL,
  `consumeNo` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `orderNo` varchar(256) default NULL,
  `payStatus` varchar(256) default NULL,
  `receiveName` varchar(256) default NULL,
  `receiveAddress` varchar(256) default NULL,
  `orderPrice` varchar(256) default NULL,
  `chargeType` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `name` varchar(256) default NULL,
  `orderStatus` varchar(256) default NULL,
  `receiveTime` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_view_test_testprocessbreezecontextqk5
-- ----------------------------
DROP TABLE IF EXISTS `_order5`;
CREATE TABLE `_order5` (
  `resultSet` varchar(10) default NULL,
  `length` int(10) default NULL,
  `start` int(10) default NULL,
  `ordername` varchar(20) default NULL,
  `desc` varchar(20) default NULL,
  `serverCenter` int(20) default NULL,
  `receiveDate` bigint(20) default NULL,
  `memo` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `orderType` int(11) default NULL,
  `receivePhone` varchar(256) default NULL,
  `consumeNo` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `orderNo` varchar(256) default NULL,
  `payStatus` varchar(256) default NULL,
  `receiveName` varchar(256) default NULL,
  `receiveAddress` varchar(256) default NULL,
  `orderPrice` varchar(256) default NULL,
  `chargeType` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `name` varchar(256) default NULL,
  `orderStatus` varchar(256) default NULL,
  `receiveTime` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_view_test_testprocessbreezecontextqk6
-- ----------------------------
DROP TABLE IF EXISTS `_order6`;
CREATE TABLE `_order6` (
  `resultSet` varchar(10) default NULL,
  `length` int(10) default NULL,
  `start` int(10) default NULL,
  `ordername` varchar(20) default NULL,
  `desc` varchar(20) default NULL,
  `serverCenter` int(20) default NULL,
  `receiveDate` bigint(20) default NULL,
  `memo` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `orderType` int(11) default NULL,
  `receivePhone` varchar(256) default NULL,
  `consumeNo` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `orderNo` varchar(256) default NULL,
  `payStatus` varchar(256) default NULL,
  `receiveName` varchar(256) default NULL,
  `receiveAddress` varchar(256) default NULL,
  `orderPrice` varchar(256) default NULL,
  `chargeType` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `name` varchar(256) default NULL,
  `orderStatus` varchar(256) default NULL,
  `receiveTime` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_view_test_testprocessbreezecontextqk7
-- ----------------------------
DROP TABLE IF EXISTS `_order7`;
CREATE TABLE `_order7` (
  `resultSet` varchar(10) default NULL,
  `length` int(10) default NULL,
  `start` int(10) default NULL,
  `ordername` varchar(20) default NULL,
  `desc` varchar(20) default NULL,
  `serverCenter` int(20) default NULL,
  `receiveDate` bigint(20) default NULL,
  `memo` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `orderType` int(11) default NULL,
  `receivePhone` varchar(256) default NULL,
  `consumeNo` varchar(256) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `dataOwner` varchar(64) default NULL,
  `orderNo` varchar(256) default NULL,
  `payStatus` varchar(256) default NULL,
  `receiveName` varchar(256) default NULL,
  `receiveAddress` varchar(256) default NULL,
  `orderPrice` varchar(256) default NULL,
  `chargeType` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `name` varchar(256) default NULL,
  `orderStatus` varchar(256) default NULL,
  `receiveTime` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for order_view
-- ----------------------------
DROP VIEW IF EXISTS `order_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_view` AS select `order_view_test_testprocessbreezecontextqk5`.`resultSet` AS `resultSet`,`order_view_test_testprocessbreezecontextqk5`.`length` AS `length`,`order_view_test_testprocessbreezecontextqk5`.`start` AS `start`,`order_view_test_testprocessbreezecontextqk5`.`ordername` AS `ordername`,`order_view_test_testprocessbreezecontextqk5`.`desc` AS `desc`,`order_view_test_testprocessbreezecontextqk5`.`serverCenter` AS `serverCenter`,`order_view_test_testprocessbreezecontextqk5`.`receiveDate` AS `receiveDate`,`order_view_test_testprocessbreezecontextqk5`.`memo` AS `memo`,`order_view_test_testprocessbreezecontextqk5`.`alias` AS `alias`,`order_view_test_testprocessbreezecontextqk5`.`orderType` AS `orderType`,`order_view_test_testprocessbreezecontextqk5`.`receivePhone` AS `receivePhone`,`order_view_test_testprocessbreezecontextqk5`.`consumeNo` AS `consumeNo`,`order_view_test_testprocessbreezecontextqk5`.`cid` AS `cid`,`order_view_test_testprocessbreezecontextqk5`.`nodeid` AS `nodeid`,`order_view_test_testprocessbreezecontextqk5`.`dataOwner` AS `dataOwner`,`order_view_test_testprocessbreezecontextqk5`.`orderNo` AS `orderNo`,`order_view_test_testprocessbreezecontextqk5`.`payStatus` AS `payStatus`,`order_view_test_testprocessbreezecontextqk5`.`receiveName` AS `receiveName`,`order_view_test_testprocessbreezecontextqk5`.`receiveAddress` AS `receiveAddress`,`order_view_test_testprocessbreezecontextqk5`.`orderPrice` AS `orderPrice`,`order_view_test_testprocessbreezecontextqk5`.`chargeType` AS `chargeType`,`order_view_test_testprocessbreezecontextqk5`.`opertime` AS `opertime`,`order_view_test_testprocessbreezecontextqk5`.`name` AS `name`,`order_view_test_testprocessbreezecontextqk5`.`orderStatus` AS `orderStatus`,`order_view_test_testprocessbreezecontextqk5`.`receiveTime` AS `receiveTime` from `order_view_test_testprocessbreezecontextqk5`;

-- ----------------------------
-- View structure for wg_rolesaction_view
-- ----------------------------
DROP VIEW IF EXISTS `wg_rolesaction_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wg_rolesaction_view` AS select `rolesaction`.`alias` AS `alias`,`action`.`cid` AS `actionCid`,`rolesaction`.`opertime` AS `opertime`,`rolesaction`.`cid` AS `cid`,`action`.`actionName` AS `actionDisplayName`,`rolesaction`.`dataOwner` AS `dataOwner`,`rolesaction`.`nodeid` AS `nodeid` from (`wg_rolesaction` `rolesAction` left join `wg_action` `action` on((`rolesaction`.`actionCid` = `action`.`cid`)));

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `_order1` VALUES ('count', '1', '0', 'lida', 'ture', '1', '1382450704276', '123', 'Order', '1', '18566246990', 'x10', '1', '1', '', 'D1', '2', 'liwensi', '????', '100', '1', '1382450709999', 'liwensi', '1', '2');
INSERT INTO `_order1` VALUES ('list', '1', '1', 'liwensi', 'false', '1', '1382450704276', '123', 'Order', '2', '1231', 'X11', '2', '2', null, 'D2', '1', 'lida', '??', '1000', '2', '1382450704276', 'lida', '2', '1');
INSERT INTO `_order2` VALUES ('count', '1', '0', 'lida', 'ture', '1', '1382450704276', 'memo', 'Order', '1', '18566246990', 'x10', '1', '1', '', 'D1', '2', 'liwensi', '????', '100', '1', '1382450709999', 'liwensi', '1', '2');
INSERT INTO `_order2` VALUES ('list', '1', '1', 'liwensi', 'false', '1', '1382450704276', '123', 'Order', '2', '1231', 'X11', '2', '2', null, 'D2', '1', 'lida', '??', '1000', '2', '1382450704276', 'lida', '2', '1');
INSERT INTO `_order3` VALUES ('count', '1', '0', 'lida', 'ture', '1', '1382450704276', '123', 'Order', '1', '18566246990', 'x10', '1', '1', '', 'D1', '2', 'liwensi', '????', '100', '1', '1382450704276', 'liwensi', '1', 'count');
INSERT INTO `_order3` VALUES ('list', '1', '1', 'liwensi', 'false', '1', '1382450704276', '123', 'Order', '2', '1231', 'X11', '2', '2', null, 'D2', '1', 'lida', '??', '1000', '2', '1382450704276', 'lida', '2', '1');
INSERT INTO `_order4` VALUES ('count', '1', '0', 'lida', 'ture', '1', '1382450704276', '123', 'Order', '1', '18566246990', 'x10', '1', '1', '', 'D1', '2', 'liwensi', '????', '100', '1', '1382450704276', 'liwensi', '1', 'count');
INSERT INTO `_order4` VALUES ('list', '1', '1', 'liwensi', 'false', '1', '1382450704276', '123', 'Order', '2', '1231', 'X11', '2', '2', '', 'D2', '1', 'lida', '??', '1000', '2', '1382450704276', 'lida', '2', '1');
INSERT INTO `_order5` VALUES ('count', '1', '0', 'lida', 'ture', '1', '1382450704276', '123', 'Order', '1', '18566246990', 'x10', '1', '1', '', 'D1', '2', 'liwensi', '????', '100', '1', '1382450704276', 'liwensi', '1', 'count');
INSERT INTO `_order5` VALUES ('list', '1', '1', 'liwensi', 'false', '1', '1382450704276', '123', 'Order', '2', '1231', 'X11', '2', '2', '', 'D2', '1', 'lida', '??', '1000', '2', '1382450704276', 'lida', '2', '1');
INSERT INTO `_order6` VALUES ('count', '1', '0', 'lida', 'ture', '1', '1382450704276', '123', 'Order', '1', '18566246990', 'x10', '1', '1', '', 'D1', '2', 'liwensi', '????', '100', '1', '1382450704276', 'liwensi', '1', 'count');
INSERT INTO `_order6` VALUES ('list', '1', '1', 'liwensi', 'false', '1', '1382450704276', '123', 'Order', '2', '1231', 'X11', '2', '2', '', 'D2', '1', 'lida', '??', '1000', '2', '1382450704276', 'lida', '2', '1');
INSERT INTO `_order7` VALUES ('count', '1', '0', 'lida', 'ture', '1', '1382450704276', '123', 'Order', '1', '18566246990', 'x10', '1', '1', '', 'D1', '2', 'liwensi', '????', '100', '1', '1382450704276', 'liwensi', '1', 'count');
INSERT INTO `_order7` VALUES ('list', '1', '1', 'liwensi', 'false', '1', '1382450704276', '123', 'Order', '2', '1231', 'X11', '2', '2', '', 'D2', '1', 'lida', '??', '1000', '2', '1382450704276', 'lida', '2', '1');
