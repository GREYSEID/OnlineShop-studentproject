<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>����</title>
</head>

<body>
	<%
request.setCharacterEncoding("gb18030");
String search=request.getParameter("search");
if(search==null||"".equals(search))out.print("<script>window.location.href='index.jsp';</script>");
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
	String str="select A.id from goods A,storeacc B "+"where A.storeid=B.storeid and count+0>0 "+"and "+"( name LIKE '%"+search+"%' or "+" tag like '%"+search+"%' or introduction like '%"+search+"%' or id like '%"+search+"%' or A.storeid like '%"+search+"%' or store like'%"+search+"%' ) ";
	out.print(str);
	ResultSet rs=st.executeQuery(str);
	String s="";
	while(rs.next())
	{
		out.print(rs.getString("id")+"<br>");
		s+="goodslist="+rs.getString("id")+"&";
	}
	response.sendRedirect("index.jsp?"+s);
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>

</html>