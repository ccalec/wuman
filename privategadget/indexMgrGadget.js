
define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	require("../gadget/userInfoGadget");
	FW.register(
		{
			param:{
			},
			name:"indexMgrGadget",
			extends:["userInfoGadget"],
			onCreate:function(){
				// 获取全局系统参数
				this.MY.cmsconfig = {};
				var param = {
					alias: "cmsconfig",
					param: {
					},
					spes:{
						orderby:[{
							name:"cid",
							desc:"false"
						}]
					}
				};
				this.API.doServer("queryContent", "cms", param, function(code,data){
					if(code==0&&data){
						// 获取cmsconfig
						for (var i = 0; i < data.cmsdata.length; i++) {
							this.MY.cmsconfig[data.cmsdata[i].cid] = data.cmsdata[i].value;
						};
						// 获取登录信息
						this.API.doServer(this.param.getinfoServiceName, this.param.getinfoServicePackage,{},
							function(code,data){
								if (code ==0 && data){
									this.MY.userInfo = data;
									// 如果cmsconfig开关为关闭状态，则关闭网站
									if(this.MY.cmsconfig["3"]!=1){
										this.API.show("view_noAct", this.MY.userInfo);
										return;
									}
									// hash路由设置
									this.API.private("privateHashEnterRoute");
								}else{
									this.API.show("view_userNotLogin",this.MY.userInfo,null,true);
								}
								$("#actTit").text("（"+this.MY.cmsconfig["2"]+"）");
							}
						);
					}
				})
			},
			FireEvent:{
				fireRoute: function(stepName){
					this.API.private('privateRoute',stepName);
				},
				fireResetCart: function(){
					this.MY.shopCart = {};
					this.API.private("privateSetStorage","shopCart",null);
					this.API.private("privateRouteShopping");
				},
				fireSubmitOrder: function(){
					var _this = this;
					if(!_this.API.private('privateVerifyYuSuan')) return;
					if(!_this.API.private('privateVerifyShopping')) return;
					// 字段校验
					var formDom = _this.API.find("#submitOrder");
					var fieldsObj = {
						receivename: formDom.find("input[name='receivename']").val(),
						receivephone: formDom.find("input[name='receivephone']").val(),
						receiveaddress: formDom.find("input[name='receiveaddress']").val(),
						receivetime: formDom.find("input[name='receivetime']").val(),
						other: formDom.find("textarea[name='other']").val()
					};
					// 参数校验
					if(!_this.API.private("privateVerifyParam", fieldsObj)) return;
					// 让按钮失效
					_this.API.find("#btn2SubmitOrder").addClass("disabled").find("i").addClass("icon-spinner icon-spin");
					// 生成订单记录
					var param = {
						"alias": "juorder",
						"param": {
							"biz": _this.MY.userInfo.biz,
							"total" : _this.API.private("privateGetPayMoney"),
							"name": _this.MY.userInfo.name,
							"peoplenum": _this.API.private("privateGetStorage","people_num"),
							"receivename": fieldsObj.receivename,
							"receivephone": fieldsObj.receivephone,
							"receiveaddress": fieldsObj.receiveaddress,
							"receivetime": fieldsObj.receivetime,
							"other": fieldsObj.other,
							"nodeid": "1",
							"mcid": _this.MY.userInfo.cid,
							"addtime": moment()._d.getTime().toString()
						}
					};
					_this.API.doServer("addContent", "cms", param, function(code,data){
						if(code==0 && data){
							var orderNo = data[1];
							// 处理购物车订单详情数据
							var arrSqlstr = [];
							for(var pid in _this.MY.shopCart){
								var pnum = _this.MY.shopCart[pid].num;
								var sqlstr = "SELECT 'orderdesc',"+pnum+","+pid+","+orderNo;
								arrSqlstr.push(sqlstr);
							}
							var sql = arrSqlstr.join(" UNION ALL ");
							_this.API.doServer("addOrderDesc", "customer", {sql: sql}, function(code,data){
								if(code==0 && data){
									_this.API.show("view_submitSuccess",{orderNo: orderNo},null,true);
									// 清空购物车
									_this.MY.shopCart = {};
									_this.API.private("privateClearStorage");
								}else{
									_this.API.show("view_submitFail",null,null,true);
								}
								this.API.private("privateDoMenu","show");
							})
						}
					})
				},
				fireOrderDesc: function(cid){
					var _this = this;
					var param = {
						alias: "juorder",
						param: {
							cid: cid
						},
						spes:{
							orderby:[{
								name:"cid",
								desc:"false"
							}]
						}
					};
					_this.API.doServer("queryContent", "cms", param, function(code,data){
						if(code==0 && data){
							var orderDescData = data.cmsdata[0];
							// 查询商品列表
							param.alias = "orderdesc";
							param.param = {nodeid: cid};
							_this.API.doServer("queryContent", "cms", param, function(code,data){
								if(code==0 && data){
									orderDescData.proList = data.cmsdata;
									_this.API.show("view_orderDesc", orderDescData,null,true);
								}
							})
						}
					})
				},
				fireOrderDel: function(cid, xthis){
					var _this = this;
					if(!window.confirm("确定删除订单："+cid+" 吗?")) return;
					_this.API.doServer("delOrder", "customer", {cid: cid}, function(code,data){
						if(code==0 && data){
							alert("删除成功!");
							$(xthis).parents("tr").remove();
						}else if(code==21){
							alert("删除失败，缺少权限！");
						}
					})
				}
			},
			private:{
				privateRouteWelcome: function(){
					document.location.hash = "welcome";
					this.API.show("view_userLogin", this.MY.userInfo,null,true);
					this.API.private("privateDoMenu","show");
				},
				privateRouteYuSuan: function(){
					var _this = this;
					document.location.hash = "yusuan";
					_this.API.private("privateDoMenu","show");
					_this.API.show("view_yusuan",{
						num: _this.API.private("privateGetStorage","people_num") || 0,
						biaozhun: _this.MY.cmsconfig["1"]
					},null,true);
					// 滚轮效果初始化
					var $this = _this.API.find("#spinner-opts input[type=text]");
					$this.hide().after('<span />');
					$this.next().addClass('ui-slider-small').
					addClass("inline ui-slider-green").
					css('width','700px').slider({
						value:parseInt($this.val()),
						range: "min",
						animate:true,
						min: parseInt($this.attr('data-min')),
						max: parseInt($this.attr('data-max')),
						step: parseFloat($this.attr('data-step')) || 1,
						slide: function( event, ui ) {
							// $this.val(ui.value);
							var rbVal = _this.MY.cmsconfig["1"];
							var ynum = _this.API.find("#people_num").text();
							var ytotal = _this.API.find("#total_money").text();
							_this.MY.yusuan = _this.MY.yusuan || {};
							// 存储到storange
							_this.API.private("privateSetStorage", "people_num", ui.value);
							_this.API.private("privateSetStorage", "total_money", ui.value*rbVal);
							// 动画变幻
							_this.API.private("privateAnimNum", "#people_num", ynum, ui.value);
							_this.API.private("privateAnimNum", "#total_money", ytotal, ui.value*rbVal);
							if(ui.value){
								_this.API.find("#btn2shop").removeClass("disabled");
							}else{
								_this.API.find("#btn2shop").addClass("disabled");
							}
						}
					});
					// 默认动画变幻数字
					_this.API.private("privateAnimNum", "#people_num", 0, _this.API.private("privateGetStorage","people_num"));
					_this.API.private("privateAnimNum", "#total_money", 0, _this.API.private("privateGetStorage","total_money"));
					if(parseInt(_this.API.private("privateGetStorage","people_num"))) _this.API.find("#btn2shop").removeClass("disabled");
				},
				privateRouteShopping: function(){
					var _this = this;
					if(!_this.API.private('privateVerifyYuSuan')) return;
					document.location.hash = "shopping";
					_this.API.private("privateDoMenu","show");
					_this.MY.shopCart = _this.MY.shopCart || FW.use().evalJSON(_this.API.private("privateGetStorage","shopCart")) || {}; //定义购物车对象
					var param = {
						alias: "product",
						param: {
							nodeid: "0"
						},
						spes:{
							orderby:[{
								name:"cid",
								desc:"false"
							}],
							limit:{
								start: 0,
								length: "100"
							}
						}
					};
					_this.API.doServer("queryNode", "cms", param, function(code,data){
						if(code!==0 || !data.cmsdata) return;
						var newData = {};
						newData.nodeList = data.cmsdata;
						newData.colorArr = ['', 'green','red','orange','purple','dark'];
						_this.API.show("view_shopping", newData,null,true);
						_this.API.private("privateBindTabEvent",param);
						_this.API.find('#myTab a[data-toggle="tab"]').eq(0).click();

						// 初始化购物车
						// 默认动画变幻数字
						_this.API.private("privateAnimNum", "#pay_money", 0, _this.API.private("privateGetPayMoney"));
						_this.API.private("privateAnimNum", "#pro_num", 0, _this.API.private("privateGetProNum"));
						_this.API.private("privateAnimNum", "#total_money", 0, _this.API.private("privateGetStorage","total_money"));
						if(_this.API.private("privateGetProNum")==0) {
							_this.API.find("#payBox").addClass("empty");
						}
						if(_this.API.private("privateGetPayMoney") > _this.API.private("privateGetStorage","total_money")) {
							_this.API.find("#payBox").addClass("over");
						}
						if(_this.API.private("privateGetProNum") && _this.API.private("privateGetPayMoney") <= _this.API.private("privateGetStorage","total_money")) {
							_this.API.find("#btn2order").removeClass("disabled");
							_this.API.find("#payBox").removeClass("red");
						}
					})
				},
				privateRouteOrder: function(){
					var _this = this;
					if(!_this.API.private('privateVerifyYuSuan')) return;
					_this.MY.shopCart = _this.MY.shopCart || FW.use().evalJSON(_this.API.private("privateGetStorage","shopCart")) || {}; //定义购物车对象
					if(!_this.API.private('privateVerifyShopping')) return;
					document.location.hash = "order";
					_this.API.private("privateDoMenu","show");
					// 定义或读取storage内的已选商品
					if(_this.MY.shopCart){
						_this.API.private("privateSetStorage","shopCart",FW.use().toJSONString(_this.MY.shopCart));
					}else{
						_this.MY.shopCart = FW.use().evalJSON(_this.API.private("privateGetStorage","shopCart")) || {}; //定义购物车对象
					}
					var orderData = {
						userInfo: _this.MY.userInfo,
						shopCart: _this.MY.shopCart,
						cartInfo: {
							people_num: _this.API.private("privateGetStorage","people_num"),
							total_money: _this.API.private("privateGetStorage","total_money"),
							pro_num: _this.API.private("privateGetProNum"),
							pay_money: _this.API.private("privateGetPayMoney")
						}
					};
					_this.API.show("view_order", orderData,null,true);
					_this.API.private("privateDateRangerInit");
				},
				privateRouteOrderMgr: function(){
					var _this = this;
					document.location.hash = "ordermgr";
					_this.API.private("privateDoMenu","show");
					var param = {
						alias: "juorder",
						param: {
							mcid: _this.MY.userInfo.cid
						},
						spes:{
							orderby:[{
								name:"cid",
								desc:"true"
							}],
							limit:{
								start: 0,
								length: "10"
							}
						}
					};
					_this.API.doServer("queryContent", "cms", param, function(code,data){
						if(code==0){
							if(data && data.cmsdata){
								_this.API.show("view_orderMgr", {orderList: data.cmsdata},null,true);
							}else{
								_this.API.show("view_orderMgr", null,null,true);
							}
						}
					})
				},
				privateAnimNum: function(dom,y,n){
		      $({domNum: y}).animate({
		        domNum: n
		      },{
		        duration: 300,
		        easing: 'linear',
		        step: function () {
		          if(n%1!==0){
		            $(dom).text(this.domNum.toFixed(1));
		          }else{
		            $(dom).text(Math.ceil(this.domNum));
		          }
		        },
		        done: function () {
		          $(dom).text(this.domNum%1!==0?this.domNum.toFixed(1):this.domNum);
		        }
		      });
		    },
		    privateBindTabEvent :function(param){
		    	var _this = this;
		    	_this.API.find('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
						var proList = {};
						param.param.nodeid = _this.MY.clickid = _this.API.find(e.currentTarget).attr("data-cid");
						// 获取子栏目
						_this.API.doServer("queryNode", "cms", param, function(code,data){
							if(code==0 && data.cmsdata){
								var hasNode = true;
								var nodeidArr = [];
								for (var i = 0; i < data.cmsdata.length; i++) {
									nodeidArr.push(data.cmsdata[i].cid);
									proList[data.cmsdata[i].cid] = {
										displayName: data.cmsdata[i].displayName,
										list:[]
									};
								};
								// 获取商品
								param.param.nodeid = "%in ("+nodeidArr.join(",")+")%";
								// _this.API.doServer("queryContent", "cms", param, function(code,data){
								_this.API.doServer("queryProductLM3", "customer", {}, function(code,data){
									if(code!==0 || !data) return;
									for (var i = 0; i < data.length; i++) {
										if(!data[i].nodeid) continue;
										proList[data[i].nodeid].list.push(data[i]);
									};
									_this.API.show("view_protml", {proList: proList, hasNode: hasNode, shopCart : _this.MY.shopCart}, "#product_"+_this.MY.clickid+" .list",true);
									_this.API.private("privateNumAction");
								})
							}else{
								var hasNode = false;
								// 获取商品
								_this.API.doServer("queryContent", "cms", param, function(code,data){
									if(code!==0 || !data.cmsdata) return;
									proList = data.cmsdata;
									_this.API.show("view_protml", {proList: proList, hasNode: hasNode, shopCart : _this.MY.shopCart}, "#product_"+_this.MY.clickid+" .list",true);
									_this.API.private("privateNumAction");
								})
							};
						})
					})
		    },
		    privateNumAction: function (){
		    	var _this = this;
		    	var time = null;
					_this.API.find('.spinner-input').each(function(){
						var $this = $(this);
						$this.ace_spinner({value: parseInt($this.val()), min:0, max:100, step:1, touch_spinner: true, icon_up:'icon-caret-up', icon_down:'icon-caret-down', btn_up_class:'btn-success' , btn_down_class:'btn-danger'})
						.closest('.ace-spinner')
						.on('changed.fu.spinner', function(e){
							clearTimeout(time);
							time = setTimeout(function(){
								var domIpt = _this.API.find(e.target).find("input");
								var prevPayMoney = _this.API.private("privateGetPayMoney");
								var prevProNum = _this.API.private("privateGetProNum");
								var cid = domIpt.parents("tr").find("td:eq(0)").text();
								var num = domIpt.val();
								if(num*1>0){
									_this.MY.shopCart[cid] = {
										name: domIpt.parents("tr").find("td:eq(1)").text(),
										unit: domIpt.parents("tr").find("td:eq(2)").text(),
										price: domIpt.parents("tr").find("td:eq(3)").text(),
										num: domIpt.val()
									};
									_this.API.find(e.target).parents("tr").addClass('highlight');
								}else{
									_this.MY.shopCart[cid] && delete _this.MY.shopCart[cid];
									_this.API.find(e.target).parents("tr").removeClass('highlight');
								}
								// 默认动画变幻数字
								_this.API.private("privateAnimNum", "#pay_money", prevPayMoney, _this.API.private("privateGetPayMoney"));
								_this.MY.prevPayMoney = _this.API.private("privateGetPayMoney");
								_this.API.private("privateAnimNum", "#pro_num", prevProNum, _this.API.private("privateGetProNum"));
								_this.MY.prevProNum = _this.API.private("privateGetProNum");
								// 按钮状态控制
								if(!_this.API.private("privateGetProNum") || _this.API.private("privateGetPayMoney") > _this.API.private("privateGetStorage","total_money")){
									_this.API.find("#btn2order").addClass("disabled");
									_this.API.find("#payBox").addClass("red");
								}else{
									_this.API.find("#btn2order").removeClass("disabled");
									_this.API.find("#payBox").removeClass("red");
								}
								if(_this.API.private("privateGetProNum")==0) {
									_this.API.find("#payBox").addClass("empty").removeClass("over");
								}else{
									_this.API.find("#payBox").removeClass("empty").addClass("over");
								}
							},300);
						})
					})
				},
				privateGetStorage: function (key){
	        return sessionStorage.getItem(key) || 0;
		    },
		    privateSetStorage: function (key, value){
		    	if(value===null){
		    		sessionStorage.removeItem(key);
		    		return;
		    	}
	        sessionStorage.setItem(key, value);
		    },
		    privateClearStorage: function(){
		    	sessionStorage.clear();
		    },
		    privateGetPayMoney: function(){
		    	var payMoney = 0;
		    	for (var cid in this.MY.shopCart) {
		    		var num = (this.MY.shopCart[cid].num*1>0)?this.MY.shopCart[cid].num:0;
		    		var price = (this.MY.shopCart[cid].price*1>0)?this.MY.shopCart[cid].price:0;
		    		payMoney+=num*price;
		    	};
		    	return payMoney;
		    },
		    privateGetProNum: function(){
		    	var proNum = 0;
		    	for (var cid in this.MY.shopCart) {
		    		var num = (this.MY.shopCart[cid].num*1>0)?this.MY.shopCart[cid].num:0;
		    		proNum+=this.MY.shopCart[cid].num*1;
		    	};
		    	return proNum;
		    },
		    privateDateRangerInit: function(){
		    	var _this = this;
					_this.API.find('#date-range-picker').daterangepicker({
						'applyClass' : 'btn-sm btn-success',
						'cancelClass' : 'btn-sm btn-default',
						format : 'YYYY/MM/DD',
						locale: {
							applyLabel: '提交',
							cancelLabel: '取消'
						}
					})
					.prev().on(ace.click_event, function(){
						$(this).next().focus();
					});
				},
				privateVerifyParam: function(fieldsObj){
					if(!fieldsObj.receivename){
						alert("请输入收货人姓名或花名");
						return false;
					}
					if(!/^\d{5,11}$/.test(parseInt(fieldsObj.receivephone))){
						alert("请输入收货人联系电话");
						return false;
					}
					if(!fieldsObj.receiveaddress){
						alert("请输入收货人地址或工位");
						return false;
					}
					if(!fieldsObj.receivetime){
						alert("请正确输入配送日期");
						return false;
					}
					return true;
				},
				privateDoMenu: function(isShow){
					// 判断是否需要menu
					if(isShow==="show"){
						$("#submenu").fadeIn();
						// 高亮显示menu
						var hash = document.location.hash.replace("#","");
						$("#submenu li>a").each(function(){
							if($(this).attr("data-hash")==hash){
								$("#submenu li>a").removeClass("on");
								$(this).addClass("on");
								return true;
							}
						})
					}else{
						$("#submenu").fadeOut();
					}
				},
				privateRoute:function(stepName){
					this.API.private("privateRoute"+stepName);
				},
				privateVerifyYuSuan: function(){
					// 预算校验
					if(parseInt(this.API.private("privateGetStorage","people_num"))) return true;
					alert("您还未制定预算！");
					this.API.private('privateRoute','YuSuan');
					return false;
				},
				privateVerifyShopping: function(){
					// 商品校验
					if(this.API.private("privateGetProNum") && this.API.private("privateGetPayMoney") <= this.API.private("privateGetStorage","total_money")) return true;
					alert("您还未选购商品或已超标！");
					this.API.private('privateRoute','Shopping');
					return false;
				},
				privateHashEnterRoute: function(){
					var hash = document.location.hash.replace("#","");
					var ROUTE = {
						"welcome": "Welcome",
						"yusuan": "YuSuan",
						"shopping": "Shopping",
						"order": "Order",
						"ordermgr": "OrderMgr"
					}
					if(hash && ROUTE[hash]){
						this.API.private("privateRoute"+ROUTE[hash]);
					}else{
						this.API.private("privateRouteWelcome");
					}
				}
			},
			TrigerEvent:{
				trigerRoute: function(stepName){
					this.API.private('privateRoute',stepName);
				}
			}
		}
	);
	return FW;
});

