<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>ȡ������</title>
</head>

<body>
	<%
String id=request.getParameter("orderid");
String action=request.getParameter("action");
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/taotao?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
	ResultSet rs=st.executeQuery("select*from orderlist where id="+id);
	rs.next();
	String goodsstr=rs.getString("goodslist");//�������ݿ��е�����
	String numstr=rs.getString("numlist");
	String[]goodslist=goodsstr.split("\\|");//�ַ���ת��Ϊ����
	String[]numlist=numstr.split("\\|");
	for(int i=0;i<goodslist.length;i++)//Ѱ����Ӧ����Ʒ������ȥ����Ʒ��������
	{
		PreparedStatement ps=null;
		String string="select*from goods where id="+goodslist[i];
		ps=conn.prepareStatement(string);
		ResultSet res=ps.executeQuery();
		res.next();
		int count=Integer.parseInt(res.getString("count"));
		res.close();
		ps.close();
		int num=count+Integer.parseInt(numlist[i]);
		String sql="update goods set count="+num+" where id="+goodslist[i];
		ps=conn.prepareStatement(sql);
		int result=ps.executeUpdate();
		if(result==0)
		{
			out.print("<script>alert('ȡ������ʧ��');</script>");
		}
		ps.close();
		String delete="delete from orderlist where id="+id;
		ps=conn.prepareStatement(delete);
		result=ps.executeUpdate();
		if(result==0)
		{
			out.print("<script>alert('ȡ������ʧ��');</script>");
		}
		ps.close();
	}
	rs.close();
	st.close();
	conn.close();
	response.sendRedirect("orderManage.jsp?action="+action);
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>

</html>