<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>删除商品</title>
</head>

<body>
	<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
	<%
String storeid=(String)session.getAttribute("storeid");
if(storeid==null)response.sendRedirect("storeLogin.html");
try{
	request.setCharacterEncoding("gb18030");
	String goodsid=request.getParameter("goodsid");
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet res=stmt.executeQuery("select picture from goods where id='"+goodsid+"'");//获取商品的图片信息
	String filepath="D:\\pt\\imeg\\";
	res.next();
	String filetruepath=filepath+res.getString("picture");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	int rs=st.executeUpdate("delete from goods where id='"+goodsid+"'");//删除商品
	res.close();
	st.close();
	stmt.close();
	conn.close();
	if(rs==0){
		out.print("更新失败");
		out.print("<script>alert('更新失败');</script>");
	}
	else{
		File file=new File(filetruepath);
		if(!file.exists())file.delete();//删除上传的图片
	}
	response.sendRedirect("goodsManage.jsp");
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>

</html>