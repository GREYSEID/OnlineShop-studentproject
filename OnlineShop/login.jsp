<%@page language="java" contentType="text/html; charset=gb18030"
    pageEncoding="gb18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!doctype html>
<html>

<head>
	<title>��¼</title>
	<meta charset="gb18030">
	<meta name="author" content="GREYSEID">
</head>

<body>
	<%
String action=request.getParameter("action");
String goodsid=request.getParameter("goodsid");
try{
	    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	  //���������ַ���,������GMT%2B8
	    String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	  //�����ݿ⽨������
	    Connection conn= DriverManager.getConnection(url,"root","yuan1234");
		request.setCharacterEncoding("gb18030");
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("userpwd");
		Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
		ResultSet rs=st.executeQuery("select id,pwd from myuser where id="+"\""+userid+"\"");
		rs.next();
			if((userid.equals(rs.getString("id")))&&(pwd.equals(rs.getString("pwd"))))
			{
				session.setAttribute("userid", userid);
				if("1".equals(action)&&(goodsid!=null||"".equals(goodsid)))out.print("<script>window.location.href='Goods.jsp?goodsid="+goodsid+"'</script>");
				else if("2".equals(action))out.print("<script>window.location.href = 'Cart.jsp'</script>");
				else if("3".equals(action))out.print("<script>window.location.href = 'orderManage.jsp?action=1'</script>");
				else response.sendRedirect("welcome.html");
			}
			else{
				out.print("<script>alert('�û������벻���ڻ����'); window.location.href = 'loginregister.html';</script>");
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
	out.print("<script>alert('�û������벻���ڻ����'); window.location.href = 'loginregister.html';</script>");
	//response.sendRedirect("loginregister.html");
}
catch(Exception e)
{
	out.print(e);
}
finally{
}
%>
</body>

</html>