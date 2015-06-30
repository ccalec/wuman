<%@page import="com.breeze.framwork.databus.BreezeContext"%>
<%@page import="com.weiguang.service.authority.AuthIniter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="bgPower.jsp" %>
<%
  BreezeContext user = (BreezeContext)session.getAttribute("user");
  if(user==null)return;
  BreezeContext roleCtx = user.getContext("role");
  String authJson = AuthIniter.getActorJson(roleCtx);
%>
<script type="text/javascript">
  //罗哥，权限的代码，放在appClass.js里面的430行，请测试
  var authorityData = <%=authJson%>;
</script>

