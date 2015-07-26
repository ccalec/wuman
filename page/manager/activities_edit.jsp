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
    .f_formList table th:last-child,.f_formList table td:last-child{
      display: none;
    }
    .f_formList table tr.list-none td:last-child{
      display: table-cell;
    }
    .help-inline{
    }
    ._limit_num_inp{
      width: 50px;
    }
    .f_add_time .add-on,
    .activities_conAdd .f_add_time
    {
      display: none!important;
    }
    .activities_conEdit .form-wrap{
      float: none!important;
    }
    #J_actgoodscon{
      margin: 0 10px;
    }
    #J_actgoodscon table{
      border: 1px solid #ddd!important;
    }
    .th_cid{
      width: 60px;
    }
    .th_File{
      width: 80px;
    }
    .th_dazhe_price,.th_price,.th_quantity{
      width: 100px;
    }
    #myTab li a{
      padding: 8px 20px;
      color: #2283c5;
    }
    #myTab li.active a{
      border-top-color: orange;
      color: orange;
    }
    .th_nodeid{
      width: 120px;
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
        <span id="">活动详情</span>
        <small>
          <i class="icon-double-angle-right"></i>
          <span id="">编辑</span>
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
        <form id="formContentAdd" class="form-horizontal clearfix"></form>
      </div>
    </div>

    <div id="J_actgoodscon" style="display:none;">
      <div class="FWApp " id="filterGadget" style="padding:15px 0;">
        <!--@filterGadget@
        {
          noShow: false
        }
        -->
        <div id="viewFilter">
          <form id="J_filterForm" class="serarea">
            <label>宝贝名称：<input name="title" type="text"></label>
            <label>宝贝货号：<input name="goodsno" type="text"></label>
            <label>入库日期：
              <div class="row-fluid input-append J_rksj" style="margin-bottom:0; width:150px">
                <input class="span10" type="text" name="addtime" data-format="yyyy-MM-dd">
                <span class="add-on">
                  <i class="icon-calendar"></i>
                </span>
              </div>
            </label>

            <div class="space10"></div>
            <label class="label-price">宝贝价格：<input name="price_start" type="text"> <span>到</span> <input name="price_end" type="text"></label>
            <div class="catsel J_catesel">
              <span>宝贝类目：</span>
              <select id="parentCateList">
                <option value="-1">全部类目</option>
              </select>
              &gt;&gt;
              <select id="sonCateList">
                <option value="-1">子类目</option>
              </select>
              <input type="hidden" name="nodeid" class="J_nodeid">
            </div>
            <label>
              宝贝状态：
              <select name="status">
                <option value="0">全部</option>
                <option value="1">预设上架</option>
                <option value="2">已上架</option>
                <option value="3">预设下架</option>
                <option value="4">已下架</option>
                <option value="5">从未上架</option>
                <option value="6">优先上新</option>
              </select>
            </label>
            <div class="btndiv">
              <button type="button" class="btn btn-app btn-primary btn-small J_submitBtn">
                <i class="icon-search bigger-200"></i> 搜索
              </button>
            </div>
            <button type="submit" style="display:none;"></button>
          </form>
        </div>
        <div id="viewCateListTPL">
          <!--$for(var i=0; i<data.cateList.length; i++){ -->
            <option value="${_}{data.cateList[i].cid}">${_}{data.cateList[i].cat_name}</li>
          <!--$} -->
        </div>
      </div>
      <div class="FWApp " id="activitiesGoodsListGadget">
        <!--@activitiesGoodsListGadget@
        {
        }
        -->
        <div id="viewContentList">
          <form id="formContentList" class="form-horizontal clearfix"></form>
        </div>
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
  seajs.use( ['gadget/cmsMgrNodeTreeGadget','privategadget/activitiesEditGadget','privategadget/filterGadget','privategadget/activitiesGoodsListGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>