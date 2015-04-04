
define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	require("../gadget/cmsMgrGadget"); //引入扩展函数
	FW.register(
		{
			param:{
				btnForList:{
				}
			},
			name:"memberMgrExtGadget",
			extends:["cmsMgrGadget"],
			FireEvent:{
			},
			private:{
				privateMessConListOk: function(_data){
					// alert(FW.use().toJSONString(_data));
					for (var i = 0; i < _data.length; i++) {
						if(!parseInt(_data[i].scoresmonth)){
							this.API.find(".actionBtnForList .btn-success").eq(i).attr("disabled","disabled");
						}
					};
				},
				privateMessConEditOk: function(){
					var _this = this;
					_this.API.find(".f_password ._password_inp").attr("disabled","disabled").attr("type","password").next().html("<a class='btn btn-mini btn-info' id='modifyPsd' href='javascript:void(0)'>修改密码</a><a class='btn btn-mini btn-success' style='display:none' id='submitPsd' href='javascript:void(0)'>确认提交</a>");
					_this.API.find("#modifyPsd").click(function(){
						$(this).hide().next().show();
						_this.API.find(".f_password ._password_inp").removeAttr("disabled").attr("type","text").val("").focus();
					})
					_this.API.find("#submitPsd").click(function(){
						var psd = _this.API.find(".f_password ._password_inp").val();
						if(!psd) return;
						$(this).html("<i class='icon-spinner icon-spin orange bigger-125'></i> 修改中");
						_this.API.doServer("modifyPassword","customer",{userid:_this.MY.cid,newPassword:psd},function(code,data){
							if(code==0 && data){
								alert("密码修改成功");
								_this.API.private("privateShowConEdit");
							}else{
								$(this).html("修改失败，重新修改</i>");
							}
						})

					})
				},
				privateSubmitConAdd: function(_callback){
					var _this = this;
					//将表单转换成json
					var data = _this.API.find("#"+_this.param.formConAdd)[0].getDataAndCheck();
					var psd = data.password || "";
					if(psd) delete data.password;
					if(!data) return;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curNodeid = _this.MY.cid;
						var curAlias = _this.MY.sonAlias;
					}else{
						var curNodeid = _this.MY.nodeid;
						var curAlias = _this.MY.alias;
					}
					//转换data中有数组的情况为字符串
					_this.API.private("privateFormToData",_this.MY.contentDesc[curAlias],data);
					var _param = {alias:curAlias,param:data};
					var _serverName = _this.MY.serverName.aCon;
					data.nodeid = curNodeid || "0";  //指定栏目nodeid
					_this.API.doServer(_serverName,_this.MY.package,_param,function(code,data){
						if(code == 0){
							if(psd){
								_this.API.doServer("modifyPassword","customer",{userid:data[1],newPassword:psd},function(code,data2){
									if(code==0){
										_callback && _callback(data);
									}
								})
							}else{
								_callback && _callback(data);
							}
						}else{
							alert("内容添加失败！");
						}
					})
				}
			},
			TrigerEvent:{

			}
		}
	);
	return FW;
});

