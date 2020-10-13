<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<%
String userid=(String)session.getAttribute("userid");
String boolcodeout="inline";
String boolcodein="none";
String boolblockout="block";
String boolblockin="none";
if(userid!=null){
	boolcodeout="none";
	boolcodein="inline";
	boolblockout="none";
	boolblockin="block";
}
%>
	<meta charset="GB18030">
	<title>详细注册</title>
	<link rel="stylesheet" type="text/css" href="taotao.css">
	<style type="text/css">
		a {
			text-decoration: none;
			color: grey;
		}

		a:hover {
			color: white;
		}

		textarea {
			overflow-y: scroll;
			resize: none;
		}

		.borderstyle {
			margin: 0 auto;
			width: 600px;
			border-radius: 25px;
			background-color: rgba(0, 0, 0, 0.5);
			color: white;
			text-align: center;
		}

		body {
			background-image: url(https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591866510&di=4cc097419e92cc07e1e266346c42574f&imgtype=jpg&er=1&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F096%2F755%2F666%2F49611e232c4646bcbfdca563a39b15ab.jpg);
			background-size: 100%;
		}
	</style>
	<script type="text/javascript">
		function test() {
			var pwd = document.getElementById("userpwd").value;
			var con = document.getElementById("confirm").value;
			if (pwd != con) document.getElementById("submit").disabled = "disabled";
			else document.getElementById("submit").disabled = false;
		}
		function see(files, imgs) {
			url = window.URL.createObjectURL(document.getElementById(files).files.item(0));
			document.getElementById(imgs).src = url;
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
	</script>
</head>

<body style="margin: 0;padding: 0;overflow: visible;background-color: #f5f5f5;" onload="showTime()">
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
	<a href="index.jsp">主页</a>
	<br>
	<br>
	<br>
	<br>
	<div class=borderstyle>
		<h1>详细注册</h1>
		<form action="insertregister.jsp" method="post" style="text-align:center;" enctype="multipart/form-data">
			<table style="margin: 0 auto;text-align: left;">
				<tbody>
					<tr>
						<td><input type="file" name="fileUpload" accept="image/*" onchange="see('files','imgs')"
								id="files"></td>
						<td>
							<div style="height: 100px;width:100px;overflow: hidden;border-radius: 50%;"><img alt="头像"
									src="/pt/imeg/timg1.jpg" style="height: 100%;" id="imgs"></div>
						</td>
					</tr>
					<tr>
						<td>
							<label for='userid'>用户ID:</label>
						</td>
						<td>
							<input type="text" name='userid' id='userid' required="required">
						</td>
					</tr>
					<tr>
						<td>
							<label for='usernickname'>昵称:</label>
						</td>
						<td>
							<input type='text' name='usernickname' id='usernickname'>
						</td>
					</tr>
					<tr>
						<td>
							<label for='useremail'>邮箱:</label>
						</td>
						<td>
							<input type='text' name='useremail' id='useremail'>
						</td>
					</tr>
					<tr>
						<td>
							<label for='username'>姓名:</label>
						</td>
						<td>
							<input type='text' name='username' id='username'>
						</td>
					</tr>
					<tr>
						<td>
							<label for='userage'>年龄:</label>
						</td>
						<td>
							<input type='text' name='userage' id='userage' oninput="value=value.replace(/[^\d]/g,'')">
						</td>
					</tr>
					<tr>
						<td>
							<label for='userpwd'>密码:</label>
						</td>
						<td>
							<input type='password' name='userpwd' id='userpwd' required='required' onkeyup="test()">
						</td>
					</tr>
					<tr>
						<td>
							<label for='confirm'>确认密码:</label>
						</td>
						<td>
							<input type='password' id='confirm' name='confirm' onkeyup="test()" required='required'>
						</td>
					</tr>
					<tr>
						<td>
							<label for='userphone'>手机号:</label>
						</td>
						<td>
							<input type='text' name='userphone' id='userphone'
								oninput="value=value.replace(/[^\d]/g,'')">
						</td>
					</tr>
					<tr>
						<td>
							<label for='usercity'>城&nbsp;&nbsp;&nbsp;市:</label>
						</td>
						<td style="padding-left=0;">
							<select name="usercity">
								<%
			  	try{
			  	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		  	    //定义连接字符串,东八区GMT%2B8
		  	    String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
		  	    //和数据库建立连接
		  	    Connection conn= DriverManager.getConnection(url,"root","yuan1234");
		  	  	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			  	ResultSet res=stmt.executeQuery("select cityname from city");//嵌套使用多一个statement
			  	out.print("<option value='null' selected='selected'>---</option>");//选择城市
			  	while(res.next())
			  	{
			  		String cityname=res.getString("cityname");
			  		out.print("<option value='"+cityname+"'>"+cityname+"</option>");
			  	}
			  	res.close();
			  	stmt.close();
			  	conn.close();
			  	}
			  	catch(Exception e)
			  	{
			  		e.printStackTrace();
			  		out.print("<script>alert('读取数据库错误'); window.location.href = 'currentregister.jsp';</script>");
			  	}
			  	%>
							</select>
						</td>
					</tr>
					<tr>
						<td style="vertical-align:text-top;">
							<label for='useraddress'>地&nbsp;&nbsp;&nbsp;址:</label>
						</td>
						<td colspan='2'>
							<textarea rows='5' cols='40' name='useraddress' id='useraddress'></textarea>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td style="width: 140px;"></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" value="注册" id="submit">
		</form>
	</div>
</body>

</html>