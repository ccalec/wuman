<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>仓库中的宝贝－${title}</title>
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
        <span id="">宝贝管理</span>
        <small>
          <i class="icon-double-angle-right"></i>
          <span>仓库中的宝贝</span>
        </small>
      </h1>
    </div>

    <div class="FWApp " id="filterGadget">
      <!--@filterGadget@
      {
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
              <option value="-1">一级类目</option>
            </select>
            &gt;&gt;
            <select id="sonCateList">
              <option value="-1">子类目</option>
            </select>
            <input type="hidden" name="nodeid" class="J_nodeid">
          </div>
          <button type="button" class="btn btn-app btn-primary btn-small J_submitBtn">
            <i class="icon-search bigger-200"></i>
              搜索
          </button>
          <button type="submit" style="display:none;"></button>
        </form>

        <div class="tabList" id="J_tablist">
          <ul>
            <li class="active" data-value="0">全部宝贝</li>
            <li data-value="1">预设上架</li>
            <li data-value="2">已上架</li>
            <li data-value="3">预设下架</li>
            <li data-value="4">已下架</li>
            <li data-value="5">从未上架</li>
            <li data-value="6">优先上新</li>
          </ul>
        </div>
      </div>
      <div id="viewCateListTPL">
        <!--$for(var i=0; i<data.cateList.length; i++){ -->
          <option value="${_}{data.cateList[i].cid}">${_}{data.cateList[i].cat_name}</li>
        <!--$} -->
      </div>
    </div>
    <div class="FWApp " id="goodsListGadget">
      <!--@goodsListGadget@
      {
      }
      -->
      <div id="viewContentList">
          <div class="itemlist">
            <div style="width:220px; margin: 10px 0 20px;" class="btn-group">
              <button type="button" onclick="FireEvent.updateStatus(0);" class="btn btn-small~ btn-success btn-add-con">
                <i class="icon-upload"></i> 上 架
              </button>
              <button type="button" onclick="FireEvent.updateStatus(1);" class="btn btn-small~ btn-info btn-sel-all">
                <i class="icon-download"></i> 下 架
              </button>
              <button type="button" onclick="FireEvent.updateStatusYXSX();" class="btn btn-small~ btn-warning btn-sel-oppo">
                <i class="icon-bookmark-empty"></i> 优先上新
              </button>
            </div>
          </div>
          <form id="formContentList" class="form-horizontal clearfix">
          </form>
      </div>
      <div id="viewMask">
        <div class="widget-box" style="width:500px; height:227px;">
          <div class="widget-header">
            <h4>${_}{data.title}提示</h4>
            <span class="widget-toolbar">
              <a href="javascript:void(0);" onclick="FireEvent.closeMask();">
                <i class="icon-remove"></i>
              </a>
            </span>
          </div>
          <div class="widget-body">
            <div class="widget-main no-padding">
              <form class="form-inline">
                <fieldset style="padding: 50px 20px;" id="J_conWrap">
                  <label class="radio-label">
                    <input type="radio" name="jk" class="J_timeType" checked="true" value="0">
                    <span class="lbl"> 即刻${_}{data.title}</span>
                  </label>
                  <label class="radio-label">
                    <input type="radio" name="jk" class="J_timeType" value="1">
                    <span class="lbl"> 预设${_}{data.title}</span>
                  </label>
                  <div class="row-fluid input-append yushe-time">
                    <input class="span10 J_ysvalue" type="text" data-format="yyyy-MM-dd hh:mm" readonly="true">
                    <span class="add-on">
                      <i class="icon-calendar"></i>
                    </span>
                  </div>
                </fieldset>
                <div class="form-actions tac">
                  <button type="button" class="btn btn-small btn-success" onclick="FireEvent.submitMask();">
                    <i class="icon-ok bigger-110"></i>
                    确定
                  </button>
                  <button type="button" class="btn btn-small btn-default" onclick="FireEvent.closeMask();">
                    <i class="icon-undo bigger-110"></i>
                    取消
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
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
  seajs.use( ['privategadget/filterGadget','privategadget/goodsListGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>