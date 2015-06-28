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
  <style>
  .commmon_property,.sku_property{
      position: relative;
      margin-top: 40px;
      padding-top: 40px;
      border-top: 1px dashed #d5d5d5;
    }
    .commmon_property:after,.sku_property:after{
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
    .commmon_property:after{
      content: "普通属性"!important;
    }
    .sku_property:after{
      content: "SKU属性"!important;
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
          <li>2. 宝贝详情信息编辑</li>
          <li class="last">3. 保存成功</li>
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
          <div class="well" style="width: 500px; margin: 50px auto 0; padding: 50px;">
            <!--$if(data.action=='conAdd'){-->
            <h4 class="green smaller lighter"><strong><i class="icon-ok"></i>宝贝入库成功</strong></h4>
            <a class="btn btn-small btn-success" onclick="FW.trigerEvent('trigerReset')" href="javascript:void(0)">查看更改</a>
            <a class="btn btn-small btn-info" onclick="FW.trigerEvent('trigerAdd')" href="javascript:void(0)">改类目下继续添加</a>
            <a class="btn btn-small btn-warning" onclick="FW.trigerEvent('trigerStep1')" href="javascript:void(0)">返回重新选择类目</a>
            <a class="btn btn-small btn-danger" href="${B}page/manager/goods_list.jsp?norole=true">查看宝贝列表</a>
            <!--$}else{-->
            <h4 class="green smaller lighter"><strong><i class="icon-ok"></i>宝贝编辑成功</strong></h4>
            <a class="btn btn-small btn-success" onclick="FW.trigerEvent('trigerReset')" href="javascript:void(0)">查看更改</a>
            <a class="btn btn-small btn-warning" onclick="FW.trigerEvent('trigerStep1')" href="javascript:void(0)">宝贝入库</a>
            <a class="btn btn-small btn-danger" href="${B}page/manager/goods_list.jsp?norole=true">查看宝贝列表</a>
            <!--$} -->
          </div>
        </div>
      </div>

      <div class="FWApp " id="skuMgrGadget">
        <!--@skuMgrGadget@
        {
        }
        -->
        <div id="viewSkuMgr">
          <div class="form-horizontal clearfix goodsform" style="display: ; margin:-40px 0 30px;">
            <div class="form-wrap clearfix">
              <!--$if(Object.keys(data.ptpMap).length){ -->
              <div class="commmon_property">
                <!--$for(var pid in data.ptpMap){ -->
                <!--$var ptpObj = data.ptpMap[pid]; -->
                <div class="control-group J_commmon_property ">
                  <label class="control-label">${_}{ptpObj.property_name}：</label>
                  <div class="controls">
                    <select class="ptp_${_}{ptpObj.cid}">
                      <!--$for(var i=0; i < ptpObj['_pvobjs'].length; i++){ -->
                      <!--$var ptpvObj = ptpObj['_pvobjs'][i]; -->
                      <!--$if(ptpvObj['_selected']){ -->
                      <option value="${_}{ptpvObj.cid}" selected="selected">${_}{ptpvObj.value}</option>
                      <!--$}else{ -->
                      <option value="${_}{ptpvObj.cid}">${_}{ptpvObj.value}</option>
                      <!--$} -->
                      <!--$} -->
                    </select>
                  </div>
                </div>
                <!--$} -->
              </div>
              <!--$} -->

              <!--$if(Object.keys(data.pMap).length){ -->
              <div class="control-group sku_property">
                <label for="huohao" class="control-label">宝贝规格：</label>
                <div class="controls">
                  <div class="profile-contact-links">

                    <!--$for(var pid in data.pMap){ -->
                    <!--$var pObj = data.pMap[pid]; -->
                    <div class="control-group control-group-sm">
                      <label class="control-label">${_}{pObj.property_name}：</label>
                      <div class="controls">
                        <!--$if(pObj._pvids && pObj._pvids.length){ -->
                        <!--$for(var i=0; i<pObj._pvids.length; i++){ -->
                        <!--$var pvObj = data.pvMap[pObj._pvids[i]]; -->
                        <label>
                          <!--$if(pvObj.activeStatus){var checked='checked';}else{var checked='';}-->
                          <input name="pvid" data-pid="${_}{pid}" class="ace ace-checkbox-2" type="checkbox" value="${_}{pvObj.cid}" ${_}{checked}>
                          <span class="lbl"></span> ${_}{pvObj.value}
                        </label>
                        <!--$} -->
                        <!--$} -->
                        <label><a class="J_addPV" data-pid="${_}{pid}" href="javascript:void(0)">＋添加</a></label>
                        <!-- <label><a class="J_rmPV" data-pid="${_}{pid}" href="javascript:void(0)"> 管理</a></label> -->
                      </div>
                    </div>
                    <!--$} -->

                    <!--}else{ -->
                    <!-- <div class="nodata">该类目下无类目属性</div> -->
                    <!-- <div class="nodata">该类目下无类目属性，<a href="${B}page/manager/CMSMgr.jsp?alias=category_properties&nodeid=${_}{data.cateid}&action=conPLAdd&norole=true">点击添加类目属性</a></div> -->

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
                      <tr>
                        <td class="hidden"><input type="hidden" name="cid" value="${_}{skuList[i].cid || ''}" /></td>
                        <!--$for(var pid in data.pMap){ -->
                        <!--$if(data.pMap[pid]['_actpvids'].length){-->
                        <!--$var pvobj = skuList[i]['_fe'][pid]; -->
                        <td>${_}{pvobj.value}<input style="display:none;" type="checkbox" name="${_}{data.skuMapData.feaField}" value="${_}{pvobj.cid}" checked="true"></td>
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
                      <tr><td colspan="1000" class="nodata">该商品暂无规格数据，请勾选宝贝规格进行添加</td></tr>
                      <!--$} -->
                    </tbody>
                  </table>
                  <!-- <div class="infodesc">备注：蓝色背景为“修改”的规格数据，黄色背景为“新增”数据</div> -->
                  </form>
                </div>
              </div>
              <!--$} -->
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