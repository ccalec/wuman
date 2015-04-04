
<%
//从参数中获取alias和tmptype
String alias = request.getParameter("alias");
String type = request.getParameter("type");
//+根据alias把对应模板路径获取到，注意，如果没有就用alias拼一个默认的出来
//拼接路径
String path = CmsIniter.COMSPATHPRIFIX + '.'+alias+".cmsview." + type;
//获取对象
BreezeContext tmpObjCtx = ContextMgr.global.getContextByPath(path);
String tmpPath=null;
//if (对象存在){
if (tmpObjCtx != null && !tmpObjCtx.isNull){
////获取模板位置
	tmpPath = tmpObjCtx.getContext("tmpurl").getData().toString();
//}else{
}else{
////使用默认模板
    tmpPath = "/page/"+alias+'/'+type+".jsp";
//}
}
//将模板信息压入到系统中
request.setAttribute("PB","<base href='"+this.getServletContext().getContextPath()+tmpPath+"'>");
//+从系统配置中获取对应的skin参数变量
//+跳转到对应页面，如果当前访问的是这个页面
request.getRequestDispatcher(tmpPath).forward(request,response);
%>