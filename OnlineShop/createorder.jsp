<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>��������</title>
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
	</script>
</head>

<body style="margin: 0;padding: 0;overflow: visible;background-color: #f5f5f5;" onload="allprice();showtime()">
	<div class="firsttitle">
		<a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;">����ҳ��</a>
		<a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">�ҵĹ��ﳵ</a>
		<a href="orderManage.jsp?action=1" style="margin-left: 10px;margin-right: 10px;">�����¼</a>
		<a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">ע��</a>
		<a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">��ҳ</a>
		<span id="time" style="float:right;width: 150px;"> </span>
		<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">�ͷ�</a>
	</div>
	<form action="ordercreate.jsp" method="get" onkeydown="if(event.keyCode==13)return false;"
		style="margin:0 auto;text-align: center;">
		<%
String address="";
String phone="";
String name="";
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection co= DriverManager.getConnection(url,"root","yuan1234");
	Statement sta=co.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet resu=sta.executeQuery("select name,phone,address from myuser where id="+userid);
	resu.next();
	address=resu.getString("address");//��ȡĬ�ϵ��ջ�����Ϣ
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
		<label>�ֻ�</label><input type="text" name="phone" value="<%=phone==null?"":phone %>"
			oninput="value=value.replace(/[^\d]/g,'')" required>
		<label>�ջ���</label><input type="text" name="name" value="<%=name==null?"":name%>" required>
		<p>��д��ַ</p>
		<textarea rows="5" cols="50" id="address" name="address" required><%=address==null?"":address %></textarea>
		<table style="text-align: center;margin: 0 auto;">
			<tr>
				<td></td>
				<td>��Ʒid</td>
				<td>��Ʒ��</td>
				<td></td>
				<td>��Ʒ����</td>
				<td>����</td>
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
	while(rs.next())//������������Ϣ����ʾҪ������Ʒ����ϸ��Ϣ
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
		out.print("<td><div style='width:50px;height:50px;'>"+"<img style='width:100%;height:100%;' alt='ͼƬ' src='/pt/imeg/"+((rs.getString("picture")==null||"".equals(rs.getString("picture")))?("timg (3).jpg"):(URLEncoder.encode(rs.getString("picture"),"gb18030")))+"'"+"</div></td>");
		for(int i=0;i<goodslist.length;i++)
		{
			if(goodslist[i].equals(rs.getString("id"))){
				int count=Integer.parseInt(rs.getString("count"));
				if(count<Integer.parseInt(numlist[i])){//������Ƿ����
					out.print("<script>alert('"+rs.getString("name")+"��治��');window.location.href='Cart.jsp';</script>");
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
		<button type="submit">�ύ����</button><span>�ܼ�:</span><span id='price'>0</span><input type="hidden" id='allprice'
			name='allprice'>
	</form>
</body>

</html>