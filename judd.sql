/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50615
 Source Host           : localhost
 Source Database       : judd

 Target Server Type    : MySQL
 Target Server Version : 50615
 File Encoding         : utf-8

 Date: 12/04/2014 09:21:41 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `adminuser`
-- ----------------------------
DROP TABLE IF EXISTS `adminuser`;
CREATE TABLE `adminuser` (
  `account` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(40) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `adminuser`
-- ----------------------------
BEGIN;
INSERT INTO `adminuser` VALUES ('admin', 'dedcd0d685a85a58bc76b5f1b57fe03c', 'admin', '', 'adminManager');
COMMIT;

-- ----------------------------
--  Table structure for `cmsmetadata`
-- ----------------------------
DROP TABLE IF EXISTS `cmsmetadata`;
CREATE TABLE `cmsmetadata` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataDesc` varchar(20480) DEFAULT NULL,
  `alias` varchar(128) NOT NULL,
  `tableName` varchar(128) DEFAULT NULL,
  `displayName` varchar(128) DEFAULT NULL,
  `parentAlias` varchar(128) DEFAULT NULL,
  `dataRefresh` varchar(128) DEFAULT NULL,
  `dataOwner` varchar(64) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `dataOwnerSet` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `cmsmetadata`
-- ----------------------------
BEGIN;
INSERT INTO `cmsmetadata` VALUES ('1', '{\"tableName\":{\"title\":\"表名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"1\",\"order\":\"50\"},\"displayName\":{\"title\":\"模型名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"parentAlias\":{\"title\":\"挂接模型\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataRefresh\":{\"title\":\"数据刷新\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataDesc\":{\"title\":\"数据描述\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"20480\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"dataOwnerSet\":{\"title\":\"数据权限设置\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataOwner\":{\"title\":\"数据所有者\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'channel', 'cmsmetadata', '数据模型', 'channelClass', '', '', null, '1', ''), ('2', '{\"displayName\":{\"title\":\"分类名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'channelClass', 'wg_channelclass', '模型分类', '', '', '', null, '1', ''), ('3', '{\"name\":{\"title\":\"参数名\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"value\":{\"title\":\"参数值\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsconfig', 'wg_cmsconfig', 'cms系统配置', '', '', '', '1384485152128', '1', ''), ('4', '{\"keyname\":{\"title\":\"视图类型\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"40\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"列表页为list，详情页为detail\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateid\":{\"title\":\"模板索引\",\"type\":\"OuterLink\",\"fieldType\":\"int\",\"ourterLink\":\"cmsviewtemplate.cid\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"tmpname\":{\"title\":\"模板地址\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"cmsviewtemplate.templateurl\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"tmpurl\":{\"title\":\"模板视图\",\"type\":\"File\",\"fieldType\":\"ourterField\",\"ourterLink\":\"cmsviewtemplate.templateimg\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsview', 'wg_cmsview', 'CMS视图配置', 'channel', '', '', null, '1', ''), ('5', '{\"name\":{\"title\":\"模板名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateurl\":{\"title\":\"模板地址\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateimg\":{\"title\":\"模板图片\",\"type\":\"File\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsviewtemplate', 'wg_cmsviewtemplate', '视图模板', '', '', '', null, '1', ''), ('6', '{\"actionName\":{\"title\":\"权限名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"1\"},\"serviceName\":{\"title\":\"服务名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"2\"},\"paramJson\":{\"title\":\"权限参数\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"1024\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"3\"}}', 'action', 'wg_action', '权限定义', '', '', '', null, '1', ''), ('7', '{\"actionCid\":{\"title\":\"权限ID\",\"type\":\"OuterLink\",\"fieldType\":\"int\",\"ourterLink\":\"action.cid\",\"fieldLen\":\"11\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"\"},\"actionDisplayName\":{\"title\":\"角色名称\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"action.actionName\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"}}', 'rolesAction', 'wg_rolesaction', '角色权限', 'roles', '', '', null, '1', ''), ('8', '{\"displayName\":{\"title\":\"角色名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"1\"},\"name\":{\"title\":\"角色标识\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"2\"}}', 'roles', 'wg_roles', '角色定义', '', '', '', null, '1', ''), ('9', '{\"statusAlias\":{\"title\":\"状态别名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"statusName\":{\"title\":\"状态名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'statusinfo', 'wg_statusinfo', '状态信息', '', '', '', null, '1', ''), ('10', '{\"actionName\":{\"title\":\"动作名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"serviceName\":{\"title\":\"服务名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"nextStatusCid\":{\"title\":\"选择下一状态\",\"type\":\"OuterLink\",\"fieldType\":\"varchar\",\"ourterLink\":\"statusinfo.cid\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"nextStatusName\":{\"title\":\"下一状态名称\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"statusinfo.statusName\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'statusaction', 'wg_statusaction', '状态动作', 'statusinfo', '', '', null, '1', ''), ('22', '{\"name\":{\"title\":\"花名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"checkers\":\"\\\\S+\",\"failTips\":\"花名不能为空哦\"}],\"desc\":\"必填，员工花名 \",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"password\":{\"title\":\"登录密码\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"checkers\":\"\\\\S+\",\"failTips\":\"请设置登录密码\"}],\"desc\":\"必填，登录密码\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"20\"},\"workid\":{\"title\":\"工号\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"phone\":{\"title\":\"手机号码\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"email\":{\"title\":\"邮箱\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"},\"biz\":{\"title\":\"所在业务线\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"70\"},\"address\":{\"title\":\"所在工位\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"80\"}}', 'member', 'judd_member', '会员管理', '', '', null, null, '3', ''), ('23', '{\"name\":{\"title\":\"商品名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"checkers\":\"\\\\S+\",\"failTips\":\"商品名称不能为空哦\"}],\"desc\":\"必填\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"price\":{\"title\":\"商品单价\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"checkers\":\"\\\\S+\",\"failTips\":\"商品价格不能为空哦\"}],\"desc\":\"元。必填\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"unit\":{\"title\":\"商品单位\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"checkers\":\"\\\\S+\",\"failTips\":\"商品单位不能为空哦\"}],\"desc\":\"必填\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"status\":{\"title\":\"商品状态\",\"type\":\"Select\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"正常\":\"1\",\"缺货\":\"0\"}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"}}', 'product', 'judd_product', '商品管理', 'proclass', '', null, null, '3', ''), ('24', '{\"displayName\":{\"title\":\"类别名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"checkers\":\"\\\\S+\",\"failTips\":\"商品类别名称不能为空哦\"}],\"desc\":\"必填\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"typedesc\":{\"title\":\"类别备注\",\"type\":\"Html\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"\"}}', 'proclass', 'judd_proclass', '商品分类', '', '', null, null, '3', ''), ('29', '{\"biz\":{\"title\":\"所属业务线\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"mcid\":{\"title\":\"下单人ID\",\"type\":\"Hidden\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"15\"},\"total\":{\"title\":\"金额总计\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"name\":{\"title\":\"下单人\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"peoplenum\":{\"title\":\"订购人数\",\"type\":\"ReadOnly\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"receivename\":{\"title\":\"收货人\",\"type\":\"Hidden\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"receivephone\":{\"title\":\"收货电话\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"},\"receiveaddress\":{\"title\":\"收货地址\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"70\"},\"addtime\":{\"title\":\"下单时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"80\"},\"receivetime\":{\"title\":\"配送时间\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"80\"},\"other\":{\"title\":\"备注\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"110\"},\"nodeid\":{\"title\":\"订单状态\",\"type\":\"Select\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"未处理\":1,\"已处理\":2}],\"desc\":\"对订单进行处理\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"120\"}}', 'juorder', 'judd_order', '订单管理', 'ordertype', '', null, null, '3', ''), ('30', '{\"pid\":{\"title\":\"商品ID\",\"type\":\"ReadOnly\",\"fieldType\":\"int\",\"ourterLink\":\"product.cid\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"pname\":{\"title\":\"商品名称\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"product.name\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"pprice\":{\"title\":\"商品单价\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"product.price\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"punit\":{\"title\":\"商品单位\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"product.unit\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"},\"pnum\":{\"title\":\"下单数量\",\"type\":\"ReadOnly\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"}}', 'orderdesc', 'judd_orderdesc', '订单明细', 'juorder', '', null, null, '3', ''), ('31', '{\"displayName\":{\"title\":\"订单类型\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"}}', 'ordertype', 'judd_ordertype', '订单分类', '', '', null, null, '3', '');
COMMIT;

-- ----------------------------
--  Table structure for `judd_member`
-- ----------------------------
DROP TABLE IF EXISTS `judd_member`;
CREATE TABLE `judd_member` (
  `phone` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `workid` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `biz` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `judd_member`
-- ----------------------------
BEGIN;
INSERT INTO `judd_member` VALUES ('18268041810', '68080', 'jianhui.fjh@alibaba-inc.com', 'member', '月飞', '1ef523c6b645a65441a91fa80df077c1', '1417503631398', '1', null, '0', '交易线', '4-4-N-188');
COMMIT;

-- ----------------------------
--  Table structure for `judd_order`
-- ----------------------------
DROP TABLE IF EXISTS `judd_order`;
CREATE TABLE `judd_order` (
  `total` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `receivetime` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `other` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `peoplenum` int(11) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) DEFAULT NULL,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `receivename` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `biz` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `receivephone` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `receiveaddress` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `mcid` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `judd_order`
-- ----------------------------
BEGIN;
INSERT INTO `judd_order` VALUES ('42', '12/03/2014 - 12/04/2014', '加油哦', 'juorder', '50', '33', '1', null, '1417539055329', '1417567762084', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('520', '12/03/2014 - 12/17/2014', '可以啦', 'juorder', '60', '34', '2', null, '1417568730330', '1417569898340', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('444', '12/03/2014 - 12/04/2014', '卡卡的', 'juorder', '41', '35', '1', null, '1417568730330', '1417579750809', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('9', '12/03/2014 - 12/18/2014', null, 'juorder', '34', '41', '1', null, '-2020917240', '1417616359642', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('450', '2014/12/04 - 2014/12/04', null, 'juorder', '19', '42', '1', null, '284189402', '1417623397086', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('0', '2014/12/04 - 2014/12/04', null, 'juorder', '19', '43', '1', null, '284499992', '1417623707675', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('1111', '2014/12/04 - 2014/12/04', null, 'juorder', '30', '44', '1', null, '1417624700023', '1417624700027', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('6', '2014/12/17 - 2014/12/17', null, 'juorder', '16', '45', '1', null, '1417624786197', '1417624786199', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('51', '2014/12/20 - 2014/12/20', null, 'juorder', '26', '46', '1', null, '1417624929345', '1417624929347', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1'), ('922', '2014/12/04 - 2014/12/10', null, 'juorder', '62', '47', '1', null, '1417627009984', '1417627009990', '月飞', '交易线', '月飞', '18268041810', '4-4-N-188', '1');
COMMIT;

-- ----------------------------
--  Table structure for `judd_orderdesc`
-- ----------------------------
DROP TABLE IF EXISTS `judd_orderdesc`;
CREATE TABLE `judd_orderdesc` (
  `pnum` int(11) DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `judd_orderdesc`
-- ----------------------------
BEGIN;
INSERT INTO `judd_orderdesc` VALUES ('2', 'orderdesc', '9', null, '124', null, '33'), ('3', 'orderdesc', '10', null, '125', null, '33'), ('35', 'orderdesc', '10', null, '127', null, '34'), ('1', 'orderdesc', '14', null, '128', null, '34'), ('21', 'orderdesc', '5', null, '130', null, '35'), ('25', 'orderdesc', '7', null, '131', null, '35'), ('37', 'orderdesc', '10', null, '132', null, '35'), ('3', 'orderdesc', '9', null, '146', null, '41'), ('16', 'orderdesc', '2', null, '147', null, '42'), ('21', 'orderdesc', '4', null, '148', null, '42'), ('32', 'orderdesc', '7', null, '149', null, '42'), ('25', 'orderdesc', '18', null, '150', null, '42'), ('33', 'orderdesc', '2', null, '154', null, '43'), ('4', 'orderdesc', '6', null, '155', null, '44'), ('1', 'orderdesc', '15', null, '156', null, '44'), ('2', 'orderdesc', '16', null, '157', null, '44'), ('5', 'orderdesc', '17', null, '158', null, '44'), ('2', 'orderdesc', '18', null, '159', null, '44'), ('2', 'orderdesc', '19', null, '160', null, '44'), ('2', 'orderdesc', '6', null, '162', null, '45'), ('2', 'orderdesc', '9', null, '163', null, '45'), ('2', 'orderdesc', '7', null, '165', null, '46'), ('17', 'orderdesc', '9', null, '166', null, '46'), ('3', 'orderdesc', '2', null, '168', null, '47'), ('20', 'orderdesc', '4', null, '169', null, '47'), ('33', 'orderdesc', '8', null, '170', null, '47'), ('29', 'orderdesc', '10', null, '171', null, '47'), ('28', 'orderdesc', '11', null, '172', null, '47'), ('2', 'orderdesc', '12', null, '173', null, '47'), ('3', 'orderdesc', '17', null, '174', null, '47'), ('3', 'orderdesc', '21', null, '175', null, '47'), ('4', 'orderdesc', '23', null, '176', null, '47');
COMMIT;

-- ----------------------------
--  Table structure for `judd_ordertype`
-- ----------------------------
DROP TABLE IF EXISTS `judd_ordertype`;
CREATE TABLE `judd_ordertype` (
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `displayName` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `judd_ordertype`
-- ----------------------------
BEGIN;
INSERT INTO `judd_ordertype` VALUES ('ordertype', '未处理', '1417538930193', '1', null, '0'), ('ordertype', '已处理', '1417538943271', '2', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `judd_proclass`
-- ----------------------------
DROP TABLE IF EXISTS `judd_proclass`;
CREATE TABLE `judd_proclass` (
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `displayName` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `typedesc` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `judd_proclass`
-- ----------------------------
BEGIN;
INSERT INTO `judd_proclass` VALUES ('proclass', '1417578012658', '1', null, '0', '下午茶&加油站', '<p class=\"p1\">用途（下午茶15:00配送、加油站22:00配送）</p>'), ('proclass', '1417578041582', '2', null, '0', '宵夜', '<p class=\"p1\">夜宵：配送时间每日21:00</p>'), ('proclass', '1417578086632', '3', null, '0', '午餐&晚餐', '<p class=\"p1\">午餐：配送时间每日12:00，晚餐：配送时间每日18:00</p>'), ('proclass', '1417578130998', '4', null, '0', '加班必备', '大促加班必备良品，无费用。'), ('proclass', '1417244188848', '6', null, '2', '二号楼点典餐厅', null), ('proclass', '1417244207294', '7', null, '2', '五号楼礼信年年餐厅', null), ('proclass', '1417244277298', '8', null, '2', '一号楼乐融餐厅', null);
COMMIT;

-- ----------------------------
--  Table structure for `judd_product`
-- ----------------------------
DROP TABLE IF EXISTS `judd_product`;
CREATE TABLE `judd_product` (
  `unit` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `status` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `judd_product`
-- ----------------------------
BEGIN;
INSERT INTO `judd_product` VALUES ('箱', '时价', 'product', '香蕉', '1417577201092', '1', null, '1', '1'), ('箱', '时价', 'product', '柚子', '1417577192070', '2', null, '1', '1'), ('箱', '时价', 'product', '苹果70', '1417243339690', '3', null, '1', '1'), ('箱', '时价', 'product', '水果黄瓜', '1417243339700', '4', null, '1', '1'), ('箱', '时价', 'product', '宫川蜜桔', '1417243339703', '5', null, '1', '1'), ('箱', '时价', 'product', '冬枣', '1417243339709', '6', null, '1', '1'), ('箱', '时价', 'product', '桂圆', '1417243339713', '7', null, '1', '1'), ('块', '1', 'product', '定胜糕', '1417243339717', '8', null, '1', '1'), ('包', '3', 'product', '小小酥', '1417243339722', '9', null, '1', '1'), ('包', '12', 'product', '法式', '1417243339725', '10', null, '1', '1'), ('包', '1.5', 'product', '干脆面', '1417243339728', '11', null, '1', '1'), ('包', '35', 'product', '牛肉粒', '1417243614536', '12', null, '1', '1'), ('箱', '45', 'product', '方便面', '1417243614539', '13', null, '1', '1'), ('箱', '100', 'product', '火腿肠', '1417243614543', '14', null, '1', '1'), ('包', '20', 'product', 'tipo面包', '1417243614548', '15', null, '1', '1'), ('包', '10', 'product', '加应子', '1417243614551', '16', null, '1', '1'), ('包', '15', 'product', '烧贝壳', '1417243614554', '17', null, '1', '1'), ('包', '18', 'product', '仙贝', '1417243614556', '18', null, '1', '1'), ('箱', '480', 'product', '咖啡', '1417243614558', '19', null, '1', '1'), ('箱', '60', 'product', '牛奶', '1417243614559', '20', null, '1', '1'), ('箱', '48', 'product', '可乐', '1417243614560', '21', null, '1', '1'), ('箱', '48', 'product', '雪碧', '1417243614562', '22', null, '1', '1'), ('箱（纸盒）', '60', 'product', '王老吉', '1417243614563', '23', null, '1', '1'), ('箱', '60', 'product', '谷粒谷力', '1417243614565', '24', null, '1', '1'), ('箱', '120', 'product', '红牛', '1417243614566', '25', null, '1', '1'), ('甜甜圈、三角蛋糕、粗粮', '10', 'product', '套餐A：西式套餐', '1417244751341', '26', null, '6', '1'), ('炒饭、粥、粗粮', '10', 'product', '套餐B：中式套餐', '1417244743580', '27', null, '6', '1'), ('炒粉干、八宝粥、粗粮', '10', 'product', '套餐C：中式套餐', '1417244736019', '28', null, '6', '1'), ('红豆面包、起酥条、粗粮', '10', 'product', '套餐D:西式套餐', '1417244724870', '29', null, '6', '1'), ('牛奶、水果、鸡蛋', '10', 'product', '套餐E：标配', '1417244710093', '30', null, '6', '1'), ('盒', '3.5', 'product', '酸奶', '1417244609828', '31', null, '7', '1'), ('个', '2', 'product', '水果', '1417244609830', '32', null, '7', '1'), ('碗', '2.5', 'product', '八宝粥', '1417244609832', '33', null, '7', '1'), ('碗', '2.5', 'product', '皮蛋瘦肉粥', '1417244609835', '34', null, '7', '1'), ('个', '2.5', 'product', '蛋挞', '1417244609837', '35', null, '7', '1'), ('个', '3', 'product', '糟糕', '1417244609840', '36', null, '7', '1'), ('个', '2', 'product', '海绵蛋糕', '1417244609845', '37', null, '7', '1'), ('片', '2', 'product', '面包片', '1417244609848', '38', null, '7', '1'), ('个', '1.5', 'product', '小餐包', '1417244609854', '39', null, '7', '1'), ('份', '3', 'product', '炒粉干', '1417244609858', '40', null, '7', '1'), ('个', '3.5', 'product', '葱花肉丝馅面包', '1417244609861', '41', null, '7', '1'), ('薯饼、奶黄包、紫薯、香菇鸡粥、水果', '10', 'product', '套餐A：西式套餐', '1417244690971', '42', null, '8', '1'), ('南瓜饼、猪肉包、玉米段、皮蛋瘦肉粥、水果', '10', 'product', '套餐B：中式套餐', '1417244690974', '43', null, '8', '1'), ('慕斯切片、芝麻饼、南瓜、蒙牛酸奶、水果', '10', 'product', '套餐C：中式套餐', '1417244690976', '44', null, '8', '1'), ('份', '20', 'product', '一号楼：乐融', '1417244934574', '45', null, '3', '1'), ('份', '20', 'product', '二号楼：点典', '1417244934576', '46', null, '3', '1'), ('份', '20', 'product', '五号楼：礼信年年', '1417244934577', '47', null, '3', '1'), ('份', '30', 'product', '一号楼：乐融', '1417244934579', '48', null, '3', '1'), ('份', '30', 'product', '二号楼：点典', '1417244934580', '49', null, '3', '1'), ('份', '30', 'product', '五号楼：礼信年年', '1417244934581', '50', null, '3', '1'), ('个', '不计', 'product', '躺椅', '1417245032198', '51', null, '4', '1'), ('张', '不计', 'product', '抱被', '1417245032201', '52', null, '4', '1'), ('个', '不计', 'product', '牙刷', '1417245032202', '53', null, '4', '1'), ('个', '不计', 'product', '风扇', '1417245032203', '54', null, '4', '1'), ('间', '不计', 'product', '酒店', '1417245032205', '55', null, '4', '1');
COMMIT;

-- ----------------------------
--  Table structure for `wg_action`
-- ----------------------------
DROP TABLE IF EXISTS `wg_action`;
CREATE TABLE `wg_action` (
  `paramJson` varchar(1024) DEFAULT NULL,
  `alias` varchar(128) DEFAULT NULL,
  `actionName` varchar(40) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `serviceName` varchar(40) DEFAULT NULL,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=497 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `wg_channelclass`
-- ----------------------------
DROP TABLE IF EXISTS `wg_channelclass`;
CREATE TABLE `wg_channelclass` (
  `alias` varchar(128) DEFAULT NULL,
  `displayName` varchar(256) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wg_channelclass`
-- ----------------------------
BEGIN;
INSERT INTO `wg_channelclass` VALUES ('channelClass', 'CMS', '1384385867346', '1', null, '0'), ('channelClass', '聚定制', '1417149898539', '3', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `wg_cmsconfig`
-- ----------------------------
DROP TABLE IF EXISTS `wg_cmsconfig`;
CREATE TABLE `wg_cmsconfig` (
  `alias` varchar(128) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `value` varchar(128) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wg_cmsconfig`
-- ----------------------------
BEGIN;
INSERT INTO `wg_cmsconfig` VALUES ('cmsconfig', '预算人均标准', '50', '1417571799379', '1', null, '0'), ('cmsconfig', '活动名称', '12.12大促活动', '1417572762447', '2', null, '0'), ('cmsconfig', '活动开关－设置1开启，0关闭', '1', '1417610120966', '3', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `wg_cmsview`
-- ----------------------------
DROP TABLE IF EXISTS `wg_cmsview`;
CREATE TABLE `wg_cmsview` (
  `alias` varchar(128) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `templateid` int(11) DEFAULT NULL,
  `keyname` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `wg_cmsviewtemplate`
-- ----------------------------
DROP TABLE IF EXISTS `wg_cmsviewtemplate`;
CREATE TABLE `wg_cmsviewtemplate` (
  `templateimg` varchar(256) DEFAULT NULL,
  `alias` varchar(128) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `templateurl` varchar(256) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `wg_leftmenu`
-- ----------------------------
DROP TABLE IF EXISTS `wg_leftmenu`;
CREATE TABLE `wg_leftmenu` (
  `alias` varchar(128) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `menuUrl` varchar(250) DEFAULT NULL,
  `displayName` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `wg_roles`
-- ----------------------------
DROP TABLE IF EXISTS `wg_roles`;
CREATE TABLE `wg_roles` (
  `alias` varchar(128) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `displayName` varchar(256) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wg_roles`
-- ----------------------------
BEGIN;
INSERT INTO `wg_roles` VALUES ('roles', 'adminManager', '超级管理员', '1416901372477', '1', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `wg_rolesaction`
-- ----------------------------
DROP TABLE IF EXISTS `wg_rolesaction`;
CREATE TABLE `wg_rolesaction` (
  `alias` varchar(128) DEFAULT NULL,
  `actionCid` int(11) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=644 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `wg_statusaction`
-- ----------------------------
DROP TABLE IF EXISTS `wg_statusaction`;
CREATE TABLE `wg_statusaction` (
  `alias` varchar(128) DEFAULT NULL,
  `actionName` varchar(256) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `serviceName` varchar(256) DEFAULT NULL,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `nextStatusCid` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `trigger_statusCtr_insert` AFTER INSERT ON `wg_statusaction` FOR EACH ROW BEGIN
    DECLARE maxCid varchar(20);
    DECLARE paramJson varchar(40);
    select max(cid) into maxCid from `wg_statusaction`;
    set paramJson = concat('{actionCid:' , maxCid , '}');
    insert into wg_action(paramJson,actionName,serviceName)values(paramJson,NEW.actionName,'statusCtr.setStatus');
END;
 ;;
delimiter ;

-- ----------------------------
--  Records of `wg_statusaction`
-- ----------------------------
BEGIN;
INSERT INTO `wg_statusaction` VALUES ('statusaction', '支付', '1385643280112', '1', 'statusCtr.setStatusByAlias', null, '1', '2'), ('statusaction', '打单配货', '1385643321410', '2', 'statusCtr.setStatusByAlias', null, '2', '3'), ('statusaction', '物流配送', '1385643389525', '3', 'statusCtr.setStatusByAlias', null, '3', '4'), ('statusaction', '确认配送', '1385643415474', '4', 'statusCtr.setStatusByAlias', null, '4', '5'), ('statusaction', '核销检查', '1385643441071', '5', 'statusCtr.setStatusByAlias', null, '5', '6'), ('statusaction', '生成核销报表', '1385643463885', '6', 'statusCtr.setStatusByAlias', null, '6', '7'), ('statusaction', '确认套餐配送', '1385643682054', '7', 'statusCtr.setStatusByAlias', null, '4', '2');
COMMIT;

-- ----------------------------
--  Table structure for `wg_statusinfo`
-- ----------------------------
DROP TABLE IF EXISTS `wg_statusinfo`;
CREATE TABLE `wg_statusinfo` (
  `alias` varchar(128) DEFAULT NULL,
  `statusName` varchar(256) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `statusAlias` varchar(256) DEFAULT NULL,
  `dataOwner` varchar(64) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wg_statusinfo`
-- ----------------------------
BEGIN;
INSERT INTO `wg_statusinfo` VALUES ('statusinfo', '初始', '1385637823419', '1', 'Order', null, '0'), ('statusinfo', '待配货', '1385637850165', '2', 'Order', null, '0'), ('statusinfo', '待配送', '1385637867035', '3', 'Order', null, '0'), ('statusinfo', '配送中', '1385637880741', '4', 'Order', null, '0'), ('statusinfo', '待核销', '1385637897715', '5', 'Order', null, '0'), ('statusinfo', '已核销', '1385637907765', '6', 'Order', null, '0'), ('statusinfo', '完成 ', '1385638017793', '7', 'Order', null, '0');
COMMIT;


-- ----------------------------
--  Procedure structure for `createRoles`
-- ----------------------------
DROP PROCEDURE IF EXISTS `createRoles`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createRoles`(in p_leader varchar(100) ,in p_alias varchar(100) ,in p_actionOperate varchar(7) ,in ifAddNode int)
BEGIN
        declare i int;
        DECLARE p_count INT;
        declare p_action_cid int;
        DECLARE p_roles_cid INT;
        declare p_displayName varchar(50);
        declare p_parentAlias varchar(50);
        declare p_actionOperateNum varchar(10);

        select cid into p_roles_cid from `wg_roles` where name = p_leader;
	select displayName into p_displayName FROM cmsmetadata WHERE alias = p_alias;/*获取模型名称*/
	select parentAlias into p_parentAlias from cmsmetadata where alias = p_alias;/*获取挂接的alias*/
/* 表权限补全 */
	select count(*) into p_count from `wg_action` where 'cms.addContent' IN (SELECT serviceName FROM wg_action WHERE paramJson LIKE CONCAT('{alias:"',p_alias,'"}'));
	if p_count=0  then
	    insert into wg_action(paramJson,alias,actionName,serviceName) values(CONCAT('{alias:"',p_alias,'"}'),'action',CONCAT('新增',p_displayName),'cms.addContent');
	end if;

	SELECT COUNT(*) INTO p_count FROM `wg_action` WHERE 'cms.deleteContent' IN (SELECT serviceName FROM wg_action WHERE paramJson LIKE CONCAT('{alias:"',p_alias,'"}'));
	IF p_count=0  THEN
	    INSERT INTO wg_action(paramJson,alias,actionName,serviceName) VALUES(CONCAT('{alias:"',p_alias,'"}'),'action',CONCAT('删除',p_displayName),'cms.deleteContent');
	end if;

	SELECT COUNT(*) INTO p_count FROM `wg_action` WHERE 'cms.modifyContent' IN (SELECT serviceName FROM wg_action WHERE paramJson LIKE CONCAT('{alias:"',p_alias,'"}'));
	IF p_count=0  THEN
	    INSERT INTO wg_action(paramJson,alias,actionName,serviceName) VALUES(CONCAT('{alias:"',p_alias,'"}'),'action',CONCAT('修改',p_displayName),'cms.modifyContent');
	end if;

	SELECT COUNT(*) INTO p_count FROM `wg_action` WHERE 'cms.queryContent' IN (SELECT serviceName FROM wg_action WHERE paramJson LIKE CONCAT('{alias:"',p_alias,'"}'));
	IF p_count=0  THEN
	    INSERT INTO wg_action(paramJson,alias,actionName,serviceName) VALUES(CONCAT('{alias:"',p_alias,'"}'),'action',concat('查询',p_displayName),'cms.queryContent');
	end if;
	/*判断是否添加节点操作权限*/
	IF ifAddNode = 1 then
	    SELECT COUNT(*) INTO p_count FROM `wg_action` WHERE 'cms.addNode' IN (SELECT serviceName FROM wg_action WHERE paramJson LIKE CONCAT('{alias:"',p_alias,'"}'));
	    IF p_count=0  THEN
		INSERT INTO wg_action(paramJson,alias,actionName,serviceName) VALUES(CONCAT('{alias:"',p_alias,'"}'),'action',CONCAT('新增',p_displayName,'节点'),'cms.addNode');
	    end if;

	    SELECT COUNT(*) INTO p_count FROM `wg_action` WHERE 'cms.deleteNode' IN (SELECT serviceName FROM wg_action WHERE paramJson LIKE CONCAT('{alias:"',p_alias,'"}'));
	    IF p_count=0  THEN
		INSERT INTO wg_action(paramJson,alias,actionName,serviceName) VALUES(CONCAT('{alias:"',p_alias,'"}'),'action',CONCAT('删除',p_displayName,'节点'),'cms.deleteNode');
	    END IF;

	    SELECT COUNT(*) INTO p_count FROM `wg_action` WHERE 'cms.modifyNode' IN (SELECT serviceName FROM wg_action WHERE paramJson LIKE CONCAT('{alias:"',p_alias,'"}'));
	    IF p_count=0  THEN
		INSERT INTO wg_action(paramJson,alias,actionName,serviceName) VALUES(CONCAT('{alias:"',p_alias,'"}'),'action',CONCAT('修改',p_displayName,'节点'),'cms.modifyNode');
	    END IF;
	end if;

/* 角色权限添加 */
	/*暴力清除权限*/
	delete from `wg_rolesaction` where nodeid = p_roles_cid and actionCid in (select cid from `wg_action` where paramJson like CONCAT('{alias:"',p_alias,'"}'));
	set p_actionOperateNum = substring(p_actionOperate,1,1);
	if p_actionOperateNum = '1' then
	    select cid into p_action_cid from `wg_action` where serviceName = 'cms.addContent' and paramJson like CONCAT('{alias:"',p_alias,'"}');
	    insert into wg_rolesaction(alias,actionCid,nodeid) values('rolesAction',p_action_cid,p_roles_cid);
	end if;

	SET p_actionOperateNum = SUBSTRING(p_actionOperate,2,1);
	IF p_actionOperateNum = '1' THEN
	    SELECT cid INTO p_action_cid FROM `wg_action` WHERE serviceName = 'cms.deleteContent' AND paramJson LIKE CONCAT('{alias:"',p_alias,'"}');
	    INSERT INTO wg_rolesaction(alias,actionCid,nodeid) VALUES('rolesAction',p_action_cid,p_roles_cid);
	END IF;

	SET p_actionOperateNum = SUBSTRING(p_actionOperate,3,1);
	IF p_actionOperateNum = '1' THEN
	    SELECT cid INTO p_action_cid FROM `wg_action` WHERE serviceName = 'cms.modifyContent' AND paramJson LIKE CONCAT('{alias:"',p_alias,'"}');
	    INSERT INTO wg_rolesaction(alias,actionCid,nodeid) VALUES('rolesAction',p_action_cid,p_roles_cid);
	END IF;

	SET p_actionOperateNum = SUBSTRING(p_actionOperate,4,1);
	IF p_actionOperateNum = '1' THEN
	    SELECT cid INTO p_action_cid FROM `wg_action` WHERE serviceName = 'cms.queryContent' AND paramJson LIKE CONCAT('{alias:"',p_alias,'"}');
	    INSERT INTO wg_rolesaction(alias,actionCid,nodeid) VALUES('rolesAction',p_action_cid,p_roles_cid);
	END IF;

	/*判断是否添加节点操作权限*/
	IF ifAddNode = 1 THEN
		SET p_actionOperateNum = SUBSTRING(p_actionOperate,5,1);
		IF p_actionOperateNum = '1' THEN
		    SELECT cid INTO p_action_cid FROM `wg_action` WHERE serviceName = 'cms.addNode' AND paramJson LIKE CONCAT('{alias:"',p_alias,'"}');
		    INSERT INTO wg_rolesaction(alias,actionCid,nodeid) VALUES('rolesAction',p_action_cid,p_roles_cid);
		END IF;

		SET p_actionOperateNum = SUBSTRING(p_actionOperate,6,1);
		IF p_actionOperateNum = '1' THEN
		    SELECT cid INTO p_action_cid FROM `wg_action` WHERE serviceName = 'cms.deleteNode' AND paramJson LIKE CONCAT('{alias:"',p_alias,'"}');
		    INSERT INTO wg_rolesaction(alias,actionCid,nodeid) VALUES('rolesAction',p_action_cid,p_roles_cid);
		END IF;

		SET p_actionOperateNum = SUBSTRING(p_actionOperate,7,1);
		IF p_actionOperateNum = '1' THEN
		    SELECT cid INTO p_action_cid FROM `wg_action` WHERE serviceName = 'cms.modifyNode' AND paramJson LIKE CONCAT('{alias:"',p_alias,'"}');
		    INSERT INTO wg_rolesaction(alias,actionCid,nodeid) VALUES('rolesAction',p_action_cid,p_roles_cid);
		END IF;
	end if;
    END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `insertCardByNumber`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insertCardByNumber`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCardByNumber`(in p_cardType int,in p_cardBatch varchar(100) ,
in p_cardNumber int,in p_validDate LONG,in p_money varchar(100))
BEGIN
	declare i int;
  set i=0;
	WHILE i<p_cardNumber DO
		SET i=i+1;
		INSERT INTO wg_chargecard (cardType,cardBatch,validDate,cardId,`password`,`money`) values
		(p_cardType,p_cardBatch,p_validDate,CONCAT(p_cardBatch,i),ROUND(ROUND(RAND(),5)*100000000),p_money);

	END WHILE;
END
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
