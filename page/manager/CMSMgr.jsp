<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>${title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- cssAssets -->
	<jsp:include page="cssAssets.jsp"/>
	<base target="_self"></base>
	<!-- /cssAssets -->
</head>
<body class="skin-1">

<!-- header -->
<jsp:include page="header.jsp"/>
<!-- /header -->

<div class="main-container container-fluid">
		<div class="page-content clearfix">
			<div class="page-header position-relative">
				<h1 id="pageH1" style="display:none;">
					<div class="pull-right" id="btnAction">
						<div class="btn-toolbar">
							<div class="btn-group">
								<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
									<i class="icon-cogs"></i>
									内容管理
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu dropdown-primary pull-right">
									<li authority="queryContent" style="display:none;">
										<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerContentList')"><i class="icon-bar-chart"></i> 内容列表</a>
									</li>
									<li authority="addContent" style="display:none;">
										<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerContentAdd')"><i class="icon-check"></i> 单条添加</a>
									</li>
									<li authority="addContent" style="display:none;">
										<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerContentPLAdd')"><i class="icon-check"></i> 批量添加</a>
									</li>
								</ul>
							</div><!--/btn-group-->
							<div class="btn-group">
								<button class="btn btn-success dropdown-toggle" data-toggle="dropdown">
									<i class="icon-cogs"></i>
									栏目管理
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu dropdown-success pull-right">
									<li authority="modifyNode" style="display:none;">
										<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerClassEdit')"><i class="icon-edit"></i> 栏目编辑</a>
									</li>
									<li authority="addNode" style="display:none;">
										<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerClassAdd','0')"><i class="icon-plus"></i> 添加顶栏目</a>
									</li>
									<li authority="addNode" style="display:none;">
										<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerClassAdd')"><i class="icon-plus"></i> 添加子栏目</a>
									</li>
									<li authority="deleteNode" style="display:none;">
										<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerClassDel')"><i class="icon-trash"></i> 删除栏目</a>
									</li>
								</ul>
							</div><!--/btn-group-->
						</div>
						<!-- //================================ -->

					</div>
					<span id="aliasTitle">栏目操作</span>
					<small>
						<i class="icon-double-angle-right"></i>
						<span id="actionName">列表</span>
					</small>
				</h1>
			</div>
			<div class="nodetree clearfix FWApp" id="cmsMgrNodeTreeGadget">
				<!--@cmsMgrNodeTreeGadget@
				{
					displayName:{
						"statusaction":"statusName",
						"goods":"cat_name",
						"category": "cat_name",
						"category_properties": "cat_name",
						"category_property_values": "property_name",
						"activities": "activity_type"
					}
				}
				-->
				<div id="viewNodeTree">
					<div class="well">
						<h4 class="blue">栏目</h4>
						<div id="nodeTree" class="tree"></div>
					</div>
				</div>
			</div>
			<div class="shownodecontent">
				<div id="tabSonAlias" style="display:none; margin-bottom:30px;">
					<a id="btnPLAddSonAlias" class="pull-right btn btn-mini btn-success" href="javascript:void(0)" style="display:none; margin:10px 10px 0 0; position:relative; z-index:2">
						<i class="icon-plus"></i> 批量添加
					</a>
					<a id="btnAddSonAlias" class="pull-right btn btn-mini btn-info" href="javascript:void(0)" style="display:none; margin:10px 10px 0 0; position:relative; z-index:2">
						<i class="icon-plus"></i> 单条添加
					</a>
					<ul class="nav nav-tabs padding-18" style="height:33px;">
						<li class="active">
							<a href="javascrpt:void(0)" data-toggle="tab">基本信息</a>
						</li>
					</ul>
				</div>
				<div class="FWApp " id="cmsMgrExtGadget">
					<!--@cmsMgrExtGadget@
					{
						descChannelUrl:"CMSMgr.desc"
					}
					-->
					<div id="viewContentList">
						<form id="formContentList" class="form-horizontal clearfix">
						</form>
					</div>
					<div id="viewContentAdd">
						<form id="formContentAdd" class="form-horizontal clearfix">
						</form>
					</div>
					<div id="viewContentPLAdd">
						<form id="formContentPLAdd" class="form-horizontal clearfix">
						</form>
					</div>
					<div id="viewContentEdit">
						<form id="formContentEdit" class="form-horizontal clearfix">
						</form>
					</div>
					<div id="viewClassAdd">
						<form id="formClassAdd" class="form-horizontal clearfix">
						</form>
					</div>
					<div id="viewClassEdit">
						<form id="formClassEdit" class="form-horizontal clearfix">
						</form>
					</div>
					<!-- 修改密码视图 -->
					<div id="viewModPassword">
						<form id="formModPassword" class="form-horizontal clearfix">
							<div class="form-wrap pull-left clearfix">
								<input id="userid" type="hidden" name="userid" value="${_}{data.cid}">
								<div class="control-group c_Text">
									<label for="account" class="control-label">原来密码：</label>
									<div class="controls">
										<input id="oldpassword" class="inp_text w250" readonly="true" type="text" name="oldpassword" value="${_}{data.password}">
									</div>
								</div>
								<div class="control-group c_Text">
									<label for="password" class="control-label">重设密码：</label>
									<div class="controls">
										<input id="password" class="inp_text w250" type="password" name="password" value="">
									</div>
								</div>
								<div class="control-group c_Text">
									<label for="repassword" class="control-label">确认密码：</label>
									<div class="controls">
										<input id="repassword" class="inp_text w250" type="password" name="repassword" value="">
									</div>
								</div>
							</div>
						</form>
					</div>

				</div>
				<div id="submitBtn" class="cmssubmitbtn">
					<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerSubmit')" class="btn btn-info">
						<i class="icon-ok bigger-110"></i>
						确认提交
					</a>
					&nbsp; &nbsp; &nbsp;
					<a href="javascript:void(0)" onclick="FW.trigerEvent('trigerGoBack')" class="btn">
						<i class="icon-undo bigger-110"></i>
						返回列表
					</a>
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
	seajs.use( ['gadget/cmsMgrNodeTreeGadget','privategadget/cmsMgrExtGadget'],function(a) {
		a.go("${S}");
		window.FW = a;
	});
</script>

</body>
</html>