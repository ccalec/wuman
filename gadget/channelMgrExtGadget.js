/** 
* @fileOverview CMS后台模型操作视图Gadget 
* @author <a href="http://www.wgfly.com">Alec</a> 
* @version 0.1
*/ 

/**
* @namespace
* @author Alec 
* @name channelMgrExtGadget
* @description  CMS后台模型操作视图Gadget
*/ 
define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	require("../gadget/cmsMgrGadget"); //引入扩展函数
	FW.register(
		{
			name:"channelMgrExtGadget",
			extends:["cmsMgrGadget"],
			param:{
				/**
				*@name descChannelUrl
				*@memberOf channelMgrExtGadget
				*@description 数据模型的内置数据描述文件				
				*/
				descChannelUrl: "",
				/**				
				*@name alias
				*@memberOf channelMgrExtGadget
				*@description 默认的alias				
				*/
				alias: "channel"
			},
			/**
			*@function
			*@name onCreate
			*@memberOf channelMgrExtGadget
			*@description 初始化，覆盖底层onCreate函数，为channel定制
				注意：默认alias为“channel"
			*@example 
			*/
			private:{
				/**
				*@function
				*@name privateContentDesc
				*@memberOf channelMgrExtGadget
				*@param {function} _alias 指定查询数据描述的alias
				*@param {function} _callback 查询数据描述后的回调函数
				*@description 定义查询指定alias的数据描述函数，主要实现如下：
				* 1、ajax获取channel的数据描述，并将其保存在this.MY.contentDesc["channel"]下
				* 2、执行回调函数
				*@example 
				*/
				privateContentDesc: function(_alias,_callback){
					var _this = this;
					//判断数据描述路径
					if(!_this.param.descChannelUrl){
						alert("模型数据描述路径不存在！");
						return;
					}
					//ajax取数据描述对象
					_this.MY.contentDesc = {};
					_this.MY.contentDesc[_alias] = FW.use().evalJSON($.ajax({url:_this.param.descChannelUrl,async:false}).responseText);
					//执行回调
					_callback && _callback({displayName:"数据模型"});
				},
				/**
				*@function
				*@name privateDataToForm
				*@memberOf cmsMgrGadget
				*@param {Object} _desc 当前数据描述
				*@param {Object} _arrData 从数据库获取到的多笔数据的一个数组
				*@description 将createForm函数执行参数的数据描述desc和数据data进行数据转换，主要实现如下
				* 1、channel模型对数据的特殊转换
				*@example 
				*/
				privateDataToForm: function(_desc,_arrData){
					if(_arrData && _arrData.length){
						for(var i = 0; i < _arrData.length; i++){
							var _dataDesc = [];
							if(_arrData[i].dataDesc){
								_arrData[i].dataDesc = FW.use().evalJSON(_arrData[i].dataDesc);
								for(var prop in _arrData[i].dataDesc){
									//转换valueRang为字符串
									if(_arrData[i].dataDesc[prop].valueRange){
										//将校验的checkers数组里面的函数字符串转化为函数
										for (var nProp in _arrData[i].dataDesc[prop].valueRange){
											var vOne = _arrData[i].dataDesc[prop].valueRange[nProp];
											if(vOne.checkers && vOne.checkers.indexOf("function") == 0){
												vOne.checkers = FW.use().evalJSON(vOne.checkers);
											}
										}
										_arrData[i].dataDesc[prop].valueRange = FW.use().toJSONString(_arrData[i].dataDesc[prop].valueRange);
									}
									_arrData[i].dataDesc[prop].fieldname = prop;
									_dataDesc.push(_arrData[i].dataDesc[prop]);
								}
								_arrData[i].dataDesc = _dataDesc;
							}
						}
					}
				},
				/**
				*@function
				*@name privateFormToData
				*@memberOf cmsMgrGadget
				*@param {Object} _desc 当前数据描述
				*@param {Object} _data dom[0].getData()函数获取到的单条数据
				*@description 数据转换函数:将表单获取到的数据中的数组类型List,Pics等，转换成字符串类型保存至数据库，主要实现如下：
				* 1、将List和Pics等数组类型，由数组转成字符串
				*@example 
				*/
				privateFormToData: function(_desc,_data){
					if(_data && _data.dataDesc){
						var _dataDesc = {};
						for(var i=0; i<_data.dataDesc.length;i++){
							//转换valueRang为对象
							if(_data.dataDesc[i].valueRange){
								_data.dataDesc[i].valueRange = FW.use().evalJSON(_data.dataDesc[i].valueRange);
								//将校验的checkers数组里面的函数转化为字符串
								for (var nProp in _data.dataDesc[i].valueRange){
									var vOne = _data.dataDesc[i].valueRange[nProp];
									if(/function/i.test(typeof(vOne.checkers))){
										vOne.checkers = FW.use().toJSONString(vOne.checkers);
									}
								}
							}
							var fObj = _data.dataDesc[i];
							_dataDesc[fObj.fieldname] = fObj;
							delete _dataDesc[fObj.fieldname].fieldname;
						}
						_data.dataDesc = FW.use().toJSONString(_dataDesc);
					}
				},
				
				/**
				*@function
				*@name privateBtnConDel
				*@memberOf cmsMgrGadget
				*@description 内容列表视图通用删除按钮函数
				* 需要完成的功能如下：
				* 1、判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
				* 2、doServer从数据库删除该条数据
				* 3、删除成功后重新执行内容列表视图
				*@example 
				*/
				privateBtnConDel: function(_dom,_data){
					var _this = this;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					var curAlias = _this.MY.sonAlias || _this.MY.alias;
					if(confirm("确认要删除该内容吗？")){
						var _param = {alias:_dom.parents("tr:eq(0)").find("td ._formlist_alias_inp").val()};
						var _serverName = _this.MY.serverName.dCMSCT;
						_this.API.doServer(_serverName,_this.MY.package,_param,function(code,data){
							if(code == 0){
								_this.API.private("privateShowConList");
							}else{
								alert("内容删除失败！");
							}
						})
					}
				},
				/**
				*@function
				*@name privateBtnConPLDel
				*@memberOf cmsMgrGadget
				*@description 内容列表视图批量删除按钮
				* 需要完成的功能如下：
				* 1、获得表单的dom
				* 2、判断当前视图是否存在_this.MY.sonAlias，如果存在则为子集alias操作
				* 3、绑定按钮点击事件，doServer从数据库删除该条数据
				* 4、删除成功后重新执行内容列表视图
				*@example 
				*/
				privateBtnConPLDel: function(){
					var _this = this;
					//获得dom
					var formDom = _this.API.find("#"+_this.param.formConList);
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					var curAlias = _this.MY.sonAlias || _this.MY.alias;
					if(confirm("确认要删除该内容吗？")){
						//单个循环删除=======
						//多请求同时发送初始化
						_this.API.initPost();
						var arrCheckData = formDom[0].batchEdit();
						for (var i = 0; i < arrCheckData.length; i++) {
								_this.API.addPost(_this.MY.serverName.dCMSCT,_this.MY.package,{alias:arrCheckData[i].alias},function(code,data){
									if(code!==0){
										alert("删除失败！");
									}
								})
						}
						_this.API.doPost(function(){
							_this.API.private("privateShowConList");
						})
					}
				},
				/**
				*@function
				*@name privateSubmitConAdd
				*@memberOf cmsMgrGadget
				*@description 内容添加页面提交按钮函数
				* 需要完成的功能如下：
				* 1、getDataAndCheck方法将获取表单数据并进行校验，转换成json
				* 2、转换data中有List、Pics数组类型为字符串
				* 3、将数据doServer保存进数据库
				* 4、执行回调函数_callback
				*@example 
				*/
				privateSubmitConAdd: function(_callback){
					var _this = this;
					//将表单转换成json
					var data = _this.API.find("#"+_this.param.formConAdd)[0].getDataAndCheck();
					if(!data) return;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curNodeid = _this.MY.curcid;
						var curAlias = _this.MY.sonAlias;
					}else{
						var curNodeid = _this.MY.nodeid;
						var curAlias = _this.MY.alias;
					}
					//按照排序大小重组data ,arr.sort改变原数组
					if(data.dataDesc){
						data.dataDesc.sort(function(a,b){return parseInt(a.order)>parseInt(b.order)?1:-1}); //从小到大排序
					}
					//转换data中有数组的情况为字符串
					_this.API.private("privateFormToData",_this.MY.contentDesc[curAlias],data);
					data.nodeid = curNodeid || "0";  //指定栏目nodeid
					_this.API.doServer(_this.MY.serverName.aCMSCT,_this.MY.package,data,function(code,data){
						if(code == 0 && data){
							_callback(data[0]);
						}else{
							alert("内容添加失败！");
						}
					})
				},
				/**
				*@function
				*@name privateSubmitConEdit
				*@memberOf cmsMgrGadget
				*@description 内容编辑添加页面提交按钮函数
				* 需要完成的功能如下：
				* 1、getDataAndCheck方法将获取表单数据并进行校验，转换成json
				* 2、转换data中有List、Pics数组类型为字符串
				* 3、将数据doServer保存进数据库
				* 4、执行回调函数_callback
				*@example 
				*/
				privateSubmitConEdit: function(_callback){
					var _this = this;
					//将表单转换成json
					var data = _this.API.find("#"+_this.param.formConEdit)[0].getDataAndCheck();
					if(!data) return;
					//判断当前视图是否存在__this.MY.sonAlias，如果存在则为内容子alias操作
					var curAlias = _this.MY.sonAlias || _this.MY.alias;
					//按照排序大小重组data ,arr.sort改变原数组
					if(data.dataDesc){
						data.dataDesc.sort(function(a,b){return parseInt(a.order)>parseInt(b.order)?1:-1}); //从小到大排序
					}
					//转换data中有数组的情况为字符串
					_this.API.private("privateFormToData",_this.MY.contentDesc[curAlias],data);
					_this.API.doServer(_this.MY.serverName.mCMSCT,_this.MY.package,data,function(code,data){
						if(code == 0 && data){
							_callback(data[0]);
						}else{
							alert("修改内容保存失败！");
						}
					})
				}
			}
		}
	);
	return FW;
});

