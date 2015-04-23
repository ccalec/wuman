<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="page/allhead.jsp"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>会员登录－聚划算大促后勤私人定制系统</title>
	<meta name="description" content="User login page" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--basic styles-->
	<link href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/bootstrap.min.css" rel="stylesheet" />
	<link href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/font-awesome.min.css" />

	<!--[if IE 7]>
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/font-awesome-ie7.min.css" />
	<![endif]-->

	<!--page specific plugin styles-->
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/jquery-ui-1.10.3.custom.min.css" />
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/daterangepicker.css" />
	<!--ace styles-->
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/ace.min.css" />
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/ace-skins.min.css" />


	<!--[if lt IE 9]>
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/manager/assets/css/ace-ie.min.css" />
	<![endif]-->
	<link rel="stylesheet" href="<%=this.getServletContext().getContextPath()%>/page/judd/css.css" />
</head>
<body class="login-layout bg-1">
<div class="caption">
	<div class="main-container container-fluid">
		<div class="main-content">
			<div class="row-fluid">
				<div class="span12">
					<div class="center">
						<h3 style="color:#f72862">
							<i class="icon-flag"></i>
							<span>聚划算</span>
							<span class="white">大促后勤私人定制系统</span>
						</h3>
						<h4 class="orange" style="margin-top:-20px" id="actTit"></h4>
					</div>
					<div id="submenu" style="display:;">
						<ul>
							<li><a onclick="FW.trigerEvent('trigerRoute','Welcome')" data-hash="welcome" href="javascript:void(0)">首页</a></li>
							<li><a onclick="FW.trigerEvent('trigerRoute','YuSuan')" data-hash="yusuan" href="javascript:void(0)">预算</a></li>
							<li><a onclick="FW.trigerEvent('trigerRoute','Shopping')" data-hash="shopping" href="javascript:void(0)">选购</a></li>
							<li><a onclick="FW.trigerEvent('trigerRoute','Order')" data-hash="order" href="javascript:void(0)">下单</a></li>
							<li><a onclick="FW.trigerEvent('trigerRoute','OrderMgr')" data-hash="ordermgr" href="javascript:void(0)">管理</a></li>
							<li><a href="loginout.jsp">退出</a></li>
						</ul>
					</div>
					<div class="FWApp" id="APP_index">
						<!--@indexMgrGadget@
							{
							}
						-->
						<!-- 默认登录视图 -->
						<div class="login-container" id="view_userNotLogin">
							<div class="row-fluid">
								<div class="position-relative">
									<div id="login-box" class="login-box visible widget-box no-border">
										<div class="widget-body">
											<div class="widget-main">
												<h4 class="header lighter white bigger" style="color:#">
													<i class="icon-coffee green" ></i>
													会员登陆
												</h4>
												<div class="space-6"></div>
												<form>
													<fieldset >
														<label>
															<span class="block input-icon input-icon-right">
																<input type="text" class="span12" id="adminName" placeholder="请输入花名或工号" />
																<i class="icon-user"></i>
															</span>
														</label>
														<label>
															<span class="block input-icon input-icon-right">
																<input type="password" class="span12" id="adminPass" placeholder="请输入密码" />
																<i class="icon-lock"></i>
															</span>
														</label>
														<div class="space"></div>
														<div class="clearfix">
															<a href="javascript:void(0)" onclick="FireEvent.fireLogin('adminName','adminPass')" class="width-35 pull-right btn btn-small btn-primary">
																<i class="icon-key"></i>
																登 录
															</a>
														</div>
														<div class="space-4"></div>
													</fieldset>
												</form>
											</div><!--/widget-main-->
										</div><!--/widget-body-->
									</div><!--/login-box-->
								</div>
							</div>
						</div>

						<!-- 活动未开启试图 -->
						<div id="view_noAct">
							<div class="wrap2">
								<div class="welcome">Hi，<span>${_}{data.name}</span>。暂时没有活动信息，欢迎下次再来哦</div>
							</div>
						</div>
						<!-- 登录成功视图 -->
						<div id="view_userLogin">
							<div class="wrap2">
								<div class="welcome">Hi，<span>${_}{data.name}</span>，欢迎你登录！</div>
								<div onclick="FireEvent.fireRoute('YuSuan')" class="btn btn-pink set_order"><i class="icon-shopping-cart"></i> 自助下单</div>
								<div onclick="FireEvent.fireRoute('OrderMgr')" class="btn btn-primary view_order"><i class="icon-edit"></i> 订单管理     </div>
							</div>
						</div>
						<!-- 预算视图 -->
						<div id="view_yusuan">
							<div class="wrap2">
								<div id="spinner-opts">
										<div class="step-tit">第一步：制定预算<span class="desc">（拖动滚轮增加预定人数）</span></div>
										<input class="hidden" type="text" name="lines" data-min="0" data-max="100" data-step="1" value="${_}{data.num}" style="display: none;">
								</div>
								<div class="result-box">
									<h4>预定人数：<strong id="people_num">0</strong> 人</h4>
									<h4>总有预算：<strong id="total_money">0</strong> 元</h4>
									<p>(人标：<strong id="biaozhun">${_}{data.biaozhun}</strong> 元／人)</p>
									<div class="btn btn-primary disabled" id="btn2shop" onclick="FireEvent.fireRoute('Shopping')">确认预算，开始选购</div>
								</div>
							</div>
						</div>
						<!-- 开始购物视图 -->
						<div id="view_shopping">
							<div class="wrap2">
								<div class="step-tit">第二步：选购商品<span class="desc">（选购你喜欢的商品吧）</span></div>
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<!--$for(var i=0; i<data.nodeList.length; i++){ -->
										<li>
											<a data-toggle="tab" data-cid="${_}{data.nodeList[i].cid}" href="#product_${_}{data.nodeList[i].cid}" class="${_}{data.colorArr[i%data.colorArr.length]}">
												<i class="${_}{data.colorArr[i%data.colorArr.length]} icon-coffee bigger-120"></i>
												${_}{data.nodeList[i].displayName}
											</a>
										</li>
										<!--$} -->
									</ul>
									<div class="tab-content">
										<!--$for(var i=0; i<data.nodeList.length; i++){ -->

										<div id="product_${_}{data.nodeList[i].cid}" class="tab-pane fade">
											<div class="typedesc">${_}{data.nodeList[i].typedesc}</div>
											<div class="list"></div>
										</div>
										<!--$} -->
									</div>
								</div>
								<div class="result-box fixed red" id="payBox">
									<h4>消费金额：<strong id="pay_money">0</strong> 元</h4>
									<h4>总预算：<strong id="total_money">0</strong> 元</h4>
									<p>(商品数：<strong id="pro_num">0</strong> 件)</p>
									<div class="btn btn-primary disabled" id="btn2order" onclick="FireEvent.fireRoute('Order')">确认去下单</div>
									<div class="btn btn-danger btn-mini" onclick="FireEvent.fireResetCart()">清空</div>
								</div>
							</div>
						</div>
						<div id="view_protml">
							<table class="table table-striped table-bordered">
					      <thead>
					        <tr>
					          <th style="width:30px;">ID</th>
					          <th>商品/套餐</th>
					          <th>单位/内容</th>
					          <th style="width:60px;">价格(元)</th>
					          <th style="width:120px;">购买数量</th>
					        </tr>
					      </thead>
					      <tbody>
					      	<!--$if(data.hasNode){ -->
									<!--$for(var nodeid in data.proList){ -->
									<tr><td class="class-tit" colspan="5">${_}{data.proList[nodeid].displayName}</td></tr>
									<!--$for(var i=0;i<data.proList[nodeid].list.length;i++){ -->
									<!--$var obj = data.shopCart[data.proList[nodeid].list[i].cid]; obj = obj ? obj.num : 0; var style= obj?'highlight':'';-->
									<tr class="${_}{style}">
					          <td>${_}{data.proList[nodeid].list[i].cid}</td>
					          <td>${_}{data.proList[nodeid].list[i].name}</td>
					          <td>${_}{data.proList[nodeid].list[i].unit}</td>
					          <td>${_}{data.proList[nodeid].list[i].price}</td>
					          <td>
					          	<input data-cid="${_}{data.proList[nodeid].list[i].cid}" data-price="${_}{data.proList[nodeid].list[i].price}" type="text" class="input-mini spinner-input" id="spinner_${_}{data.proList[nodeid].list[i].cid}" value="${_}{obj}" />
					          </td>
					        </tr>
					        <!--$} -->
									<!--$} -->
									<!--$}else{ -->
									<!--$for(var i=0;i<data.proList.length;i++){ -->
									<!--$var obj = data.shopCart[data.proList[i].cid]; obj = obj ? obj.num : 0; var style= obj?'highlight':'';-->
									<tr class="${_}{style}">
					          <td>${_}{data.proList[i].cid}</td>
					          <td>${_}{data.proList[i].name}</td>
					          <td>${_}{data.proList[i].unit}</td>
					          <td>${_}{data.proList[i].price}</td>
					          <td>
					        		<input data-cid="${_}{data.proList[i].cid}" data-price="${_}{data.proList[i].price}" type="text" class="input-mini spinner-input" id="spinner_${_}{data.proList[i].cid}" value="${_}{obj}" />
					          </td>
					        </tr>
					        <!--$} -->
									<!--$} -->
					      </tbody>
					    </table>
						</div>
						<!-- 填写订单信息 -->
						<div id="view_order">
							<div class="wrap2">
								<div class="step-tit">第三步：填写收货信息<span class="desc">（确认订单，正式提交）</span></div>
								<div class="masker">
									<form id="submitOrder">
										<fieldset>
											<label>
												<span class="block input-icon input-icon-left">
													<input type="text" name="receivename" value="${_}{data.userInfo.name}" class="span12" placeholder="请输入收货人姓名或花名..（eg: 月飞）">
													<i class="icon-user"></i>
												</span>
											</label>
											<label>
												<span class="block input-icon input-icon-left">
													<input type="text" name="receivephone" value="${_}{data.userInfo.phone}" class="span12" placeholder="请输入收货人联系电话..（eg: 18268041810）">
													<i class="icon-phone"></i>
												</span>
											</label>
											<label>
												<span class="block input-icon input-icon-left">
													<input type="text" name="receiveaddress" value="${_}{data.userInfo.address}" class="span12" placeholder="请输入收货地址..（eg: 4-4-N-188）">
													<i class="icon-home"></i>
												</span>
											</label>
											<label>
												<span class="block input-icon input-icon-left">
													<input type="text" name="receivetime" class="span12" id="date-range-picker" placeholder="请选择配送日期（支持多天）..">
													<i class="icon-calendar"></i>
												</span>
											</label>
											<textarea name="other" rows="2" placeholder="备注信息...(可不填)"></textarea>
											<!-- <div class="btn-shouhuo">
												<a href="javascript:void(0)" onclick="" class="btn btn-small btn-primary disabled">
													<i class="icon-ok"></i>
													确认收货信息
												</a>
												<a href="javascript:void(0)" onclick="" class="btn btn-small btn-danger disabled">
													<i class="icon-edit"></i>
													编辑收货信息
												</a>
											</div> -->
										</fieldset>
									</form>
									<div class="step-tit white"><span class="pull-left">购物车商品列表</span><div class="btn btn-danger btn-mini pull-right" onclick="FireEvent.fireRoute('Shopping')" style="margin-top:10px;"><i class="icon-edit"></i>返回修改</div></div>
									<table class="table table-striped table-bordered">
							      <thead>
							        <tr>
							          <th style="width:30px;">ID</th>
							          <th>商品/套餐</th>
							          <th>单位/内容</th>
							          <th style="width:60px;">价格(元)</th>
							          <th style="width:120px;">购买数量</th>
							        </tr>
							      </thead>
							      <tbody>
											<!--$for(var cid in data.shopCart){ -->
											<tr class="highlight">
							          <td>${_}{cid}</td>
							          <td>${_}{data.shopCart[cid].name}</td>
							          <td>${_}{data.shopCart[cid].unit}</td>
							          <td>${_}{data.shopCart[cid].price}</td>
							          <td>${_}{data.shopCart[cid].num}</td>
							        </tr>
							        <!--$} -->
						        </tbody>
						    	</table>
									<div class="result-box style2">
										<h4>定制人数：<span class="orange">${_}{data.cartInfo.people_num}</span> 人</h4>
										<h4>总预算：<span class="orange">${_}{data.cartInfo.total_money}</span> 元</h4>
										<h4>总商品数：<span class="orange">${_}{data.cartInfo.pro_num}</span> 件</h4>
										<h4>消费金额：<strong class="orange">${_}{data.cartInfo.pay_money}</strong> 元</h4>
										<div class="btn btn-primary block" id="btn2SubmitOrder" onclick="FireEvent.fireSubmitOrder()">
											<i class="icon-ok"></i>
											确认订单
										</div>
										<div class="info">订单提交前，先确认收货信息准确无误。</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 提交订单成功 -->
						<div id="view_submitSuccess">
							<div class="wrap2">
								<div class="result-img">
									<h2>提交成功! 订单编号：<strong class="orange">${_}{data.orderNo}</strong></h2>
									<div class="btn btn-small btn-primary" style="margin-top:40px;" onclick="FireEvent.fireRoute('Welcome')">返回欢迎页</div> <div class="btn btn-small btn-purple" style="margin-top:40px;" onclick="FireEvent.fireOrderDesc(${_}{data.orderNo})">查看订单详情</div>
								</div>
							</div>
						</div>
						<!-- 提交订单失败 -->
						<div id="view_submitFail">
							<div class="wrap2">
								<div class="result-img">
									<h2>系统出错，提交失败！</h2>
									<div class="btn btn-small btn-primary" style="margin-top:40px;">我要吐槽！</div>
								</div>
							</div>
						</div>
						<!-- 订单管理 -->
						<div id="view_orderMgr">
							<div class="wrap2">
								<div class="step-tit"><i class="icon-fire"></i> 管理订单－列表<span class="desc">（最近10次提交记录）</span></div>
								<div class="masker">
									<table class="table table-striped table-bordered">
							      <thead>
							        <tr>
							          <th>订单号</th>
							          <th>金额(元)</th>
							          <th>人数</th>
							          <th>下单时间</th>
							          <th>订单状态</th>
							          <th style="width:120px;">操作</th>
							        </tr>
							      </thead>
							      <tbody>
							      	<!--$if(data && data.orderList.length){ -->
							      	<!--$for(var i=0;i<data.orderList.length;i++){ -->
							      	<!--$if(data.orderList[i].nodeid==2){var status="<span class='green'>已处理</span>";}else{ var status="<span class='red'>未处理</span>";} -->
											<tr>
							          <td>${_}{data.orderList[i].cid}</td>
							          <td>${_}{data.orderList[i].total}元</td>
							          <td>${_}{data.orderList[i].peoplenum}人</td>
							          <td>${_}{FW.use('DateTime').format(new Date(parseInt(data.orderList[i].addtime)),'yyyy-MM-dd hh:mm')}</td>
							          <td>${_}{status}</td>
							          <td style="text-align:center">
							          	<div onclick="FireEvent.fireOrderDesc(${_}{data.orderList[i].cid})" class="btn btn-small btn-primary">详情</div>
							          	<!--$if(data.orderList[i].nodeid != 2){ -->
							          	<div onclick="FireEvent.fireOrderDel(${_}{data.orderList[i].cid},this)" class="btn btn-small btn-danger">删除</div>
							          	<!--$} -->
							          </td>
							        </tr>
							        <!--$} -->
							        <!--$}else{ -->
											<tr>
							          <td colspan="6" style="line-height:80px; text-align:center;">暂无订单</td>
							        </tr>
							        <!--$}-->
							      </tbody>
							    </table>
						    </div>
							</div>
						</div>
						<!-- 查看订单详情 -->
						<div id="view_orderDesc">
							<div class="wrap2">
								<div class="step-tit"><i class="icon-fire"></i> 管理订单－详情</div>
								<div class="masker" style="padding:20px;">
									<table class="tabel_orderdesc">
										<!--$if(data.nodeid==1){var status="未处理";}else{var status="已处理";} -->
										<tr><td class="tar">订单编号</td><td>${_}{data.cid}</td><td class="tar">订单状态：</td><td>${_}{status}</td></tr>
										<tr><td class="tar">所属业务线：</td><td>${_}{data.biz}</td><td class="tar">金额总计：</td><td>${_}{data.total}</td></tr>
										<tr><td class="tar">下单人：</td><td>${_}{data.name}</td><td class="tar">订购人数：</td><td>${_}{data.peoplenum}</td></tr>
										<tr><td class="tar">收货电话：</td><td>${_}{data.receivephone}</td><td class="tar">收货地址：</td><td>${_}{data.receiveaddress}</td></tr>
										<tr><td class="tar">下单时间：</td><td>${_}{FW.use('DateTime').format(new Date(parseInt(data.addtime)),'yyyy-MM-dd hh:mm')}</td><td class="tar">配送时间：</td><td>${_}{FW.use('DateTime').format(new Date(parseInt(data.receivetime)),'yyyy-MM-dd hh:mm')}</td></tr>
										<tr><td class="tar">备注：</td><td colspan="3">${_}{data.other}</td></tr>
									</table>
									<div class="prolist"><i class="icon-list"></i> 商品列表</div>
									<table class="table table-striped table-bordered">
							      <thead>
							        <tr>
							          <th style="width:30px;">ID</th>
							          <th>商品/套餐</th>
							          <th>单位/内容</th>
							          <th style="width:60px;">价格(元)</th>
							          <th style="width:120px;">购买数量</th>
							        </tr>
							      </thead>
							      <tbody>
											<!--$for(var i=0; i<data.proList.length;i++){ -->
											<tr class="highlight">
							          <td>${_}{data.proList[i].cid}</td>
							          <td>${_}{data.proList[i].pname}</td>
							          <td>${_}{data.proList[i].punit}</td>
							          <td>${_}{data.proList[i].pprice}</td>
							          <td>${_}{data.proList[i].pnum}</td>
							        </tr>
							        <!--$} -->
						        </tbody>
						    	</table>
						    	<div class="btn btn-primary btn-small pull-right" onclick="FireEvent.fireRoute('OrderMgr')">返回订单列表</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!--/.main-container-->
<!-- JavaScript plugins (requires jQuery) -->
<script src="${B}page/manager/assets/js/jquery-1.10.2.min.js"></script>
<script src="${B}breeze/lib/js/sea.js"></script>
<script src="${B}page/manager/assets/js/bootstrap.min.js"></script>
<script src="${B}page/manager/assets/js/chosen.jquery.min.js"></script>
<script src="${B}page/manager/assets/js/fuelux/fuelux.spinner.min.js"></script>
<script src="${B}page/manager/assets/js/ace-elements.min.js"></script>
<script src="${B}page/manager/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="${B}page/manager/assets/js/date-time/moment.js"></script>
<script src="${B}page/manager/assets/js/date-time/moment.zh-cn.js"></script>
<script src="${B}page/manager/assets/js/date-time/daterangepicker.js"></script>

<!-- wgfly breeze -->
	<script>
		seajs.config({base:"${B}"});
		seajs.use( [ 'privategadget/indexMgrGadget' ],function(a) {
			a.go("${S}",null,function(){

			});
			//将a全局赋值给fw  才能使用全局的事件
			window.FW = a;
		});
		document.onkeydown=function(event){
			if(!$("#view_userNotLogin").length) return;
      e = event ? event :(window.event ? window.event : null);
      if(e.keyCode==13){
          //执行的方法
          var adminName = $("#adminName").val();
          var adminPass = $("#adminPass").val();
          FW.trigerEvent("trigerLogin",adminName,adminPass);
      }
    }
	</script>
</body>
</html>