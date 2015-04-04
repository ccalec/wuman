/** 
* @fileOverview cms前台展示页面绑定分页功能
* @author <a href="http://www.wgfly.com">Alec</a> 
* @version 0.1
*/ 

/**
* @namespace
* @author Alec 
* @name paginationGadget 
* @description  这是一个支持cms绑定分页功能的gadget,提供给需要绑定分页功能的gadget继承
*/ 

define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	
	FW.register(
		{
			param:{
			},
			name:"paginationGadget",
			private:{
				/**
				*@function
				*@name privateBindPagination
				*@memberOf paginationGadget
				*@param {String} _serverName doServer服务名, 查询总数的服务名为： serverName+"Count"
				*@param {String} _package doServer包名
				*@param {Object} _param doServer内容列表的数据查询参数
				*@param {jqueryContainer} _domid 分页生成后插入的dom节点的id值
				*@param {Int} _pagesize 每页显示多少条 默认值10
				*@param {Object} _callback 获取到数据后的回调函数，参数1:data
				*@description 内容列表回调函数，主要实现如下：
				* 1、doServer查询列表总数
				* 2、获取需要显示第几页的数据
				* 3、doServer查询当页数据
				* 4、执行回调函数_callback返回data(有可能是空), 回调函数内部处理数据库后，show视图
				* 5、FW.use().showPagination插入分页页码
				*@example
				*/
				privateBindPagination: function(_serverName,_package,_param,_domid,_pagesize,_callback){
					var _this = this;
					_pagesize = _pagesize || 10;
					//计算list的数据总数
					_this.API.doServer(_serverName+"Count", _package, _param, function(code,data){
						if(code==0 && data){
							//储存数据总数
							var dataCount = parseInt(data[0].count) || 0;
							//判断总数是否为0，如果为0则显示空数据视图
							if(!dataCount){
								_callback && _callback();
								FW.use().showPagination(_this.API.find("#"+_domid));
							}else{
								//获取pagesize
								var pageSize = _pagesize || 10;
								curPageNum = Math.ceil(dataCount/pageSize);
								
								function reShowConList(_prePageNum){
									var pageNum = parseInt(_prePageNum);
									_param.spes.limit = {
										start: (pageSize*pageNum-pageSize).toString(),
										length: pageSize.toString()
									}
									_this.API.doServer(_serverName, _package, _param, function(code,data){
										if(code == 0){							
											_callback && _callback(data);
											FW.use().showPagination(_this.API.find("#"+_domid),dataCount,pageSize,pageNum,function(prePageNum){
												reShowConList(prePageNum);
											})
										}
									})
								}
								reShowConList(1);
							}
						}
					})
				}
			}
		}
	);
	return FW;
});