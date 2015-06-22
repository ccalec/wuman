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
    ._buyer_nick_inp,._buyer_full_name_inp{
      width: 120px;
    }
    ._memo_tex,._refund_reason_tex{
      height: 80px;
    }
    .date-time-picker input{
      width: 150px;
    }
    ._buy_num_inp,._ori_price_inp,._pay_price_inp,._attributes_inp{
      width: 60px;
    }
    ._item_title_inp,._buyer_address_inp,._sender_address_inp{
      width: 500px;
    }
    .inp_file_val,.thumbBtn,._item_good_img_file,.add-on{
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

    /*.f_orderno,.f_status,.f_pay_price,.f_ori_price,.f_buy_num,.f_attributes{
      float: left;
    }*/
    /*.form-wrap{
      position: relative;
    }*/
    /*.f_item_good_img label{
      display: none;
    }
    .f_item_good_img{
      position: absolute;
      right: 0;
      top: 100px;
    }
*/
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
        <div class="FWApp " id="ordersEditExtGadget">
          <!--@ordersEditExtGadget@
          {
            descChannelUrl:"CMSMgr.desc"
          }
          -->
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
</div>
<!--/.main-container-->

<!-- footer -->
<jsp:include page="footer.jsp"/>
<!-- /footer -->

<!-- wgfly breeze -->
<script>
  seajs.config({base:"${B}"});
  seajs.use( ['gadget/cmsMgrNodeTreeGadget','privategadget/ordersEditExtGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>