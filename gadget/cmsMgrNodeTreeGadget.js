define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	FW.register(
		{
			param:{
				/**				
				*@name displayName
				*@memberOf cmsMgrNodeTreeGadget
				*@description 栏目树显示的栏目字段名 默认为displayName	格式{"xxxalias":"fieldName"};
				*/
				displayName:{}

			},
			name:"cmsMgrNodeTreeGadget",
			onCreate:function(){
			},
			private:{
				//显示栏目视图函数
				//2013-11-26日罗光瑜扩展，增加从参数可以动态控制显示的名称以及查询的过滤参数，但兼容原来的程序
				privateShowNodeTree: function(alias,_displayName,_param){
					var _this = this;
					//获取栏目树显示的字段
					_this.MY.displayName = _displayName || _this.param.displayName[alias] ||  "displayName";
					//定义获取父栏目列表的data数据 的参数
					//2013-11-26日罗光瑜扩展，增加从参数可以动态控制显示的名称以及查询的过滤参数，但兼容原来的程序
					_this.API.doServer("queryNode", "cms", {alias:alias,param:_param}, function(code,data){
						if(code == 0){
							//显示视图
							_this.API.show("viewNodeTree");
							//封装栏目数据为树形数据结构
							//param: name , type , additionalParameters, children
							var temp = {};
							var tree_data = {};
							//遍历数据
							if(data.cmsdata && data.cmsdata.length){
								for (var i = 0; i < data.cmsdata.length; i++) {
									var t_cid = data.cmsdata[i].cid; 				    //栏目id
									var t_alias = data.cmsdata[i].alias; 			    //栏目别名
									var t_nodeID = data.cmsdata[i].nodeid;  		    //父栏目id
									var t_displayName = data.cmsdata[i][_this.MY.displayName];	//栏目名称
									//2013-11-26日罗光瑜修改，如果被挂接节点本身有父节点，也要正常显示,这是所有节点全部是父节点
									var parentAlias = data.cmsmetadata && data.cmsmetadata.parentAlias;//cmsmetadata: Object
									if (parentAlias && parentAlias!=t_alias){
										t_nodeID = 0;
									}
									if(data.cmsdata[i].ctalias) var t_ctalias = data.cmsdata[i].ctalias;  //ctalias 多个alias挂接在一个栏目的情况

									//整理自己
									var selfData = {
										name:t_displayName,
										type:'item',
										cid:t_cid
									};
									if(t_ctalias) selfData.ctalias = t_ctalias;

									//判断之前的假自己是否已经存在
									if (temp[t_cid]){
										selfData.type = 'folder';
										selfData.additionalParameters = temp[t_cid].additionalParameters;
									}

									temp[t_cid] = selfData;							

									//判断是否是顶级节点
									//2013-08-13 杨昆  如果非直接在页面上创建树，那么顶级结点t_nodeID为null，这样无法显示；需要加上null 判断
									if(t_nodeID == null || t_nodeID == 0){								
										//直接加入到临时列表中
										tree_data[t_cid] = selfData;
										continue;
									}

									//获取老爸
									var parent = temp[t_nodeID];
									if (!parent){
										//造一个假老爸
										parent = {									
										};
										//丢到临时数据里面
										temp[t_nodeID] = parent;
									}
									//把自己加入到老爸中
									parent.type = 'folder';
									if (!parent.additionalParameters){
										parent.additionalParameters ={
											children:{}
										}
									}
									parent.additionalParameters.children[selfData.cid] = selfData;
								}
							}
							
							//栏目树数据组合函数
							var DataSourceTree = function(options) {
								this._data 	= options.data;
								this._delay = options.delay;
							}

							DataSourceTree.prototype.data = function(options, callback) {
								var self = this;
								var $data = null;

								if(!("name" in options) && !("type" in options)){
									$data = this._data;//the root tree
									callback({ data: $data });
									return;
								}
								else if("type" in options && options.type == "folder") {
									if("additionalParameters" in options && "children" in options.additionalParameters)
										$data = options.additionalParameters.children;
									else $data = {}//no data
								}
								
								if($data != null)//this setTimeout is only for mimicking some random delay
									setTimeout(function(){callback({ data: $data });} , parseInt(Math.random() * 500) + 200);
							}
							var treeDataSource = new DataSourceTree({data: tree_data});


							// alert(FW.use().toJSONString(treeDataSource));

							//栏目树生成
							_this.API.find('#nodeTree').ace_tree({
								dataSource: treeDataSource ,
								multiSelect:false,
								loadingHTML:'<div class="tree-loading"><i class="icon-refresh icon-spin blue"></i></div>',
								'open-icon' : 'icon-minus',
								'close-icon' : 'icon-plus',
								'selectable' : true,
								'selected-icon' : 'icon-ok',
								'unselected-icon' : 'icon-remove~'
							});

							//获取url中参数nodeid,并将栏目树对勾选中，并考虑存在ctalias情况
							var _nodeid = FW.use().getParameter("nodeid") || "";
							if(_nodeid) _this.nodeid = _nodeid;

							_this.API.find(".tree-item-name").each(function(){
								if($(this).attr("cid") == _nodeid){
									$(this).prev().attr("class","icon-ok");
									$(this).parent().addClass("tree-selected");
								}
							})
						}else{
							$(".shownodecontent").removeClass("shownodecontent");
						}
					})
				}
			},
			TrigerEvent:{
				//2013-11-26日罗光瑜扩展，增加从参数可以动态控制显示的名称以及查询的过滤参数，但兼容原来的程序
				trigerReShowNodeTree: function(alias,_displayName,_param){
					this.API.private("privateShowNodeTree",alias,_displayName,_param);
				}
			}
		}
	)
	return FW;
})

