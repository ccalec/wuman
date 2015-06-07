<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>宝贝入库－${title}</title>
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
          <div class="pull-right" id="btnAction">
            <div class="btn-toolbar">
              <div class="btn-group">
                <a class="btn btn-small btn-default" href="${B}page/manager/goods_list.jsp?norole=true">
                  <i class="icon-app"></i>
                  返回宝贝列表
                </a>
              </div><!--/btn-group-->
            </div>
          </div>
          <span id="">宝贝管理</span>
          <small>
            <i class="icon-double-angle-right"></i>
            <span>宝贝入库</span>
          </small>
        </h1>
      </div>

      <div class="goods_nav">
        <ul>
          <li>1. 选择宝贝类目</li>
          <li>2. 填写宝贝详情信息</li>
          <li class="last">3. 入库成功</li>
        </ul>
      </div>
      <div class="FWApp " id="goodsMgrGadget">
        <!--@goodsMgrGadget@
        {
        }
        -->
        <div id="viewGoodsMgrStep1" class="wrapbox step1">
          <div class="catebox">
            <div class="catelist">
              <ul id="parentList">
              </ul>
            </div>
            <div class="catelist">
              <ul id="sonList">
              </ul>
            </div>
            <div class="arrow"><i class="icon-angle-right gray bigger-200"></i></div>
          </div>
          <div class="catres">
             <span>您当前的选择是：</span>
             <span id="restxt">未选择</span>
          </div>
          <div id="btnStep1" class="btncls">
            <a href="javascript:void(0)" onclick="FireEvent.step1btn()" class="btn btn-info disabled">
              <i class="icon-ok bigger-110"></i>
              下一步
            </a>
          </div>
        </div>
        <div id="viewCateListTPL">
          <!--$for(var i=0; i<data.cateList.length; i++){ -->
            <li data-cid="${_}{data.cateList[i].cid}">${_}{data.cateList[i].cat_name}</li>
          <!--$} -->
        </div>

        <div id="viewContentAdd" class="wrapbox step2">
          <div class="space-24"></div>
          <form id="formContentAdd" class="form-horizontal clearfix">
          </form>
        </div>

        <div id="viewContentEdit" class="wrapbox step2">
          <div class="space-24"></div>
          <form id="formContentEdit" class="form-horizontal clearfix">
          </form>
        </div>

        <div id="viewGoodsMgrStep3" class="step3">
          <div class="well">
            <h4 class="green smaller lighter">
              <strong>
                <i class="icon-ok"></i>
                提交成功
              </strong>
            </h4>
            <a class="btn btn-small btn-info" onclick="FW.trigerEvent('trigerReset')" href="javascript:void(0)">查看更改</a>
            <a class="btn btn-small btn-success" href="${B}page/manager/goods_list.jsp?norole=true">返回宝贝列表</a>
          </div>
        </div>
      </div>
      <hr>
      <div class="FWApp " id="skuMgrGadget">
        <!--@skuMgrGadget@
        {
        }
        -->
        <div id="viewSkuMgr">
          <div class="form-horizontal clearfix goodsform" style="display: ;">
            <div class="form-wrap clearfix">
              <div class="control-group">
                <label for="huohao" class="control-label">宝贝规格：</label>
                <div class="controls">
                  <div class="profile-contact-links">
                    <!--$if(Object.keys(data.pMap).length){ -->
                    <!--$for(var pid in data.pMap){ -->
                    <!--$var pObj = data.pMap[pid]; -->
                    <div class="control-group control-group-sm">
                      <label class="control-label">${_}{pObj.property_name}：</label>
                      <div class="controls">
                        <!--$if(pObj.pvList && pObj.pvList.length){ -->
                        <!--$for(var i=0; i<pObj.pvList.length; i++){ -->
                        <label>
                          <!--$if(pObj.pvList[i].activeStatus){ -->
                          <!--$if(pObj.pvList[i]._initStatus){var disabled='disabled';}else{var disabled='';} -->
                          <input name="pvid" data-pid="${_}{pid}" class="ace ace-checkbox-2 ${_}{disabled}" type="checkbox" value="${_}{pObj.pvList[i].cid}" checked="true">
                          <!--$}else{ -->
                          <input name="pvid" data-pid="${_}{pid}" class="ace ace-checkbox-2" type="checkbox" value="${_}{pObj.pvList[i].cid}">
                          <!--$} -->
                          <span class="lbl"></span> ${_}{pObj.pvList[i].value}
                        </label>
                        <!--$} -->
                        <!--$} -->
                        <label><a class="J_addPV" data-pid="${_}{pid}" href="javascript:void(0)">＋添加</a></label>
                        <!-- <label><a class="J_rmPV" data-pid="${_}{pid}" href="javascript:void(0)"> 管理</a></label> -->
                      </div>
                    </div>
                    <!--$} -->
                    <!--$}else{ -->
                    <div class="nodata">该类目下无类目属性，<a href="${B}page/manager/CMSMgr.jsp?alias=category_properties&nodeid=${_}{data.cateid}&action=conPLAdd&norole=true">点击添加类目属性</a></div>
                    <!--$} -->
                  </div>
                </div>
              </div>
              <div class="control-group">
                <label for="" class="control-label">&nbsp;</label>
                <div class="controls">
                  <form id="J_skuform">
                  <table style="margin-bottom:10px;" class="table table-striped table-bordered table-hover baobeigg">
                    <thead>
                      <tr>
                        <th class="hidden"></th>
                        <!--$for(var i=0; i<data.skuMapData.headList.length; i++){ -->
                        <th class="center">${_}{data.skuMapData.headList[i]}</th>
                        <!--$} -->
                      </tr>
                    </thead>
                    <tbody>
                      <!--$var skuList = data.skuMapData.skuList; fieldList = data.skuMapData.showFields; -->
                      <!--$if(skuList && skuList.length){ -->
                      <!--$for(var i=0; i<skuList.length; i++){ -->
                      <!--$if(!skuList[i].cid){var colcls = 'tr_add';}else{var colcls = '';} -->
                      <tr class="${_}{colcls}">
                        <td class="hidden"><input type="hidden" name="cid" value="${_}{skuList[i].cid || ''}" /></td>
                        <!--$for(var pid in data.pMap){ -->
                        <!--$if(data.pMap[pid]['_len']){-->
                        <!--$var fobj = skuList[i]['_fe'][pid]; -->
                        <td>${_}{fobj.value}<input style="display:none;" type="checkbox" name="${_}{data.skuMapData.feaField}" value="${_}{fobj.cid}" checked="true"></td>
                        <!--$} -->
                        <!--$} -->
                        <!--$for(var k=0; k<fieldList.length; k++){ -->
                        <!--$if(skuList[i].cid){ -->
                        <td><input value="${_}{skuList[i][fieldList[k]] || 0}" class="gg_${_}{fieldList[k]}" name="${_}{fieldList[k]}" type="text"></td>
                        <!--$}else{ -->
                        <td><input value="${_}{skuList[i][fieldList[k]] || 0}" class="gg_${_}{fieldList[k]} error" name="${_}{fieldList[k]}" type="text"></td>
                        <!--$} -->
                        <!--$} -->
                      </tr>
                      <!--$} -->
                      <!--$}else{ -->
                      <tr><td colspan="1000" class="nodata">该商品暂无任何库存，请勾选宝贝规格进行添加</td></tr>
                      <!--$} -->
                    </tbody>
                  </table>
                  <div class="infodesc">备注：蓝色背景为“修改”的规格数据，黄色背景为“新增”数据</div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="submitBtn" class="cmssubmitbtn">
        <a href="javascript:void(0)" onclick="FW.trigerEvent('trigerSubmit')" class="btn btn-info">
          <i class="icon-ok bigger-110"></i>
          确认提交
        </a>
        &nbsp; &nbsp; &nbsp;
        <a href="javascript:void(0)" onclick="FW.trigerEvent('trigerReset')" class="btn">
          <i class="icon-undo bigger-110"></i>
          取消，重新编辑
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
  seajs.use( ['privategadget/goodsMgrGadget','privategadget/skuMgrGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>