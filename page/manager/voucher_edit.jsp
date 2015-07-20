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
      max-width: 800px!important;
      min-height: 80px!important;
    }
    ._total_num_inp,._rule_money_inp{
      width: 50px;
    }
    .f_rule_money{
      display: none;
    }
    .f_start_time,.f_valid_start_time,.f_total_num{
      clear: both;
    }
    .f_valid_start_time,.f_valid_end_time,.f_start_time,.f_end_time{
      float: left;
    }
    .f_valid_end_time label,.f_end_time label{
      width: 80px!important;
    }
    .f_valid_end_time .controls,.f_end_time .controls{
      margin-left: 90px!important;
    }
    .date-time-picker input{
      width: 150px!important;
    }
    .f_add_time .add-on,
    .voucher_conAdd .f_add_time
    {
      display: none!important;
    }
    .voucher_conEdit .form-wrap{
      float: none!important;
    }
    .f_rule_type .controls label{
      display: block;
      float: none;
    }
    ._total_money_inp{
      width: 80px!important;
    }
    .form-horizontal .control-group.f_total_num,
    .form-horizontal .control-group.f_end_time{
      margin-bottom: 25px!important;
    }
    .form-horizontal .control-group.f_valid_start_time,
    .form-horizontal .control-group.f_valid_end_time{
      margin-top: 25px!important;
    }
    .f_total_money{
      padding-top: 15px;
    }
    .f_use_range{
      padding: 15px 0;
    }
    ._money1_inp,._money1_num_inp,._money1_rule_inp,
    ._money2_inp,._money2_num_inp,._money2_rule_inp,
    ._money3_inp,._money3_num_inp,._money3_rule_inp{
      width: 50px!important;
    }
    .f_money1, .f_money1_num, .f_money1_rule,
    .f_money2, .f_money2_num, .f_money2_rule,
    .f_money3, .f_money3_num, .f_money3_rule{
      float: left;
    }
    .f_money1_num label,
    .f_money2_num label,
    .f_money3_num label{
      width: 100px!important;
    }
    .f_money1_num .controls,
    .f_money2_num .controls,
    .f_money3_num .controls{
      margin-left: 110px!important;
    }
    .f_money1,.f_money2,.f_money3,.f_use_range,.f_total_money{
      clear: both;
    }
    ._total_send_num_inp,
    ._money1_send_num_inp,
    ._money2_send_num_inp,
    ._money3_send_num_inp{
      width: 50px!important;
    }
    ._use_range_inp{
      display: none!important;
    }
    .f_total_send_num{
      position: relative;
      margin-top: 40px;
      padding-top: 40px;
      border-top: 1px dashed #d5d5d5;
    }
    .f_total_send_num:after{
      position: absolute;
      top: -10px;
      left: 0;
      width: 100%;
      height: 20px;
      line-height: 20px!important;
      text-align: center;
      color: #999;
      font-size: 12px;
      content: "发放情况"!important;
    }
    /*add view*/
    .voucher_conAdd .f_total_send_num,
    .voucher_conAdd .f_money1_send_num,
    .voucher_conAdd .f_money2_send_num,
    .voucher_conAdd .f_money3_send_num,
    /*.voucher_conAdd .f_total_num,*/
    /*.voucher_conAdd .f_total_money,*/
    .voucher_conAdd .f_add_time{
      display: none!important;
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
        <span id="">红包详情</span>
        <small>
          <i class="icon-double-angle-right"></i>
          <span id="">编辑</span>
        </small>
      </h1>
    </div>
    <div class="FWApp " id="voucherEditGadget">
      <!--@voucherEditGadget@
      {
      }
      -->
      <div id="viewContentEdit">
        <form id="formContentEdit" class="form-horizontal clearfix"></form>
      </div>
      <div id="viewContentAdd">
        <form id="formContentAdd" class="form-horizontal clearfix"></form>
      </div>
      <div id="viewUseRange" class="userange">
        <ul id="userRageForm">
          <li data-pre="all">
            <label>${_}{data.allIpt}</label>
          </li>
          <li data-pre="act">
            <label>${_}{data.actIpt}</label>
            <dl class="con">
              <dt>活动可用</dt>
              <!--$for(var i=0; i<data.actList.length;i++){-->
              <dd><label>${_}{data.actList[i]}</label></dd>
              <!--$}-->
            </dl>
          </li>
          <li data-pre="catid">
            <label>${_}{data.catidIpt}</label>
            <dl class="con dd2">
              <dt>部分商品</dt>
              <!--$for(var i=0; i<data.catList.length;i++){-->
              <dd><label>${_}{data.catList[i]}</label></dd>
              <!--$}-->
            </dl>
          </li>
          <li data-pre="other">
            <label>${_}{data.otherIpt}</label>
          </li>
        </ul>
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
  seajs.use( ['gadget/cmsMgrNodeTreeGadget','privategadget/voucherEditGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>