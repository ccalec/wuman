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
<style type="text/css">
  .page-content .page-header:first-child h1{
    font-size: 20px;
  }
  .page-bodyer ul{
    margin: 20px 10px;
  }
  .page-bodyer li{
    display: inline-block;
    margin: 0 100px 30px 0;
    font-size: 13px;
    color: #777;
  }
  .page-bodyer li em{
    color: #b74635;
    margin: 0 5px;
  }
</style>
<div class="main-container container-fluid">
    <div class="page-content clearfix">
      <div class="page-header position-relative">
        <h1 id="pageH1" class="blue">
          <i class="icon-dashboard"></i>
          <span id="aliasTitle">数据总览</span>
        </h1>
      </div>
      <div class="page-bodyer">
        <ul>
          <li>
            <span class="label label-info arrowed-right arrowed-in">仓库存货数</span>
            <em>23456</em>件
          </li>
          <li>
            <span class="label label-info arrowed-right arrowed-in">上架宝贝数</span>
            <em>12345</em>件
          </li>
        </ul>
      </div>
    </div>
    <div class="page-content clearfix">
      <div class="page-header position-relative">
        <h1 id="pageH1" class="blue">
          <i class="icon-bar-chart"></i>
          <span id="aliasTitle">今日销售状况</span>
        </h1>
      </div>
      <div class="page-bodyer">
        <ul>
          <li>
            <span class="label label-success arrowed-right arrowed-in">今日总销量</span>
            <em>4321</em>元
          </li>
          <li>
            <span class="label label-success arrowed-right arrowed-in">待付款</span>
            <em>123</em>笔订单
          </li>
          <li>
            <span class="label label-success arrowed-right arrowed-in">待发货</span>
            <em>234</em>笔订单
          </li>
          <li>
            <span class="label label-success arrowed-right arrowed-in">已发货</span>
            <em>567</em>笔订单
          </li>
        </ul>
      </div>
    </div>
    <div class="page-content clearfix">
      <div class="page-header position-relative">
        <h1 id="pageH1" class="blue">
          <i class="icon-comments"></i>
          <span id="aliasTitle">用户反馈</span>
        </h1>
      </div>
      <div class="page-bodyer">
        <ul>
          <li>
            <span class="label label-warning arrowed-right arrowed-in">今日总反馈量</span>
            <em>252</em>个
          </li>
        </ul>
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