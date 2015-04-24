/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://www.wgfly.com">Alec</a>
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
						alert("密码输入不能为空");
						return;
					}
					if(psd!==repsd){
						alert("两次密码输入不一致，请重新输入");
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
							alert("密码修改成功");
							_this.API.private("privateShowConList");
						}else{
							$(this).html("修改失败，重新修改</i>");
						}
					})
				},
				privateSetRoles:function(_dom,_data){
					document.location.href = "rolesAction.jsp?nodeid="+_data.cid;
				}
			},
			TrigerEvent:{
			}
		}
	);
	return FW;
});

