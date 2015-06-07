<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>订单管理－${title}</title>
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
        <h1 id="pageH1">
          <span id="">订单管理</span>
          <small>
            <i class="icon-double-angle-right"></i>
            <span id="actionName">订单列表</span>
          </small>
        </h1>
      </div>
      <div class="FWApp " id="filterGadget">
        <!--@filterGadget@
        {
        }
        -->
        <div id="viewFilter" class="orderlist">
          <form id="J_filterForm" class="serarea">
            <label>宝贝名称：<input name="item_title" type="text"></label>
            <label>订单编号：<input name="orderno" type="text"></label>
            <label>买家昵称：<input name="buyer_nick" type="text"></label>
            <div class="space10"></div>
            <label class="label-time">
              成交时间：
              <div class="row-fluid input-append J_rksj" style="margin-bottom:0; width:150px">
                <input class="span10" type="text" name="start_time" data-format="yyyy-MM-dd">
                <span class="add-on">
                  <i class="icon-calendar"></i>
                </span>
              </div>
              <span class="mlr10">到</span>
              <div class="row-fluid input-append J_rksj" style="margin-bottom:0; width:150px">
                <input class="span10" type="text" name="end_time" data-format="yyyy-MM-dd">
                <span class="add-on">
                  <i class="icon-calendar"></i>
                </span>
              </div>
            </label>

            <div class="catsel J_catesel">
              <span>宝贝类目：</span>
              <select id="parentCateList">
                <option value="-1">一级类目</option>
              </select>
              &gt;&gt;
              <select id="sonCateList">
                <option value="-1">子类目</option>
              </select>
              <input type="hidden" name="category_id" class="J_nodeid">
            </div>
            <button type="button" class="btn btn-app btn-primary btn-small J_submitBtn">
              <i class="icon-search bigger-200"></i>
                搜索
            </button>
            <button type="submit" style="display:none;"></button>
          </form>

          <div class="tabList" id="J_tablist">
            <ul>
              <li class="active" data-value="">全部订单</li>
              <li data-value="1">待付款</li>
              <li data-value="2">待发货</li>
              <li data-value="3">已发货</li>
              <li data-value="4">已收货</li>
              <li data-value="5">申请退款</li>
              <li data-value="6">退款成功</li>
            </ul>
          </div>
        </div>
        <div id="viewCateListTPL">
          <!--$for(var i=0; i<data.cateList.length; i++){ -->
            <option value="${_}{data.cateList[i].cid}">${_}{data.cateList[i].cat_name}</li>
          <!--$} -->
        </div>
      </div>
      <div class="FWApp " id="ordersListGadget">
        <!--@ordersListGadget@
        {
        }
        -->
        <div id="viewOrdersList" class="orderlist">
          <div class="itemlist">

            <table class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th width="100%">宝贝名称</th>
                  <th width="80">单价（元）</th>
                  <th width="80">数量</th>
                  <th width="100">买家</th>
                  <th width="80">交易状态</th>
                  <th width="120">实收款</th>
                </tr>
              </thead>
            </table>

            <!--$if(data){ -->
            <!--$for(var i=0; i<data.orderList.length;i++){ -->
            <!--$var item = data.orderList[i]; -->
            <table class="table table-bordered orderItem">
              <caption align="top" class="tit" >
                <label><input type="checkbox"><span class="lbl"></span></label>
                <a href="${_}{item.descurl}">订单编号：${_}{item.orderno}</a>　　 成交时间：${_}{item.add_time}
              </caption>
              <tr>
                <td width="100%">
                  ${_}{item.item_good_img} ${_}{item.item_title}
                </td>
                <td class="tac" width="80">${_}{item.ori_price}</td>
                <td class="tac" width="80">${_}{item.buy_num}</td>
                <td class="tac" width="100">${_}{item.buyer_nick}</td>
                <td class="tac" width="80">${_}{item.status}</td>
                <td class="tac" width="120">${_}{item.pay_price}</td>
              </tr>
            </table>
            <!--$} -->
            <!--$}else{ -->
            <table class="table table-bordered orderItem">
              <tr>
                <td colspan="1000" class="nodata">暂无订单</td>
              </tr>
            </table>
            <!--$} -->

            <div style="width:220px;" class="hidden-phone visible-desktop btn-group pull-left">

              <button type="button" class="btn btn-mini btn-info btn-sel-all"><i class="icon-ok bigger-120"> 全选</i></button>
              <button type="button" class="btn btn-mini btn-warning btn-sel-oppo"><i class="icon-remove bigger-120"> 反选</i></button>
              <span class="mlr10"></span>
              <button type="button" class="btn btn-mini btn-success btn-order-do"><i class="icon-check bigger-120"> 订单处理</i></button>
              <!-- <button authority="deleteContent" type="button" class="btn btn-mini btn-danger btn-del btn-del-list"><i class="icon-trash bigger-120"> 操作</i></button> -->
            </div>
            <div id="pagination" class="pull-right"></div>
          </div>
        </div>
      </div>
    </div>
</div>
<!--/.main-container-->


<div style="display:none;">
  <div class="FWApp" id="cmsMgrStatusGadget">
    <!--@cmsMgrStatusGadget@
    {
      fieldDesc:"lastCommand"
    }
    -->
    <div id="viewWmsMgrStatusGadget">
      <form id="statusFrom" class="form-horizontal clearfix" style="margin-bottom:0;">
        <div class="form-wrap pull-left clearfix">
          <div class="control-group c_Radio">
            <label class="control-label" style="width:110px">结论：</label>
            <div class="controls" style="margin-left:150px">
              <!--$for(var i=0; i<data.radioData.length;i++){ -->
              <label>
                <input type='radio' name="actionName" value="${_}{data.radioData[i].cid}" />
                <span class='lbl'> ${_}{data.radioData[i].actionName}</span>
              </label>&emsp;&emsp;
              <!--$} -->
            </div>
          </div>
          <!--$if(data.descData){ -->
          <div class="control-group c_TextArea">
            <label class="control-label" for="statusDesc" style="width:110px">描述：</label>
            <div class="controls" style="margin-left:150px">
              <div class='row-fluid'>
                <!--$for(var prop in data.descData){ -->
                <textarea id="statusDesc" class="pan12" name="${_}{prop}">${_}{data.descData[prop]}</textarea>
                <!--$} -->
              </div>
            </div>
          </div>
          <!--$} -->
        </div>
      </form>
    </div>
  </div>
  <!-- end .app -->
</div>
<!--/.审核状态视图 -->


<!-- footer -->
<jsp:include page="footer.jsp"/>
<!-- /footer -->

<!-- wgfly breeze -->
<script>
  seajs.config({base:"${B}"});
  seajs.use( ['privategadget/filterGadget','privategadget/ordersListGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>