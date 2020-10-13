<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>确认发货</title>
</head>

<body>
	<%
String storeid=(String)session.getAttribute("storeid");
if(storeid==null)out.print("<script>window.location.href='orderManage.jsp?action=2'</script>");
request.setCharacterEncoding("gb18030");
String id=request.getParameter("goodsid");
String post=request.getParameter("post");
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	int result=st.executeUpdate("update orderlist set post='"+post+"'"+" , status='已发货' where id='"+id+"'");
	if(result==0){
		out.print("<script>alert('发货失败'); window.location.href = 'orderManage.jsp?action=2';</script>");
	}
	response.sendRedirect("orderManage.jsp?action=2");
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>

</html>