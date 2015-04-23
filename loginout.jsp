<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  session.removeAttribute("user");
    out.println("<script>alert('已退出登录!');location.href='"+this.getServletContext().getContextPath()+"/index.jsp';</script>");
%>