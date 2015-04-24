<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.removeAttribute("user");
    out.println("<script>top.location.href='"+this.getServletContext().getContextPath()+"/page/adminUserPage/login.jsp';</script>");
%>