<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.breeze.framwork.databus.*"%>
<%@page import="com.breeze.framwork.netserver.tool.ContextMgr"%>
<%@page import="com.weiguang.service.cms.*"%>
<%
request.setAttribute("B",this.getServletContext().getContextPath()+'/');
request.setAttribute("S",this.getServletContext().getContextPath()+"/breeze.brz");
request.setAttribute("_","$");
String path = CmsIniter.CMSPARAMPRIFIX + ".skin";
//获取对象
BreezeContext tmpObjCtx = ContextMgr.global.getContextByPath(path);
if (tmpObjCtx == null || tmpObjCtx.isNull()){
	request.setAttribute("skin","defalut");
}else{
	request.setAttribute("skin",tmpObjCtx.getData().toString());
}
%>