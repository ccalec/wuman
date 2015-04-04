<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="${B}/breeze/lib/js/jquery.js"></script>
<script src="${B}/breeze/lib/js/sea.js"></script>
<script src="${B}/config/config.jsp"></script>

<!-- 图片上传 -->
<script src="${B}/breeze/lib/js/ajaxfileupload.js"></script>

<!-- Jquery UI -->
<script type="text/javascript"> if("ontouchend" in document) document.write("<script src='${B}/page/manager/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>

<!--page specific plugin scripts-->
<script src="${B}/page/manager/assets/js/bootstrap.min.js"></script>
<script src="${B}/page/manager/assets/js/fuelux/fuelux.tree.min.js"></script>
<script src="${B}/page/manager/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${B}/page/manager/assets/js/date-time/bootstrap-timepicker.min.js"></script>
<script src="${B}/page/manager/assets/js/date-time/moment.min.js"></script>
<script src="${B}/page/manager/assets/js/date-time/daterangepicker.min.js"></script>
<script src="${B}/page/manager/assets/js/date-time/bootstrap-datetimepicker.min.js"></script>
<script src="${B}/page/manager/assets/js/bootbox.min.js"></script>
<script src="${B}/page/manager/assets/js/chosen.jquery.min.js"></script>
<script src="${B}/page/manager/assets/js/jquery.easy-pie-chart.min.js"></script>
<script src="${B}/page/manager/assets/js/jquery.sparkline.min.js"></script>
<script src="${B}/page/manager/assets/js/flot/jquery.flot.min.js"></script>
<script src="${B}/page/manager/assets/js/flot/jquery.flot.pie.min.js"></script>
<script src="${B}/page/manager/assets/js/flot/jquery.flot.resize.min.js"></script>
<!-- html编辑器 -->
<script src="${B}/breeze/xheditor/jquery-migrate-1.1.0.min.js"></script>
<script src="${B}/breeze/xheditor/xheditor-1.2.1.min.js"></script>
<script src="${B}/breeze/xheditor/xheditor_lang/zh-cn.js"></script>

<!-- 多图上传函数 -->
<script src="${B}/breeze/swfupload/swfupload.js"></script>
<script src="${B}/breeze/swfupload/handlers.js"></script>

<!--ace scripts-->
<script src="${B}/page/manager/assets/js/ace-elements.min.js"></script>
<script src="${B}/page/manager/assets/js/ace.min.js"></script>


<!-- 菜单高亮展开 -->
<script type="text/javascript">
	$(function(){

		//判断是否有菜单操作权限，显示该用户拥有权限的菜单
		$("[actionName]").each(function(){
		 	//获取页面权限的severname
		 	var actionName = $(this).attr("actionName");
		 	//格式是actionName@ServiceName.
		 	actionInfoArry = actionName.split("@");
		 	if(actionInfoArry.length !=2) return true;
		 	var actionList = authorityData[actionInfoArry[1]] || null;
		 	if(!actionList) return true;
		 	//遍历权限数组，寻找对应alias和servename
		 	for (var i = 0; i < actionList.length; i++){
		 		if(actionList[i].actionName == actionInfoArry[0]){
		 			$(this).show();
		 			break;
		 		}
		 	}
		});
	})
</script>