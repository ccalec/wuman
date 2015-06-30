define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	FW.register(
		{
			name:"cmsMgrRolesGadget",
			onCreate:function(){

				var _this = this;

				//定义package
				_this.package = {
					cms:"cms",
					role:"role"
				};

				//定义各种情况的serverName
				_this.serverName = {
					qCon:    "queryContent", 	        //查自身内容表内容
					mRoles:  "modifyAction"             //修改权限
				};

				//定义alias
				_this.alias = "rolesAction";
				_this.rolesAlias = "roles";
				_this.action = "action";

				//视图ID
				_this.viewID = "viewCmsRoles";

				//存储组合对象
				var newData = {};

				//根据url的nodeid获取角色信息
				_this.nodeid = FW.use().getParameter("nodeid") || "";
				if(!_this.nodeid) return;

				var rolesParam = {
					alias: _this.rolesAlias,
					param: {
						cid: _this.nodeid
					}
				};

				_this.API.doServer(_this.serverName.qCon,_this.package.cms,rolesParam,function(code,data){
					if(code==0 && data){
						newData.rolesName = data.cmsdata[0].displayName;
						newData.enname = data.cmsdata[0].name;
						newData.arrCMSCheckName = ['本表新增','本表删除','本表修改','本表查询','父表新增','父表删除','父表修改'];
						//从cmsmatedata表循环出表内容，获取alias
						_this.API.doServer(_this.serverName.qCon,_this.package.cms,{alias:_this.action},function(code,data){
							if(code==0 && data){
								if(!data.cmsdata || !data.cmsdata.length) return;
								//重组查询出的权限结果，并分类
								var cmsData= {};
								var zdyData = [];
								var arrCMSServiceName = ['cms.addContent','cms.deleteContent','cms.modifyContent','cms.queryContent','cms.addNode','cms.deleteNode','cms.modifyNode'];
								for (var i = 0; i < data.cmsdata.length; i++) {
									if(data.cmsdata[i].paramJson && FW.use().evalJSON(data.cmsdata[i].paramJson).alias && $.inArray(data.cmsdata[i].serviceName, arrCMSServiceName) != -1){
										var _sn = $.inArray(data.cmsdata[i].serviceName, arrCMSServiceName);
										var _alias = FW.use().evalJSON(data.cmsdata[i].paramJson).alias;
										var _actionName = data.cmsdata[i].actionName.substring(2).replace("节点","");
										cmsData[_alias] = cmsData[_alias] || {};
										cmsData[_alias]['actionName'] = cmsData[_alias]['actionName'] || _actionName;
										cmsData[_alias]['rolesArr'] = cmsData[_alias]['rolesArr'] || ["","","","","","",""];
										cmsData[_alias]['rolesArr'][_sn] = data.cmsdata[i].cid;
									}else{
										var _actionName = data.cmsdata[i].actionName;
										var newZdyData = {};
										newZdyData.cid = data.cmsdata[i].cid;
										newZdyData.actionName = data.cmsdata[i].actionName;
										newZdyData.serviceName = data.cmsdata[i].serviceName;
										zdyData.push(newZdyData);
									}
								};
								newData.cmsData = cmsData;
								newData.zdyData = zdyData;

								//将已有权限actionCid存入newData
								newData.arrHavedAction = [];

								//给已有权限加上对勾
								var rolesActionParam = {
									alias: _this.alias,
									param: {
										nodeid: _this.nodeid
									}
								};

								_this.API.doServer(_this.serverName.qCon,_this.package.cms,rolesActionParam,function(code,data){
									if(code==0){
										if(data && data.cmsdata && data.cmsdata.length){
											for (var i = 0; i < data.cmsdata.length; i++) {
												newData.arrHavedAction.push(data.cmsdata[i].actionCid);
											};
										}

										//显示列表视图
										_this.API.show(_this.viewID,newData);

										//行鼠标经过事件
										_this.API.find(".profile-info-row").hover(function(){
											$(this).css("background","#f7f7f7");
										},function(){
											$(this).css("background","none");
										});

										//cms全选，反选
										_this.API.find(".cmsSelAll").click(function(){
											var cbox = _this.API.find("#cmsList input[type='checkbox']");
											cbox.attr("checked","true");
										})
										_this.API.find(".cmsCalAll").click(function(){
											var cbox = _this.API.find("#cmsList input[type='checkbox']");
											cbox.each(function(){
												if($(this).attr("checked")){
												    $(this).removeAttr("checked");
												}else{
												   $(this).attr("checked","true");
												}
											})
										})

										//zdy全选，反选
										_this.API.find(".zdySelAll").click(function(){
											var cbox = _this.API.find("#zdyList input[type='checkbox']");
											cbox.attr("checked",'true');
										})
										_this.API.find(".zdyCalAll").click(function(){
											var cbox = _this.API.find("#zdyList input[type='checkbox']");
											cbox.each(function(){
												if($(this).attr("checked")){
												    $(this).removeAttr("checked");
												}else{
												   $(this).attr("checked","true");
												}
											})
										})

										//单行全选，反选
										_this.API.find(".rowSelAll").click(function(){
											var cbox = $(this).parents(".profile-info-row").find("input[type='checkbox']");
											cbox.attr("checked",'true');
										})
										_this.API.find(".rowCalAll").click(function(){
											var cbox = $(this).parents(".profile-info-row").find("input[type='checkbox']");
											cbox.each(function(){
												if($(this).attr("checked")){
												    $(this).removeAttr("checked");
												}else{
												   $(this).attr("checked","true");
												}
											})
										})
									}
								})
							}
						})
					}
				})
			},
			FireEvent:{

			},
			TrigerEvent:{
				eventSubmit:function(){
					if(confirm("确认需要修改吗？")){
						var resultArr = [];
						this.API.find("input[name='rolestatus']:checked").each(function(){
							resultArr.push($(this).val());
						})
						var param = {
							nodeid: this.nodeid
						};

						param.actionCid = resultArr.join(",") || "-1";

						this.API.doServer(this.serverName.mRoles,this.package.role,param,function(code,data){
							if(code==0){
								alert("保存成功！");
								document.location.href = "CMSMgr.jsp?alias=roles";
							}
						})
					}
				}
			}
		}
	);
	return FW;
});