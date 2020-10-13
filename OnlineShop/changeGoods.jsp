<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>更新商品</title>
	<%
String storeid=(String)session.getAttribute("storeid");
String boolcodeout="inline";
String boolcodein="none";
String boolblockout="block";
String boolblockin="none";
if(storeid==null)response.sendRedirect("goodsManage.jsp");
else{
	boolcodeout="none";
	boolcodein="inline";
	boolblockout="none";
	boolblockin="block";
}
%>
	<%
String goodsid=request.getParameter("goodsid");
if(goodsid==null||goodsid=="")response.sendRedirect("goodsManage.jsp");
String goodspicture=null;
String goodspicture2=null;
String goodspicture3=null;
String goodspicture4=null;
String goodsname=null;
String goodsprice=null;
String goodstag=null;
String goodsintroduction=null;
String goodscount=null;
try{
  Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
  //定义连接字符串,东八区GMT%2B8
  String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
  //和数据库建立连接
  Connection conn= DriverManager.getConnection(url,"root","********");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	ResultSet rs=st.executeQuery("select * from goods where id="+"\""+goodsid+"\"");
	rs.next();//获取商品的详细信息
	goodspicture=rs.getString("picture");
	goodspicture2=rs.getString("picture2");
	goodspicture3=rs.getString("picture3");
	goodspicture4=rs.getString("picture4");
	goodsname=rs.getString("name");
	goodsprice=rs.getString("price");
	goodstag=rs.getString("tag");
	goodsintroduction=rs.getString("introduction");
	goodscount=rs.getString("count");
	if(goodspicture==null)goodspicture="/pt/imeg/timg (3).jpg";
	else {
		String gbk=URLEncoder.encode(goodspicture,"gb18030");
		goodspicture="/pt/imeg/"+gbk;
	}
	if(goodspicture2==null)goodspicture2="/pt/imeg/timg (3).jpg";
	else {
		String gbk=URLEncoder.encode(goodspicture2,"gb18030");
		goodspicture2="/pt/imeg/"+gbk;
	}
	if(goodspicture3==null)goodspicture3="/pt/imeg/timg (3).jpg";
	else {
		String gbk=URLEncoder.encode(goodspicture3,"gb18030");
		goodspicture3="/pt/imeg/"+gbk;
	}
	if(goodspicture4==null)goodspicture4="/pt/imeg/timg (3).jpg";
	else {
		String gbk=URLEncoder.encode(goodspicture4,"gb18030");
		goodspicture4="/pt/imeg/"+gbk;
	}
	goodsname=(goodsname==null?"":goodsname);
	goodsprice=(goodsprice==null?"":goodsprice);
	goodstag=(goodstag==null?"":goodstag);
	goodsintroduction=(goodsintroduction==null?"":goodsintroduction);
	goodscount=(goodscount==null?"":goodscount);
	rs.close();
	st.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
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
		function see(files, imgs, picturenum) {
			if (document.getElementById(files).files.item(0) != null) {
				url = window.URL.createObjectURL(document.getElementById(files).files.item(0));
				document.getElementById(imgs).src = url;
				document.getElementById(picturenum).checked = true;
			}
			else {
				document.getElementById(picturenum).checked = false;
				if (imgs == "imgs1") document.getElementById(imgs).src = "<%=goodspicture%>";
				else if (imgs == "imgs2") document.getElementById(imgs).src = "<%=goodspicture2%>";
				else if (imgs == "imgs3") document.getElementById(imgs).src = "<%=goodspicture3%>";
				else if (imgs == "imgs4") document.getElementById(imgs).src = "<%=goodspicture4%>";
			}
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
		<a href="storeLogin.html"
			style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">登录</a>
		<a href="storecurrentregister.jsp"
			style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">注册</a>
		<a href="storeuserimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">商家信息修改</a>
		<a href="orderManage.jsp?action=2"
			style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">购买记录</a>
		<a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">注销</a>
		<a href="goodsManage.jsp" style="margin-left: 10px;margin-right: 10px;">主页</a>
		<span id="time" style="float:right;width: 150px;"> </span>
		<a href="index.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">客户入口</a>
		<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">客服</a>
	</div>
	<a href="goodsManage.jsp">主页</a>
	<br>
	<br>
	<br>
	<br>
	<div class=borderstyle>
		<h1>更新商品</h1>
		<form action="changegood.jsp" method="post" enctype="multipart/form-data">
			<table style="text-align: left;margin: 0 auto;">
				<tr>
					<td>
						<input type="text" name="goodsid" id="goodsid" style="visibility:hidden" value="<%=goodsid %>">
					</td>
					<td></td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" name='picturenum' value='0' hidden id='piturenum1'>
						<input type="file" name="fileUpload" accept="image/*"
							onchange="see('files','imgs','piturenum1')" id="files"></td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="图片" src="<%=goodspicture %>"
								style="height: 100%;" id="imgs"></div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" name='picturenum' value='1' hidden id='piturenum2'>
						<input type="file" name="fileUpload" accept="image/*"
							onchange="see('files2','imgs2','piturenum2')" id="files2"></td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="图片" src="<%=goodspicture2 %>"
								style="height: 100%;" id="imgs2"></div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" name='picturenum' value='2' hidden id='piturenum3'>
						<input type="file" name="fileUpload" accept="image/*"
							onchange="see('files3','imgs3','piturenum3')" id="files3"></td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="图片" src="<%=goodspicture3 %>"
								style="height: 100%;" id="imgs3"></div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" name='picturenum' value='3' hidden id='piturenum4'>
						<input type="file" name="fileUpload" accept="image/*"
							onchange="see('files4','imgs4','piturenum4')" id="files4"></td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="图片" src="<%=goodspicture4 %>"
								style="height: 100%;" id="imgs4"></div>
					</td>
				</tr>
				<tr>
					<td><label for="goodsname">商品名</label></td>
					<td><input type="text" name="goodsname" id="goodsname" value="<%=goodsname %>"></td>
				</tr>
				<tr>
					<td><label for="goodsprice">价格</label></td>
					<td><input type="text" name="goodsprice" id="goodsprice" value="<%=goodsprice %>"
							required="required"></td>
				</tr>
				<tr>
					<td><label for="goodscount">库存</label></td>
					<td><input type="text" name="goodscount" id="goodscount" value="<%=goodscount %>"
							required="required" oninput="value=value.replace(/[^\d]/g,'')"></td>
				</tr>
				<tr>
					<td><label for="goodstag">标签</label></td>
					<td><input type="text" name="goodstag" id="goodstag" value="<%=goodstag %>"></td>
				</tr>
				<tr>
					<td style="vertical-align:text-top;"><label for="goodsintroduction">介绍</label>
					<td><textarea rows="5" cols="40" colspan="2" name="goodsintroduction"
							id="goodsintroduction"><%=goodsintroduction %></textarea></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td style="width: 140px;"></td>
				</tr>
			</table>
			<input type="submit" value="更新">
		</form>
	</div>
	<br>
	<br>
	<br>
	<br>
</body>

</html>
