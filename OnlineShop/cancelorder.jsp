<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>取消订单</title>
</head>

<body>
	<%
String id=request.getParameter("orderid");
String action=request.getParameter("action");
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/taotao?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","********");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	ResultSet rs=st.executeQuery("select*from orderlist where id="+id);
	rs.next();
	String goodsstr=rs.getString("goodslist");//接收数据库中的数据
	String numstr=rs.getString("numlist");
	String[]goodslist=goodsstr.split("\\|");//字符串转换为数组
	String[]numlist=numstr.split("\\|");
	for(int i=0;i<goodslist.length;i++)//寻找相应的商品，将减去的商品数量加上
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
			out.print("<script>alert('取消订单失败');</script>");
		}
		ps.close();
		String delete="delete from orderlist where id="+id;
		ps=conn.prepareStatement(delete);
		result=ps.executeUpdate();
		if(result==0)
		{
			out.print("<script>alert('取消订单失败');</script>");
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
