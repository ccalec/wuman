<%@page import="com.breeze.framwork.databus.BreezeContext"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <%
  if(session.getAttribute("user")==null){
    out.println("<script>top.location.href='"+this.getServletContext().getContextPath()+"/page/adminUserPage/login.jsp'</script>");
  }else{
    BreezeContext nuser = (BreezeContext)session.getAttribute("user");
    if(nuser.getContext("role") == null){
      out.println("<script>top.location.href='"+this.getServletContext().getContextPath()+"/page/adminUserPage/login.jsp'</script>");
    }
  }
  %>
