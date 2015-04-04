<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>${loginDesc2}－${loginTitle}${cop}</title>
	<meta name="description" content="User login page" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--basic styles-->
	<link href="${B}/page/manager/assets/css/bootstrap.min.css" rel="stylesheet" />
	<link href="${B}/page/manager/assets/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="${B}/page/manager/assets/css/font-awesome.min.css" />

	<!--[if IE 7]>
	<link rel="stylesheet" href="${B}/page/manager/assets/css/font-awesome-ie7.min.css" />
	<![endif]-->

	<!--page specific plugin styles-->
	<link rel="stylesheet" href="${B}/page/manager/assets/css/jquery-ui-1.10.3.custom.min.css" />

	<!--fonts-->

	<!--ace styles-->
	<link rel="stylesheet" href="${B}/page/manager/assets/css/ace.min.css" />
	<link rel="stylesheet" href="${B}/page/manager/assets/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="${B}/page/manager/assets/css/ace-skins.min.css" />

	<!--[if lt IE 9]>
	<link rel="stylesheet" href="${B}/page/manager/assets/css/ace-ie.min.css" />
	<![endif]-->

	<link rel="stylesheet" href="${B}/page/judd/css.css" />

</head>
<body class="login-layout bg-1">
	<div class="caption">
		<div  id="appDivId">
			<div id="viewDataMain">
				<div class="main-container container-fluid">
					<div class="main-content">
						<div class="row-fluid">
							<div class="span12">
								<div class="center">
									<h3 style="color:#f72862">
										<i class="icon-leaf"></i>
										<span >${loginTitle}</span>
										<span class="white">${cop}</span>
									</h3>
								</div>
								<div class="login-container">
									<div class="row-fluid">
										<div class="position-relative">
											<div id="login-box" class="login-box visible widget-box no-border">
												<div class="widget-body">
													<div class="widget-main">
														<h4 class="header white lighter bigger">
															<i class="icon-coffee green"></i>
															${loginDesc2}
														</h4>
														<div class="space-6"></div>
														<form class="FWApp" id="APP_login">
															<!--@userInfoGadget@
																{
																	directShowView:'view_userLogin',
																	loginServiceName:'adminLogin',
																	loginServicePackage:'admin',
																	loginSuccJumb:'${loginSuccJumb}'
																}
															-->
															<fieldset id="view_userLogin">
																<label>
																	<span class="block input-icon input-icon-right">
																		<input type="text" class="span12" id="adminName" placeholder="请输入管理员账号" />
																		<i class="icon-user"></i>
																	</span>
																</label>

																<label>
																	<span class="block input-icon input-icon-right">
																		<input type="password" class="span12" id="adminPass" placeholder="请输入管理员密码" />
																		<i class="icon-lock"></i>
																	</span>
																</label>

																<div class="space"></div>
																<div class="clearfix">
																	<!-- <label class="inline">
																		<input type="checkbox" />
																		<span class="lbl"> Remember Me</span>
																	</label> -->
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
										</div><!--/position-relative-->
									</div>
								</div>
							</div><!--/.span-->
						</div><!--/.row-fluid-->
					</div>
				</div><!--/.main-container-->
			</div>
		</div>
	</div>

<!--/.main-container-->
<!-- JavaScript plugins (requires jQuery) -->
<script src="${B}breeze/lib/js/jquery.js"></script>
<script src="${B}breeze/lib/js/sea.js"></script>

<!-- wgfly breeze -->

	<script>
		seajs.config({base:"${B}"});
		seajs.use( [ 'gadget/userInfoGadget' ],function(a) {
			a.go("${S}");
			//将a全局赋值给fw  才能使用全局的事件
			window.FW = a;
		});
		document.onkeydown=function(event){
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