<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>�̼ҵ�¼</title>
</head>

<body>
	<%
try{
	  Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	  //���������ַ���,������GMT%2B8
	  String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	  //�����ݿ⽨������
	  Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	  request.setCharacterEncoding("gb18030");
	  String storeid=request.getParameter("userid");
	  String pwd=request.getParameter("userpwd");
	  Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
	  ResultSet rs=st.executeQuery("select storeid,storepwd from storeacc where storeid="+"\""+storeid+"\"");
	  rs.next();
			if((storeid.equals(rs.getString("storeid")))&&(pwd.equals(rs.getString("storepwd"))))
			{
				session.setAttribute("storeid", storeid);
				response.sendRedirect("goodsManage.jsp");
			}
			else{
				out.print("<script>alert('�û������벻���ڻ����');window.location.href='storeLogin.html';</script>");
				//response.setHeader("Refresh", "3;loginregister.html");
				//response.sendRedirect("loginregister.html");
			}
	rs.close();
	st.close();
	conn.close();
}
catch(ClassNotFoundException e)
{
	out.print("װ��ʧ��");
}
catch(SQLException e)
{
	out.println(e);
	out.print("����ʧ��");
	out.print("<script>alert('�û������벻���ڻ����'); window.location.href = 'storeLogin.html';</script>");
	//response.sendRedirect("storeLogin.html");
}
catch(Exception e)
{
	out.print(e);
}
%>
</body>

</html>