<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>创建订单</title>
	<%
String userid=(String)session.getAttribute("userid");
if(userid==null)response.sendRedirect("loginregister.html");
if(request.getParameter("allprice")==null||"".equals(request.getParameter("allprice")))out.print("<script>window.location.href='Cart.jsp'</script>");
if(request.getParameterValues("goods")==null)out.print("<script>window.location.href = 'Cart.jsp'</script>");
if(request.getParameterValues("num")==null)out.print("<script>window.location.href = 'Cart.jsp'</script>");
%>
	<link rel="stylesheet" type="text/css" href="taotao.css">
	<script type="text/javascript">
		function allprice() {
			var numlist = document.getElementsByName("num");
			var number = 0;
			for (var i = 0; i < numlist.length; i++) {
				if (numlist[i].checked == true) {
					number += (parseInt(numlist[i].value) * parseFloat(numlist[i].parentElement.nextElementSibling.innerHTML));
				}
			}
			document.getElementById('price').innerHTML = number;
			document.getElementById('allprice').value = number;
		}
		function showTime() {
			var t = new Date();
			var year = t.getFullYear();
			var month = t.getMonth();
			var day = t.getDate();
			var week = t.getDay();
			var hour = t.getHours();
			var minute = t.getMinutes();
			var second = t.getSeconds();
			var curWeek;
			switch (week) {
				case 0: curWeek = "星期日"; break;
				case 1: curWeek = "星期一"; break;
				case 2: curWeek = "星期二"; break;
				case 3: curWeek = "星期三"; break;
				case 4: curWeek = "星期四"; break;
				case 5: curWeek = "星期五"; break;
				case 6: curWeek = "星期六"; break;
			}
			var time = " " + year + "年" + month + "月" + day + "日 " + curWeek + " " + hour + ":" + minute + ":" + second;
			document.getElementById("time").innerHTML = time;
		}
		setInterval("showTime()", 1000);
		function login() {
			document.getElementById("login").style.display = "block";
			document.getElementById("register").style.display = "none";
		}
		function register() {
			document.getElementById("login").style.display = "none";
			document.getElementById("register").style.display = "block";
		}
		var count = 0;
		function imgclick() {
			count++;
			if ((count % 2) == 1) { document.getElementById("imgclick").src = "timg (2).jpg"; }
			else if ((count % 2) == 0) { document.getElementById("imgclick").src = "timg (1).jpg"; }
		}
	</script>
</head>

<body style="margin: 0;padding: 0;overflow: visible;background-color: #f5f5f5;" onload="allprice();showtime()">
	<div class="firsttitle">
		<a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;">个人页面</a>
		<a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">我的购物车</a>
		<a href="orderManage.jsp?action=1" style="margin-left: 10px;margin-right: 10px;">购买记录</a>
		<a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">注销</a>
		<a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">主页</a>
		<span id="time" style="float:right;width: 150px;"> </span>
		<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">客服</a>
	</div>
	<form action="ordercreate.jsp" method="get" onkeydown="if(event.keyCode==13)return false;"
		style="margin:0 auto;text-align: center;">
		<%
String address="";
String phone="";
String name="";
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection co= DriverManager.getConnection(url,"root","yuan1234");
	Statement sta=co.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet resu=sta.executeQuery("select name,phone,address from myuser where id="+userid);
	resu.next();
	address=resu.getString("address");//获取默认的收货人信息
	phone=resu.getString("phone");
	name=resu.getString("name");
	resu.close();
	sta.close();
	co.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
		<label>手机</label><input type="text" name="phone" value="<%=phone==null?"":phone %>"
			oninput="value=value.replace(/[^\d]/g,'')" required>
		<label>收货人</label><input type="text" name="name" value="<%=name==null?"":name%>" required>
		<p>填写地址</p>
		<textarea rows="5" cols="50" id="address" name="address" required><%=address==null?"":address %></textarea>
		<table style="text-align: center;margin: 0 auto;">
			<tr>
				<td></td>
				<td>商品id</td>
				<td>商品名</td>
				<td></td>
				<td>商品数量</td>
				<td>单价</td>
			</tr>
			<%
request.setCharacterEncoding("gb18030");
String[] goodslist=request.getParameterValues("goods");
String[] numlist=request.getParameterValues("num");
//if(request.getParameterValues("goods")==null)out.print("<script>window.location.href='Cart.jsp';</script>");
//if(request.getParameterValues("num")==null)out.print("<script>window.location.href = 'Cart.jsp'</script>");
if(goodslist!=null&&numlist!=null){
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	String s="select A.*,B.store from goods A ,storeacc B where A.storeid=B.storeid and (id="+goodslist[0];
	for(int i=1;i<goodslist.length;i++)//不知道筛选条件过多会不会崩溃
	{
		s+=" or id="+goodslist[i];
	}
	s+=" )";
	ResultSet rs=st.executeQuery(s);
	String nowstore="";
	while(rs.next())//按照所给的信息，显示要购买商品的详细信息
	{
		String store=rs.getString("store");
		if(!nowstore.equals(store)){
			out.print("<tr>");
			out.print("<td>"+store+"</td>");
			out.print("</tr>");
			nowstore=store;
		}
		out.print("<tr>");
		out.print("<td>"+"<input type='checkbox' value='"+rs.getString("id")+"'"+" name='goods' onclick='checkone("+rs.getRow()+")' id='"+rs.getRow()+"' checked hidden></td>");
		out.print("<td>"+rs.getString("id")+"</td>");
		out.print("<td>"+rs.getString("name")+"</td>");
		out.print("<td><div style='width:50px;height:50px;'>"+"<img style='width:100%;height:100%;' alt='图片' src='/pt/imeg/"+((rs.getString("picture")==null||"".equals(rs.getString("picture")))?("timg (3).jpg"):(URLEncoder.encode(rs.getString("picture"),"gb18030")))+"'"+"</div></td>");
		for(int i=0;i<goodslist.length;i++)
		{
			if(goodslist[i].equals(rs.getString("id"))){
				int count=Integer.parseInt(rs.getString("count"));
				if(count<Integer.parseInt(numlist[i])){//检测库存是否充足
					out.print("<script>alert('"+rs.getString("name")+"库存不足');window.location.href='Cart.jsp';</script>");
				}
				out.print("<td>"+numlist[i]+"<input type='checkbox' value='"+numlist[i]+"'name='num'  checked hidden></td>");
			}
		}
		out.print("<td>"+rs.getString("price")+"</td>");
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
}
%>
		</table>
		<button type="submit">提交订单</button><span>总价:</span><span id='price'>0</span><input type="hidden" id='allprice'
			name='allprice'>
	</form>
</body>

</html>