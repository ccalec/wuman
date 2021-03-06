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
  <style>
    #formContentList .hidden-phone.visible-desktop.btn-group.pull-left,
    #formContentList .actionBtnForList .btn-danger{
      display:none!important;
    }

  </style>
</head>
<body class="skin-1">

<!-- header -->
<jsp:include page="header.jsp"/>
<!-- /header -->

<div class="main-container container-fluid">
  <!-- leftMenu -->
  <jsp:include page="leftMenu.jsp"/>
  <!-- /leftMenu -->

  <!--PAGE CONTENT BEGINS HERE-->
  <!-- ====================== -->
  <div class="main-content">
    <div id="breadcrumbs" class="breadcrumbs">
      <ul class="breadcrumb">
        <li> <i class="icon-home home-icon"></i>
          <a href="javascript:void(0);">${pre_welcome}</a>
          <span class="divider"> <i class="icon-angle-right arrow-icon"></i>
          </span>
        </li>
        <li class="active">
          ${welcome}
        </li>
      </ul>
      <!--.breadcrumb-->

      <div id="nav-search" class="nav-search">
        <form class="form-search">
          <span class="input-icon">
            <input type="text" autocomplete="off" id="nav-search-input" class="input-small nav-search-input" placeholder="Search ...">
            <i class="icon-search nav-search-icon"></i>
          </span>
        </form>
      </div>
      <!--#nav-search-->
    </div>

    <div class="page-content clearfix">
      <div class="page-header position-relative">
        <h1 id="pageH1" style="display:none;">
          <div class="pull-right" id="btnAction">

            <!-- //================================ -->

          </div>
          <span>活动管理</span>
          <small>
            <i class="icon-double-angle-right"></i>
            <span>参数设置</span>
          </small>
        </h1>
      </div>
      <div class="nodetree clearfix FWApp" id="cmsMgrNodeTreeGadget">
        <!--@cmsMgrNodeTreeGadget@
        {
          alias: "cmsconfig"
        }
        -->
        <div id="viewNodeTree">
          <div class="well">
            <h4 class="blue">订单分类</h4>
            <div id="nodeTree" class="tree"></div>
          </div>
        </div>
      </div>
      <div class="shownodecontent">
        <div class="FWApp " id="cmsMgrExtGadget">
          <!--@cmsMgrExtGadget@
          {
            alias: "cmsconfig",
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
  <!-- ====================== -->
  <!--PAGE CONTENT ENDS HERE-->

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