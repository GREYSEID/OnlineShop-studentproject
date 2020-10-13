<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<% 
response.setHeader("Pragma","No-cache");//����ʱǿ��ˢ�²�ʹ�û���
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
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
	ResultSet rs=st.executeQuery("select nickname,head from myuser where id="+"\""+userid+"\"");
	rs.next();
	nickname=rs.getString("nickname");
	head=rs.getString("head");
	if(head!=null){
		String gbk=URLEncoder.encode(head,"gb18030");//������Ҫת��,jsp��src��ַ�൱�ڴ�һ����ҳͼƬ������������Ҫת��
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
	<title>���ﳵ</title>
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
				case 0: curWeek = "������"; break;
				case 1: curWeek = "����һ"; break;
				case 2: curWeek = "���ڶ�"; break;
				case 3: curWeek = "������"; break;
				case 4: curWeek = "������"; break;
				case 5: curWeek = "������"; break;
				case 6: curWeek = "������"; break;
			}
			var time = " " + year + "��" + month + "��" + day + "�� " + curWeek + " " + hour + ":" + minute + ":" + second;
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
		function up(g)/*�㰴ť��������*/ {
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
				var c = ca[i].trim();/*ȥ�ո�*/
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
				var c = ca[i].trim();/*ȥ�ո�*/
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
		function changeid(g)/*�����ı����޸Ĺ�����*/ {
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
				var c = ca[i].trim();/*ȥ�ո�*/
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
		function deleteid(g)/*ɾ�����ﳵ����Ʒ*/ {
			var goods = g;
			var string = document.getElementById(goods).value;
			var num = parseInt(document.getElementById(goods).value);
			var goodslist;
			var numlist;
			var ca = document.cookie.split(";");
			var str;
			var str1;
			for (var i = 0; i < ca.length; i++) {
				var c = ca[i].trim();/*ȥ�ո�*/
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
			if (check) {/*�����ò��У�Ҫ��if-elseʶ��*/
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
		function allprice()/*����۸�*/ {
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
			style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">��¼</a>
		<a href="currentregister.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">ע��</a>
		<a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">����ҳ��</a>
		<a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">�ҵĹ��ﳵ</a>
		<a href="orderManage.jsp?action=1"
			style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">�����¼</a>
		<a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">ע��</a>
		<a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">��ҳ</a>
		<span id="time" style="float:right;width: 150px;"> </span>
		<a href="goodsManage.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">�̼����</a>
		<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">�ͷ�</a>
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
							type="submit" value="����" class="searchButton">
					</form>
				</center>
			</div>
			<div style="float: left;height: 100%;width: 25%;">
				<form action="login.jsp" class="loginregister" style="display:<%=boolblockout%>;">
					<label for="userid">��&nbsp;�� </label><input type="text" id="userid" placeholder="USERID"
						class="lrstyle" required="required" name="userid"><br>
					<label for="userpwd">��&nbsp;�� </label><input type="password" id="userpwd" placeholder="PASSWORD"
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
						<img alt="ͷ��" src="<%=head%>" style="height:100%;width: 100%"></div>
				</div>
			</div>
		</div>
	</div>
	<div style="width: 1500px;height: 1800px;margin:0 auto;">
		<div style='height:100%;width:85%;float: left;'>
			<h1>���ﳵ</h1>
			<form action="createorder.jsp" onkeydown="if(event.keyCode==13)return false;" method="get">
				<table>
					<tr>
						<td><input type="checkbox" value="all" id="all" onclick="check()">ȫѡ</td>
						<td>��Ʒid</td>
						<td>��Ʒ��</td>
						<td></td>
						<td>��Ʒ����</td>
						<td>����</td>
						<td>ɾ��</td>
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
		//���������ַ���,������GMT%2B8
		String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
		//�����ݿ⽨������
		Connection conn= DriverManager.getConnection(url,"root","yuan1234");
		Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
		String s="select A.*,B.store from goods A ,storeacc B where A.storeid=B.storeid and (id="+goodslist[0];
		for(int i=1;i<goodslist.length;i++)//��֪��ɸѡ��������᲻�����
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
			out.print("<td><div style='width:50px;height:50px;'>"+"<a href='Goods.jsp?goodsid="+rs.getString("id")+"'><img style='width:100%;height:100%;' alt='ͼƬ' src='/pt/imeg/"+((rs.getString("picture")==null||"".equals(rs.getString("picture")))?("timg (3).jpg"):(URLEncoder.encode(rs.getString("picture"),"gb18030")))+"'"+"</a></div></td>");
			for(int i=0;i<goodslist.length;i++)
			{
				if(goodslist[i].equals(rs.getString("id"))){
					
					out.print("<td><button type=button onclick='up("+goodslist[i]+")'>��</button><input id='"+goodslist[i]+"' type='text' value='"+numlist[i]+"' size=1 onkeyup='changeid("+goodslist[i]+")'oninput=\"value=value.replace(/\\D|^0/g,'')\"><button type=button onclick='down("+goodslist[i]+")'>��</button><input type='checkbox' value='"+numlist[i]+"'name='num' hidden></td>");
				}
			}
			out.print("<td>"+rs.getString("price")+"</td>");
			out.print("<td><a onclick='deleteid("+rs.getString("id")+")'>ɾ��</a></td>");
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
				<input type="submit" value="����"><span>�ܼ�:</span><span id='price'>0</span><input type="hidden"
					id='allprice' name='allprice'>
				<br><a onclick="clearcart();">��չ��ﳵ</a>
			</form>
		</div>
		<div style='height:100%;width:15%;float: left;' class='goods'>
			<%
        try{//��Ϊ�����Ƽ��㷨�����Լ�չʾһ�±����ǰ�������Ʒ
        	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        	//���������ַ���,������GMT%2B8
        	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
        	//�����ݿ⽨������
        	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
        	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
        	String string="select id,picture,name from goods";
        	ResultSet rs=st.executeQuery(string);
        	//rs.last();
        	//if(rs.getRow()>0){
       		int v=0;
       		//rs.first();
       		while(rs.next()&&v!=8)//��ʾ��Ʒ��Ϣ
       		{
       			out.print("<a href='Goods.jsp?goodsid="+rs.getString("id")+"'><div class='divdiv' ><img src='"+(rs.getString("picture")==null||"".equals(rs.getString("picture"))?"/pt/imeg/timg (3).jpg":"/pt/imeg/"+URLEncoder.encode(rs.getString("picture"),"gb18030"))+"' alt='������Ʒ'></div></a>");
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