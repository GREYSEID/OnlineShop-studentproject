<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��Ϣ�޸�</title>
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
        <a href="storeLogin.html" style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">��¼</a>
        <a href="storecurrentregister.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">ע��</a>
        <a href="storeuserimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">�̼���Ϣ�޸�</a>
        <a href="orderManage.jsp?action=2" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">�����¼</a>
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
    <br>
    <div class="borderstyle">
        <form action="updatestore.jsp" method="post" style="text-align:center;" enctype="multipart/form-data">
        <table style="margin: 0 auto;text-align: left;">
        <tbody>
        <%
        request.setCharacterEncoding("gb18030");
        try{
	        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	  	    //���������ַ���,������GMT%2B8
	  	    String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	  	    //�����ݿ⽨������
	  	    Connection conn= DriverManager.getConnection(url,"root","yuan1234");
		  	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
		  	ResultSet rs=st.executeQuery("select * from storeacc where storeid="+"\""+storeid+"\"");
		  	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		  	ResultSet res=stmt.executeQuery("select cityname from city");//Ƕ��ʹ�ö�һ��statement
		  	if(rs.next())
		  	{
		  		String email=rs.getString("email");//try�ڵı���Ҳ��ֲ���������Ŀ鲻����
		  		String name=rs.getString("store");
			  	String pwd=rs.getString("storepwd");
			  	String phone=rs.getString("phone");
			  	String address=rs.getString("address");
			  	String city=rs.getString("city");
			  	String head=rs.getString("picture");
			  	String gbk=null;
			  	if(head!=null)gbk=URLEncoder.encode(head,"gb18030");//������Ҫת��
			  	%><tr><td><input type='file' name='fileUpload' accept="image/*" onchange="see('files','imgs')" id="files"></td><td>
				<div style='height: 100px;width:100px;overflow: hidden;border-radius: 50%;'><img alt='ͷ��' src="<%=(head==null?"/pt/imeg/timg1.jpg":"/pt/imeg/"+gbk) %>" style='height: 100%;' id='imgs'></div>
				</td></tr><%
			  	out.print("<tr><td>");
			  	out.print("<label for='userid'>�̵�ID:</label>");
			  	out.print("<td>"+storeid+"</td>");
			  	out.print("</td><td>");
			  	out.print("<input type=\"hidden\"  value='"+storeid+"' name='userid' id='userid'>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='useremail'>����:</label>");
			  	out.print("</td><td>");
			  	if(email==null)out.print("<input type='text' name='storeemail' id='useremail'>");//�����ֵΪnull�Ļ����Լ�.equals("null")
			  	else out.println("<input type='text' value='"+email+"' name='storeemail' id='useremail'>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='username'>�̵���:</label>");
			  	out.print("</td><td>");
			  	if(name==null)out.print("<input type='text' name='storename' id='username' required>");
			  	else out.print("<input type='text' value='"+name+"' name='storename' id='username' required>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='userpwd'>����:</label>");
			  	out.print("</td><td>");
			  	if(pwd==null)out.print("<input type='password' name='storepwd' id='userpwd' required='required' onkeyup=\"test()\">");
			  	else out.print("<input type='password' value='"+pwd+"' name=storepwd id='userpwd' required='required' onkeyup=\"test()\">");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	%><label for='confirm'>ȷ������:</label><%
			  	out.print("</td><td>");		
			  	if(pwd==null)out.print("<input type='password' id='confirm' name='confirm' onkeyup=\"test()\" required='required'>");
			  	else out.print("<input type='password' id='confirm' name='confirm' onkeyup=\"test()\" value='"+pwd+"'required='required'>");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='userphone'>�ֻ���:</label>");
			  	out.print("</td><td>");
			  	if(phone==null)out.print("<input type='text' name='storephone' id='userphone' oninput = \"value=value.replace(/[^\\d]/g,'')\">");
			  	else out.print("<input type='text' value='"+phone+"' name='storephone' id='userphone' oninput = \"value=value.replace(/[^\\d]/g,'')\">");
			  	out.print("</td></tr>");
			  	out.print("<tr><td>");
			  	out.print("<label for='usercity'>��&nbsp;&nbsp;&nbsp;��:</label>");
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
			  	out.print("<label for='useraddress'>��&nbsp;&nbsp;&nbsp;ַ:</label>");
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
        <input type="submit" value="�޸�" id="submit">
        </form>
        </div>
</body>
</html>