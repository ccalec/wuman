<%--
	罗光瑜2013-9-23日重写，本次重写主要是把客户端的模拟环境准备的更简单，更容易上手
	思路是，接受客户端的请求，然后在根据参数，将请求直接sendredirecte即可。不搞的那么复杂
	这里还是要有用户个人数据的问题，便于并发的并行操作。所以目录首先以数据包为第一目录。如果没有，
	就是使用默认的。即空
	第二个目录是包目录，然后是业务名。
	下来是文件名，文件名是上传上来的参数进行md5加密的结果。
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.breeze.support.tools.*"%>
<%@ page import="java.util.*"%>
<%
//读取参数
String paramData = request.getParameter("data");
String pkg = request.getParameter("pkg");
//转换成map
Map<String,Object> jsonMap = GsonTools.parserJsonMapObj(content);
String url = "data/";
if (pkg != null && "".equals(pkg)){
	url =url + pkg + "/";
}
url = url + jsonMap.get("package").toString()+"/";
url = url + jsonMap.get("name").toString()+"/";
url = url + Md5.getMd5Str(paramData) + ".js";
response.sendRedirect(url);
%>