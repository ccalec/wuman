/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name cmsMgrExtGadget
* @description  CMS后台内容操作视图的扩展函数Gadget
*/

define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	require("../breeze/framework/js/tools/Widget")(FW);
	require("../gadget/cmsMgrGadget"); //引入扩展函数
	FW.register(
		{
			param:{
				btnForList:{
					administrator:[{
						title:"设置密码",
						class:"btn btn-mini btn-pink",
						html:" <i class='icon-key bigger-120'> 设置密码</i>",
						onclick:"privateModPassword"
					},{
						title:"编辑",
						authority:"modifyContent",
						class:"btn btn-mini btn-info",
						style:"display:none",
						html:" <i class='icon-edit bigger-120'> 编辑</i>",
						onclick:"privateBtnConEdit"
					},{
						title:"删除",
						authority:"deleteContent",
						class:"btn btn-mini btn-danger",
						style:"display:none",
						html:" <i class='icon-trash bigger-120'> 删除</i>",
						onclick:"privateBtnConDel"
					}],
					user:[{
						title:"设置密码",
						class:"btn btn-mini btn-pink",
						html:" <i class='icon-key bigger-120'> 设置密码</i>",
						onclick:"privateModPassword"
					},{
						title:"编辑",
						authority:"modifyContent",
						class:"btn btn-mini btn-info",
						style:"display:none",
						html:" <i class='icon-edit bigger-120'> 编辑</i>",
						onclick:"privateBtnConEdit"
					},{
						title:"删除",
						authority:"deleteContent",
						class:"btn btn-mini btn-danger",
						style:"display:none",
						html:" <i class='icon-trash bigger-120'> 删除</i>",
						onclick:"privateBtnConDel"
					}]
				}
			},
			name:"cmsMgrExtGadget",
			extends:["cmsMgrGadget"],
			FireEvent:{
			},
			private:{
				// 修改密码
				privateModPassword:function(_dom,_data){
					var _this = this;
					//定义当前状态指针
					_this.MY.action = 'modPwd';
					//显示提交\返回按钮
					$("#submitBtn").show();
					//替换操作标题
					$("#actionName").text("密码修改");
					// 显示对应视图
					_data.password = _data.password || "密码尚未设置";
					_this.API.show('viewModPassword',_data);
				},
				privateSubmit_modPwd:function(){
					var _this = this;
					var uid = _this.API.find('#userid').val();
					var psd = _this.API.find('#password').val();
					var repsd = _this.API.find('#repassword').val();
					if(!psd || !repsd){
						FW.use('Widget').alert("密码输入不能为空");
						return;
					}
					if(psd!==repsd){
						FW.use('Widget').alert("两次密码输入不一致，请重新输入");
						_this.API.find('#password').val('');
						_this.API.find('#repassword').val('');
						return;
					}
					if(_this.MY.alias==='administrator'){
						var packageName = 'admin';
					}else{
						var packageName = 'customer';
					}
					_this.API.doServer("modifyPassword",packageName,{userid:uid,newPassword:psd},function(code,data){
						if(code==0 && data){
							FW.use('Widget').alert("密码修改成功");
							_this.API.private("privateShowConList");
						}else{
							$(this).html("修改失败，重新修改</i>");
						}
					})
				},
				privateSetRoles:function(_dom,_data){
					document.location.href = "rolesAction.jsp?nodeid="+_data.cid;
				},
				privateSetDescAndData: function(_alias,_data,_callback){
					var _this = this;
					if(_alias === 'category_property_values' && this.MY.sonAlias === 'category_property_values' && (this.MY.action==='conAdd'||this.MY.action==='conPLAdd')){
						if(this.MY.action==='conAdd') _data = [_data];
						$.each(_data, function(index,item){
							item.category_id = _this.MY.nodeid;
							item.property_id = _this.MY.cid;
							item.add_time = (new Date().getTime()).toString();
						});
						var desc = _this.MY.contentDesc[_alias];
						desc.category_id.type = 'Hidden';
						desc.category_name.type = 'Hidden';
						desc.property_id.type = 'Hidden';
						desc.property_name.type = 'Hidden';
					}
					_callback && _callback();
				}
			},
			TrigerEvent:{
				trigerSubmit: function(){
					var _this = this;
					//列表提交
					if(_this.MY.action == _this.MY.act.conList){
						_this.API.private("privateSubmitConList",function(){
							FW.use('Widget').alert("修改完成!");
							_this.API.private("privateShowConList");
						});
					}
					//内容添加
					else if(_this.MY.action == _this.MY.act.conAdd){
						_this.API.private("privateSubmitConAdd",function(){
							FW.use('Widget').alert("内容添加成功！");
							_this.API.private("privateShowConList");
						});
					}
					//内容批量添加
					else if(_this.MY.action == _this.MY.act.conPLAdd){
						_this.API.private("privateSubmitConPLAdd",function(){
							FW.use('Widget').alert("添加完成!");
							_this.API.private("privateShowConList");
						});
					}
					//编辑内容
					else if(_this.MY.action == _this.MY.act.conEdit){
						_this.API.private("privateSubmitConEdit",function(){
							FW.use('Widget').alert("保存成功！");
							_this.API.private("privateShowConList");
						});
					}
					//编辑栏目
					else if(_this.MY.action == _this.MY.act.classEdit){
						_this.API.private("privateSubmitClassEdit",function(){
							FW.use('Widget').alert("保存成功！");
							FW.trigerEvent('trigerReShowNodeTree',_this.MY.alias);
							_this.API.private("privateShowConList");
						});
					}
					//添加栏目
					else if(_this.MY.action == _this.MY.act.classAdd){
						_this.API.private("privateSubmitClassAdd",function(){
							FW.use('Widget').alert("栏目添加成功！");
							FW.trigerEvent('trigerReShowNodeTree',_this.MY.alias);
							_this.API.private("privateShowConList");
						});
					}
					//其他
					else{
						_this.API.private('privateSubmit_'+_this.MY.action);
					}
				},
				trigerGoBack: function(){
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					this.API.private("privateShowConList");
				}
			}
		}
	);
	return FW;
});

