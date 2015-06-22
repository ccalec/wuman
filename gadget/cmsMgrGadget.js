/**
* @fileOverview CMS后台内容操作视图的Gadget
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name cmsMgrGadget
* @description  CMS后台内容操作视图Gadget
*/
define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/Widget")(FW);
	FW.register(
		{
			name:"cmsMgrGadget",
			param:{
				/**
				*@name alias
				*@memberOf cmsMgrGadget
				*@description 默认的alias
				*/
				alias:"",
				/**
				*@name cid
				*@memberOf cmsMgrGadget
				*@description 默认的cid,通常和action:conEdit搭配出现
				*/
				cid:"",
				/**
				*@name nodeid
				*@memberOf cmsMgrGadget
				*@description 默认的nodeid,通常和action:classEdit搭配出现
				*/
				nodeid:"",
				/**
				*@name action
				*@memberOf cmsMgrGadget
				*@description 指定显示默认视图
				* 可选值： conList,conAdd,conPLAdd,conEdit,classAdd,classEdit
				*/
				action:"",
				/**
				*@name pagesize
				*@memberOf cmsMgrGadget
				*@description 内容列表视图默认分页数
				*/
				pagesize:10,
				/**
				*@name plModSet
				*@memberOf cmsMgrGadget
				*@description 批量修改开关设置，默认为false 关闭状态 ture为开启状态
				*/
				plModSet:{
					xxalias:true
				},
				/**
				*@name plAddSetNum
				*@memberOf cmsMgrGadget
				*@description 批量添加默认多少比空白数据
				*/
				plAddSetNum:10,
				/**
				*@name btnForList
				*@memberOf cmsMgrGadget
				*@description 自定义扩张列表视图的操作按钮
				*/
				btnForList:{
					default:[{
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
					roles:[{
						title:"权限设置",
						class:"btn btn-mini btn-success",
						html:" <i class='icon-group bigger-120'> 权限</i>",
						onclick:"privateSetRoles"
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
				},
				/**
				*@name viewConList
				*@memberOf cmsMgrGadget
				*@description 内容列表视图ID
				*/
				viewConList: "viewContentList",
				/**
				*@name viewConAdd
				*@memberOf cmsMgrGadget
				*@description 内容添加视图ID
				*/
				viewConAdd: "viewContentAdd",
				/**
				*@name viewConPLAdd
				*@memberOf cmsMgrGadget
				*@description 内容批量添加视图ID
				*/
				viewConPLAdd: "viewContentPLAdd",
				/**
				*@name viewClassEdit
				*@memberOf cmsMgrGadget
				*@description 内容栏目修改视图ID
				*/
				viewClassEdit: "viewClassEdit",
				/**
				*@name viewClassAdd
				*@memberOf cmsMgrGadget
				*@description 内容添加栏目视图ID
				*/
				viewClassAdd: "viewClassAdd",
				/**
				*@name viewConEdit
				*@memberOf cmsMgrGadget
				*@description 内容编辑视图ID
				*/
				viewConEdit: "viewContentEdit",
				/**
				*@name formConList
				*@memberOf cmsMgrGadget
				*@description 内容列表视图表单formID
				*/
				formConList: "formContentList",
				/**
				*@name formConAdd
				*@memberOf cmsMgrGadget
				*@description 内容添加视图表单formID
				*/
				formConAdd: "formContentAdd",
				/**
				*@name formConPLAdd
				*@memberOf cmsMgrGadget
				*@description 内容编辑视图表单formID
				*/
				formConPLAdd: "formContentPLAdd",
				/**
				*@name formClassEdit
				*@memberOf cmsMgrGadget
				*@description 栏目修改视图表单formID
				*/
				formClassEdit: "formClassEdit",
				/**
				*@name formClassAdd
				*@memberOf cmsMgrGadget
				*@description 添加栏目视图表单formID
				*/
				formClassAdd: "formClassAdd",
				/**
				*@name formConEdit
				*@memberOf cmsMgrGadget
				*@description 内容编辑视图表单formID
				*/
				formConEdit: "formContentEdit"
			},
			/**
			*@function
			*@name onCreate
			*@memberOf cmsMgrGadget
			*@description 初始化，定义六中视图函数，视图状态指针，视图ID，对应formID，以及CMSMgr的所有serviceName和package
			*@example
			*/
			onCreate:function(){
				var _this = this;
				//全局设置
				var _this = this;
				//获取url中参数alias
				_this.MY.alias =   _this.param.alias || FW.use().getParameter("alias") || "";
				if(!_this.MY.alias) return;
				//获取显示的视图指针action
				_this.MY.action = _this.param.action || FW.use().getParameter("action") || "";
				//获取默认参数cid
				_this.MY.cid =    _this.param.cid    || FW.use().getParameter("cid") || "";
				//获取默认参数nodeid
				_this.MY.nodeid = _this.param.nodeid || FW.use().getParameter("nodeid") || "";
				//获取默认参数norole，页面权限判断开关按钮 默认为false，需要权限判断
				_this.MY.isrole = _this.param.norole || FW.use().getParameter("norole") || "";
				//存储默认alias及子集alias的数据描述
				_this.MY.contentDesc = {};
				//存储子集alias变量
				_this.MY.sonAlias = "";
				//自身cid,用于存在子集alias内容编辑时用
				_this.MY.sonCid = "";
				//判断是否自己挂接自己类型
				_this.MY.isSelfAlias = false;
				//判断是否没有挂接栏目
				_this.MY.noClass = false;
				//定义状态指针,6种视图命名定义
				_this.MY.act = {
					conList: "conList",  			//内容列表
					conAdd: "conAdd",    			//内容添加
					conPLAdd: "conPLAdd",    		//内容批量添加
					classEdit: "classEdit",   		//栏目修改
					classAdd: "classAdd",			//添加栏目
					conEdit: "conEdit"				//编辑内容
				}
				//定义package
				_this.MY.package = "cms";
				//定义各种情况的serverName
				_this.MY.serverName = {
					aCon: "addContent",				//内容表:增
					plaCon: "pladdContent",			//内容表:批量增
					dCon: "deleteContent",     		//内容表:删
					mCon: "modifyContent",			//内容表:改
					qCon: "queryContent",   	    //内容表:查
					aNode: "addNode",				//父内容表：增
					dNode: "deleteNode",			//父内容表：删
					mNode: "modifyNode",			//父内容表：改
					qNode: "queryNode",	   			//父内容表：查
					qSon: "queryConSonAlias", 		//子内容表：查
					aCMSCT: "addCMSType",			//cms模型：增
					dCMSCT: "deleteCMSType",		//cms模型：删
					mCMSCT: "modifyCMSType",		//cms模型：改
					qCMSCT: "queryOneCMSType",      //cms模型：查
					qAllCT: "queryAllCMSType",      //cms模型：查所有
					qNodeCT: "queryNodeCMSType"     //cms模型：查父表
				}
				//获取栏目数据描述
				_this.API.private("privateGetNodeDesc");
				//获取自身数据描述，并展示默认视图
				_this.API.private("privateContentDesc", _this.MY.alias, function(_cmsmatedata){
					//判断是否自己挂接自己类型
					if(_cmsmatedata.parentAlias ==  _this.MY.alias){
						_this.MY.isSelfAlias = true;
					}
					//更新aliasTitle
					$("#aliasTitle").text(_cmsmatedata.displayName);
					$("#pageH1").show();
					//显示默认视图
					_this.API.private("privateShowDefaultView");
					//对整个文档中的操作按钮进行权限校验
					_this.API.private("privateCheckAuth", $("body"));
				})
			},
			FireEvent:{
			},
			private:{
				/**
				*@function
				*@name privateGetNodeDesc
				*@memberOf cmsMgrGadget
				*@description 初始化获取当前alias栏目树数据描述nodeDesc,主要实现如下：
				*@ 1、判断是否没有栏目 指针_this.MY.noClass, 布尔类型 有栏目设为false；   没有栏目设为true
				*@ 2、将nodeDesc保存在_this.MY.nodeDesc变量中
				*@ 3、在没有栏目的情况下，移除【栏目管理】按钮Group
				*@example
				*/
				privateGetNodeDesc: function(){
					var _this = this;
					_this.API.doServer(_this.MY.serverName.qNodeCT,_this.MY.package,{alias:_this.MY.alias},function(code,data){
						//栏目列表的数据描述请求结果判断
						if(code == 0 && data){
							_this.MY.nodeDesc = data[0].dataDesc?FW.use().evalJSON(data[0].dataDesc):{};
							_this.MY.nodeDesc.cid={
								type:'Hidden',
								title:'cid',
								islist:"0"
							};
						}else{  //没有挂接栏目的情况
							_this.MY.noClass = true;
							$("#btnAction .btn-group:eq(1)").remove();
						}
					})
				},
				/**
				*@function
				*@name privateGetSonDesc
				*@memberOf cmsMgrGadget
				*@description 初始化判断是否存在挂接的子节点，主要实现如下：
				*@ 1、生成tab内容切换模块HTML代码，并插入到对应节点中
				*@ 2、给内容编辑视图下出现的子集切换栏绑定点击事件
				*注意，如果存在子节点，在点击编辑内容的时候，在编辑视图会出现tag切换栏对子内容进行编辑与修改操作
				*@example
				*/
				privateGetSonDesc: function(){
					var _this = this;
					_this.API.doServer(_this.MY.serverName.qSon,_this.MY.package,{alias:_this.MY.alias},function(code,data){
						//子节点内容请求结果判断
						//===================
						if(code == 0 && data){
							//1、生成tab内容切换模块HTML代码，
							var tabHtml = "";
							for (var i=0; i<data.length; i++) {
								tabHtml += "<li>";
								tabHtml += "<a href='javascript:void(0)' sonalias='"+data[i].alias+"' data-toggle='tab'>"+data[i].displayName+"</a>";
								tabHtml += "</li>";
							}
							//并插入到对应节点中
							$("#tabSonAlias>ul>li:gt(0)").remove();
							$("#tabSonAlias>ul").append(tabHtml);
							$("#tabSonAlias").show();
							//3、给内容编辑视图下出现的子集切换栏绑定点击事件
							$("#tabSonAlias>ul>li>a").on("click",function(){
								//点击当前li无效
								if($(this).parent().hasClass("active")) return;
								//根据序号，判断显示不同视图
								var index = $("#tabSonAlias>ul>li>a").index($(this));
								if(index==0){
									//删除sonAlias
									delete _this.MY.sonAlias;
									$("#btnAddSonAlias").hide();
									$("#btnPLAddSonAlias").hide();
									_this.API.private("privateShowConEdit");
								}else{
									//将对应li的sonAlias存入this对象
									_this.MY.sonAlias = $(this).attr("sonalias");
									//正常添加的情况
									$("#btnAddSonAlias").show().on("click",function(){
										_this.API.private("privateShowConAdd");
									})
									//批量添加的情况
									$("#btnPLAddSonAlias").show().on("click",function(){
										_this.API.private("privateShowConPLAdd");
										_this.API.find(".table_formlist:eq(0)").next().find(".btn-add-con").show();
									})
									_this.API.private("privateContentDesc", _this.MY.sonAlias, function(){
										_this.API.private("privateShowConList");
									})
								}
							})
						}
					})
				},
				/**
				*@function
				*@name privateContentDesc
				*@memberOf cmsMgrGadget
				*@param {String} _alias 指定需要查询数据描述的alias
				*@param {function} _callback 查询数据描述后的回调函数
				*@description 定义查询指定alias的数据描述函数，主要实现如下：
				*@ 1、获取当前视图alias的数据描述，并将其保存在this.MY.contentDesc[curAlias]下
				*@ 2、给数据描述增加cid的描述 this.MY.contentDesc[curAlias].cid 赋值
				*@ 3、执行回调函数
				*@example
				*/
				privateContentDesc: function(_alias,_callback){
					var _this = this;
					_this.API.doServer(_this.MY.serverName.qCMSCT,_this.MY.package,{alias:_alias},function(code,data){
						if(code==0 && data){
							_this.MY.contentDesc[_alias] = data[0].dataDesc?FW.use().evalJSON(data[0].dataDesc):{};
							_this.MY.contentDesc[_alias].cid = _this.MY.contentDesc[_alias].cid || {
								type:'Hidden',
								title:'cid',
								islist:"0"
							}
							_callback && _callback(data[0]);
						}
					})
				},
				/**
				*@function
				*@name privateShowDefaultView
				*@memberOf cmsMgrGadget
				*@description 根据url参数action显示对应的视图,<br/>
				*@ 注意，url中的action值列表如下,
				* 默认内容列表    conList   <br/>
				* 内容添加	    conAdd    <br/>
				* 内容批量添加    conPLAdd  <br/>
				* 栏目添加	    classAdd  <br/>
				* 内容编辑	    conEdit   同时url中需带入参数cid <br/>
				* 栏目编辑	    classEdit 同时url中需带入参数nodeid
				* 主要实现如下：
				* 1、发送trigerEvent消息给栏目树Gadget
				* 2、执行显示对应视图的函数
				* 3、在栏目添加视图，需要判断是否添加顶级栏目 给指针this.MY.isding赋值 布尔类型
				*@example
				*/
				privateShowDefaultView: function(){
					//内容添加
					if(this.MY.action == this.MY.act.conAdd){
						FW.trigerEvent("trigerReShowNodeTree",this.MY.alias);
						this.API.private("privateShowConAdd");
					}
					//内容批量添加
					else if(this.MY.action == this.MY.act.conPLAdd){
						FW.trigerEvent("trigerReShowNodeTree",this.MY.alias);
						this.API.private("privateShowConPLAdd");
					}
					//添加栏目
					else if(this.MY.action == this.MY.act.classAdd){
						FW.trigerEvent("trigerReShowNodeTree",this.MY.alias);
						this.MY.isding = true;
						this.API.private("privateShowClassAdd");
					}
					//内容编辑
					else if(this.MY.action == this.MY.act.conEdit && this.MY.cid){
						FW.trigerEvent("trigerReShowNodeTree",this.MY.alias);
						this.API.private("privateShowConEdit");
					}
					//栏目编辑
					else if(this.MY.action == this.MY.act.classEdit && this.MY.nodeid){
						FW.trigerEvent("trigerReShowNodeTree",this.MY.alias);
						this.API.private("privateShowClassEdit");
					}
					//内容列表
					else{
						FW.trigerEvent("trigerReShowNodeTree",this.MY.alias);
						this.API.private("privateShowConList");
					}
				},
				/**
				*@function
				*@name privateOutLinkCB
				*@memberOf cmsMgrGadget
				*@param {Object} _dataDesc 当前数据描述
				*@param {JqueryContainer} _formDom 当前视图的form节点
				*@param {String} _fieldName 当前外联字段名
				*@param {String} _fieldValue 当前外联字段值
				*@param {function} _callback 获取外联数据后，重新渲染视图的回调函数
				*@description 定义外联字段的按钮事件函数，主要实现如下：
				* 1、根据视图指针，获取真实_fieldName，和外联数据的序号sn
				* 2、获得外联表的alias及主键字段名
				* 3、获取外联数据描述，显示弹出层，展示外联内容列表
				*@example
				*/
				privateOutLinkCB: function(_dataDesc, _formDom, _fieldName, _fieldValue, _callback){
					var _this = this;
					//获取外联数据的序号sn， -1标示不存在序号，非列表外联
					var reVal = /data.formList\[(.*?)\].*?/g.exec(_fieldName);
					var sn = reVal==null?-1:reVal[1];

					//获取真实_fieldName
					_fieldName = _fieldName.split(".")[_fieldName.split(".").length-1];
					//获得外联表的alias及主键字段名
					var l_ourterLink = _dataDesc[_fieldName].ourterLink;
					if(l_ourterLink.split(".").length !== 2) return;
					var l_alias = l_ourterLink.split(".")[0];
					var l_keyField = l_ourterLink.split(".")[1];
					//设置弹出层默认标题
					var dialogTitle = "";
					//参数：param
					var param = {
						alias:l_alias,
						param:{},
						spes:{
							orderby:[{
								name:"cid",
								desc:"true"
							}]
						}
					};
					//定义生成内容列表的节点
					if(!$("#newViewDom").length){
						$("body").append("<div style='display:none;' id='newViewDom'></div>");
						$("body").append("<div id='preOuterLinkEditForm'></div>");
					}
					var newViewDom = $("#newViewDom");
					var conListDom = $("#preOuterLinkEditForm");

					//定义包含内容列表的容器,包装内容列表函数，生成内容列表
					function reShowListForOutlink(_wrapConListDom,_newParam,_reShowCB){
						_this.API.private("privateContentDesc",_newParam.alias,function(cmsmetadata){
							//定义弹出层默认标题
							if(!dialogTitle){
								dialogTitle = "请选择"+cmsmetadata.displayName;
							}
							//显示分页列表
							_this.API.private("privateBindFormListPage", conListDom, _newParam, 2, function(data){
								//将内容列表移动到内容列表的节点
								_wrapConListDom.empty();
								conListDom.appendTo(_wrapConListDom);
								_reShowCB && _reShowCB();
							})

						})
					}
					//执行外联视图自定义,可以转换_param, 返回外联视图Dom
					_this.API.private("privateSetOutlinkView", newViewDom, param, sn, function(wrapConListDom, newParam){
						//给自定义视图筛选机制自定义param绑定事件接口函数
						reShowListForOutlink(wrapConListDom,newParam);
					},function(wrapConListDom, newParam, newDialogTitle){
						//设置自定义标题
						if(newDialogTitle) dialogTitle = newDialogTitle;
						//生成内容列表，插入对应节点
						reShowListForOutlink(wrapConListDom,newParam,function(){
							//显示弹出层，定义保存按钮执行函数
							_this.API.private("privateMaskLayer",newViewDom,dialogTitle,1000,function(){
								//获取选中的data数据
								var __FormData = conListDom[0].batchEdit();
								if(!__FormData.length) return;
								//将已填写数据getData储存起来
								var newData = _formDom[0].getData();

								//判断是否是列表视图，如果是列表，就将data转成data.formList
								if(_this.MY.action == _this.MY.act.conPLAdd || _this.MY.action == _this.MY.act.conList){
									newData = _formDom[0].getData().formList;
								}
								if(!newData) return;
								//将data数据内容一一赋值进入外联字段
								for(var l_prop in _dataDesc){
									// FW.use('Widget').alert(l_prop);
									if (!_dataDesc[l_prop].ourterLink){
										continue;
									}
									var arr_ourterLink = _dataDesc[l_prop].ourterLink.split(".");
									if(arr_ourterLink.length !== 2) return;
									var ll_alias = arr_ourterLink[0];
									var ll_keyField = arr_ourterLink[1];
									if(ll_alias == l_alias){
										if(sn !== -1){
											newData[sn][l_prop] = __FormData[0][ll_keyField];
										}else{
											newData[l_prop] = __FormData[0][ll_keyField];
										}
									}
								}
								//执行回调，重新渲染原视图
								_callback && _callback(newData);
							})
						})
					})
				},
				/**
				*@function
				*@name privateSetOutlinkView
				*@memberOf cmsMgrGadget
				*@param {jqueryContainer} _newViewDom 提供给自定义视图的dom节点
				*@param {Object} _param 提供给自定义视图的初始化参数
				*@param {String} _sn 提供给自定义视图,需要更新第几行的数据
				*@param {Function} _refConList 给自定义视图提供绑定接口事件，用于自定义视图操作，更新param条件刷新数据列表等情况
				*@return {Function} _callback 自定义视图定制后，需要返回执行的回调函数
				*@description 自定义弹出层的dom视图，并绑定过滤条件刷新内容事件
				*注意：_refConList，_callback 两个函数都需要3个参数:
				* wrapConListDom： 返回需要插入内容列表的空节点,
				* newParam : 自定义视图转换后生成内容列表的新参数,
				* newDialogTitle: 自定义标题   (可选)；
				*@example
				*/
				privateSetOutlinkView:function(_newViewDom,_param,_sn,_refConList,_callback){
					_callback && _callback(_newViewDom,_param);
				},
				/**
				*@function
				*@name privateMaskLayer
				*@memberOf cmsMgrGadget
				*@param {jqueryContainer} _dom 需要插入到弹出层的dom节点
				*@param {Object} _dialogHtml bootbox的html初始代码
				*@param {String} _width 宽度 默认1000
				*@param {function} or {Object} _bindBtnEvent 非必填参数，【保存】按钮的回调函数 或者 自定义按钮html和callback
				*@description 弹出带【保存】【取消】按钮的弹出蒙版层，用于外联字段等情况，实现功能如下：
				* 1、弹出dialog层
				* 2、在保存按钮的回调中执行_callback回调函数
				* 3、定义弹出层的大小和弹出方式
				* 4、注意参数_bindBtnEvent，如果是函数，则是默认两个【保存】【取消】按钮，如果是Array，则表示自定义按钮数组，数组的的成员则是按钮对象，每个按钮对象包含两个成员，html，callback
				*@example
				*/
				privateMaskLayer: function(_dom,_dialogTitle,_width,_bindBtnEvent){
					var htmlstr = "<div style='text-align:left;cursor:default; background:#fff; padding:10px;'><div class='modal-header' style='margin-bottom:10px;'><h3>"+_dialogTitle+"</h3></div>";
					htmlstr += "<div class='modal-body'><form id='outerLinkEditForm' class='form-horizontal clearfix' style='margin:0px;'></form></div>";
					if(_bindBtnEvent){
						htmlstr += "<div class='modal-footer'>";
						if(_bindBtnEvent instanceof Function){
							htmlstr += "<a href='javascript:;' class='btn btn btn-small btn-success'><i class='icon-ok bigger-110'></i> 保存</a>";
							htmlstr += "<a href='javascript:;' class='btn btn btn-small'><i class='icon-undo bigger-110'></i> 取消</a>";
						}
						if(_bindBtnEvent instanceof Array){
							for (var i = 0; i < _bindBtnEvent.length; i++) {
								htmlstr += _bindBtnEvent[i].html;
							};
						}
						htmlstr += "</div>";
					}
					htmlstr += "</div>";
					//显示弹出层 默认宽度：800px
					//计算高度
					// var fHei = _dom.outerHeight() + 101;
					FW.blockUI(htmlstr,($(window).width()-_width)/2,10,_width,"auto",0);
					_dom.appendTo($("#outerLinkEditForm")).show();
					$("#outerLinkEditForm").find(".form-wrap").removeClass("pull-left");
					$(".chosen-select").chosen(); //绑定closen
					//给购物车弹出层绑定关闭事件
					if(_bindBtnEvent){
						$(".modal-footer>a").click(function(){
							var index = $(".modal-footer>a").index($(this));
							if(_bindBtnEvent instanceof Function){
								FW.unblockUI();
								if(index==0){
									_bindBtnEvent && _bindBtnEvent();
								}
							}
							if(_bindBtnEvent instanceof Array){
								_bindBtnEvent[index].callback && _bindBtnEvent[index].callback();
							};
						})
					}
				},
				/**
				*@function
				*@name privateSetDescAndData
				*@memberOf cmsMgrGadget
				*@param {String} _alias 当前需要生成列表的alias
				*@param {Object} _data 当前数据
				*@param {function} _callback 回调函数
				*@description 将createForm函数执行参数的数据描述desc和数据data进行数据转换，主要实现如下
				* 1、可以在各种视图情况下对数据描述this.MY.contentDesc[_alias]和data的自定义设置
				* 2、为了兼容函数内部有doserver的情况，带入回调
				*@example
				*/
				privateSetDescAndData: function(_alias,_data,_callback){
					_callback && _callback();
				},
				/**
				*@function
				*@name privateDataToForm
				*@memberOf cmsMgrGadget
				*@param {Object} _desc 当前数据描述
				*@param {Object} _arrData 从数据库获取到的多笔数据的一个数组
				*@description 将从数据库获取到的数据data进行数据转换，主要实现如下
				* 1、将List和Pics等数组类型，由字符串转成数组
				*@example
				*/
				privateDataToForm: function(_desc,_arrData){
					var _this = this;
					//转换data中数组字符串的情况为数组
					if(_arrData && _arrData.length){
						for(var v_prop in _desc){
							if($.inArray(_desc[v_prop].type, ['List','Pics']) != -1){
								for(var i = 0; i < _arrData.length; i++){
									if(!_arrData[i][v_prop]) continue;
									_arrData[i][v_prop] = FW.use().evalJSON(_arrData[i][v_prop]);
								}
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
					var _this = this;
					//转换_data中数组字符串的情况为数组
					if(_data){
						for(var v_prop in _desc){
							if($.inArray(_desc[v_prop].type, ['List','Pics']) != -1){
								if(!_data[v_prop]) continue;
								_data[v_prop] = FW.use().toJSONString(_data[v_prop]);
							}
						}
					}
				},
				/**
				*@function
				*@name privateShowConList
				*@memberOf cmsMgrGadget
				*@description 展示内容列表视图、编辑内容时Tag切换到挂接的子集内容列表视图
				*注意，此视图拥有两种模式,根据param参数中的plModSet[curAlias]的值为模式开关：
				*1、开关默认false: 普通数据展示模式，独立样式：curAlias+"_conList"
				*2、开关true: 数据批量编辑模式：此视图拥有独立样式：curAlias+"_editConList"
				* 需要完成的功能如下：
				* 1、如果是可快速编辑模式，则显示提交、返回按钮,否则隐藏
				* 2、定义当前视图指针
				* 3、替换操作标题
				* 4、显示列表视图
				* 5、获得生成表单的dom节点formDom
				* 6、增加视图独立样式class
				* 7、生成分页列表
				* 8、执行内容列表的回调函数
				*@example
				*/
				privateShowConList: function(){
					var _this = this;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curNodeid = _this.MY.cid;
						var curAlias = _this.MY.sonAlias;
					}else{
						var curNodeid = _this.MY.nodeid;
						var curAlias = _this.MY.alias;
					}
					//定义当前状态指针
					_this.MY.action = _this.MY.act.conList;
					//替换操作标题
					$("#actionName").text("列表");
					//显示列表视图
					_this.API.show(_this.param.viewConList);
					//获得List的dom
					var formDom = _this.API.find("#"+_this.param.formConList);
					//增加视图独立样式class
					//如果是可快速编辑模式，则显示视图class为editConList
					if(!_this.param.plModSet[curAlias]){
						formDom.addClass(curAlias+"_"+_this.MY.action).addClass(_this.MY.action);
					}else{
						formDom.addClass(curAlias+"_editConList").addClass("editConList");
					}
					//定义获取param,用于获取总数
					var _param = {
						alias:curAlias,
						param:{},
						spes:{
							orderby:[{
								name:"cid",
								desc:"true"
							}]
						}
					}
					if(curNodeid){
						_param.param.nodeid = curNodeid;  //查询
					}
					//显示分页列表
					_this.API.private("privateBindFormListPage",formDom,_param,0,function(data){
						//内容列表回调函数
						_this.API.private("privateShowConListCB",data);
						//如果是可快速编辑模式，则显示提交按钮,否则隐藏
						if(_this.param.plModSet[curAlias]){
							$("#submitBtn").show();
						}else{
							$("#submitBtn").hide();
						}
					});
				},
				/**
				*@function
				*@name privateShowConListCB
				*@memberOf cmsMgrGadget
				*@param {Object} _data 内容列表视图的data数据
				*@description 内容列表回调函数，主要实现如下：
				* 1、给列表每行的checkbox增加FW.trigerEvent事件
				* 2、给列表操作区域的默认按钮绑定事件
				* 3、给列表操作区域的自定义扩展按钮绑定事件
				* 4、给列表的批量删除按钮绑定事件
				* 5、给列表操作区域的所有按钮进行权限判断
				*@example
				*/
				privateShowConListCB:function(_data){
					var _this = this;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curNodeid = _this.MY.cid;
						var curAlias = _this.MY.sonAlias;
					}else{
						var curNodeid = _this.MY.nodeid;
						var curAlias = _this.MY.alias;
					}
					//获得List的dom
					var formDom = _this.API.find("#"+_this.param.formConList);
					//给列表每行的checkbox增加FW.trigerEvent事件
					formDom.find("table:eq(0)>tbody>tr>td>label>input[type='checkbox']").on("click",function(){
						var index = formDom.find("table:eq(0)>tbody>tr>td>label>input[type='checkbox']").index($(this));
						FW.trigerEvent("trigerCheckBoxClick",_data[index]);
					})
					//给当前alias的内容列表操作区域绑定点击事件
					if( _this.param.btnForList && _this.param.btnForList[curAlias]){
						btnJoin(_this.param.btnForList[curAlias]);
					}else if(_this.param.btnForList && _this.param.btnForList.default){
						btnJoin(_this.param.btnForList.default);
					}

					//批量删除按钮
					formDom.find(".btn-del-list").on("click",function(){
						_this.API.private("privateBtnConPLDel");
					});

					//btn扩展处理内部函数
					function btnJoin(arrBtn){
						for (var i = 0; i < arrBtn.length; i++) {
							var aattr = "<a href='javascript:void(0);' ";
							(function(iii){
								for(var prop in arrBtn[iii]){
									if(prop.toLowerCase() == "onclick"){
										var aonclick = arrBtn[iii][prop];
									}else if(prop == "html"){
										var ahtml = arrBtn[iii][prop];
									}else{
										aattr += prop+"='"+arrBtn[iii][prop]+"' ";
									}
								}
								aattr += ">";
								//插入对应节点
								$(aattr+ahtml+"</a>").appendTo(formDom.find("table:eq(0)>tbody>tr>td>.actionBtnForList"))
								.on("click",function(){
									var index = formDom.find("table:eq(0)>tbody>tr>td>.actionBtnForList").index($(this).parents(".actionBtnForList"));
									_this.API.private(aonclick,$(this),_data[index]);
								})
							})(i)
						}
					}
					//权限判断
					_this.API.private("privateCheckAuth",formDom);
					//内容列表视图显示完发送的mess
					_this.API.private("privateMessConListOk",_data);
				},
				/**
				*@function
				*@name privateMessConListOk
				*@memberOf cmsMgrGadget
				*@description 列表显示完后发送的内部消息，可根据alias及视图指针判断
				*@example
				*/
				privateMessConListOk:function(_data){
				},
				/**
				*@function
				*@name privateBindFormListPage
				*@memberOf cmsMgrGadget
				*@param {jqueryContainer} _dom 内容列表生成后插入的dom节点
				*@param {Object} _param doServer内容列表的数据查询参数
				*@param {Object} _type  doServer内容列表的显示类型 0为通用列表，1为批量添加，2为外联列表，3纯展示内容，无任何表单编辑项
				*@param {Object} _callback 内容列表的回调函数，用于绑定按钮操作等
				*@description 内容列表回调函数，主要实现如下：
				* 1、doServer查询列表总数
				* 2、获取需要显示第几页的数据，没指定则从本地存储拿
				* 3、doServer查询当页数据
				* 4、生成列表前对数据中有List,Pics类型进行转换函数，以及数据描述和数据的自定义
				* 5、createFormList函数生成列表
				* 6、FW.use().showPagination绑定分页功能
				* 6、执行内容列表回调函数_callback
				*@example
				*/
				privateBindFormListPage:function(_dom,_param,_type,_callback){
					var _this = this;
					//生成列表前param的参数对外自定义接口
					_param = _this.API.private("privateSetListParam",_param);
					//查询总数条件
					_param.resultset = 'count';
					//计算list的数据总数
					_this.API.doServer(_this.MY.serverName.qCon, _this.MY.package, _param, function(code,data){
						if(code==0 && data){
							//储存数据总数
							var dataCount = parseInt(data.cmsdata[0].count) || 0;
							//判断总数是否为0，如果为0则显示空数据视图
							if(!dataCount){
								//表单生成前，对数据描述的自定义接口
								_this.API.private("privateSetDescAndData", _param.alias, null, function(){
									FW.use().createFormList(_this.MY.contentDesc[_param.alias],_dom,null,function(fieldName,fieldValue){
										_this.API.private("privateOutLinkCB",_this.MY.contentDesc[_param.alias], _dom, fieldName, fieldValue);
									},_type)
									//显示分页
									FW.use().showPagination(_dom.find("#pagination"));
								})
							}else{
								//获取pagesize
								var pageSize = _this.param.pagesize || 20;
								var lsPageNum = _param.param.nodeid ? (_param.alias + _param.param.nodeid) : _param.alias;
								var curPageNum = parseInt(FW.use().load(lsPageNum)) || 1;
								if(curPageNum > Math.ceil(dataCount/pageSize)){
									curPageNum = Math.ceil(dataCount/pageSize);
								}
								function reShowConList(_prePageNum){
									//存入本地存储
									FW.use().save(lsPageNum,_prePageNum);
									var pageNum = parseInt(_prePageNum);
									//将_param参数修改为获取最新newData数据的param
									_param.resultset = 'list';
									_param.spes.limit = {
										start: (pageSize*pageNum-pageSize).toString(),
										length: pageSize.toString()
									}
									_this.API.doServer(_this.MY.serverName.qCon, _this.MY.package, _param, function(code,data){
										if(code == 0){
											//表单生成前，对数据库数据类型转换
											_this.API.private("privateDataToForm", _this.MY.contentDesc[_param.alias], data.cmsdata);
											//重新显示列表数据
											function reShowOutLink(_data){
												//表单生成前，对数据描述和数据的自定义接口
												_this.API.private("privateSetDescAndData", _param.alias, _data, function(){
													//生成列表
													FW.use().createFormList(_this.MY.contentDesc[_param.alias], _dom, _data, function(fieldName,fieldValue){
														_this.API.private("privateOutLinkCB",_this.MY.contentDesc[_param.alias], _dom, fieldName, fieldValue,function(newdata){
															reShowOutLink(newdata);
														})
													},_type)
													//显示分页
													FW.use().showPagination(_dom.find("#pagination"),dataCount,pageSize,pageNum,function(prePageNum){
														reShowConList(prePageNum);
													})
													//执行内容列表回调函数
													_callback && _callback(data.cmsdata);
												})
											}
											reShowOutLink(data.cmsdata);
										}
									})
								}
								reShowConList(curPageNum);
							}
						}
					})
				},
				/**
				*@function
				*@name privateSetListParam
				*@memberOf cmsMgrGadget
				*@param {Object} _param doServer内容列表的数据查询参数
				*@return {Object}_param 自定义后的内容列表
				*@description 生成分页列表前，对查询参数的自定义功能，常用于条件查询，外联自定义设置等
				*@example
				*/
				privateSetListParam:function(_param){
					var _this = this;
					return _param;
				},
				/**
				*@function
				*@name privateShowConAdd
				*@memberOf cmsMgrGadget
				*@description 展示内容添加视图  兼容sonAlias内容添加
				* 需要完成的功能如下：
				* 1、显示提交、返回按钮
				* 2、定义当前视图指针
				* 3、替换操作标题
				* 4、显示内容添加视图
				* 5、获得生成表单的dom节点formDom
				* 6、增加视图独立样式class
				* 7、创建内容添加表单
				*注意，此视图拥有独立样式：curAlias+"_conAdd"
				*@example
				*/
				privateShowConAdd: function(){
					var _this = this;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curNodeid = _this.MY.cid;
						var curAlias = _this.MY.sonAlias;
					}else{
						var curNodeid = _this.MY.nodeid;
						var curAlias = _this.MY.alias;
					}
					if(!curNodeid && !_this.MY.noClass){
						FW.use('Widget').alert("请先选择栏目!");
						return;
					}
					//定义当前状态指针
					_this.MY.action = _this.MY.act.conAdd;
					//替换操作标题
					$("#actionName").text("内容添加");
					//显示内容添加视图
					_this.API.show(_this.param.viewConAdd);
					//获得List的dom
					var formDom = _this.API.find("#"+_this.param.formConAdd);
					//增加视图独立样式class
					formDom.addClass(curAlias+"_"+_this.MY.action).addClass(_this.MY.action);
					//重新显示列表数据
					function reShowOutLink(_data){
						//表单生成前，对数据描述和数据的自定义接口
						_this.API.private("privateSetDescAndData", curAlias, _data, function(){
							FW.use().createForm(_this.MY.contentDesc[curAlias], formDom, _data, function(fieldName,fieldValue){
								_this.API.private("privateOutLinkCB",_this.MY.contentDesc[curAlias], formDom, fieldName, fieldValue,function(newdata){
									reShowOutLink(newdata);
								})
							})
						})
					}
					reShowOutLink(null);
					//显示提交返回按钮
					$("#submitBtn").show();
					//内容添加视图显示完的mess
					_this.API.private("privateMessConAddOk");
				},
				/**
				*@function
				*@name privateMessConAddOk
				*@memberOf cmsMgrGadget
				*@description 内容添加视图显示完后发送的内部消息，可根据alias及视图指针判断
				*@example
				*/
				privateMessConAddOk:function(){
				},
				/**
				*@function
				*@name privateShowConPLAdd
				*@memberOf cmsMgrGadget
				*@description 展示内容批量添加视图  兼容sonAlias内容列表
				* 需要完成的功能如下：
				* 1、显示提交、返回按钮
				* 2、定义当前视图指针
				* 3、替换操作标题
				* 4、显示批量添加视图
				* 5、获得生成表单的dom节点formDom
				* 6、增加视图独立样式class
				* 7、初始化赋值10比空数据，并生成表单列表
				*注意，此视图拥有独立样式：curAlias+"_conPLAdd"
				*@example
				*/
				privateShowConPLAdd: function(){
					var _this = this;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curNodeid = _this.MY.cid;
						var curAlias = _this.MY.sonAlias;
					}else{
						var curNodeid = _this.MY.nodeid;
						var curAlias = _this.MY.alias;
					}

					if(!curNodeid && !_this.MY.noClass){
						FW.use('Widget').alert("请先选择栏目!");
						return;
					}
					//定义当前状态指针
					_this.MY.action = _this.MY.act.conPLAdd;
					//替换操作标题
					$("#actionName").text("内容批量添加");
					//显示批量添加视图
					_this.API.show(_this.param.viewConPLAdd);
					//获得dom
					var formDom = _this.API.find("#"+_this.param.formConPLAdd);
					//增加视图独立样式class
					formDom.addClass(curAlias+"_"+_this.MY.action).addClass(_this.MY.action);
					//初始化赋值10比空数据，并生成表单列表
					var blankData = [];
					var oneBlankData = {};
					for(var prop in _this.MY.contentDesc[curAlias]){
						oneBlankData[prop] = "";
					}
					for(var i=0;i<_this.param.plAddSetNum;i++){
						blankData.push(oneBlankData);
					}
					//重新显示列表数据
					function reShowOutLink(_data){
						//表单生成前，对数据描述和数据的自定义接口
						_this.API.private("privateSetDescAndData", curAlias, _data, function(){
							//生成列表
							FW.use().createFormList(_this.MY.contentDesc[curAlias],formDom,_data,function(fieldName,fieldValue){
								_this.API.private("privateOutLinkCB",_this.MY.contentDesc[curAlias], formDom, fieldName, fieldValue,function(newdata){
									reShowOutLink(newdata);
								})
							},1)
						})
					}
					reShowOutLink(blankData);
					//显示提交、返回按钮
					$("#submitBtn").show();
					//内容批量添加视图显示完的mess
					_this.API.private("privateMessConPLAddOk");
				},
				/**
				*@function
				*@name privateMessConPLAddOk
				*@memberOf cmsMgrGadget
				*@description 内容批量添加视图显示完后发送的内部消息，可根据alias及视图指针判断
				*@example
				*/
				privateMessConPLAddOk:function(){
				},
				/**
				*@function
				*@name privateShowConEdit
				*@memberOf cmsMgrGadget
				*@description 展示内容修改视图  兼容sonAlias内容修改
				* 需要完成的功能如下：
				* 1、根据是否存在sonAlias， 判断当前获取alias还是sonAlias
				* 2、根据是否存在sonAlias，判断当前获取cid还是sonCid
				* 3、显示提交、返回按钮
				* 4、定义当前视图指针
				* 5、替换操作标题
				* 6、显示子级sonAlias的Tab
				* 7、显示内容编辑视图
				* 8、获得生成表单的dom节点formDom
				* 9、增加视图独立样式class
				* 10、doServer获取内容data,
				* 11、转换data中数组字符串的情况为数组 privateDataToForm
				* 12、生成内容编辑表单 FW.use().createForm
				*注意，此视图拥有独立样式：curAlias+"_conPLAdd"
				*@example
				*/
				privateShowConEdit: function(){
					var _this = this;
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curAlias = _this.MY.sonAlias;
						var curCid = _this.MY.sonCid;
					}else{
						$("#tabSonAlias>ul>li").removeClass("active").eq(0).addClass("active");
						var curAlias = _this.MY.alias;
						var curCid = _this.MY.cid;
					}
					//定义当前状态指针 包含list,edit,add
					_this.MY.action = _this.MY.act.conEdit;
					//替换操作标题
					$("#actionName").text("内容修改");
					//显示内容编辑视图
					_this.API.show(_this.param.viewConEdit);
					//获得dom
					var formDom = _this.API.find("#"+_this.param.formConEdit);
					//增加视图独立样式class
					formDom.addClass(curAlias+"_"+_this.MY.action).addClass(_this.MY.action);
					//定义内容修改的data数据 的参数
					var param = {
						alias: curAlias,
						param:{
							cid: curCid
						}
					};
					_this.API.doServer(_this.MY.serverName.qCon,_this.MY.package,param,function(code,data){
						if(code == 0 && data && data.cmsdata){
							if(_this.MY.alias != "channel"){
								if(_this.MY.sonAlias){
									_this.MY.sonAlias = data.cmsdata[0].alias;
								}else{
									_this.MY.alias = data.cmsdata[0].alias;
								}
							}
							//获取子集数据描述
							if(!_this.MY.sonAlias){
								_this.API.private("privateGetSonDesc");
							}
							_this.API.private("privateContentDesc",curAlias,function(){
								//将数据库数据进行类型转换
								_this.API.private("privateDataToForm", _this.MY.contentDesc[curAlias], data.cmsdata);
								//重新显示列表数据
								function reShowOutLink(_data){
									//表单生成前，对数据描述和数据的自定义接口
									_this.API.private("privateSetDescAndData", curAlias, _data, function(){
										//生成表单
										FW.use().createForm(_this.MY.contentDesc[curAlias], formDom, _data, function(fieldName,fieldValue){
											_this.API.private("privateOutLinkCB",_this.MY.contentDesc[curAlias], formDom, fieldName, fieldValue,function(newdata){
												reShowOutLink(newdata);
											})
										})
									})
								}
								reShowOutLink(data.cmsdata[0]);
								//显示提交\返回按钮
								$("#submitBtn").show();
								//内容编辑视图显示完的mess
								_this.API.private("privateMessConEditOk",data.cmsdata[0]);
							})
						}
					})
				},
				/**
				*@function
				*@name privateMessConEditOk
				*@memberOf cmsMgrGadget
				*@description 内容编辑视图显示完后发送的内部消息，可根据alias及视图指针判断
				*@example
				*/
				privateMessConEditOk:function(data){
				},
				/**
				*@function
				*@name privateGetNodeDesc
				*@memberOf cmsMgrGadget
				*@description 展示栏目修改视图
				* 需要完成的功能如下：
				* 1、显示提交、返回按钮
				* 2、定义当前视图指针
				* 3、替换操作标题
				* 4、显示栏目编辑视图
				* 5、获得生成表单的dom节点formDom
				* 6、增加视图独立样式class
				* 7、doServer获取栏目内容data,
				* 8、生成表单前转换数据data，及data和desc的定制
				* 9、生成栏目内容编辑表单 FW.use().createForm
				*注意，此视图拥有独立样式：curAlias+"_classEdit"
				*@example
				*/
				privateShowClassEdit: function(){
					var _this = this;
					if(!_this.MY.nodeid){
						FW.use('Widget').alert("请先选择栏目!");
						return;
					}
					//定义当前状态指针 包含list,edit,add
					_this.MY.action = _this.MY.act.classEdit;
					//替换操作标题
					$("#actionName").text("栏目修改");
					//显示视图
					_this.API.show(_this.param.viewClassEdit);
					//获得dom
					var formDom = _this.API.find("#"+_this.param.formClassEdit);
					//增加视图独立样式class
					formDom.addClass(_this.MY.alias+"_"+_this.MY.action).addClass(_this.MY.action);
					//定义获取栏目修改的data数据
					var param = {
						alias: _this.MY.alias,
						param:{
							cid: _this.MY.nodeid
						}
					};
					_this.API.doServer(_this.MY.serverName.qNode,_this.MY.package,param,function(code,data){
						if(code == 0 && data.cmsdata){
							//表单生成前，对数据描述和数据的自定义接口
							_this.API.private("privateDataToForm", _this.MY.contentDesc[_this.MY.alias], data.cmsdata);
							//重新显示列表数据
							function reShowOutLink(_data){
								//生成表单
								FW.use().createForm(_this.MY.nodeDesc, formDom, _data, function(fieldName,fieldValue){
									_this.API.private("privateOutLinkCB",_this.MY.nodeDesc, formDom, fieldName, fieldValue,function(newdata){
										reShowOutLink(newdata);
									})
								})
							}
							reShowOutLink(data.cmsdata[0]);
							//显示提交、返回按钮
							$("#submitBtn").show();
							//栏目编辑视图显示完的mess
							_this.API.private("privateMessClassEditOk");
						}
					})
				},
				/**
				*@function
				*@name privateMessClassEditOk
				*@memberOf cmsMgrGadget
				*@description 栏目编辑视图显示完后发送的内部消息，可根据alias及视图指针判断
				*@example
				*/
				privateMessClassEditOk:function(){
				},
				/**
				*@function
				*@name privateGetNodeDesc
				*@memberOf cmsMgrGadget
				*@description 展示栏目添加视图
				* 需要完成的功能如下：
				* 1、显示提交、返回按钮
				* 2、定义当前视图指针
				* 3、替换操作标题
				* 4、显示栏目添加视图
				* 5、获得生成表单的dom节点formDom
				* 6、增加视图独立样式class
				* 7、生成表单前转换数据data，及data和desc的定制
				* 8、生成栏目内容添加表单 FW.use().createForm
				*注意，此视图拥有独立样式：curAlias+"_classAdd"
				*@example
				*/
				privateShowClassAdd: function(){
					var _this = this;
					if(!_this.MY.isding && !_this.MY.nodeid){
						FW.use('Widget').alert("请先选择栏目!");
						return;
					}
					//定义当前状态指针
					_this.MY.action = _this.MY.act.classAdd;
					//判断是否添加顶级栏目
					if(_this.MY.isding){
						$("#actionName").text("添加顶栏目");
					}else{
						$("#actionName").text("添加子栏目");
					}
					//显示栏目添加视图
					_this.API.show(_this.param.viewClassAdd);
					//获得dom
					var formDom = _this.API.find("#"+_this.param.formClassAdd);
					//增加视图独立样式class
					formDom.addClass(_this.MY.alias+"_"+_this.MY.action).addClass(_this.MY.action);
					//重新显示列表数据
					function reShowOutLink(_data){
						FW.use().createForm(_this.MY.nodeDesc, formDom, _data, function(fieldName,fieldValue){
							_this.API.private("privateOutLinkCB",_this.MY.nodeDesc, formDom, fieldName, fieldValue,function(newdata){
								reShowOutLink(newdata);
							})
						})
					}
					reShowOutLink(null);
					//显示提交返回按钮
					$("#submitBtn").show();
					//栏目添加视图显示完的mess
					_this.API.private("privateMessClassAddOk");
				},
				/**
				*@function
				*@name privateMessClassAddOk
				*@memberOf cmsMgrGadget
				*@description 栏目添加视图显示完后发送的内部消息，可根据alias及视图指针判断
				*@example
				*/
				privateMessClassAddOk:function(){
				},
				/**
				*@function
				*@name privateBtnConEdit
				*@memberOf cmsMgrGadget
				*@description 内容列表视图通用编辑按钮
				* 需要完成的功能如下：
				* 1、执行显示内容编辑视图函数
				*@example
				*/
				privateBtnConEdit: function(_dom,_data){
					//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
					if(this.MY.sonAlias){
						this.MY.sonCid = _data.cid;
					}else{
						this.MY.cid = _data.cid;
					}
					//获取当前
					this.API.private("privateShowConEdit");
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
						var _param = {
							alias:curAlias,
							param:{
								cid:_data.cid
							}
						}
						var _serverName = _this.MY.serverName.dCon;
						_this.API.doServer(_serverName,_this.MY.package,_param,function(code,data){
							if(code == 0){
								_this.API.private("privateShowConList");
							}else{
								FW.use('Widget').alert("内容删除失败！");
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
				//
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
								_this.API.addPost(_this.MY.serverName.dCon,_this.MY.package,{alias:curAlias,param:{cid:arrCheckData[i].cid}},function(code,data){
									if(code!==0){
										FW.use('Widget').alert("删除失败！");
									}
								});
						}
						_this.API.doPost(function(){
							_this.API.private("privateShowConList");

						})
					}
				},
				/**
				*@function
				*@name privateCheckAuth
				*@memberOf cmsMgrGadget
				*@param {jquerContainer} _dom 指定节点内的所有按钮进行权限判断
				*@description 定义带有属性：authority按钮的权限判断：用于是否显示按钮，
				* 需要完成的功能如下：
				* 1、根据this.MY.isrole指针判断是否对权限按钮进行权限判断，为true则显示所有权限按钮，不进行权限校验
				* 2、指针为false,则对所有按钮的authority属性值是否在authorityData对象当中，进行匹配
				* 3、匹配成功则显示，不成功则表示没有权限，则隐藏
				*@注意： authorityData是由页头head区域定义的全局变量，由后台传值权限对象
				*@example
				*/
				privateCheckAuth:function(_dom){
					if(this.MY.isrole){
						$("[authority]").show();
					}else{
						//判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
						var curAlias = this.MY.sonAlias || this.MY.alias;
						if(!curAlias || !authorityData) return;
						_dom.find("[authority]").each(function(){
						 	//获取页面权限的severname
						 	var serverName = "cms."+$(this).attr("authority");
						 	//从jsp传过来的authorityData对象中找serviceName，然后遍历其数组找alias
						 	if(!authorityData[serverName]) return true;
						 	for (var i = 0; i < authorityData[serverName].length; i++){
						 		if(authorityData[serverName][i].paramJson.alias == curAlias){
						 			$(this).show();
						 			break;
						 		}
						 	}
						})
					}
				},
				/**
				*@function
				*@name privateSubmitConList
				*@memberOf cmsMgrGadget
				*@description 内容列表页面提交按钮函数
				* 需要完成的功能如下：
				* 1、判断当前alias是否设置内容列表批量修改开关，如true则允许提交，如false则直接返回
				* 2、getDataAndCheck方法将获取表单数据并进行校验，转换成json，获取列表的存储数据数组
				* 3、转换data中有List、Pics数组类型为字符串
				* 4、遍历存储数组，将数据依次doServer保存进数据库
				* 5、执行回调函数_callback
				*@example
				*/
				privateSubmitConList: function(_callback){
					var _this = this;
					//判断当前视图是否存在__this.MY.sonAlias，如果存在则为内容子alias操作
					var curAlias = _this.MY.sonAlias || _this.MY.alias;
					if(!_this.param.plModSet[curAlias]){
						return;
					}
					//将表单转换成json，获取列表的存储数据数组
					var data = _this.API.find("#"+_this.param.formConList)[0].getDataAndCheck();
					if(!data) return;
					data = data.formList;
					if(!data.length) return;
					//转换data中有数组的情况为字符串
					for (var i = 0; i < data.length; i++) {
						_this.API.private("privateFormToData",_this.MY.contentDesc[curAlias],data[i]);
					}
					//多请求同时发送初始化
					_this.API.initPost();
					var _data = [];
					for (var i = 0; i < data.length; i++) {
						(function(iii){
							_this.API.addPost(_this.MY.serverName.mCon,_this.MY.package,{alias:curAlias,param:data[iii]},function(code,data){
								if(code==0){
									_data.push(data[0]);
								}else{
									FW.use('Widget').alert("Cid="+data[iii].cid+":修改失败！");
								}
							});
						})(i)
					}
					_this.API.doPost(function(){
						_callback && _callback();
					})
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
							_callback && _callback(data);
						}else{
							FW.use('Widget').alert("内容添加失败！");
						}
					})
				},
				/**
				*@function
				*@name privateSubmitConPLAdd
				*@memberOf cmsMgrGadget
				*@description 内容批量添加页面提交按钮函数
				* 需要完成的功能如下：
				* 1、getDataAndCheck方法将获取表单数据并进行校验，转换成json，获取列表的存储数据数组
				* 2、遍历数组转换data中有List、Pics数组类型为字符串
				* 3、将数据依次doServer保存进数据库
				* 4、执行回调函数_callback
				*@example
				*/
				privateSubmitConPLAdd: function(_callback){
					var _this = this;
					//将表单转换成json
					var data = _this.API.find("#"+_this.param.formConPLAdd)[0].getDataAndCheck();
					if(!data) return;
					data = data.formList;
					if(!data.length) return;
					//判断当前视图是否存在__this.MY.sonAlias，如果存在则为内容子alias操作
					//判断是否指定栏目
					if(_this.MY.sonAlias){
						var curNodeid = _this.MY.cid;
						var curAlias = _this.MY.sonAlias;
					}else{
						var curNodeid = _this.MY.nodeid;
						var curAlias = _this.MY.alias;
					}
					//转换data中有数组的情况为字符串
					for (var i = 0; i < data.length; i++) {
						_this.API.private("privateFormToData",_this.MY.contentDesc[curAlias],data[i]);
					}
					//遍历数据，删除空数据，并指定栏目nodeid,生成最新ndata
					var ndata = [];
					var hiddenData = _this.API.find("#"+_this.param.formConPLAdd)[0].getHiddenData();
					for (var i = 0; i < data.length; i++) {
						var status = false;
						for(var ppp in data[i]){
							if(data[i][ppp] !== hiddenData[0][ppp]){
								status = true;
							}
						}
						if(status){
							data[i].nodeid = curNodeid;
							ndata.push(data[i]);
						}
					};
					if(!ndata.length) return;
					//单个循环批量添加=======
					//多请求同时发送初始化
					_this.API.initPost();
					var _data = [];
					for (var i = 0; i < ndata.length; i++) {
						(function(iii){
							_this.API.addPost(_this.MY.serverName.aCon,_this.MY.package,{alias:curAlias,param:ndata[iii]},function(code,data){
								if(code==0 && data){
									_data.push(data);
								}else{
									FW.use('Widget').alert("第"+iii+"条数据添加失败！");
								}
							});
						})(i)
					}
					_this.API.doPost(function(){
						_callback && _callback(_data);
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
					//转换data中有数组的情况为字符串
					_this.API.private("privateFormToData",_this.MY.contentDesc[curAlias],data);
					var _param = {alias:curAlias,param:data};
					var _serverName = _this.MY.serverName.mCon;

					_this.API.doServer(_serverName,_this.MY.package,_param,function(code,data){
						if(code==0){
							_callback && _callback();
						}else{
							FW.use('Widget').alert("修改内容保存失败！");
						}
					})
				},
				/**
				*@function
				*@name privateSubmitClassEdit
				*@memberOf cmsMgrGadget
				*@description 栏目编辑添加页面提交按钮函数
				* 需要完成的功能如下：
				* 1、getDataAndCheck方法将获取表单数据并进行校验，转换成json
				* 2、转换data中有List、Pics数组类型为字符串
				* 3、将数据doServer保存进数据库
				* 4、执行回调函数_callback
				*@example
				*/
				privateSubmitClassEdit: function(_callback){
					var _this = this;
					//将表单转换成json
					var data = _this.API.find("#"+_this.param.formClassEdit)[0].getDataAndCheck();
					if(!data) return;
					//转换data中有数组的情况为字符串
					_this.API.private("privateFormToData",_this.MY.nodeDesc,data);
					var param = {
						alias:_this.MY.alias,
						param:data
					};
					_this.API.doServer(_this.MY.serverName.mNode,_this.MY.package, param, function(code,data){
						if(code == 0){
							_callback && _callback();
						}else{
							FW.use('Widget').alert("修改栏目保存失败！");
						}
					})
				},
				/**
				*@function
				*@name privateSubmitClassAdd
				*@memberOf cmsMgrGadget
				*@description 栏目添加页面提交按钮函数
				* 需要完成的功能如下：
				* 1、getDataAndCheck方法将获取表单数据并进行校验，转换成json
				* 2、转换data中有List、Pics数组类型为字符串
				* 3、将数据doServer保存进数据库
				* 4、执行回调函数_callback
				*@example
				*/
				privateSubmitClassAdd: function(_callback){
					var _this = this;
					//将表单转换成json
					var data = _this.API.find("#"+_this.param.formClassAdd)[0].getDataAndCheck();
					if(!data) return;
					data.nodeid = _this.MY.isding?0:_this.MY.nodeid;
					//转换data中有数组的情况为字符串
					_this.API.private("privateFormToData",_this.MY.nodeDesc,data);
					var param = {
							alias: _this.MY.alias,
							param: data
						};
					_this.API.doServer(_this.MY.serverName.aNode,_this.MY.package,param,function(code,data){
						if(code == 0 && data){
							_callback(data);
						}else{
							FW.use('Widget').alert("添加栏目保存失败！");
						}
					})
				}
			},
			TrigerEvent:{
				/**
				*@function
				*@name trigerSubmit
				*@memberOf cmsMgrGadget
				*@description 用于各种视图的提交事件<br/>
				*注意，视图包含有：列表提交，内容添加视图，批量添加视图，编辑内容视图，添加栏目视图，编辑栏目视图
				*@example
				*/
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
				/**
				*@function
				*@name trigerChangeClass
				*@memberOf cmsMgrGadget
				*@description 栏目树点击事件<br/>
				*注意，点击栏目的栏目名，显示点击的当前栏目所对应ctalias的内容列表或编辑该栏目自身
				*@param {Int} nodeid 栏目id
				*@param {String} ctalias 栏目表ctalias字段，标识该栏目所对应的alias
				*@example
				*/
				trigerChangeClass: function(nodeid,ctalias){
					var _this = this;
					//赋值给this对象的nodeid
					_this.MY.nodeid = nodeid;
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					if(_this.MY.isSelfAlias){  //如果自己挂自己
						_this.API.private("privateShowClassEdit");
					}else{
						if(ctalias) _this.MY.alias = ctalias;
						_this.API.private("privateContentDesc",_this.MY.alias,function(){
							_this.API.private("privateShowConList");
						})
					}
				},
				/**
				*@function
				*@name trigerContentList
				*@memberOf cmsMgrGadget
				*@description 显示内容列表视图
				*@example
				*/
				trigerContentList: function(){
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					this.API.private("privateShowConList");
				},
				/**
				*@function
				*@name trigerContentList
				*@memberOf cmsMgrGadget
				*@description 显示内容添加视图
				*@example
				*/
				trigerContentAdd: function(){
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					this.API.private("privateShowConAdd");
				},
				/**
				*@function
				*@name trigerContentList
				*@memberOf cmsMgrGadget
				*@description 显示批量内容添加视图
				*@example
				*/
				trigerContentPLAdd: function(){
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					this.API.private("privateShowConPLAdd");
				},
				/**
				*@function
				*@name trigerContentList
				*@memberOf cmsMgrGadget
				*@description 显示栏目修改视图
				*@example
				*/
				trigerClassEdit: function(){
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					this.API.private("privateShowClassEdit");
				},
				/**
				*@function
				*@name trigerContentList
				*@memberOf cmsMgrGadget
				*@description 显示栏目添加视图
				*@param {String} isding 是否是添加顶级栏目 "0"标示是顶级栏目,默认为添加子栏目
				*@example
				*/
				trigerClassAdd: function(isding){
					if(isding=="0"){
						this.MY.isding = true;
					}else{
						this.MY.isding = false;
					}
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					this.API.private("privateShowClassAdd");
				},
				/**
				*@function
				*@name trigerContentList
				*@memberOf cmsMgrGadget
				*@description 删除当前选中的栏目
				*@example
				*/
				trigerClassDel: function(){
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					if(!this.MY.nodeid){
						FW.use('Widget').alert("请先选择栏目");
						return;
					}
					var param = {
							param:{
								cid: this.MY.nodeid
							},
							alias: this.MY.alias
						};
					if(confirm("确定要删除该栏目吗？")){
						this.API.doServer(this.MY.serverName.dNode,this.MY.package,param,function(code,data){
							if(code == 0 && data){
								FW.use('Widget').alert("栏目删除成功！");
								document.location.href = document.location.href;
							}else{
								FW.use('Widget').alert("栏目删除失败！");
							}
						})
					}
				},
				/**
				*@function
				*@name trigerGoBack
				*@memberOf cmsMgrGadget
				*@description 返回内容列表视图
				*@example
				*/
				trigerGoBack: function(){
					//删除sonAlias
					delete this.MY.sonAlias;
					//隐藏子级头
					$("#tabSonAlias").hide();
					$("#btnAddSonAlias").hide();
					$("#btnPLAddSonAlias").hide();
					this.API.private("privateShowConList");
				},
				/**
				*@function
				*@name trigerCheckBoxClick
				*@memberOf cmsMgrGadget
				*@description 列表视图 复选框点击事件扩展接口
				*@param {object} rowData 当前行的data数据
				*@example
				*/
				trigerCheckBoxClick:function(rowData){
					//FW.use('Widget').alert(FW.use().toJSONString(rowData));
				}

			}
		}
	);
	return FW;
});

