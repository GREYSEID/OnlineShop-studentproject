<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<% 
response.setHeader("Pragma","No-cache");//后退时强制刷新不使用缓存
response.setHeader("Cache-Control","No-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "No-store");
String userid=(String)session.getAttribute("userid");
String boolcodeout="inline";
String boolcodein="none";
String boolblockout="block";
String boolblockin="none";
String head="/pt/imeg/timg1.jpg";
String nickname=null;
if(userid!=null){
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
	ResultSet rs=st.executeQuery("select nickname,head from myuser where id="+"\""+userid+"\"");
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
	out.print(e);
	e.printStackTrace();
}
}
%>

<head>
	<meta charset="GB18030">
	<title>购物车</title>
	<link rel="stylesheet" type="text/css" href="taotao.css">
	<style>
		.theimgstyle {
			height: 333px;
			width: 333px;
		}

		.thegoodsstyle {
			width: 333px;
			height: 30px;
			background-color: rgb(214, 214, 214);
			border: 0;
		}

		.goods {}

		.goods a {
			width: 150px;
			display: block;
		}

		.goods .astyle {
			width: 150px;
			height: 180px;
		}

		.goods img {
			width: 100%;
			height: 100%;
		}

		.goods .divstyle {
			width: 150px;
			height: 30px;
			background-color: rgb(214, 214, 214);
			;
		}

		.goods .divdiv {
			width: 150px;
			height: 150px;
		}
	</style>
	<script>
		function login() {
			location.href = "loginregister.html?" + "login=true";
		}
		function register() {
			location.href = "loginregister.html?" + "login=false";
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
		function up(g)/*点按钮控制数量*/ {
			var goods = g;
			var num = parseInt(document.getElementById(goods).value);
			num = num + 1;
			document.getElementById(goods).value = num;
			var goodslist;
			var numlist;
			var ca = document.cookie.split(";");
			var str;
			var str1;
			for (var i = 0; i < ca.length; i++) {
				var c = ca[i].trim();/*去空格*/
				if (c.indexOf("goodsid") == 0) str = c.substring("goodsid=".length, c.length);
				if (c.indexOf("num") == 0) str1 = c.substring("num=".length, c.length);
			}
			goodslist = str.split("|");
			numlist = str1.split("|");
			var goodsstr = "";
			var numstr = "";
			for (var i = 0; i < goodslist.length - 1; i++) {
				if (goods == goodslist[i]) {
					goodsstr += goodslist[i] + "|";
					numstr += num + "|";
				}
				else {
					goodsstr += goodslist[i] + "|";
					numstr += numlist[i] + "|";
				}
			}
			document.cookie = "goodsid=" + goodsstr + ";";
			document.cookie = "num=" + numstr + ";";
			document.getElementById(goods).parentElement.lastElementChild.value = num;
		}
		function down(g) {
			var goods = g;
			var num = parseInt(document.getElementById(goods).value);
			num = num - 1;
			if (num <= 0) {
				num = 1;
				return false;
			}
			document.getElementById(goods).value = num;
			var goodslist;
			var numlist;
			var ca = document.cookie.split(";");
			var str;
			var str1;
			for (var i = 0; i < ca.length; i++) {
				var c = ca[i].trim();/*去空格*/
				if (c.indexOf("goodsid") == 0) str = c.substring("goodsid=".length, c.length);
				if (c.indexOf("num") == 0) str1 = c.substring("num=".length, c.length);
			}
			goodslist = str.split("|");
			numlist = str1.split("|");
			var goodsstr = "";
			var numstr = "";
			for (var i = 0; i < goodslist.length - 1; i++) {
				if (goods == goodslist[i]) {
					goodsstr += goodslist[i] + "|";
					numstr += num + "|";
				}
				else {
					goodsstr += goodslist[i] + "|";
					numstr += numlist[i] + "|";
				}
			}
			document.cookie = "goodsid=" + goodsstr + ";";
			document.cookie = "num=" + numstr + ";";
			document.getElementById(goods).parentElement.lastElementChild.value = num;
		}
		function changeid(g)/*输入文本框修改购买数*/ {
			var goods = g;
			var string = document.getElementById(goods).value;
			var num = parseInt(document.getElementById(goods).value);
			if (isNaN(string) || num <= 0) {
				document.getElementById(goods).value = 1;
				return false;
			}
			var goodslist;
			var numlist;
			var ca = document.cookie.split(";");
			var str;
			var str1;
			for (var i = 0; i < ca.length; i++) {
				var c = ca[i].trim();/*去空格*/
				if (c.indexOf("goodsid") == 0) str = c.substring("goodsid=".length, c.length);
				if (c.indexOf("num") == 0) str1 = c.substring("num=".length, c.length);
			}
			goodslist = str.split("|");
			numlist = str1.split("|");
			var goodsstr = "";
			var numstr = "";
			for (var i = 0; i < goodslist.length - 1; i++) {
				if (goods == goodslist[i]) {
					goodsstr += goodslist[i] + "|";
					numstr += num + "|";
				}
				else {
					goodsstr += goodslist[i] + "|";
					numstr += numlist[i] + "|";
				}
			}
			document.cookie = "goodsid=" + goodsstr + ";";
			document.cookie = "num=" + numstr + ";";
			document.getElementById(goods).parentElement.lastElementChild.value = num;
		}
		function deleteid(g)/*删除购物车中商品*/ {
			var goods = g;
			var string = document.getElementById(goods).value;
			var num = parseInt(document.getElementById(goods).value);
			var goodslist;
			var numlist;
			var ca = document.cookie.split(";");
			var str;
			var str1;
			for (var i = 0; i < ca.length; i++) {
				var c = ca[i].trim();/*去空格*/
				if (c.indexOf("goodsid") == 0) str = c.substring("goodsid=".length, c.length);
				if (c.indexOf("num") == 0) str1 = c.substring("num=".length, c.length);
			}
			goodslist = str.split("|");
			numlist = str1.split("|");
			var goodsstr = "";
			var numstr = "";
			for (var i = 0; i < goodslist.length - 1; i++) {
				if (goods == goodslist[i]) {

				}
				else {
					goodsstr += goodslist[i] + "|";
					numstr += numlist[i] + "|";
				}
			}
			document.cookie = "goodsid=" + goodsstr + ";";
			document.cookie = "num=" + numstr + ";";
			window.location.href = 'Cart.jsp';
		}
		function check() {
			var check = document.getElementById("all").checked;
			var checknum = document.getElementsByName("num");
			var checkgoods = document.getElementsByName("goods");
			if (check) {/*单独用不行，要用if-else识别*/
				for (var i = 0; i < checknum.length; i++) {
					checknum[i].checked = true;
					checkgoods[i].checked = true;
				}
			}
			else {
				for (var i = 0; i < checknum.length; i++) {
					checknum[i].checked = false;
					checkgoods[i].checked = false;
				}
			}
		}
		function checkone(g) {
			var check = document.getElementById(g).checked;
			var bro = document.getElementById(g).parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.lastElementChild;
			if (check)
				bro.checked = true;
			else bro.checked = false;
		}
		function allprice()/*计算价格*/ {
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
		function clearcart() {
			document.cookie = "goodsid=; expires=Thu, 01 Jan 1970 00:00:00 GMT";
			document.cookie = "num=; expires=Thu, 01 Jan 1970 00:00:00 GMT";
			window.location.href = "Cart.jsp";
		}
	</script>
</head>

<body style="margin: 0;padding: 0;overflow: visible;background-color: #f5f5f5;" onload="showTime()"
	onchange="allprice()">
	<div class="firsttitle">
		<a href="loginregister.html?login=true"
			style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">登录</a>
		<a href="currentregister.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">注册</a>
		<a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">个人页面</a>
		<a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">我的购物车</a>
		<a href="orderManage.jsp?action=1"
			style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">购买记录</a>
		<a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">注销</a>
		<a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">主页</a>
		<span id="time" style="float:right;width: 150px;"> </span>
		<a href="goodsManage.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">商家入口</a>
		<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">客服</a>
	</div>
	<div style="background-color: white;width: 100%;height: 150px;">
		<div style="width: 1500px;height: 150px;border:  0;background-color: white;margin: 0 auto;">
			<div style="width: 25%;height: 150px;float: left;">
				<a href="https://www.taobao.com/"><img src="1.jpg" style="height: 100%;" /></a>
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
					<div><input type='hidden' name='action' value='2'>
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
	<div style="width: 1500px;height: 1800px;margin:0 auto;">
		<div style='height:100%;width:85%;float: left;'>
			<h1>购物车</h1>
			<form action="createorder.jsp" onkeydown="if(event.keyCode==13)return false;" method="get">
				<table>
					<tr>
						<td><input type="checkbox" value="all" id="all" onclick="check()">全选</td>
						<td>商品id</td>
						<td>商品名</td>
						<td></td>
						<td>商品数量</td>
						<td>单价</td>
						<td>删除</td>
					</tr>
					<%
Cookie goodscookie=null;
Cookie[]cookies=null;
Cookie numcookie=null;
cookies=request.getCookies();
String str=null;
String str1=null;
String[]goodslist=null;
String[]numlist=null;
if(cookies!=null)
{
	for(int i=0;i<cookies.length;i++)
	{
		if("goodsid".equals(cookies[i].getName()))
		{
			goodscookie=cookies[i];
		}
		if("num".equals(cookies[i].getName()))
		{
			numcookie=cookies[i];
		}
	}
	//if(goodscookie.getValue()!=null&&numcookie.getValue()!=null){
	if(goodscookie!=null)str=goodscookie.getValue();
	if(str!=null)goodslist=str.split("\\|");
	if(numcookie!=null)str1=numcookie.getValue();
	if(str1!=null)numlist=str1.split("\\|");
	if(goodscookie!=null&&numcookie!=null)
	{
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
		while(rs.next())
		{
			String store=rs.getString("store");
			if(!nowstore.equals(store)){
				out.print("<tr>");
				out.print("<td>"+"<input type='checkbox' value='"+rs.getString("storeid")+"'"+"name='store' hidden>"+store+"</td>");
				out.print("</tr>");
				nowstore=store;
			}
			out.print("<tr>");
			out.print("<td>"+"<input type='checkbox' value='"+rs.getString("id")+"'"+" name='goods' onclick='checkone("+rs.getRow()+")' id='"+rs.getRow()+"'></td>");
			out.print("<td>"+rs.getString("id")+"</td>");
			out.print("<td>"+rs.getString("name")+"</td>");
			out.print("<td><div style='width:50px;height:50px;'>"+"<a href='Goods.jsp?goodsid="+rs.getString("id")+"'><img style='width:100%;height:100%;' alt='图片' src='/pt/imeg/"+((rs.getString("picture")==null||"".equals(rs.getString("picture")))?("timg (3).jpg"):(URLEncoder.encode(rs.getString("picture"),"gb18030")))+"'"+"</a></div></td>");
			for(int i=0;i<goodslist.length;i++)
			{
				if(goodslist[i].equals(rs.getString("id"))){
					
					out.print("<td><button type=button onclick='up("+goodslist[i]+")'>↑</button><input id='"+goodslist[i]+"' type='text' value='"+numlist[i]+"' size=1 onkeyup='changeid("+goodslist[i]+")'oninput=\"value=value.replace(/\\D|^0/g,'')\"><button type=button onclick='down("+goodslist[i]+")'>↓</button><input type='checkbox' value='"+numlist[i]+"'name='num' hidden></td>");
				}
			}
			out.print("<td>"+rs.getString("price")+"</td>");
			out.print("<td><a onclick='deleteid("+rs.getString("id")+")'>删除</a></td>");
			out.print("</tr>");
		}
		rs.close();
		st.close();
		conn.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	}
	//}
	
}
%>
				</table>
				<input type="submit" value="结算"><span>总价:</span><span id='price'>0</span><input type="hidden"
					id='allprice' name='allprice'>
				<br><a onclick="clearcart();">清空购物车</a>
			</form>
		</div>
		<div style='height:100%;width:15%;float: left;' class='goods'>
			<%
        try{//因为不会推荐算法，所以简单展示一下表格中前几项的商品
        	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        	//定义连接字符串,东八区GMT%2B8
        	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
        	//和数据库建立连接
        	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
        	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
        	String string="select id,picture,name from goods";
        	ResultSet rs=st.executeQuery(string);
        	//rs.last();
        	//if(rs.getRow()>0){
       		int v=0;
       		//rs.first();
       		while(rs.next()&&v!=8)//显示商品信息
       		{
       			out.print("<a href='Goods.jsp?goodsid="+rs.getString("id")+"'><div class='divdiv' ><img src='"+(rs.getString("picture")==null||"".equals(rs.getString("picture"))?"/pt/imeg/timg (3).jpg":"/pt/imeg/"+URLEncoder.encode(rs.getString("picture"),"gb18030"))+"' alt='这是商品'></div></a>");
       			out.print("<a href='Goods.jsp?goodsid="+rs.getString("id")+"'><div class='divstyle' >"+rs.getString("name")+"</div></a><br>");
       			v++;
       		}
        	//}

        	rs.close();
        	st.close();
        	conn.close();
        }
        catch(Exception e)
        {
        	e.printStackTrace();
        }
        finally{}
        %>
		</div>
	</div>
</body>

</html>