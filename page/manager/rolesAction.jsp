<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>${title}</title>
	<meta name="description" content="User login page" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!-- cssAssets -->
	<jsp:include page="cssAssets.jsp"/>
	<!-- /cssAssets -->
</head>
<body class="skin-1">

<!-- header -->
<jsp:include page="header.jsp"/>
<!-- /header -->

<div class="main-container container-fluid">

		<div class="page-content clearfix">
			<div class="FWApp" id="cmsMgrRolesGadget">
				<!--@cmsMgrRolesGadget@
				{
				}
				-->
				<div id="viewCmsRoles">

					<div class="page-header position-relative">
						<h1>
							<div class="pull-right">
								<a class="btn btn-primary btn-small" href="CMSMgr.jsp?alias=roles&norole=true"><i class="icon-undo"></i> 返回角色列表 </a>
							</div>
							<span id="rolesName">${_}{data.rolesName}</span>
							<small>
								<i class="icon-double-angle-right"></i>&emsp;<span id="actionName">${_}{data.enname}</span>
							</small>
							<small>
								<i class="icon-double-angle-right"></i>&emsp;<span id="actionName">设置权限</span>
							</small>
						</h1>
					</div>

					<h4 class="header blue">
						<i class="icon-hand-right icon-animated-hand-pointer blue"></i>
						cms表权限设置 &emsp;
						<button class="btn btn-mini btn-success cmsSelAll">全选</button>
						<button class="btn btn-mini btn-info cmsCalAll">反选</button>
					</h4>

					<div class="profile-user-info profile-user-info-striped" id="cmsList">
						<!--$for(var prop in data.cmsData){-->
						<div class="profile-info-row clearfix">
							<div class="profile-info-name">${_}{data.cmsData[prop].actionName}</div>
							<div class="profile-info-value">
								<!--$for(var i=0,arrRoles=data.cmsData[prop].rolesArr; i<arrRoles.length;i++){-->
								<!--$if(arrRoles[i]){-->
								<div class="checkbox pull-left">
									<label>
										<!--$if($.inArray(arrRoles[i], data.arrHavedAction) != -1){-->
										<input class="ace" type="checkbox" value='${_}{arrRoles[i]}' name="rolestatus" checked="checked">
										<!--$}else{-->
										<input class="ace" type="checkbox" value='${_}{arrRoles[i]}' name="rolestatus">
										<!--$}-->
										<span class="lbl"> ${_}{data.arrCMSCheckName[i]}</span>
									</label>
								</div>
								<!--$}}-->
								<button class="btn btn-mini btn-info  pull-right rowCalAll" style="margin:-3px 0 0 0px;">反选</button>
								<button class="btn btn-mini btn-success  pull-right rowSelAll" style="margin:-3px 0 0 0px;">全选</button>

							</div>
						</div>
						<!--$}-->
					</div>

					<div class="hr hr30 hr-double"></div>

					<h4 class="header blue">
						<i class="icon-hand-right icon-animated-hand-pointer blue"></i>
						自定义功能权限设置 &emsp;
						<button class="btn btn-mini btn-success zdySelAll">全选</button>
						<button class="btn btn-mini btn-info zdyCalAll">反选</button>
					</h4>

					<div class="clearfix" id="zdyList">
						<!--$for(var i=0,arrZdyRoles=data.zdyData; i<arrZdyRoles.length;i++){-->
						<div class="checkbox pull-left">
							<label>
								<!--$if($.inArray(arrZdyRoles[i].cid, data.arrHavedAction) != -1){-->
								<input class="ace" type="checkbox" value="${_}{arrZdyRoles[i].cid}" name="rolestatus" checked="checked">
								<!--$}else{-->
								<input class="ace" type="checkbox" value="${_}{arrZdyRoles[i].cid}" name="rolestatus">
								<!--$}-->
								<span class="lbl"> ${_}{arrZdyRoles[i].actionName}</span>
							</label>
						</div>
						<!--$}-->
					</div>
				</div>
			</div>
			<!-- end .app -->
			<div class="space space-30"></div>
			<div class="clearfix form-actions">
				<div style="margin-left:130px;">
					<button type="button" class="btn btn-info" onclick="FW.trigerEvent('eventSubmit')">
						<i class="icon-ok bigger-110"></i>
						提交
					</button>
				</div>
			</div>
		</div>
</div>
<!--/.main-container-->

<!-- footer -->
<jsp:include page="footer.jsp"/>
<!-- /footer -->

<!-- wgfly breeze -->
<script>
	seajs.config({base:"${B}"});
	seajs.use( ["gadget/cmsMgrRolesGadget"],function(a) {
		a.go("${S}");
		window.FW = a;
	});
</script>



</body>
</html>