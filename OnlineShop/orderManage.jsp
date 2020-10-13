<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>订单管理</title>
	<style>
		.orderstyle {
			display: "";
		}

		.goodsstyle {
			display: none;
		}

		.orderstyle:hover .goodsstyle {
			display: table-row;
		}

		.orderstyle:hover {}

		table {
			text-align: center;
		}

		td {
			width: 200px;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="taotao.css">
	<script>
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
		function check(id) {
			var i = document.getElementById(id);
			var hidden = i.hasAttribute("hidden");
			if (hidden) {
				i.removeAttribute("hidden");
			}
			else {
				i.setAttribute("hidden", "hidden");
			}
		}
	</script>
</head>

<body style="margin: 0;padding: 0;overflow: visible;background-color: #f5f5f5;" onload="showTime()">
	<%
String action=request.getParameter("action");
if("1".equals(action)){
String userid=(String)session.getAttribute("userid");
String boolcodeout="inline";
String boolcodein="none";
String boolblockout="block";
String boolblockin="none";
String head="/pt/imeg/timg1.jpg";
String nickname=null;
if(userid==null)out.print("<script>window.location.href='loginregister.html';</script>");
if(userid!=null){//检测用户是否登录，登录了就显示个人信息等，没登陆就显示登录注册页面
	boolcodeout="none";
	boolcodein="inline";
	boolblockout="none";
	boolblockin="block";

try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	ResultSet rs=st.executeQuery("select nickname,head from myuser where id="+"\""+userid+"\"");//获取用户的昵称头像，显示
	rs.next();
	nickname=rs.getString("nickname");
	head=rs.getString("head");
	if(head!=null){
		String gbk=URLEncoder.encode(head,"gb18030");//有中文要转码,jsp的src地址相当于打开一个网页图片，不能有中文要转码
		head="/pt/imeg/"+gbk;
	}
	else head="/pt/imeg/timg1.jpg";
	rs.close();
	st.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
}
}
%>
	<div class="firsttitle">
		<a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;">个人页面</a>
		<a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">我的购物车</a>
		<a href="orderManage.jsp?action=1" style="margin-left: 10px;margin-right: 10px">购买记录</a>
		<a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">注销</a>
		<a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">主页</a>
		<span id="time" style="float:right;width: 150px;"> </span>
		<a href="goodsManage.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">商家入口</a>
		<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">客服</a>
	</div>
	<div style="background-color: white;width: 100%;height: 150px;">
		<div style="width: 1500px;height: 150px;border:  0;background-color: white;margin: 0 auto;">
			<div style="width: 25%;height: 150px;float: left;">
				<a href="https://www.taobao.com/"><img src="1.jpg" style="height: 100%;width:100%;" /></a>
			</div>
			<div style="float: left;height: 100%;width:50%;">
				<center>
					<form action="search.jsp" style="padding: 40px 0;">
						<input type="text" id="searchText" placeholder="SEARCH" class="searchstyle" name='search'><input
							type="submit" value="搜索" class="searchButton">
					</form>
				</center>
			</div>
			<div style="float: left;height: 100%;width: 25%;">
				<form action="login.jsp" class="loginregister" style="display:<%=boolblockout%>;">
					<label for="userid">账&nbsp;号 </label><input type="text" id="userid" placeholder="USERID"
						class="lrstyle" required="required" name="userid"><br>
					<label for="userpwd">密&nbsp;码 </label><input type="password" id="userpwd" placeholder="PASSWORD"
						class="lrstyle" required="required" name="userpwd">
					<div><input type='hidden' name='action' value='3'>
						<input type="submit" value="LOGIN"><a href="currentregister.jsp"
							style="font-size: 5px;cursor: default;">REGISTER</a>
					</div>
				</form>
				<div style="display:<%=boolblockin %>;height:100%;width:100%;">
					<div style="float:left;position: relative;top: 40%;"><span style="">welcome!!!&nbsp;<a
								href="userimf.jsp"><%=nickname %></a></span></div>
					<div
						style="width:100px;height:100px;border-radius:50%;overflow: hidden;float:right;position: relative;top: 10%;">
						<img alt="头像" src="<%=head%>" style="height:100%;width: 100%"></div>
				</div>
			</div>
		</div>
	</div>
	<div style="marign:0 auto;text-align: center;">
		<table align="center">
			<tr>
				<td>订单号</td>
				<td>商店</td>
				<td>购买日期</td>
				<td>价格</td>
				<td>订单状态</td>
				<td>取消订单</td>
				<td>确认收货</td>
			</tr>
			<%
int PageSize=20;//一页显示20条
int RowCount=0;//记录总数
int PageCount=1;//总页数
int Page=1;//显示的页码
String strPage=null;//接收页码
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	ResultSet rs=st.executeQuery("select A.*,B.store from orderlist A,storeacc B where A.storeid=B.storeid and userid="+"\""+userid+"\"");
	if(rs.next())
	{
		rs.last();
		RowCount=rs.getRow();
		PageCount=(RowCount+PageSize-1)/PageSize;//总页数，加1从1开始数

	strPage=request.getParameter("page");
	if(strPage==null)Page=1;
	else{
		Page=Integer.parseInt(strPage);
		if(Page>PageCount)Page=PageCount;
		if(Page<1)Page=1;
	}
	if(PageCount>0)rs.absolute((Page-1)*PageSize+1);//跳转到指定记录位置
	int n=0;
	while(n<PageSize&&rs!=null&&!rs.isAfterLast())
	{
		String id=rs.getString("id");
		String storeid=rs.getString("storeid");
		String store=rs.getString("store");
		String time=rs.getString("time");
		String price=rs.getString("price");
		String goodsstr=rs.getString("goodslist");
		String status=rs.getString("status");
		String[]goodslist=goodsstr.split("\\|");
		String numstr=rs.getString("numlist");
		String[]numlist=numstr.split("\\|");
		String address=rs.getString("address");
		String name=rs.getString("name");
		String phone=rs.getString("phone");
		String post=rs.getString("post");
		out.print("<tr><td colspan='7'>");
		out.print("<table class='orderstyle'>");
		out.print("<tr>");
		out.print("<td>"+id+"</td>");
		out.print("<td>"+store+"</td>");
		out.print("<td>"+time+"</td>");
		out.print("<td>"+price+"</td>");
		if(status.equals("待支付"))out.print("<td><a href='pay.jsp?allprice="+price+"&orderid="+id+"'>"+status+"</a></td>");
		else out.print("<td>"+status+"</td>");
		out.print("<td><a href='"+"cancelorder.jsp?action=1&orderid="+id+"'>取消订单</a></td>");
		if(!"已收货".equals(status)&&!"待支付".equals(status))out.print("<td><a href='"+"confirmget.jsp?orderid="+id+"'>确认收货</a></td>");
		else out.print("<td></td>");
		out.print("</tr>");
		for(int i=0;i<goodslist.length;i++)
		{
			out.print("<tr class='goodsstyle'><td colspan=7 >");
			out.print("<table>");
			Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
			ResultSet res=stmt.executeQuery("select * from goods where id="+"\""+goodslist[i]+"\"");
			res.next();
			String picture=res.getString("picture");
			out.print("<tr><td rowspan=2>");
			out.print("<a href='Goods.jsp?goodsid="+goodslist[i]+"'><img src='/pt/imeg/"+((picture==null||"".equals(picture))?"timg (3).jpg":picture)+"' alt='' style='height:50px;'></a>");
			out.print("</td>");
			out.print("<td>商品id:"+res.getString("id")+"</td>");
			out.print("<td>单价:"+res.getString("price")+"</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td>商品名:"+res.getString("name")+"</td>");
			out.print("<td>购买数:"+numlist[i]+"</td>");
			out.print("</tr>");
			out.print("</table>");
			//out.print
			out.print("</td></tr>");
			stmt.close();
			res.close();
		}
		out.print("<tr class='goodsstyle'>");
		out.print("<td style='text-align:left;'>收货人:"+name+"</td>");
		out.print("<td style='text-align:left;'>收货人联系方式:"+phone+"</td>");
		out.print("<td style='text-align:left;'>快递单号:"+(post==null?"":post)+"</td>");
		out.print("</tr>");
		out.print("<tr class='goodsstyle'><td colspan=7 style='text-align:left;'>收货地址:"+address+"</td></tr>");
		out.print("</table>");
		out.print("</td></tr>");
		n++;
		rs.next();
	}
	}
	%>
		</table><%
	out.print("<form action=\"orderManage.jsp\" method=\"get\">");
	if(Page>1)
	{
		out.print("&nbsp;<a href='orderManage.jsp?action=1&page=1'>首&nbsp;页</a>&nbsp;");
		out.print("&nbsp;<a href='orderManage.jsp?action=1&page="+(Page-1)+"'>上一页</a>&nbsp;");
	}
	out.print("&nbsp;第"+Page+"页&nbsp;");
	if(Page<PageCount)
	{
		out.print("&nbsp;<a href='orderManage.jsp?action=1&page="+(Page+1)+"'>下一页</a>&nbsp;");
		out.print("&nbsp;<a href='orderManage.jsp?action=1&page="+PageCount+"'>尾&nbsp;页</a>&nbsp;");
	}
	out.print("<input type='hidden' value=1 name='action'>");
	out.print("&nbsp;跳转到<input type='text' name='page' size=2>页&nbsp;共"+PageCount+"页&nbsp;<input type='submit' value='go'>&nbsp;");
	out.print("</form>");
}
catch(Exception e)
{
	e.printStackTrace();
}
}
else if("2".equals(action))
{
	String storeid=(String)session.getAttribute("storeid");
	if(storeid==null)out.print("<script>window.location.href = 'goodsManage.jsp';</script>");
	%>
		<div class="firsttitle">
			<a href="storeuserimf.jsp" style="margin-left: 10px;margin-right: 10px;">个人页面</a>
			<a href="orderManage.jsp?action=2" style="margin-left: 10px;margin-right: 10px">购买记录</a>
			<a href="logout.jsp?action=2" style="margin-left: 10px;margin-right: 10px;">注销</a>
			<a href="goodsManage.jsp" style="margin-left: 10px;margin-right: 10px;">主页</a>
			<span id="time" style="float:right;width: 150px;"> </span>
			<a href="index.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">客户入口</a>
			<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">客服</a>
		</div>
		<div style="marign:0 auto;text-align: center;">
			<table align="center">
				<tr>
					<td>订单号</td>
					<td>购买日期</td>
					<td>价格</td>
					<td>订单状态</td>
					<td>取消订单</td>
					<td>确认发货</td>
				</tr>
				<%
	int PageSize=20;//一页显示20条
	int RowCount=0;//记录总数
	int PageCount=1;//总页数
	int Page=1;//显示的页码
	String strPage=null;//接收页码
	try{
		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		//定义连接字符串,东八区GMT%2B8
		String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
		//和数据库建立连接
		Connection conn= DriverManager.getConnection(url,"root","yuan1234");
		Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
		ResultSet rs=st.executeQuery("select A.*,B.store from orderlist A,storeacc B where A.storeid=B.storeid and A.storeid="+"\""+storeid+"\"");
		if(rs.next())
		{
			rs.last();
			RowCount=rs.getRow();
			PageCount=(RowCount+PageSize-1)/PageSize;//总页数，加1从1开始数

		strPage=request.getParameter("page");
		if(strPage==null)Page=1;
		else{
			Page=Integer.parseInt(strPage);
			if(Page>PageCount)Page=PageCount;
			if(Page<1)Page=1;
		}
		if(PageCount>0)rs.absolute((Page-1)*PageSize+1);//跳转到指定记录位置
		int n=0;
		while(n<PageSize&&rs!=null&&!rs.isAfterLast())
		{
			String id=rs.getString("id");
			String store=rs.getString("store");
			String time=rs.getString("time");
			String price=rs.getString("price");
			String goodsstr=rs.getString("goodslist");
			String status=rs.getString("status");
			String[]goodslist=goodsstr.split("\\|");
			String numstr=rs.getString("numlist");
			String[]numlist=numstr.split("\\|");
			String address=rs.getString("address");
			String name=rs.getString("name");
			String phone=rs.getString("phone");
			String post=rs.getString("post");
			out.print("<tr><td colspan='6'>");
			out.print("<table class='orderstyle'>");
			out.print("<tr>");
			out.print("<td>"+id+"</td>");
			out.print("<td>"+time+"</td>");
			out.print("<td>"+price+"</td>");
			out.print("<td>"+status+"</td>");
			out.print("<td><a href='"+"cancelorder.jsp?action=2&orderid="+id+"'>取消订单</a></td>");
			if("已支付".equals(status))out.print("<td><a onclick='check("+id+")'>确认发货</a><form action='confirm.jsp' id='"+id+"' hidden><input type='hidden' value="+id+" name='goodsid'><input type='text' name='post'></form></td>");
			else out.print("<td></td>");
			out.print("</tr>");
			for(int i=0;i<goodslist.length;i++)
			{
				out.print("<tr class='goodsstyle'><td colspan=6 >");
				out.print("<table>");
				Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
				ResultSet res=stmt.executeQuery("select * from goods where id="+"\""+goodslist[i]+"\"");
				res.next();
				String picture=res.getString("picture");
				out.print("<tr><td rowspan=2>");
				out.print("<a href='Goods.jsp?goodsid="+goodslist[i]+"'><img src='/pt/imeg/"+((picture==null||"".equals(picture))?"timg (3).jpg":picture)+"' alt='' style='height:50px;'></a>");
				out.print("</td>");
				out.print("<td>商品id:"+res.getString("id")+"</td>");
				out.print("<td>单价:"+res.getString("price")+"</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td>商品名:"+res.getString("name")+"</td>");
				out.print("<td>购买数:"+numlist[i]+"</td>");
				out.print("</tr>");
				out.print("</table>");
				//out.print
				out.print("</td></tr>");
				stmt.close();
				res.close();
			}
			out.print("<tr class='goodsstyle'>");
			out.print("<td style='text-align:left;'>收货人:"+name+"</td>");
			out.print("<td style='text-align:left;'>收货人联系方式:"+phone+"</td>");
			out.print("<td style='text-align:left;'>快递单号:"+(post==null?"":post)+"</td>");
			out.print("</tr>");
			out.print("<tr class='goodsstyle'><td colspan=6 style='text-align:left;'>收货地址:"+address+"</td></tr>");
			out.print("</table>");
			out.print("</td></tr>");
			n++;
			rs.next();
		}
		}
		%>
			</table><%
		out.print("<form action=\"orderManage.jsp\" method=\"get\">");
		if(Page>1)
		{
			out.print("&nbsp;<a href='orderManage.jsp?action=2&page=1'>首&nbsp;页</a>&nbsp;");
			out.print("&nbsp;<a href='orderManage.jsp?action=2&page="+(Page-1)+"'>上一页</a>&nbsp;");
		}
		out.print("&nbsp;第"+Page+"页&nbsp;");
		if(Page<PageCount)
		{
			out.print("&nbsp;<a href='orderManage.jsp?action=2&page="+(Page+1)+"'>下一页</a>&nbsp;");
			out.print("&nbsp;<a href='orderManage.jsp?action=2&page="+PageCount+"'>尾&nbsp;页</a>&nbsp;");
		}
		out.print("<input type='hidden' value=2 name='action'>");
		out.print("&nbsp;跳转到<input type='text' name='page' size=2>页&nbsp;共"+PageCount+"页&nbsp;<input type='submit' value='go'>&nbsp;");
		out.print("</form>");
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
else{
	out.print("<script>window.location.href = 'loginregister.html';</script>");
}
%>
		</div>
</body>

</html>