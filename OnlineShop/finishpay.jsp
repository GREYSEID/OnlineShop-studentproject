<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>支付成功</title>
</head>

<body>
	<%//更新状态，完成支付
String userid=(String)session.getAttribute("userid");
if(userid==null)out.print("<script>window.location.href='loginregister.html'</script>");
request.setCharacterEncoding("gb18030");
String[]orderid=request.getParameterValues("orderid");
try{
	  Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	  //定义连接字符串,东八区GMT%2B8
	  String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai";
	  //和数据库建立连接
	  Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	  for(int i=0;i<orderid.length;i++)
	  {
		  Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		  String str="update orderlist set status='已支付' where id="+orderid[i];
		  int result=st.executeUpdate(str);
		  if(result==0)out.print("<script>alert('支付失败')</script>");
		  st.close();
		  response.sendRedirect("index.jsp");
		  out.print("<script>window.location.href = 'index.jsp'</script>");
	  }
}
catch(Exception e)
{
	e.printStackTrace();
	out.print("支付失败");
}
%>
</body>

</html>