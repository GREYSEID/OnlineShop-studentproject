<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>�����Ʒ</title>
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
				document.getElementById(imgs).src = '/pt/imeg/timg (3).jpg';
				document.getElementById(picturenum).checked = false;
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
	</script>
</head>

<body style="margin: 0;padding: 0;overflow: visible;background-color: #f5f5f5;" onload="showTime()">
	<div class="firsttitle">
		<a href="storeuserimf.jsp" style="margin-left: 10px;margin-right: 10px;">�̼���Ϣ�޸�</a>
		<a href="orderManage.jsp?action=2" style="margin-left: 10px;margin-right: 10px;">�����¼</a>
		<a href="logout.jsp?action=2" style="margin-left: 10px;margin-right: 10px;">ע��</a>
		<a href="goodsManage.jsp" style="margin-left: 10px;margin-right: 10px;">��ҳ</a>
		<span id="time" style="float:right;width: 150px;"> </span>
		<a href="index.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">�ͻ����</a>
		<a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">�ͷ�</a>
	</div>
	<a href="goodsManage.jsp">��ҳ</a>
	<br>
	<br>
	<br>
	<br>
	<%
String storeid=(String)session.getAttribute("storeid");
if(storeid==null)response.sendRedirect("storeLogin.html");
String goodsid=Long.toString(System.currentTimeMillis());//�߲��������ã���������Ϊid
%>
	<div class=borderstyle>
		<h1>�����Ʒ</h1>
		<form action="addgood.jsp" method="post" enctype="multipart/form-data">
			<table style="text-align: left;margin: 0 auto;">
				<tr>
					<td>
						<input type="text" name="goodsid" id="goodsid" style="visibility:hidden" value="<%=goodsid %>">
					</td>
					<td></td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" hidden id='picture1' name='picturenum' value='0'>
						<input type="file" name="fileUpload" accept="image/*" onchange="see('files','imgs','picture1')"
							id="files"></td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="ͼƬ"
								src="/pt/imeg/timg (3).jpg" style="height: 100%;" id="imgs"></div>
					</td>
				</tr>
				<tr>
					<td><input type="checkbox" hidden id='picture2' name='picturenum' value='1'><input type="file"
							name="fileUpload" accept="image/*" onchange="see('files2','imgs2','picture2')" id="files2">
					</td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="ͼƬ"
								src="/pt/imeg/timg (3).jpg" style="height: 100%;" id="imgs2"></div>
					</td>
				</tr>
				<tr>
					<td><input type="checkbox" hidden id='picture3' name='picturenum' value='2'><input type="file"
							name="fileUpload" accept="image/*" onchange="see('files3','imgs3','picture3')" id="files3">
					</td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="ͼƬ"
								src="/pt/imeg/timg (3).jpg" style="height: 100%;" id="imgs3"></div>
					</td>
				</tr>
				<tr>
					<td><input type="checkbox" hidden id='picture4' name='picturenum' value='3'><input type="file"
							name="fileUpload" accept="image/*" onchange="see('files4','imgs4','picture4')" id="files4">
					</td>
					<td>
						<div style="height: 100px;width:100px;overflow: hidden;"><img alt="ͼƬ"
								src="/pt/imeg/timg (3).jpg" style="height: 100%;" id="imgs4"></div>
					</td>
				</tr>
				<tr>
					<td><label for="goodsname">��Ʒ��</label></td>
					<td><input type="text" name="goodsname" id="goodsname"></td>
				</tr>
				<tr>
					<td><label for="goodsprice">�۸�</label></td>
					<td><input type="text" name="goodsprice" id="goodsprice" required="required"></td>
				</tr>
				<tr>
					<td><label for="goodscount">���</label></td>
					<td><input type="text" name="goodscount" id="goodscount" required="required"
							oninput="value=value.replace(/[^\d]/g,'')"></td>
				</tr>
				<tr>
					<td><label for="goodstag">��ǩ</label></td>
					<td><input type="text" name="goodstag" id="goodstag"></td>
				</tr>
				<tr>
					<td style="vertical-align:text-top;"><label for="goodsintroduction">����</label>
					<td><textarea rows="5" cols="40" colspan="2" name="goodsintroduction"
							id="goodsintroduction"></textarea></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td style="width: 140px;"></td>
				</tr>
			</table>
			<input type="submit" value="�ύ">
		</form>
	</div>
	<br>
	<br>
	<br>
	<br>
</body>

</html>