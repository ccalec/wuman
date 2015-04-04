-- ----------------------------
-- Table structure for adminuser
-- ----------------------------
CREATE TABLE `adminuser` (
  `account` varchar(20) NOT NULL default '',
  `password` varchar(40) NOT NULL,
  `name` varchar(20) default NULL,
  `email` varchar(20) default NULL,
  `role` varchar(100) default NULL,
  PRIMARY KEY  (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_action
-- ----------------------------
CREATE TABLE `wg_action` (
  `paramJson` varchar(1024) default NULL,
  `alias` varchar(128) default NULL,
  `actionName` varchar(40) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `serviceName` varchar(40) default NULL,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=401 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_roles
-- ----------------------------
CREATE TABLE `wg_roles` (
  `alias` varchar(128) default NULL,
  `name` varchar(256) default NULL,
  `displayName` varchar(256) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_rolesaction
-- ----------------------------
CREATE TABLE `wg_rolesaction` (
  `alias` varchar(128) default NULL,
  `actionCid` int(11) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=511 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `adminuser` VALUES ('admin', 'dedcd0d685a85a58bc76b5f1b57fe03c', 'admin', '', 'adminManager');
INSERT INTO `cmsmetadata`(cid,dataDesc,alias,tableName,displayName,parentAlias,dataRefresh,dataOwnerSet) VALUES ('26', '{\"actionName\":{\"title\":\"权限名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"fieldLen\":\"40\",\"islist\":\"1\",\"order\":\"1\"},\"serviceName\":{\"title\":\"服务名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"fieldLen\":\"40\",\"islist\":\"0\",\"order\":\"2\"},\"paramJson\":{\"title\":\"权限参数\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"fieldLen\":\"1024\",\"islist\":\"0\",\"order\":\"3\"}}', 'action', 'wg_action', '权限定义', '', null, '');
INSERT INTO `cmsmetadata`(cid,dataDesc,alias,tableName,displayName,parentAlias,dataRefresh,dataOwnerSet) VALUES ('27', '{\"actionCid\":{\"title\":\"权限ID\",\"type\":\"OuterLink\",\"fieldType\":\"int\",\"ourterLink\":\"action.cid\",\"fieldLen\":\"11\",\"islist\":\"0\"},\"actionDisplayName\":{\"title\":\"角色名称\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"action.actionName\",\"fieldLen\":\"256\",\"islist\":\"1\"}}', 'rolesAction', 'wg_rolesaction', '角色权限', 'roles', null, '');
INSERT INTO `cmsmetadata`(cid,dataDesc,alias,tableName,displayName,parentAlias,dataRefresh,dataOwnerSet) VALUES ('28', '{\"displayName\":{\"title\":\"角色名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"fieldLen\":\"256\",\"islist\":\"1\",\"order\":\"1\"},\"name\":{\"title\":\"角色标识\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"fieldLen\":\"256\",\"islist\":\"1\",\"order\":\"2\"}}', 'roles', 'wg_roles', '角色定义', '', null, '');
INSERT INTO `wg_roles` VALUES ('roles', 'adminManager', '乐享微网管理员', '1377327440477', '1', null, '0');
-- ----------------------------
-- Table structure for cmsmetadata
-- ----------------------------
DROP TABLE IF EXISTS `cmsmetadata`;
CREATE TABLE `cmsmetadata` (
  `cid` int(11) NOT NULL auto_increment,
  `dataDesc` varchar(20480) default NULL,
  `alias` varchar(128) NOT NULL,
  `tableName` varchar(128) default NULL,
  `displayName` varchar(128) default NULL,
  `parentAlias` varchar(128) default NULL,
  `dataRefresh` varchar(128) default NULL,
  `dataOwner` varchar(64) default NULL,
  `opertime` bigint(20) default NULL,
  `nodeid` int(11) default NULL,
  `dataOwnerSet` varchar(128) default NULL,
  PRIMARY KEY  (`cid`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_channelclass
-- ----------------------------
CREATE TABLE `wg_channelclass` (
  `alias` varchar(128) default NULL,
  `displayName` varchar(256) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for wg_cmsconfig
-- ----------------------------
CREATE TABLE `wg_cmsconfig` (
  `alias` varchar(128) default NULL,
  `name` varchar(40) default NULL,
  `value` varchar(128) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_cmsview
-- ----------------------------
CREATE TABLE `wg_cmsview` (
  `alias` varchar(128) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  `templateid` int(11) default NULL,
  `keyname` varchar(256) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wg_cmsviewtemplate
-- ----------------------------
CREATE TABLE `wg_cmsviewtemplate` (
  `templateimg` varchar(256) default NULL,
  `alias` varchar(128) default NULL,
  `name` varchar(40) default NULL,
  `templateurl` varchar(256) default NULL,
  `opertime` bigint(20) default NULL,
  `cid` int(11) NOT NULL auto_increment,
  `dataOwner` varchar(64) default NULL,
  `nodeid` int(11) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `cmsmetadata` VALUES ('1', '{\"tableName\":{\"title\":\"表名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"1\",\"order\":\"50\"},\"displayName\":{\"title\":\"模型名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"parentAlias\":{\"title\":\"挂接模型\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataRefresh\":{\"title\":\"数据刷新\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataDesc\":{\"title\":\"数据描述\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"20480\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"dataOwnerSet\":{\"title\":\"数据权限设置\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataOwner\":{\"title\":\"数据所有者\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'channel', 'cmsmetadata', '数据模型', 'channelClass', '', '', null, '3', null);
INSERT INTO `cmsmetadata` VALUES ('2', '{\"displayName\":{\"title\":\"分类名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'channelClass', 'wg_channelclass', '模型分类', '', '', '', null, '3', null);
INSERT INTO `cmsmetadata` VALUES ('40', '{\"keyname\":{\"title\":\"视图类型\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"40\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"列表页为list，详情页为detail\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateid\":{\"title\":\"模板索引\",\"type\":\"OuterLink\",\"fieldType\":\"int\",\"ourterLink\":\"cmsviewtemplate.cid\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"tmpname\":{\"title\":\"模板地址\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"cmsviewtemplate.templateurl\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"tmpurl\":{\"title\":\"模板视图\",\"type\":\"File\",\"fieldType\":\"ourterField\",\"ourterLink\":\"cmsviewtemplate.templateimg\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsview', 'wg_cmsview', 'CMS视图配置', 'channel', '', null, null, '1', '');
INSERT INTO `cmsmetadata` VALUES ('41', '{\"name\":{\"title\":\"模板名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateurl\":{\"title\":\"模板地址\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateimg\":{\"title\":\"模板图片\",\"type\":\"File\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsviewtemplate', 'wg_cmsviewtemplate', '视图模板', '', '', null, null, '1', '');
INSERT INTO `cmsmetadata` VALUES ('42', '{\"name\":{\"title\":\"参数名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"value\":{\"title\":\"参数值\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsconfig', 'wg_cmsconfig', 'cms系统配置', '', '', '', '1384485152128', '1', '');
INSERT INTO `wg_channelclass` VALUES ('channelClass', 'CMS', '1384385867346', '1', null, '0');
