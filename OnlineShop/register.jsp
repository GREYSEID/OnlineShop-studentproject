<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>ע��</title>
</head>

<body>
	<%
try{
Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//���������ַ���,������GMT%2B8
String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
//�����ݿ⽨������
Connection conn= DriverManager.getConnection(url,"root","yuan1234");
request.setCharacterEncoding("GB18030");
String userid=request.getParameter("registeruserid");
String pwd=request.getParameter("registeruserpwd");
Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
ResultSet rs=st.executeQuery("select id from myuser where id="+"\""+userid+"\"");
rs.last();
int last=rs.getRow();
if(last==0)
{
	PreparedStatement ps=conn.prepareStatement("insert into myuser(id,pwd,nickname)values(?,?,?)");
	ps.setString(1,userid);
	ps.setString(2,pwd);
	ps.setString(3,userid);//���������˺��ǳ�Ϊid��
	ps.execute();
	ps.close();
	session.setAttribute("userid", userid);
	response.sendRedirect("userimf.jsp?register=true");
}
else{
	out.println("<script>alert('�û����Ѵ���');window.location.href='loginregister.html?login=false';</script>");
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