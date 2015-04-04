/** 
* @fileOverview cms前台展示页面通用视图Gadget 
* @author <a href="http://www.wgfly.com">Alec</a> 
* @version 0.1
*/ 

/**
* @namespace
* @author Alec 
* @name cmsViewGadget 
* @description  这是一个支持cms查询显示的gadget，支持用cms显示alias的三个模式
* 包括：nodeList,contentList,contentDetail,
* 在本API中，页面将使用主视图view_main
*/ 

define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	
	FW.register(
		{
			param:{
				/**				
				*@name viewObj
				*@memberOf cmsViewGadget
				*@description 默认模式			
				*/
				viewObj:"nodeList",
				/**				
				*@name alias
				*@memberOf cmsViewGadget
				*@description 默认alias			
				*/
				alias:null,
				/**				
				*@name cid
				*@memberOf cmsViewGadget
				*@description 默认cid 当nodeList的视图下，0标示查顶级栏目; contentList视图下，-1表示忽略cid，查询全部		
				*/
				cid:null,
				/**				
				*@name pageLen
				*@memberOf cmsViewGadget
				*@{int} int类型 
				*@description 默认分页长度是10如果不想要分页限制，可以将分页长度设定成足够大			
				*/
				pageLen:10,
				/**				
				*@name orderby
				*@memberOf cmsViewGadget
				*@{Arrar} 数组类型 
				*@description 数据排序条件			
				*/
				orderby:[{
					name:"cid",
					desc:"true"
				}],				
				
				/**				
				*@name btnShowMore
				*@memberOf cmsViewGadget
				*@description 用于nodeList或contentList两种视图，指定点击查看更多节点ID			
				*/
				btnShowMore:"pageDv",

                /**				
				*@name view_main
				*@memberOf cmsViewGadget
				*@description 主要视图，缺省为view_main		
				*/
				mainView:"view_main",

				/**				
				*@name condiction
				*@memberOf cmsViewGadget
				*@description 查询的条件	
				*/
				condiction:{}
			},
			name:"cmsViewGadget",
			/**
			*@function
			*@name onCreate
			*@memberOf cmsViewGadget
			*@description 初始化，根据参数，显示对应视图
			*@example 
			*/
			onCreate:function(){

				var _this = this;

				//初始化页码
				_this.pageNo = 0;

				//视图判断
				if(!_this.param.viewObj){
					alert("未指定视图参数viewObj！");
					return;
				}

				//获取参数alias
				_this.alias = _this.param.alias || FW.use().getParameter("alias");
				if(!_this.alias){
					alert("未指定alias！");
					return;
				}

				//获取url中参数cid
				_this.cid = _this.param.cid || FW.use().getParameter("cid");

				//定义serverName
				_this.serverName = "";

				//定义package
				_this.package = "cms";

				//定义参数对象
				_this.doServerParam = {
					alias:_this.alias,
					param:_this.param.condiction,
					spes:{
						orderby:this.param.orderby,
						limit:{
							start: 0,
							length: _this.param.pageLen+1+""
						}
					}
				};

				//定义4种视图的参数 =============
				//视图: view_nodeList
				//nodeList 当前alias栏目列表 如果没有指定cid，则查顶级栏目，如果指定，这查指定栏目的子栏目
				if(_this.param.viewObj == "nodeList"){
					_this.serverName = "queryNode";
					_this.doServerParam.param.nodeid = _this.cid || "0";
				}

				//视图: view_contentList
				//contentList 查询当前alias,指定cid栏目的内容列表,
				if(_this.param.viewObj == "contentList"){
					_this.serverName = "queryContent";
					if(_this.cid && _this.cid != "-1"){
						_this.doServerParam.param.nodeid = _this.cid;
					}
				}

				//视图: view_contentDetail
				//contentDetail 查询当前alias，当前cid的内容详情
				if(_this.param.viewObj == "contentDetail"){
					_this.serverName = "queryContent";
					delete _this.doServerParam.spes;
					if(_this.cid){
						_this.doServerParam.param.cid = _this.cid;
					}
				}
				
				//视图: view_firstContent
				//firstContent 查询当前alias，当前栏目cid下面的第一条内容的内容详情
				if(_this.param.viewObj == "firstContent"){
					_this.serverName = "queryContent";
					_this.doServerParam.spes.limit.length = 1;
					if(_this.cid){
						_this.doServerParam.param.nodeid = _this.cid;
					}
				}

				//初始化显示视图，获取初始数据
				_this.MY.getData = function(isShowMore){
					//如果是nodeList 或contentList 列表视图，点击查看更多时更新起始参数
					if(_this.param.viewObj == "nodeList" || _this.param.viewObj == "contentList"){
						_this.doServerParam.spes.limit.start = _this.pageNo*_this.param.pageLen+"";
					}
					_this.API.doServer(_this.serverName, _this.package, _this.doServerParam, function(code,data){
						if(code==0 && data.cmsdata){
							//如果是nodeList 或contentList 列表视图，长度比请求长度大1，标示可以继续点击下一页，删除最后多查出的data
							if(_this.param.viewObj == "nodeList" || _this.param.viewObj == "contentList"){
								if(data.cmsdata.length == this.doServerParam.spes.limit.length){
									data.cmsdata.pop();
									_this.API.find("#"+_this.param.btnShowMore).show();
								}else{
									_this.API.find("#"+_this.param.btnShowMore).hide();
								}
							}

							//根据是否是初始化，还是点击查看更多，来显示对应的data.cmsdata
							if(isShowMore){
								_this.API.append(_this.param.mainView, data.cmsdata, _this.param.mainView);
							}else{
								_this.API.show(_this.param.mainView, data.cmsdata);
							}
							
						}else{
							_this.API.show("view_"+_this.param.viewObj);
						}
					})
				}
				_this.MY.getData();

			},
			FireEvent:{
				/**
				*@function
				*@name Fire_ShowMore
				*@memberOf cmsViewGadget
				*@description 用于nodeList,contentList两种列表视图，点击查看更多loading数据
				*@param {String} thisId 指定需要loading数据的appid
				*@example 				
				*/
				showMore:function(_appid){
					this.pageNo++;
					this.MY.getData(true);
				}
			},
			TrigerEvent:{				
				trigerSearch:function(_appid,_keyword){					
					if(_appid == this.id){
						
						//重置pageNo
						this.pageNo = 0;

						//增加后台查询“或”和“与”逻辑的判断指针参数
				    	this.doServerParam.method = "query";

				    	//从_desc中获取需要查询匹配的参数 放入到param的查询条件
				    	this.doServerParam.param = this.doServerParam.param || {};

				    	//滞空指定栏目nodeid
				    	delete this.doServerParam.param.nodeid;

				    	//将查询条件一一赋值进入
						this.doServerParam.param.title = "%"+_keyword+"%";
						this.doServerParam.param.simpleDesc = "%"+_keyword+"%";
						this.MY.getData();
					}
				}
			}
		}
	);
	return FW;
});