<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>注册</title>
</head>

<body>
	<%
try{
Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//定义连接字符串,东八区GMT%2B8
String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
//和数据库建立连接
Connection conn= DriverManager.getConnection(url,"root","********");
request.setCharacterEncoding("GB18030");
String userid=request.getParameter("registeruserid");
String pwd=request.getParameter("registeruserpwd");
Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
ResultSet rs=st.executeQuery("select id from myuser where id="+"\""+userid+"\"");
rs.last();
int last=rs.getRow();
if(last==0)
{
	PreparedStatement ps=conn.prepareStatement("insert into myuser(id,pwd,nickname)values(?,?,?)");
	ps.setString(1,userid);
	ps.setString(2,pwd);
	ps.setString(3,userid);//初创建的账号昵称为id号
	ps.execute();
	ps.close();
	session.setAttribute("userid", userid);
	response.sendRedirect("userimf.jsp?register=true");
}
else{
	out.println("<script>alert('用户名已存在');window.location.href='loginregister.html?login=false';</script>");
	}
rs.close();
st.close();
conn.close();
}
catch(Exception e)
{
	out.print(e);
	e.printStackTrace();
}
%>
</body>

</html>
