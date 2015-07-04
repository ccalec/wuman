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
  <style>
    select{
      width: 100px;
    }
    textarea{
      max-width: 800px;
    }
    .help-inline{
    }
    ._limit_num_inp{
      width: 50px;
    }
    .f_add_time .add-on
    {
      display: none!important;
    }
    .f_buyer_full_name,.f_refund_type,.f_sender_address{
      position: relative;
      margin-top: 40px;
      padding-top: 40px;
      border-top: 1px dashed #d5d5d5;
    }
    .f_buyer_full_name:after,.f_refund_type:after,.f_sender_address:after{
      position: absolute;
      top: -10px;
      left: 0;
      width: 100%;
      height: 20px;
      line-height: 20px!important;
      text-align: center;
      color: #999;
      font-size: 12px;
    }
    .f_buyer_full_name:after{
      content: "收货信息"!important;
    }
    .f_refund_type:after{
      content: "退货信息"!important;
    }
    .f_sender_address:after{
      content: "发货信息"!important;
    }
    .orders_conEdit .form-wrap{
      float: none!important;
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

        <span id="aliasTitle">栏目操作</span>
        <small>
          <i class="icon-double-angle-right"></i>
          <span id="actionName">列表</span>
        </small>
      </h1>
    </div>
    <div class="FWApp " id="activitiesEditGadget">
      <!--@activitiesEditGadget@
      {
      }
      -->
      <div id="viewContentEdit">
        <form id="formContentEdit" class="form-horizontal clearfix"></form>
      </div>
      <div id="viewContentAdd">
        <form id="formContentAdd" class="form-horizontal clearfix">
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
  seajs.use( ['gadget/cmsMgrNodeTreeGadget','privategadget/activitiesEditGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>