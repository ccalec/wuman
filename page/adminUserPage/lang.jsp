<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setAttribute("loginTitle","屋满网");
	request.setAttribute("cop","服务管理系统");
	request.setAttribute("loginDesc2","管理员登陆");
	request.setAttribute("loginSuccJumb","../manager/index.jsp?norole=true");
%>