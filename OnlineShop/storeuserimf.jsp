<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>信息修改</title>
<link rel="stylesheet" type="text/css" href="taotao.css">
<style>
		        a{
		        	text-decoration:none;
		        	color:grey;
		        }
				a:hover{
					color: white;
				}
        		textarea {
					overflow-y:scroll;
					resize: none;
				}
				.borderstyle{
					margin:0 auto;
					width:600px;
					border-radius: 25px;
					background-color: rgba(0, 0, 0, 0.5);
					color:white;
				}
				body{
					background-image: url(https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591866510&di=4cc097419e92cc07e1e266346c42574f&imgtype=jpg&er=1&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F096%2F755%2F666%2F49611e232c4646bcbfdca563a39b15ab.jpg);
					background-size: 100%;
				}
        </style>
         <script type="text/javascript">
        function test(){
        	var pwd=document.getElementById("userpwd").value;
        	var con=document.getElementById("confirm").value;
        	if(pwd!=con)document.getElementById("submit").disabled="disabled";
        	else document.getElementById("submit").disabled=false;
        }
        function see(files, imgs)
        {
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
    <%String storeid=(String)session.getAttribute("storeid");
    if(storeid==null)response.sendRedirect("goodsManage.jsp");
    String boolcodeout="inline";
    String boolcodein="none";
    String boolblockout="block";
    String boolblockin="none";
    if(storeid!=null){
    	boolcodeout="none";
    	boolcodein="inline";
    	boolblockout="none";
    	boolblockin="block";
    }
    %>
    <div class="firsttitle">
        <a href="storeLogin.html" style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">登录</a>
        <a href="storecurrentregister.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">注册</a>
        <a href="storeuserimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">商家信息修改</a>
        <a href="orderManage.jsp?action=2" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">购买记录</a>
        <a href="logout.jsp?action=2" style="margin-left: 10px;margin-right: 10px;">注销</a>
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
    <br>
    <div class="borderstyle">
        <form action="updatestore.jsp" method="post" style="text-align:center;" enctype="multipart/form-data">
        <table style="margin: 0 auto;text-align: left;">
        <tbody>
        <%
        request.setCharacterEncoding("gb18030");
        try{
	        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	  	    //定义连接字符串,东八区GMT%2B8
	  	    String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	  	    //和数据库建立连接
	  	    Connection conn= DriverManager.getConnection(url,"root","********");
		  	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
		  	ResultSet rs=st.executeQuery("select * from storeacc where storeid="+"\""+storeid+"\"");
		  	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		  	ResultSet res=stmt.executeQuery("select cityname from city");//嵌套使用多一个statement
		  	if(rs.next())
		  	{
		  		String email=rs.getString("email");//try内的变量也算局部变量，别的块不能用
		  		String name=rs.getString("store");
			  	String pwd=rs.getString("storepwd");
			  	String phone=rs.getString("phone");
			  	String address=rs.getString("address");
			  	String city=rs.getString("city");
			  	String head=rs.getString("picture");
			  	String gbk=null;
			  	if(head!=null)gbk=URLEncoder.encode(head,"gb18030");//有中文要转码
			  	%><tr><td><input type='file' name='fileUpload' accept="image/*" onchange="see('files','imgs')" id="files"></td><td>
				<div style='height: 100px;width:100px;overflow: hidden;border-radius: 50%;'><img alt='头像' src="<%=(head==null?"/pt/imeg/timg1.jpg":"/pt/imeg/"+gbk) %>" style='height: 100%;' id='imgs'></div>
				</td></tr><%
			  	out.print("<tr><td>");
			  	out.print("<label for='userid'>商店ID:</label>");
			  	out.print("<td>"+storeid+"</td>");
			  	out.print("</td><td>");
			  	out.print("<input type=\"hidden\"  value='"+storeid+"' name='userid' id='userid'>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='useremail'>邮箱:</label>");
			  	out.print("</td><td>");
			  	if(email==null)out.print("<input type='text' name='storeemail' id='useremail'>");//如果数值为null的话可以加.equals("null")
			  	else out.println("<input type='text' value='"+email+"' name='storeemail' id='useremail'>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='username'>商店名:</label>");
			  	out.print("</td><td>");
			  	if(name==null)out.print("<input type='text' name='storename' id='username' required>");
			  	else out.print("<input type='text' value='"+name+"' name='storename' id='username' required>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='userpwd'>密码:</label>");
			  	out.print("</td><td>");
			  	if(pwd==null)out.print("<input type='password' name='storepwd' id='userpwd' required='required' onkeyup=\"test()\">");
			  	else out.print("<input type='password' value='"+pwd+"' name=storepwd id='userpwd' required='required' onkeyup=\"test()\">");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	%><label for='confirm'>确认密码:</label><%
			  	out.print("</td><td>");		
			  	if(pwd==null)out.print("<input type='password' id='confirm' name='confirm' onkeyup=\"test()\" required='required'>");
			  	else out.print("<input type='password' id='confirm' name='confirm' onkeyup=\"test()\" value='"+pwd+"'required='required'>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='userphone'>手机号:</label>");
			  	out.print("</td><td>");
			  	if(phone==null)out.print("<input type='text' name='storephone' id='userphone' oninput = \"value=value.replace(/[^\\d]/g,'')\">");
			  	else out.print("<input type='text' value='"+phone+"' name='storephone' id='userphone' oninput = \"value=value.replace(/[^\\d]/g,'')\">");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='usercity'>城&nbsp;&nbsp;&nbsp;市:</label>");
			  	out.print("</td><td style=\"padding-left=0;\">");
			  	/*if(city==null)out.print("<input type='text' name='usercity' id='usercity'>");
			  	else out.print("<input type='text' value='"+city+"' name='usercity' id='usercity'>");*/
			  	%><select name="storecity"><%
			  	out.print("<option value='null' selected='selected'>---</option>");
			  	while(res.next())
			  	{
			  		String cityname=res.getString("cityname");
			  		out.print("<option value='"+cityname+"'"+((cityname.equals(city))?("selected='selected'"):"")+">"+cityname+"</option>");
			  	}
			  	%></select><%
			  	out.print("</td></tr>");
			  	out.print("<tr><td style=\"vertical-align:text-top;\">");
			  	out.print("<label for='useraddress'>地&nbsp;&nbsp;&nbsp;址:</label>");
			  	out.print("</td><td  colspan='2'>");
			  	if(address==null)out.print("<textarea rows='5' cols='40' name='storeaddress' id='useraddress'>"+"</textarea>");
			  	else out.print("<textarea rows='5' cols='40' name='storeaddress' id='storeaddress'>"+address+"</textarea>");
			  	out.print("</td></tr>");
			  	rs.close();
			  	res.close();
			  	stmt.close();
			  	st.close();
			  	conn.close();
			 }
        	}
        catch(Exception e)
        {
	        	out.print(e);
	        	e.printStackTrace();
        }
        finally{}
        %>
                <tr><td></td><td></td><td style="width: 140px;"></td></tr>
        </tbody></table>
        <input type="submit" value="修改" id="submit">
        </form>
        </div>
</body>
</html>
