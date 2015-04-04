<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String rightKey = "1qaz@WSX";
	boolean needLogin = true;
	if (session.getAttribute("login") != null) {
		needLogin = false;
	} else {
		String password = request.getParameter("password");
		if (rightKey.equals(password)) {
			session.setAttribute("login", true);
			needLogin = false;
		}else{
			session.removeAttribute("login");
		}
	}	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%if (needLogin){ %>
	<form method="post">
		请输入密码<input name="password" type="password"><br /> <input
			type="submit" value="ok">
	</form>
<%}else{ %>
	<a href="logsview.jsp">查看日志</a><br/>
	<a href="createflow.jsp">编辑flow</a><br/>
	<a href="editservice.jsp">编辑业务</a><br/>
	<a href="testserver.jsp">测试业务</a><br/>
	<a href="manager/RefereshProject.jsp">升级工程</a><br/>
	<a href="createdb.jsp">创建数据库表</a><br/>
<%} %>
</body>
</html>