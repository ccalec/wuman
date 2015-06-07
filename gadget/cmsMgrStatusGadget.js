/** 
* @fileOverview CMS后台审核状态流程控制Gadget 
* @author <a href="http://www.wgfly.com">Alec</a> 
* @version 0.1
*/ 

/**
* @namespace
* @author Alec 
* @name cmsMgrStatusGadget 
* @description  这是一个用于修改单条数据当前审核状态值的功能gadget,用于多流程审核功能
*/ 

define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	
	FW.register(
		{
			param:{
				/**				
				*@name fieldDesc
				*@memberOf cmsMgrStatusGadget
				*@description 描述字段的字段名			
				*/
				fieldDesc:""
			},
			name:"cmsMgrStatusGadget",
			onCreate:function(){
			},
			FireEvent:{
				
			},
			TrigerEvent:{
				/**
				*@function
				*@name trigercmsMgrStatusGadget
				*@memberOf cmsMgrStatusGadget
				*@description 审核状态的triger事件
				*@param {String} xxxx
				*@example 
				* 《a href="#" onclick="FW.trigerEvent('trigercmsMgrStatusGadget','alias',{})" 》lioing《/a》
				*/
				trigercmsMgrStatusGadget:function(__alias,__rowData){
					var _this = this;
					var statusData = {};
					if(_this.param.fieldDesc && __rowData[_this.param.fieldDesc]){
						statusData.descData = {};
						statusData.descData[_this.param.fieldDesc] = __rowData[_this.param.fieldDesc];
					}
					//根据输入的当前状态获取该状态所支持的action信息
					_this.API.doServer("getStatusAction","StatusCtr",{alias:__alias,curStatus:__rowData.status},function(code,data){
						if(code==0&&data){
							statusData.radioData = data;
							//生成radio,显示视图
							_this.API.show("viewcmsMgrStatusGadget",statusData);
							var statusCtrHTML = _this.API.find("#viewcmsMgrStatusGadget").html();
							_this.API.find("#viewcmsMgrStatusGadget").empty();
							
							//显示弹出层
							var jsonStrHTML = "<div class='modal-header' style='margin-bottom:20px;'><h3>状态审核</h3></div>"+statusCtrHTML;
							bootbox.dialog(jsonStrHTML, [{
									"label" : "<i class='icon-ok bigger-110'></i> 保存",
									"class" : "btn btn-small btn-success",
									"callback": function(){
										//获得当前选择的action值
										var actionNameVal = $(".modal-body input[name='actionName']").val();
										//获得描述字段的值
										var statusDescVal = $(".modal-body input[name='statusDesc']").val();
										//执行setStatus service
										_this.API.doServer("setStatus","StatusCtr",{alias:__alias,curStatus:__rowData.status},function(code,data){
											if(code==0&&data){
												FW.trigerEvent("trigerContentList");
											}else{
												alert("setStatus出错!");
											}
										})
									}
								}, {
									"label" : "<i class='icon-undo bigger-110'></i> 取消",
									"class" : "btn btn-small",
									"callback": function() {

									}
								}]
							);
							//绑定提交事件

						}else{
							alert("getStatusAction出错或未有可操作项");
						}

					})
				}
			}
		}
	);
	return FW;
});

