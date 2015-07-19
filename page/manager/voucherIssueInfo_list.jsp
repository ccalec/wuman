<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>红包管理 － ${title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <!-- cssAssets -->
  <jsp:include page="cssAssets.jsp"/>
  <base target="_self"></base>
  <!-- /cssAssets -->
  <style>
    .category_property_values_conAdd .f_add_time{
      display: none;
    }
  </style>
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

        </div>
        <span id="">红包发放管理</span>
        <small>
          <i class="icon-double-angle-right"></i>
          <span id="actionName">列表</span>
        </small>
      </h1>
    </div>
    <div class="FWApp " id="voucherIssueInfoListGadget">
      <!--@voucherIssueInfoListGadget@
      {
      }
      -->
      <div id="viewContentList">
        <form id="formContentList" class="form-horizontal clearfix">
        </form>
      </div>
      <div id="viewContentEdit">
        <form id="formContentEdit" class="form-horizontal clearfix">
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
<!--/.main-container-->

<!-- footer -->
<jsp:include page="footer.jsp"/>
<!-- /footer -->

<!-- wgfly breeze -->
<script>
  seajs.config({base:"${B}"});
  seajs.use( ['gadget/cmsMgrNodeTreeGadget','privategadget/voucherIssueInfoListGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>