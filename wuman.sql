/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50615
 Source Host           : localhost
 Source Database       : wuman

 Target Server Type    : MySQL
 Target Server Version : 50615
 File Encoding         : utf-8

 Date: 04/18/2015 11:37:01 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `cmsmetadata`
-- ----------------------------
BEGIN;
INSERT INTO `cmsmetadata` VALUES ('1', '{\"tableName\":{\"title\":\"表名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"1\",\"order\":\"50\"},\"displayName\":{\"title\":\"模型名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"parentAlias\":{\"title\":\"挂接模型\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataRefresh\":{\"title\":\"数据刷新\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataDesc\":{\"title\":\"数据描述\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"20480\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"dataOwnerSet\":{\"title\":\"数据权限设置\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"dataOwner\":{\"title\":\"数据所有者\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'channel', 'cmsmetadata', '数据模型', 'channelClass', '', '', null, '1', ''), ('2', '{\"displayName\":{\"title\":\"分类名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'channelClass', 'wg_channelclass', '模型分类', '', '', '', null, '1', ''), ('3', '{\"name\":{\"title\":\"参数名\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"value\":{\"title\":\"参数值\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"128\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsconfig', 'wg_cmsconfig', 'cms系统配置', '', '', '', '1384485152128', '1', ''), ('4', '{\"keyname\":{\"title\":\"视图类型\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"40\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"列表页为list，详情页为detail\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateid\":{\"title\":\"模板索引\",\"type\":\"OuterLink\",\"fieldType\":\"int\",\"ourterLink\":\"cmsviewtemplate.cid\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"tmpname\":{\"title\":\"模板地址\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"cmsviewtemplate.templateurl\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"tmpurl\":{\"title\":\"模板视图\",\"type\":\"File\",\"fieldType\":\"ourterField\",\"ourterLink\":\"cmsviewtemplate.templateimg\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsview', 'wg_cmsview', 'CMS视图配置', 'channel', '', '', null, '1', ''), ('5', '{\"name\":{\"title\":\"模板名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateurl\":{\"title\":\"模板地址\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"templateimg\":{\"title\":\"模板图片\",\"type\":\"File\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'cmsviewtemplate', 'wg_cmsviewtemplate', '视图模板', '', '', '', null, '1', ''), ('6', '{\"actionName\":{\"title\":\"权限名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"1\"},\"serviceName\":{\"title\":\"服务名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"40\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"2\"},\"paramJson\":{\"title\":\"权限参数\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"1024\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"3\"}}', 'action', 'wg_action', '权限定义', '', '', '', null, '1', ''), ('7', '{\"actionCid\":{\"title\":\"权限ID\",\"type\":\"OuterLink\",\"fieldType\":\"int\",\"ourterLink\":\"action.cid\",\"fieldLen\":\"11\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"\"},\"actionDisplayName\":{\"title\":\"角色名称\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"action.actionName\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"\"}}', 'rolesAction', 'wg_rolesaction', '角色权限', 'roles', '', '', null, '1', ''), ('8', '{\"displayName\":{\"title\":\"角色名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"1\"},\"name\":{\"title\":\"角色标识\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"256\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"2\"}}', 'roles', 'wg_roles', '角色定义', '', '', '', null, '1', ''), ('9', '{\"statusAlias\":{\"title\":\"状态别名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"statusName\":{\"title\":\"状态名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'statusinfo', 'wg_statusinfo', '状态信息', '', '', '', null, '1', ''), ('10', '{\"actionName\":{\"title\":\"动作名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"serviceName\":{\"title\":\"服务名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"nextStatusCid\":{\"title\":\"选择下一状态\",\"type\":\"OuterLink\",\"fieldType\":\"varchar\",\"ourterLink\":\"statusinfo.cid\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"nextStatusName\":{\"title\":\"下一状态名称\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"statusinfo.statusName\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'statusaction', 'wg_statusaction', '状态动作', 'statusinfo', '', '', null, '1', ''), ('32', '{\"account\":{\"title\":\"账号\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"password\":{\"title\":\"密码\",\"type\":\"Hidden\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"20\"},\"name\":{\"title\":\"姓名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"phone\":{\"title\":\"手机\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"email\":{\"title\":\"邮件\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"role\":{\"title\":\"角色\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"}}', 'administrator', 'wg_administrator', '管理员', '', '', null, null, '3', ''), ('33', '{\"nick\":{\"title\":\"用户昵称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"checkers\":\"\\\\S+\",\"failTips\":\"姓名不能为空\"}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"phone\":{\"title\":\"绑定手机号\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"password\":{\"title\":\"用户密码\",\"type\":\"Hidden\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"30\"},\"fullname\":{\"title\":\"用户真实姓名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"address\":{\"title\":\"详细地址\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"sex\":{\"title\":\"性别\",\"type\":\"Select\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"女\":0,\"男\":1}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"60\"},\"birthday\":{\"title\":\"生日\",\"type\":\"DatePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"70\"},\"email\":{\"title\":\"邮箱\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"80\"},\"pic\":{\"title\":\"头像url\",\"type\":\"File\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"90\"},\"ref_user_id\":{\"title\":\"推荐人ID\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"100\"},\"useractive\":{\"title\":\"注册方式\",\"type\":\"Select\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"手机注册\":1}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"110\"},\"user_tag\":{\"title\":\"用户标签\",\"type\":\"Select\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"买家会员\":1,\"运营\":2}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"120\"},\"addtime\":{\"title\":\"注册时间\",\"type\":\"DatePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"130\"}}', 'user', 'wm_users', '会员管理', '', '', null, null, '3', ''), ('37', '{\"user_id\":{\"title\":\"用户ID\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"province\":{\"title\":\"省\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"city\":{\"title\":\"市\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"district\":{\"title\":\"区\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"address\":{\"title\":\"详细地址\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"full_name\":{\"title\":\"姓名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"},\"phone\":{\"title\":\"电话\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"70\"},\"isdefault\":{\"title\":\"是否默认\",\"type\":\"Select\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"非默认\":0,\"默认\":1}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"80\"},\"addtime\":{\"title\":\"添加时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"90\"}}', 'address', 'wm_address', '收获地址管理', 'user', '', null, null, '3', ''), ('38', '{\"buyer_id\":{\"title\":\"购买者ID\",\"type\":\"ReadOnly\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"activity_id\":{\"title\":\"活动ID\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"attributes\":{\"title\":\"折扣信息\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"25\"},\"item_id\":{\"title\":\"商品ID\",\"type\":\"Hidden\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"30\"},\"item_title\":{\"title\":\"商品标题\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"category\":{\"title\":\"商品类目\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"50\"},\"item_sku\":{\"title\":\"商品规格\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"60\"},\"buy_num\":{\"title\":\"购买数量\",\"type\":\"ReadOnly\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"70\"},\"ori_price\":{\"title\":\"商品价格\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"80\"},\"pay_price\":{\"title\":\"成交价格\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"90\"},\"status\":{\"title\":\"成交状态\",\"type\":\"Select\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"待付款\":1,\"已发货\":2,\"退款中\":3,\"已退款\":4}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"100\"},\"pay_time\":{\"title\":\"付款时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"110\"},\"send_time\":{\"title\":\"发货时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"120\"},\"memo\":{\"title\":\"买家备注\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"130\"},\"reason\":{\"title\":\"退款原因\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"140\"},\"snap_id\":{\"title\":\"商品快照ID\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"150\"},\"buyer_address\":{\"title\":\"收获地址\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"160\"},\"sender_address\":{\"title\":\"发货地址\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"170\"},\"send_type\":{\"title\":\"配送方式\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"0\",\"issearch\":\"0\",\"order\":\"180\"},\"send_id\":{\"title\":\"配送单号\",\"type\":\"ReadOnly\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"190\"},\"addtime\":{\"title\":\"下单时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"200\"}}', 'order', 'wm_order', '订单管理', '', '', null, null, '3', ''), ('39', '{\"user_id\":{\"title\":\"用户ID\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"item_id\":{\"title\":\"商品ID\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"}}', 'collects', 'wm_user_collects', '收藏管理', '', '', null, null, '3', ''), ('40', '{\"cat_name\":{\"title\":\"类目名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"season_type\":{\"title\":\"季节类型\",\"type\":\"Select\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"无季节信息\":0,\"春季\":1,\"夏季\":2,\"秋季\":3,\"冬季\":4}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"cat_img\":{\"title\":\"类目图片\",\"type\":\"File\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"cat_pro\":{\"title\":\"sku属性\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"addtime\":{\"title\":\"添加时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'category', 'wm_category', '商品类目管理', '', '', null, null, '3', ''), ('41', '{\"title\":{\"title\":\"商品名\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"price\":{\"title\":\"价格\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"dazhe_price\":{\"title\":\"打折价\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"goods_img\":{\"title\":\"商品图片\",\"type\":\"File\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"other_img\":{\"title\":\"其他图片\",\"type\":\"Pics\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"5000\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"},\"quantity\":{\"title\":\"库存\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"70\"},\"status\":{\"title\":\"商品状态\",\"type\":\"Select\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"在线\":0,\"下架\":1}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"80\"},\"good_desc\":{\"title\":\"商品描述\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"1000\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"90\"},\"huo_str\":{\"title\":\"货号\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"100\"},\"caizhi\":{\"title\":\"材质\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"110\"},\"feature\":{\"title\":\"属性扩展\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"120\"},\"act_id\":{\"title\":\"活动ID\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"130\"},\"addtime\":{\"title\":\"添加时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"140\"}}', 'goods', 'wm_goods', '商品管理', 'category', '', null, null, '3', ''), ('42', '{\"item_id\":{\"title\":\"商品ID\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"sku_num\":{\"title\":\"库存\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"sku_price\":{\"title\":\"商品价格\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"seller_bianma\":{\"title\":\"商家编码\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"sku_pro\":{\"title\":\"扩展属性\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"addtime\":{\"title\":\"添加时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"}}', 'sku', 'wm_sku', '商品SKU管理', '', '', null, null, '3', ''), ('43', '{\"title\":{\"title\":\"活动名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"pic\":{\"title\":\"活动主图\",\"type\":\"File\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"start_time\":{\"title\":\"活动开始时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"end_time\":{\"title\":\"活动结束时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"range_type\":{\"title\":\"作用类型\",\"type\":\"Select\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":[{\"商品\":1,\"类目\":1}],\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"range_ids\":{\"title\":\"作用Ids\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"},\"limit_num\":{\"title\":\"限购数量\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"70\"},\"discount\":{\"title\":\"折扣\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"80\"},\"features\":{\"title\":\"扩展字段\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"90\"},\"operator\":{\"title\":\"操作人\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"100\"},\"addtime\":{\"title\":\"添加时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"110\"}}', 'activities', 'wm_activities', '活动管理', '', '', null, null, '3', ''), ('44', '{\"title\":{\"title\":\"类型名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"}}', 'activity_type', 'wm_activity_type', '活动类型管理', '', '', null, null, '3', ''), ('45', '{\"title\":{\"title\":\"活动名称\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"total_money\":{\"title\":\"红包总额\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"money_features\":{\"title\":\"红包面值\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"use_range\":{\"title\":\"使用范围\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"activity_type\":{\"title\":\"活动类型\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"},\"category\":{\"title\":\"作用类目\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"60\"},\"get_rule\":{\"title\":\"获取规则ID\",\"type\":\"Text\",\"fieldType\":\"int\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"70\"},\"rule_feature\":{\"title\":\"规则解释\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"80\"},\"features\":{\"title\":\"扩展字段\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"90\"},\"operator\":{\"title\":\"操作人\",\"type\":\"Text\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"100\"},\"addtime\":{\"title\":\"添加时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"110\"}}', 'voucher', 'wm_voucher', '抵用券管理', '', '', null, null, '3', ''), ('46', '{\"user_id\":{\"title\":\"用户ID\",\"type\":\"OuterLink\",\"fieldType\":\"int\",\"ourterLink\":\"user.cid\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"10\"},\"user_name\":{\"title\":\"用户姓名\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"user.fullname\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"20\"},\"user_phone\":{\"title\":\"用户手机\",\"type\":\"ReadOnly\",\"fieldType\":\"ourterField\",\"ourterLink\":\"user.phone\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"30\"},\"content\":{\"title\":\"反馈内容\",\"type\":\"TextArea\",\"fieldType\":\"varchar\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"40\"},\"addtime\":{\"title\":\"反馈时间\",\"type\":\"DateTimePicker\",\"fieldType\":\"bigint\",\"ourterLink\":\"\",\"fieldLen\":\"\",\"dataExt\":\"\",\"valueRange\":\"\",\"desc\":\"\",\"width\":\"\",\"fieldtmp\":\"\",\"islist\":\"1\",\"issearch\":\"0\",\"order\":\"50\"}}', 'feedback', 'wm_feedback', '用户反馈管理', '', '', null, null, '3', '');
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
) ENGINE=MyISAM AUTO_INCREMENT=595 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wg_action`
-- ----------------------------
BEGIN;
INSERT INTO `wg_action` VALUES ('{alias:\"administrator\"}', 'action', '查询管理员', null, '511', 'cms.queryContent', null, null), ('{alias:\"administrator\"}', 'action', '新增管理员', null, '512', 'cms.addContent', null, null), ('{alias:\"administrator\"}', 'action', '修改管理员', null, '513', 'cms.modifyContent', null, null), ('{alias:\"administrator\"}', 'action', '删除管理员', null, '514', 'cms.deleteContent', null, null), ('{alias:\"administrator\"}', 'action', '新增管理员节点', null, '515', 'cms.addNode', null, null), ('{alias:\"administrator\"}', 'action', '修改管理员节点', null, '516', 'cms.modifyNode', null, null), ('{alias:\"administrator\"}', 'action', '删除管理员节点', null, '517', 'cms.deleteNode', null, null), ('{alias:\"user\"}', 'action', '查询会员管理', null, '518', 'cms.queryContent', null, null), ('{alias:\"user\"}', 'action', '新增会员管理', null, '519', 'cms.addContent', null, null), ('{alias:\"user\"}', 'action', '修改会员管理', null, '520', 'cms.modifyContent', null, null), ('{alias:\"user\"}', 'action', '删除会员管理', null, '521', 'cms.deleteContent', null, null), ('{alias:\"user\"}', 'action', '新增会员管理节点', null, '522', 'cms.addNode', null, null), ('{alias:\"user\"}', 'action', '修改会员管理节点', null, '523', 'cms.modifyNode', null, null), ('{alias:\"user\"}', 'action', '删除会员管理节点', null, '524', 'cms.deleteNode', null, null), ('{alias:\"address\"}', 'action', '查询收获地址', null, '525', 'cms.queryContent', null, null), ('{alias:\"address\"}', 'action', '新增收获地址', null, '526', 'cms.addContent', null, null), ('{alias:\"address\"}', 'action', '修改收获地址', null, '527', 'cms.modifyContent', null, null), ('{alias:\"address\"}', 'action', '删除收获地址', null, '528', 'cms.deleteContent', null, null), ('{alias:\"address\"}', 'action', '新增收获地址节点', null, '529', 'cms.addNode', null, null), ('{alias:\"address\"}', 'action', '修改收获地址节点', null, '530', 'cms.modifyNode', null, null), ('{alias:\"address\"}', 'action', '删除收获地址节点', null, '531', 'cms.deleteNode', null, null), ('{alias:\"trade\"}', 'action', '查询订单管理', null, '532', 'cms.queryContent', null, null), ('{alias:\"trade\"}', 'action', '新增订单管理', null, '533', 'cms.addContent', null, null), ('{alias:\"trade\"}', 'action', '修改订单管理', null, '534', 'cms.modifyContent', null, null), ('{alias:\"trade\"}', 'action', '删除订单管理', null, '535', 'cms.deleteContent', null, null), ('{alias:\"trade\"}', 'action', '新增订单管理节点', null, '536', 'cms.addNode', null, null), ('{alias:\"trade\"}', 'action', '修改订单管理节点', null, '537', 'cms.modifyNode', null, null), ('{alias:\"trade\"}', 'action', '删除订单管理节点', null, '538', 'cms.deleteNode', null, null), ('{alias:\"collects\"}', 'action', '查询收藏管理', null, '539', 'cms.queryContent', null, null), ('{alias:\"collects\"}', 'action', '新增收藏管理', null, '540', 'cms.addContent', null, null), ('{alias:\"collects\"}', 'action', '修改收藏管理', null, '541', 'cms.modifyContent', null, null), ('{alias:\"collects\"}', 'action', '删除收藏管理', null, '542', 'cms.deleteContent', null, null), ('{alias:\"collects\"}', 'action', '新增收藏管理节点', null, '543', 'cms.addNode', null, null), ('{alias:\"collects\"}', 'action', '修改收藏管理节点', null, '544', 'cms.modifyNode', null, null), ('{alias:\"collects\"}', 'action', '删除收藏管理节点', null, '545', 'cms.deleteNode', null, null), ('{alias:\"category\"}', 'action', '查询商品类目', null, '546', 'cms.queryContent', null, null), ('{alias:\"category\"}', 'action', '新增商品类目', null, '547', 'cms.addContent', null, null), ('{alias:\"category\"}', 'action', '修改商品类目', null, '548', 'cms.modifyContent', null, null), ('{alias:\"category\"}', 'action', '删除商品类目', null, '549', 'cms.deleteContent', null, null), ('{alias:\"category\"}', 'action', '新增商品类目节点', null, '550', 'cms.addNode', null, null), ('{alias:\"category\"}', 'action', '修改商品类目节点', null, '551', 'cms.modifyNode', null, null), ('{alias:\"category\"}', 'action', '删除商品类目节点', null, '552', 'cms.deleteNode', null, null), ('{alias:\"goods\"}', 'action', '查询商品管理', null, '553', 'cms.queryContent', null, null), ('{alias:\"goods\"}', 'action', '新增商品管理', null, '554', 'cms.addContent', null, null), ('{alias:\"goods\"}', 'action', '修改商品管理', null, '555', 'cms.modifyContent', null, null), ('{alias:\"goods\"}', 'action', '删除商品管理', null, '556', 'cms.deleteContent', null, null), ('{alias:\"goods\"}', 'action', '新增商品管理节点', null, '557', 'cms.addNode', null, null), ('{alias:\"goods\"}', 'action', '修改商品管理节点', null, '558', 'cms.modifyNode', null, null), ('{alias:\"goods\"}', 'action', '删除商品管理节点', null, '559', 'cms.deleteNode', null, null), ('{alias:\"sku\"}', 'action', '查询商品SKU管理', null, '560', 'cms.queryContent', null, null), ('{alias:\"sku\"}', 'action', '新增商品SKU管理', null, '561', 'cms.addContent', null, null), ('{alias:\"sku\"}', 'action', '修改商品SKU管理', null, '562', 'cms.modifyContent', null, null), ('{alias:\"sku\"}', 'action', '删除商品SKU管理', null, '563', 'cms.deleteContent', null, null), ('{alias:\"sku\"}', 'action', '新增商品SKU管理节点', null, '564', 'cms.addNode', null, null), ('{alias:\"sku\"}', 'action', '修改商品SKU管理节点', null, '565', 'cms.modifyNode', null, null), ('{alias:\"sku\"}', 'action', '删除商品SKU管理节点', null, '566', 'cms.deleteNode', null, null), ('{alias:\"activities\"}', 'action', '查询活动管理', null, '567', 'cms.queryContent', null, null), ('{alias:\"activities\"}', 'action', '新增活动管理', null, '568', 'cms.addContent', null, null), ('{alias:\"activities\"}', 'action', '修改活动管理', null, '569', 'cms.modifyContent', null, null), ('{alias:\"activities\"}', 'action', '删除活动管理', null, '570', 'cms.deleteContent', null, null), ('{alias:\"activities\"}', 'action', '新增活动管理节点', null, '571', 'cms.addNode', null, null), ('{alias:\"activities\"}', 'action', '修改活动管理节点', null, '572', 'cms.modifyNode', null, null), ('{alias:\"activities\"}', 'action', '删除活动管理节点', null, '573', 'cms.deleteNode', null, null), ('{alias:\"activity_type\"}', 'action', '查询活动类型管理', null, '574', 'cms.queryContent', null, null), ('{alias:\"activity_type\"}', 'action', '新增活动类型管理', null, '575', 'cms.addContent', null, null), ('{alias:\"activity_type\"}', 'action', '修改活动类型管理', null, '576', 'cms.modifyContent', null, null), ('{alias:\"activity_type\"}', 'action', '删除活动类型管理', null, '577', 'cms.deleteContent', null, null), ('{alias:\"activity_type\"}', 'action', '新增活动类型管理节点', null, '578', 'cms.addNode', null, null), ('{alias:\"activity_type\"}', 'action', '修改活动类型管理节点', null, '579', 'cms.modifyNode', null, null), ('{alias:\"activity_type\"}', 'action', '删除活动类型管理节点', null, '580', 'cms.deleteNode', null, null), ('{alias:\"voucher\"}', 'action', '查询抵用券管理', null, '581', 'cms.queryContent', null, null), ('{alias:\"voucher\"}', 'action', '新增抵用券管理', null, '582', 'cms.addContent', null, null), ('{alias:\"voucher\"}', 'action', '修改抵用券管理', null, '583', 'cms.modifyContent', null, null), ('{alias:\"voucher\"}', 'action', '删除抵用券管理', null, '584', 'cms.deleteContent', null, null), ('{alias:\"voucher\"}', 'action', '新增抵用券管理节点', null, '585', 'cms.addNode', null, null), ('{alias:\"voucher\"}', 'action', '修改抵用券管理节点', null, '586', 'cms.modifyNode', null, null), ('{alias:\"voucher\"}', 'action', '删除抵用券管理节点', null, '587', 'cms.deleteNode', null, null), ('{alias:\"feedback\"}', 'action', '查询用户反馈管理', null, '588', 'cms.queryContent', null, null), ('{alias:\"feedback\"}', 'action', '新增用户反馈管理', null, '589', 'cms.addContent', null, null), ('{alias:\"feedback\"}', 'action', '修改用户反馈管理', null, '590', 'cms.modifyContent', null, null), ('{alias:\"feedback\"}', 'action', '删除用户反馈管理', null, '591', 'cms.deleteContent', null, null), ('{alias:\"feedback\"}', 'action', '新增用户反馈管理节点', null, '592', 'cms.addNode', null, null), ('{alias:\"feedback\"}', 'action', '修改用户反馈管理节点', null, '593', 'cms.modifyNode', null, null), ('{alias:\"feedback\"}', 'action', '删除用户反馈管理节点', null, '594', 'cms.deleteNode', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `wg_administrator`
-- ----------------------------
DROP TABLE IF EXISTS `wg_administrator`;
CREATE TABLE `wg_administrator` (
  `phone` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `account` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `role` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `wg_administrator`
-- ----------------------------
BEGIN;
INSERT INTO `wg_administrator` VALUES ('18268041810', '76174227@qq.com', 'administrator', 'admin', 'admin', 'adminManager', 'dedcd0d685a85a58bc76b5f1b57fe03c', '1428131995355', '1', null, null);
COMMIT;

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
INSERT INTO `wg_channelclass` VALUES ('channelClass', 'CMS', '1384385867346', '1', null, '0'), ('channelClass', '业务表', '1428126224376', '3', null, '0');
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
INSERT INTO `wg_cmsconfig` VALUES ('cmsconfig', '预算人均标准', '40', '1417658141241', '1', null, '0'), ('cmsconfig', '活动名称', '11.11大促活动', '1417658128600', '2', null, '0'), ('cmsconfig', '活动开关－设置1开启，0关闭', '1', '1417837788262', '3', null, '0');
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
) ENGINE=MyISAM AUTO_INCREMENT=1246 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wg_rolesaction`
-- ----------------------------
BEGIN;
INSERT INTO `wg_rolesaction` VALUES ('rolesAction', '594', null, '1245', null, '1'), ('rolesAction', '593', null, '1244', null, '1'), ('rolesAction', '592', null, '1243', null, '1'), ('rolesAction', '591', null, '1242', null, '1'), ('rolesAction', '590', null, '1241', null, '1'), ('rolesAction', '589', null, '1240', null, '1'), ('rolesAction', '588', null, '1239', null, '1'), ('rolesAction', '587', null, '1238', null, '1'), ('rolesAction', '586', null, '1237', null, '1'), ('rolesAction', '585', null, '1236', null, '1'), ('rolesAction', '584', null, '1235', null, '1'), ('rolesAction', '583', null, '1234', null, '1'), ('rolesAction', '582', null, '1233', null, '1'), ('rolesAction', '581', null, '1232', null, '1'), ('rolesAction', '580', null, '1231', null, '1'), ('rolesAction', '579', null, '1230', null, '1'), ('rolesAction', '578', null, '1229', null, '1'), ('rolesAction', '577', null, '1228', null, '1'), ('rolesAction', '576', null, '1227', null, '1'), ('rolesAction', '575', null, '1226', null, '1'), ('rolesAction', '574', null, '1225', null, '1'), ('rolesAction', '573', null, '1224', null, '1'), ('rolesAction', '572', null, '1223', null, '1'), ('rolesAction', '571', null, '1222', null, '1'), ('rolesAction', '570', null, '1221', null, '1'), ('rolesAction', '569', null, '1220', null, '1'), ('rolesAction', '568', null, '1219', null, '1'), ('rolesAction', '567', null, '1218', null, '1'), ('rolesAction', '566', null, '1217', null, '1'), ('rolesAction', '565', null, '1216', null, '1'), ('rolesAction', '564', null, '1215', null, '1'), ('rolesAction', '563', null, '1214', null, '1'), ('rolesAction', '562', null, '1213', null, '1'), ('rolesAction', '561', null, '1212', null, '1'), ('rolesAction', '560', null, '1211', null, '1'), ('rolesAction', '559', null, '1210', null, '1'), ('rolesAction', '558', null, '1209', null, '1'), ('rolesAction', '557', null, '1208', null, '1'), ('rolesAction', '556', null, '1207', null, '1'), ('rolesAction', '555', null, '1206', null, '1'), ('rolesAction', '554', null, '1205', null, '1'), ('rolesAction', '553', null, '1204', null, '1'), ('rolesAction', '552', null, '1203', null, '1'), ('rolesAction', '551', null, '1202', null, '1'), ('rolesAction', '550', null, '1201', null, '1'), ('rolesAction', '549', null, '1200', null, '1'), ('rolesAction', '548', null, '1199', null, '1'), ('rolesAction', '547', null, '1198', null, '1'), ('rolesAction', '546', null, '1197', null, '1'), ('rolesAction', '545', null, '1196', null, '1'), ('rolesAction', '544', null, '1195', null, '1'), ('rolesAction', '543', null, '1194', null, '1'), ('rolesAction', '542', null, '1193', null, '1'), ('rolesAction', '541', null, '1192', null, '1'), ('rolesAction', '540', null, '1191', null, '1'), ('rolesAction', '539', null, '1190', null, '1'), ('rolesAction', '538', null, '1189', null, '1'), ('rolesAction', '537', null, '1188', null, '1'), ('rolesAction', '536', null, '1187', null, '1'), ('rolesAction', '535', null, '1186', null, '1'), ('rolesAction', '534', null, '1185', null, '1'), ('rolesAction', '533', null, '1184', null, '1'), ('rolesAction', '532', null, '1183', null, '1'), ('rolesAction', '531', null, '1182', null, '1'), ('rolesAction', '530', null, '1181', null, '1'), ('rolesAction', '529', null, '1180', null, '1'), ('rolesAction', '528', null, '1179', null, '1'), ('rolesAction', '527', null, '1178', null, '1'), ('rolesAction', '526', null, '1177', null, '1'), ('rolesAction', '525', null, '1176', null, '1'), ('rolesAction', '524', null, '1175', null, '1'), ('rolesAction', '523', null, '1174', null, '1'), ('rolesAction', '522', null, '1173', null, '1'), ('rolesAction', '521', null, '1172', null, '1'), ('rolesAction', '520', null, '1171', null, '1'), ('rolesAction', '519', null, '1170', null, '1'), ('rolesAction', '518', null, '1169', null, '1'), ('rolesAction', '517', null, '1168', null, '1'), ('rolesAction', '516', null, '1167', null, '1'), ('rolesAction', '515', null, '1166', null, '1'), ('rolesAction', '514', null, '1165', null, '1'), ('rolesAction', '513', null, '1164', null, '1'), ('rolesAction', '512', null, '1163', null, '1'), ('rolesAction', '511', null, '1162', null, '1');
COMMIT;

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
--  Table structure for `wm_activities`
-- ----------------------------
DROP TABLE IF EXISTS `wm_activities`;
CREATE TABLE `wm_activities` (
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `range_ids` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `pic` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `discount` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `features` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `range_type` int(11) DEFAULT NULL,
  `start_time` bigint(20) DEFAULT NULL,
  `limit_num` int(11) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_activity_type`
-- ----------------------------
DROP TABLE IF EXISTS `wm_activity_type`;
CREATE TABLE `wm_activity_type` (
  `title` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_address`
-- ----------------------------
DROP TABLE IF EXISTS `wm_address`;
CREATE TABLE `wm_address` (
  `phone` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `isdefault` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  `address` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `province` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `district` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `full_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_category`
-- ----------------------------
DROP TABLE IF EXISTS `wm_category`;
CREATE TABLE `wm_category` (
  `addtime` bigint(20) DEFAULT NULL,
  `cat_pro` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `season_type` int(11) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `cat_img` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `wm_feedback`;
CREATE TABLE `wm_feedback` (
  `content` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_goods`
-- ----------------------------
DROP TABLE IF EXISTS `wm_goods`;
CREATE TABLE `wm_goods` (
  `huo_str` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `act_id` int(11) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `goods_img` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `other_img` varchar(5000) COLLATE utf8_bin DEFAULT NULL,
  `good_desc` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  `title` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `caizhi` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `dazhe_price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `feature` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_order`
-- ----------------------------
DROP TABLE IF EXISTS `wm_order`;
CREATE TABLE `wm_order` (
  `memo` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `reason` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `sender_address` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `send_type` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  `send_time` bigint(20) DEFAULT NULL,
  `buyer_address` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `buyer_id` int(11) DEFAULT NULL,
  `send_id` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `activity_id` int(11) DEFAULT NULL,
  `status` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `item_title` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `snap_id` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `pay_time` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `item_sku` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `ori_price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `category` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `buy_num` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `attributes` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `pay_price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_sku`
-- ----------------------------
DROP TABLE IF EXISTS `wm_sku`;
CREATE TABLE `wm_sku` (
  `sku_pro` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `sku_num` int(11) DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  `sku_price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `seller_bianma` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_trade`
-- ----------------------------
DROP TABLE IF EXISTS `wm_trade`;
CREATE TABLE `wm_trade` (
  `memo` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `reason` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `sender_address` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `send_type` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  `send_time` bigint(20) DEFAULT NULL,
  `buyer_address` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `buyer_id` int(11) DEFAULT NULL,
  `send_id` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `activity_id` int(11) DEFAULT NULL,
  `status` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `item_title` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `snap_id` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `pay_time` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `item_sku` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `ori_price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `category` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `buy_num` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `attributes` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `pay_price` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_user_collects`
-- ----------------------------
DROP TABLE IF EXISTS `wm_user_collects`;
CREATE TABLE `wm_user_collects` (
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `wm_users`
-- ----------------------------
DROP TABLE IF EXISTS `wm_users`;
CREATE TABLE `wm_users` (
  `useractive` int(11) DEFAULT NULL,
  `birthday` bigint(20) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `phone` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `pic` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `user_tag` int(11) DEFAULT NULL,
  `password` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) DEFAULT NULL,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `nick` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `fullname` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `ref_user_id` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `wm_users`
-- ----------------------------
BEGIN;
INSERT INTO `wm_users` VALUES ('1', '1428132543087', '1', '13751012011', 'user', 'upload/20150404/1428131650824.jpg', '1', '', '4', '0', null, 'alec', '', '杭州西湖二十八', '1428132543091', '张三丰', '阿萨德发', '1428132543088');
COMMIT;

-- ----------------------------
--  Table structure for `wm_voucher`
-- ----------------------------
DROP TABLE IF EXISTS `wm_voucher`;
CREATE TABLE `wm_voucher` (
  `alias` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `get_rule` int(11) DEFAULT NULL,
  `nodeid` int(11) DEFAULT NULL,
  `dataOwner` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `addtime` bigint(20) DEFAULT NULL,
  `category` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `money_features` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `rule_feature` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `features` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `use_range` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `opertime` bigint(20) DEFAULT NULL,
  `activity_type` int(11) DEFAULT NULL,
  `total_money` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  View structure for `judd_orderdesc_view`
-- ----------------------------
DROP VIEW IF EXISTS `judd_orderdesc_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `judd_orderdesc_view` AS select `product`.`price` AS `pprice`,`orderdesc`.`pnum` AS `pnum`,`orderdesc`.`alias` AS `alias`,`product`.`unit` AS `punit`,`product`.`name` AS `pname`,`product`.`cid` AS `pid`,`orderdesc`.`opertime` AS `opertime`,`orderdesc`.`cid` AS `cid`,`orderdesc`.`dataOwner` AS `dataOwner`,`orderdesc`.`nodeid` AS `nodeid` from (`judd_orderdesc` `orderdesc` left join `judd_product` `product` on((`orderdesc`.`pid` = `product`.`cid`)));

-- ----------------------------
--  View structure for `wg_cmsview_view`
-- ----------------------------
DROP VIEW IF EXISTS `wg_cmsview_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wg_cmsview_view` AS select `cmsview`.`alias` AS `alias`,`cmsviewtemplate`.`cid` AS `templateid`,`cmsview`.`keyname` AS `keyname`,`cmsview`.`opertime` AS `opertime`,`cmsview`.`cid` AS `cid`,`cmsviewtemplate`.`templateimg` AS `tmpurl`,`cmsviewtemplate`.`templateurl` AS `tmpname`,`cmsview`.`dataOwner` AS `dataOwner`,`cmsview`.`nodeid` AS `nodeid` from (`wg_cmsview` `cmsview` left join `wg_cmsviewtemplate` `cmsviewtemplate` on((`cmsview`.`templateid` = `cmsviewtemplate`.`cid`)));

-- ----------------------------
--  View structure for `wg_rolesaction_view`
-- ----------------------------
DROP VIEW IF EXISTS `wg_rolesaction_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wg_rolesaction_view` AS select `rolesAction`.`alias` AS `alias`,`action`.`cid` AS `actionCid`,`rolesAction`.`opertime` AS `opertime`,`rolesAction`.`cid` AS `cid`,`action`.`actionName` AS `actionDisplayName`,`rolesAction`.`dataOwner` AS `dataOwner`,`rolesAction`.`nodeid` AS `nodeid` from (`wg_rolesaction` `rolesAction` left join `wg_action` `action` on((`rolesAction`.`actionCid` = `action`.`cid`)));

-- ----------------------------
--  View structure for `wg_statusaction_view`
-- ----------------------------
DROP VIEW IF EXISTS `wg_statusaction_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wg_statusaction_view` AS select `statusinfo`.`statusName` AS `nextStatusName`,`statusaction`.`alias` AS `alias`,`statusaction`.`actionName` AS `actionName`,`statusinfo`.`cid` AS `nextStatusCid`,`statusaction`.`opertime` AS `opertime`,`statusaction`.`cid` AS `cid`,`statusaction`.`serviceName` AS `serviceName`,`statusaction`.`dataOwner` AS `dataOwner`,`statusaction`.`nodeid` AS `nodeid` from (`wg_statusaction` `statusaction` left join `wg_statusinfo` `statusinfo` on((`statusaction`.`nextStatusCid` = `statusinfo`.`cid`)));

-- ----------------------------
--  View structure for `wm_feedback_view`
-- ----------------------------
DROP VIEW IF EXISTS `wm_feedback_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wm_feedback_view` AS select `feedback`.`content` AS `content`,`user`.`fullname` AS `user_name`,`feedback`.`addtime` AS `addtime`,`feedback`.`alias` AS `alias`,`user`.`phone` AS `user_phone`,`user`.`cid` AS `user_id`,`feedback`.`opertime` AS `opertime`,`feedback`.`cid` AS `cid`,`feedback`.`dataOwner` AS `dataOwner`,`feedback`.`nodeid` AS `nodeid` from (`wm_feedback` `feedback` left join `wm_users` `user` on((`feedback`.`user_id` = `user`.`cid`)));

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
