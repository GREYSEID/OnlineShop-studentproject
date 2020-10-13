<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="GB18030">
    <title>支付</title>
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
        <a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;">个人页面</a>
        <a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">我的购物车</a>
        <a href="" style="margin-left: 10px;margin-right: 10px;">购买记录</a>
        <a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">注销</a>
        <a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">主页</a>
        <span id="time" style="float:right;width: 150px;"> </span>
        <a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">客服</a>
    </div>
    <form action="finishpay.jsp" method="get" style="margin: 0 auto;text-align: center;">
        <img src="/pt/imeg/20200619101323.jpg" alt="付款码" style="height:300px;">
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
        <input type="submit" value="完成支付">
    </form>
</body>

</html>