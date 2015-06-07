<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>活动管理－${title}</title>
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
          <span id="">活动管理</span>
          <small>
            <i class="icon-double-angle-right"></i>
            <span id="actionName">活动列表</span>
          </small>
        </h1>
      </div>
      <div class="FWApp " id="activitiesMgrGadget">
        <!--@activitiesMgrGadget@
        {
        }
        -->
        <div id="viewActivitiesMgr" class="activitiesmgr">
          <form class="form-horizontal clearfix activitiesform">
            <div class="form-wrap pull-left clearfix">
              <div class="control-group">
                <label for="title" class="control-label">活动名称：</label>
                <div class="controls">
                    <input id="title" class="inp_text" name="title" type="text" value="09001">
                </div>
              </div>
              <div class="control-group">
                <label for="huohao" class="control-label">活动图片：</label>
                <div class="controls">
                  <textarea id="PicsTextArea" style="display:none;" class="_other_img_tex" name="data.other_img"></textarea><div style="margin-top:5px;" alt="其他图片" class="btn btn-mini btn-info" href="javascript:void(0);"><i class="icon-search bigger-120"></i> <object id="SWFUpload_0" type="application/x-shockwave-flash" data="/wuman/breeze/swfupload/swfupload.swf?preventswfcaching=1431698082984" width="230" height="18" class="swfupload"><param name="wmode" value="transparent"><param name="movie" value="/wuman/breeze/swfupload/swfupload.swf?preventswfcaching=1431698082984"><param name="quality" value="high"><param name="menu" value="false"><param name="allowScriptAccess" value="always"><param name="flashvars" value="movieName=SWFUpload_0&amp;uploadURL=%2Fwuman%2Fupload.mup&amp;useQueryString=false&amp;requeueOnError=false&amp;httpSuccess=&amp;assumeSuccessTimeout=0&amp;params=PHPSESSID%3Dsession_id()&amp;filePostName=Filedata&amp;fileTypes=*.jpg%3B%20*.gif%3B%20*.png&amp;fileTypesDescription=%E9%80%89%E6%8B%A9%20JPEG%2FGIF%2FPNG%20%E6%A0%BC%E5%BC%8F%E5%9B%BE%E7%89%87&amp;fileSizeLimit=2%20MB&amp;fileUploadLimit=0&amp;fileQueueLimit=0&amp;debugEnabled=false&amp;buttonImageURL=%2Fwuman%2Fpage%2Fmanager%2F&amp;buttonWidth=230&amp;buttonHeight=18&amp;buttonText=%3Cspan%20class%3D%22button%22%3E%E9%80%89%E6%8B%A9%E6%9C%AC%E5%9C%B0%E5%9B%BE%E7%89%87%20%3Cspan%20class%3D%22buttonSmall%22%3E(%E5%8D%95%E5%9B%BE%E6%9C%80%E5%A4%A7%E4%B8%BA%202%20MB%EF%BC%8C%E6%94%AF%E6%8C%81%E5%A4%9A%E9%80%89)%3C%2Fspan%3E%3C%2Fspan%3E&amp;buttonTextTopPadding=0&amp;buttonTextLeftPadding=0&amp;buttonTextStyle=.button%20%7Bcolor%3A%23ffffff%3B%20font-family%3A%20Helvetica%2C%20Arial%2C%20sans-serif%3B%20font-size%3A%2012pt%3B%20%7D%20.buttonSmall%20%7B%20font-size%3A%2010pt%3B%20%7D&amp;buttonAction=-110&amp;buttonDisabled=false&amp;buttonCursor=-2"></object></div><div id="divFileProgressContainer"></div><div id="PicsField"></div>
                  <p>提示：1. 本地上传图片尺寸比例建议为 4：3，大小不能超过 500 K；<br/> 2. 本类目下您最多可以上传 5 张图片。</p>
                </div>
              </div>
              <div class="control-group">
                <label for="huohao" class="control-label">活动规则：</label>
                <div class="controls">
                  单个账号，第一次购买活动内商品享受1折折扣，第二次购买活动内商品享受2折折扣，第三次购买购买活动内商品享受3折折扣。
                </div>
              </div>
              <div class="control-group">
                <label for="huohao" class="control-label">规则限制时长：</label>
                <div class="controls">
                  <input id="title" class="inp_text" name="title" type="text" value="7"> 天
                </div>
              </div>
              <div class="control-group">
                <label for="huohao" class="control-label">活动上线时间：</label>
                <div class="controls">
                  <input id="title" class="inp_text" name="title" type="text" value="09001">
                </div>
              </div>
              <div class="control-group">
                <label for="huohao" class="control-label">参与活动宝贝：</label>
                <div class="controls">
                </div>
              </div>
              <div class="control-group">
                <label for="" class="control-label">&nbsp;</label>
                <div class="controls itemlist">
                  <table style="margin-bottom:10px;" class="table table-striped table-bordered table-hover">
                    <thead>
                      <tr>
                        <th width="60" class="tac">选择</th>
                        <th width="100%" class="tac">宝贝详情</th>
                        <th width="80" class="tac">价格</th>
                        <th width="80" class="tac">库存</th>
                        <th width="180" class="tac">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td class="tac"><label><input type="checkbox"><span class="lbl"></span></label></td>
                        <td>
                            <img class="img_file data.formList[0].good_img_img_file" id="data.formList[0].good_img_img_file" style="height:60px; width:60px;" src="/wuman/images/nopic.gif">
                          宝贝名称宝贝名称宝贝名称宝贝名称宝贝名称宝贝名称
                          <span class="badge badge-success">优先上新</span>
                          <span class="badge badge-warning">已上架</span>
                        </td>
                        <td class="tac">256.00</td>
                        <td class="tac">12345</td>
                        <td class="tac">
                          <div class="hidden-phone visible-desktop btn-group actionBtnForList">
                            <a href="javascript:void(0);" title="编辑" authority="modifyContent" class="btn btn-mini btn-info" style=""> <i class="icon-edit bigger-120"> 编辑宝贝</i></a>
                            <a href="javascript:void(0);" title="删除" authority="deleteContent" class="btn btn-mini btn-danger" style=""> <i class="icon-trash bigger-120"> 上架宝贝</i></a>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <div id="submitBtn" style="padding:20px 0 0 180px; border-top:1px solid #E2E2E2;">
                <a href="javascript:void(0)" onclick="FW.trigerEvent('trigerSubmit')" class="btn btn-info">
                  <i class="icon-ok bigger-110"></i>
                  发布提交
                </a>
              </div>
            </div>
          </form>

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
  seajs.use( ['privategadget/activitiesMgrGadget'],function(a) {
    a.go("${S}");
    window.FW = a;
  });
</script>

</body>
</html>