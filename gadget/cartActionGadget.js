/** 
* @fileOverview cms前台购物车相关按钮Gadget
* @author <a href="http://www.wgfly.com">Alec</a> 
* @version 0.1
*/ 

/**
* @namespace
* @author Alec 
* @name cartActionGadget 
* @description  cms前台购物车相关按钮Gadget
*/ 

define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	FW.register(
		{
			param:{
			},
			name:"cartActionGadget",
			private:{
				/**
				*@function
				*@name privateBindPagination
				*@memberOf cartActionGadget
				*@param {jqueryContainer} _dom 分页生成后插入的dom节点
				*@param {Object} _param doServer内容列表的数据查询参数
				*@param {Object} _callback 获取到数据后的回调函数，参数1:data
				*@description 点击【加入购物车】按钮，主要实现如下：
				* 1、doServer查询列表总数
				* 2、获取需要显示第几页的数据
				* 3、doServer查询当页数据
				* 4、执行回调函数_callback返回data(有可能是空), 回调函数内部处理数据库后，show视图
				* 5、FW.use().showPagination插入分页页码
				*@example
				*/
				privateAddToCart:function(proData,Num){

					var proNum = parseInt(Num) || 1;
					var SSGoodsList = FW.use().load("SSGoodsList") || [];
					var status = true; //判断是否需要储存
					//库存长度判断
					if(SSGoodsList.length){	
						for(var i=0; i<SSGoodsList.length; i++){
							if(SSGoodsList[i].skuid == proData.skuid){
								var inventory = parseInt(SSGoodsList[i].inventory);
								if( proNum+parseInt(SSGoodsList[i].number) > inventory){
									proNum = inventory;
								}else{
									proNum = proNum+parseInt(SSGoodsList[i].number);
								}
								SSGoodsList[i].number = proNum.toString();
								FW.use().save("SSGoodsList",SSGoodsList);
								status = false;
								break;
							}
						}
					}
					if(status){
						proData.number = proNum.toString();
						SSGoodsList.push(proData);
						FW.use().save("SSGoodsList",SSGoodsList);
						//alert("已加入购物车，数量："+proNum);
					}
					//弹出购物车提示层
					this.API.private("privateCallCartInfo");
				},
				privateCancelOrder:function(){ //flow1.htm 取消订单按钮
					if(confirm("您确定需要清空购物车吗？")){
						FW.use().save("SSGoodsList",null);
						document.location.href = document.location.href;
					}
				},
				privateGoToCheck: function(){ //flow1.htm 去结算按钮
					//定义变量用于存储选中数据
					var _data =[];
					//用于存储总数
					var _count=0;
					//用于存储总价(不包含运费)
					var _goodsTotalPrice=0;
					//用于存储总价(包含运费)
					var _goodsTotalPriceWithFreight=0;
					//用于存储运费
					var _freight=0;
					for(var i=0;i<this.MY.cartInfo.length;i++){
						var checkbox = "checkbox"+this.MY.cartInfo[i].skuid;
						if(document.getElementById(checkbox).checked){
							this.MY.cartInfo[i]["number"] = document.getElementById("proqty"+this.MY.cartInfo[i].skuid).value;
							this.MY.cartInfo[i]["totalPrice"] = parseInt(this.MY.cartInfo[i]["number"])*parseInt(this.MY.cartInfo[i]["price"]);
							//统计总数
							_count+=parseInt(this.MY.cartInfo[i]["number"]);
							//统计总价(不含运费)
							_goodsTotalPrice+=parseInt(this.MY.cartInfo[i]["totalPrice"]);
							//统计总价(汗运费)
							_goodsTotalPriceWithFreight+=parseInt(_goodsTotalPrice);
    						_data.push(this.MY.cartInfo[i]);
						}
					}
					//封装公共数据
					for(var i=0;i<_data.length;i++){
						_data[i]["count"] =_count;
						_data[i]["goodsTotalPrice"]=_goodsTotalPrice;
						_data[i]["goodsTotalPriceWithFreight"]=_goodsTotalPriceWithFreight;
					}
					if(_data.length){
						this.API.show("viewFillTheOrderInformation",_data,"viewShowFillTheOrderInformation");
					}else{
						alert("您的购物车内没有商品！请先选择商品。");
					 	document.location.href = "product_shoppingCart.jsp";
					}
				},
				privateSubmitOrder:function(money){
					this.API.show("viewCommitFill",money,"viewShowCommitFill");
				},
				//弹出层，显示购物车当前信息
				privateCallCartInfo: function(){
					//读取storage里面保存的商品信息
					var SSGoodsList = FW.use().load("SSGoodsList") || [];
					var totlePrice = 0;
					var totleNum = 0;
					for(var i=0; i<SSGoodsList.length; i++){
						totlePrice += parseFloat((parseInt(SSGoodsList[i].number)*parseFloat(SSGoodsList[i].price)).toFixed(2));
						totleNum += parseInt(SSGoodsList[i].number);
					}
					var cartinfo = "我的购物车 共 <span class='red'>("+totleNum+")</span> 件商品，共计<span class='red'>"+totlePrice+"</span>元" ;
					// API.show("viewCartInfo",{cartinfo:cartinfo},false);
					var boxHTML="<div id='cBoxWrap'>";
					boxHTML+="<div id='cBoxClose'><a href='javascript:void(0);'>close</a></div>";
					boxHTML+="<div id='cBoxCon'><div class='shopcar_pop_01'>";
					boxHTML+="<p><strong style='font-size:14px'>该商品已成功加入购物车</strong><br><a title='查看购物车' href='shoppingCart.jsp'>"+cartinfo+"</a></p>";
					boxHTML+="<a class='shopcar_pop_btn01' href='product_shoppingCart.jsp'>去购物车结算</a>";
					boxHTML+="<a class='shopcar_pop_btn02' href='javascript:void(0)' onclick='$(\"#cBoxClose a\").click()'>继续购物</a>";
					boxHTML+="</div></div></div>";
					//显示弹出层
					FW.blockUI(boxHTML,($(window).width()-400)/2,($(window).height()-140)/2,400,140,0);
					//给购物车弹出层绑定关闭事件
					$("#cBoxClose a").click(function(){
						FW.unblockUI();
					}); 
				}
			}
		}
	);
	return FW;
});