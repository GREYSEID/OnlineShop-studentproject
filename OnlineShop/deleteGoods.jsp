<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>ɾ����Ʒ</title>
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
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet res=stmt.executeQuery("select picture from goods where id='"+goodsid+"'");//��ȡ��Ʒ��ͼƬ��Ϣ
	String filepath="D:\\pt\\imeg\\";
	res.next();
	String filetruepath=filepath+res.getString("picture");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
	int rs=st.executeUpdate("delete from goods where id='"+goodsid+"'");//ɾ����Ʒ
	res.close();
	st.close();
	stmt.close();
	conn.close();
	if(rs==0){
		out.print("����ʧ��");
		out.print("<script>alert('����ʧ��');</script>");
	}
	else{
		File file=new File(filetruepath);
		if(!file.exists())file.delete();//ɾ���ϴ���ͼƬ
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