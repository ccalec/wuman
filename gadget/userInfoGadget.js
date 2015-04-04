/**
* @fileOverview 处理用户信息用户登录的gadget
* @author <a href="http://www.wgfly.com">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name userInfoGadget
* @description  这是一个用户登录信息处理gadget包括，获取用户信息，用户登录，用户注册三个功能
*/
define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	FW.register(
		{
			param:{
				/**
				*@name getinfoServicePackage
				*@memberOf userInfoGadget
				*@description 获取用信息时doserver使用的包名，缺省是	customer
				*/
				getinfoServicePackage:"customer",
				/**
				*@name getinfoServiceName
				*@memberOf userInfoGadget
				*@description 获取用信息时doserver使用的业务名，缺省是	getCustomerInfo
				*/
				getinfoServiceName:"getCustomerInfo",
				/**
				*@name loginServicePackage
				*@memberOf userInfoGadget
				*@description 用户登录时doserver使用的包名，缺省是	customer
				*/
				loginServicePackage:"customer",
				/**
				*@name loginServiceName
				*@memberOf userInfoGadget
				*@description 用户登录时doserver使用的业务名，缺省是	loginUser
				*/
				loginServiceName:"loginUser",
				/**
				*@name registerServicePackage
				*@memberOf userInfoGadget
				*@description 用户注册时doserver使用的包名，缺省是	customer
				*/
				registerServicePackage:"customer",
				/**
				*@name registerServiceName
				*@memberOf userInfoGadget
				*@description 用户注册时doserver使用的业务名，缺省是	registerUser
				*/
				registerServiceName:"registerUser",
				/**
				*@name getUserFailTips
				*@memberOf userInfoGadget
				*@description 当获取用户信息失败时的提示信息，默认值是'用户登录失败'
				*/
				getUserFailTips:'用户登录失败',

				/**
				*@name getUserFailJumb
				*@memberOf userInfoGadget
				*@description 当用获取用户失败后，跳转页面,如果为null表示不跳转
				*/
				getUserFailJumb:null,

				/**
				*@name userNotLoginJumb
				*@memberOf userInfoGadget
				*@description 当用获取用户成功，但是用户未登录则进行跳转的页面信息,如果为null表示不跳转
				*/
				userNotLoginJumb:null,

				/**
				*@name loginSuccTips
				*@memberOf userInfoGadget
				*@description 当获取登录成功时的提示信息，默认值是'用户登录成功'
				*/
				loginSuccTips:'用户登录成功',

				/**
				*@name loginSuccJumb
				*@memberOf userInfoGadget
				*@description 当用登录成功后，跳转页面,如果为null表示不跳转
				*/
				loginSuccJumb:null,

				/**
				*@name loginFailTips
				*@memberOf userInfoGadget
				*@description 当获取登录失败时的提示信息，默认值是'用户登录失败'
				*/
				loginFailTips:'用户登录失败',

				/**
				*@name loginFailJumb
				*@memberOf userInfoGadget
				*@description 当用登录失败后，跳转页面,如果为null表示不跳转
				*/
				loginFailJumb:null,

				/**
				*@name registerSuccTips
				*@memberOf userInfoGadget
				*@description 当获取登录成功时的提示信息，默认值是'注册成功'
				*/
				registerSuccTips:'注册成功',

				/**
				*@name registerSuccJumb
				*@memberOf userInfoGadget
				*@description 当用登录成功后，跳转页面,如果为null表示不跳转
				*/
				registerSuccJumb:null,

				/**
				*@name registerFailTips
				*@memberOf userInfoGadget
				*@description 当获取登录失败时的提示信息，默认值是'用户登录失败'
				*/
				registerFailTips:'用户登录失败',

				/**
				*@name registerFailJumb
				*@memberOf userInfoGadget
				*@description 当用登录失败后，跳转页面,如果为null表示不跳转
				*/
				registerFailJumb:null,

				/**
				*@name directShowView
				*@memberOf userInfoGadget
				*@description 直接显示的视图名称，当有指定的时候，直接先显示该视图。
				并且不做获取用户信息操作
				*/
				directShowView:null



			},
			name:"userInfoGadget",
			/**
			*@function
			*@name onCreate
			*@memberOf userInfoGadget
			*@description 初始化，获取用户的信息，如果用已经登录，显示视图view_userLogin，未登录显示view_userNotLogin
			注意：从服务端返回的参数中，有loginStatus表示用户的登录状态，0表示已经登录，其他表示未登录
			*@example
			*/
			onCreate:function(){
				if (this.param.directShowView){
					this.API.show(this.param.directShowView);
					return;
				};
				this.API.doServer(this.param.getinfoServiceName, this.param.getinfoServicePackage,{},
					function(code,data){
						if (code ==0 && data){
							this.MY.userInfo = data;
							this.API.show("view_userLogin",this.MY.userInfo);
						}else{
							if (this.param.userNotLoginJumb){
								window.location.href = this.param.userNotLoginJumb;
								return;
							}
							this.API.show("view_userNotLogin",this.MY.userInfo);
						}
					}
				);
			},
			FireEvent:{
				/**
				*@function
				*@name FireEvent_fireLogin
				*@memberOf userInfoGadget
				*@description 用于用户登录的事件处理,customer.loginUser({account:xxx,password:xxx})
				*@param {String} accountNameid 帐号对应的表单id
				*@param {String} passwordid 密码对应的表单id号
				*@example
				* 《a href="#" onclick="FireEvent.fireLogin(userName,password)" 》lioing《/a》
				* 《input type="input" id="userName"》
				* 《input type="input" id="password"》
				*/
				fireLogin:function(__accountNameid,__passwordid){
					var account = this.API.find("#" + __accountNameid).val();
					var password = this.API.find("#" + __passwordid).val();
					this.API.trigerMyEvent("trigerLogin",account,password);
				},
				/**
				*@function
				*@name FireEvent_fireRegister
				*@memberOf userInfoGadget
				*@description 用于用户注册事件处理,customer.fireRegister({自定义})
				*@param {Object} RegisterInfo 用户注册的对象信息格式为：<br/>
				         {[注册参数名]:[页面上的表单id字符串]}
				*@example
				* 《input type="input" name="userNameid"》
				* 《input type="input" name="passwordid"》
				* 《a href="#" onclick="FireEvent.fireRegister({userName:'userNameid',password:'passwordid')}"》lioing《/a》
				*  其中userName是数据库，或是说service配置的参数名，userNameid是输入表单的name值，密码部分也是这样，这个函数可以支持任意数量字段的
				*  的注册处理
				*/
				fireRegister:function(__RegisterInfo){
					var regObj = {};
					for (var name in __RegisterInfo){
						var formObj = this.API.find("[name='"+__RegisterInfo[name]+"']");
						if (formObj.length == 1){
							var value = formObj[0].value;
							regObj[name] = value;
						}else if (formObj.length > 1){
							for (var i=0;i<formObj.length;i++){
								var inObj = formObj[i];
								if (inObj.checked){
									regObj[name] = inObj.value;
									break;
								}
							}
						}
					}
					this.API.trigerMyEvent("trigerRegister",regObj);
				}
			},
			TrigerEvent:{
				/**
				*@function
				*@name TrigerEvent_trigerLogin
				*@memberOf userInfoGadget
				*@description 用于外部gadget的事件出发登录，同时也是内部公用的调用方法<br/>
				*注意，doServer使用信息：customer.loginUser({account:xxx,password:xxx})
				*另外，如果登录成功后，该函数会向其他APP触发一个trigerLoginSucc事件
				*@param {String} accountName 帐号
				*@param {String} password 密码
				*@example
				*/
				trigerLogin:function(__accountName,__password){
					var param = {
						account:__accountName,
						password:__password
					}
					this.API.doServer(this.param.loginServiceName,this.param.loginServicePackage,param,
						function(code,data){
						if (code != 0){
							this.API.private("loginFail",code);
							return;
						}else{
							// alert(this.param.loginSuccTips);
							this.param.loginSuccJumb && (window.location.href = this.param.loginSuccJumb);
							this.API.show("view_userLogin",data[0]);
							this.MY.userInfo = data[0];
							this.API.trigerOtherEvent("trigerLoginSucc");
							return;
						}
					});
				},
				/**
				*@function
				*@name TrigerEvent_trigerRegister
				*@memberOf userInfoGadget
				*@description 用于外部gadget的事件出发登录，同时也是内部公用的调用方法
				*注意，doServer请求的参数包括：,customer.fireRegister({自定义})
				*@param {Object} registerInfo 帐号
				*@example
				*/
				trigerRegister:function(__registerInfo){
					if (!this.API.private("registerCheck",__registerInfo)){
						return;
					};
					this.API.doServer(this.param.registerServiceName,this.param.registerServicePackage,__registerInfo,
						function(code,data){
						if (code != 0){
							alert(this.param.registerFailTips);
							this.param.registerFailJumb && (window.location.href = this.param.registerFailJumb);
							return;
						}else{
							alert(this.param.registerSuccTips);
							this.param.registerSuccJumb && (window.location.href = this.param.registerSuccJumb);
							return;
						}
					});
				}
			},
			private:{
				/**
				*@function
				*@name privata_loginFail
				*@memberOf userInfoGadget
				*@description 私有方法，可用于子类扩展继承，默认情况下，只显示登录失败的信息
				*@param {Object} registerInfo 用户帐户信息
				*@example
				*/
				loginFail:function(__code){
					alert(this.param.loginFailTips);
					this.param.loginFailJumb && (window.location.href = this.param.loginFailJumb);
				},
				/**
				*@function
				*@name privata_registerCheck
				*@memberOf userInfoGadget
				*@description 私有方法，可用于子类扩展继承，默认情况下，只要输入内容部位空就为true
				*如果要定制特殊的校验，就要重载这个类
				*@param {Object} registerInfo 用户帐户信息
				*@example
				*/
				registerCheck:function(__registerInfo){
					for (var name in __registerInfo){
						if (!__registerInfo[name]){
							alert("请填写完整！");
							return false;
						}
					}
					return true;
				}
			}
		}
	);
	return FW;
});

