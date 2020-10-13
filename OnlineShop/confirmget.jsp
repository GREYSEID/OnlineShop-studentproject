<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>确认收货</title>
</head>

<body>
	<%
String userid=(String)session.getAttribute("userid");
if(userid==null)out.print("<script>awindow.location.href='orderManage.jsp?action=1';</script>");
request.setCharacterEncoding("gb18030");
String id=request.getParameter("orderid");
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	int result=st.executeUpdate("update orderlist set status='已收货' where id='"+id+"'");
	if(result==0){
		out.print("<script>alert('收货失败'); window.location.href = 'orderManage.jsp?action=1';</script>");
	}
	response.sendRedirect("orderManage.jsp?action=1");
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>

</html>