<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="GB18030">
    <title>֧��</title>
    <link rel="stylesheet" type="text/css" href="taotao.css">
    <script type="text/javascript">
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
        <a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;">����ҳ��</a>
        <a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">�ҵĹ��ﳵ</a>
        <a href="" style="margin-left: 10px;margin-right: 10px;">�����¼</a>
        <a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">ע��</a>
        <a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">��ҳ</a>
        <span id="time" style="float:right;width: 150px;"> </span>
        <a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">�ͷ�</a>
    </div>
    <form action="finishpay.jsp" method="get" style="margin: 0 auto;text-align: center;">
        <img src="/pt/imeg/20200619101323.jpg" alt="������" style="height:300px;">
        <br>
        <%
String userid=(String)session.getAttribute("userid");
if(userid==null)response.sendRedirect("loginregister.html");
request.setCharacterEncoding("gb18030");
String []orderlist=request.getParameterValues("orderid");
String allprice=request.getParameter("allprice");
for(int i=0;i<orderlist.length;i++)
{
	out.print("<input type='hidden' value="+orderlist[i]+" name='orderid'>");
}
%>
        <input type="submit" value="���֧��">
    </form>
</body>

</html>