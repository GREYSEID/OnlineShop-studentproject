<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
    <%
String storeid=(String)session.getAttribute("storeid");
String boolcodeout="inline";
String boolcodein="none";
String boolblockout="block";
String boolblockin="none";
if(storeid==null)response.sendRedirect("storeLogin.html");
else{
	boolcodeout="none";
	boolcodein="inline";
	boolblockout="none";
	boolblockin="block";
}
%>
    <meta charset="GB18030">
    <title>商品管理</title>
    <link rel="stylesheet" type="text/css" href="taotao.css">
    <style>
        td {
            width: 100px;
        }
    </style>
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
        <a href="storeLogin.html"
            style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">登录</a>
        <a href="storecurrentregister.jsp"
            style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">注册</a>
        <a href="storeuserimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">商家信息修改</a>
        <a href="orderManage.jsp?action=2"
            style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">购买记录</a>
        <a href="logout.jsp?action=2" style="margin-left: 10px;margin-right: 10px;">注销</a>
        <a href="goodsManage.jsp" style="margin-left: 10px;margin-right: 10px;">主页</a>
        <span id="time" style="float:right;width: 150px;"> </span>
        <a href="index.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">客户入口</a>
        <a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">客服</a>
    </div>
    <%
int PageSize=20;//一页显示20条
int RowCount=0;//记录总数
int PageCount=1;//总页数
int Page=1;//显示的页码
String strPage=null;//接收页码
%>
    <button onclick="window.location.href='addGoods.jsp';">添加商品</button>
    <button onclick="window.location.href='orderManage.jsp?action=2'">订单查询</button>
    <button onclick="window.location.href='storeuserimf.jsp'">店家信息修改</button>
    <button onclick="window.location.href='logout.jsp'">注销</button>
    <table align="center">
        <tr>
            <td>商品id</td>
            <td>商品名</td>
            <td>价格</td>
            <td>库存</td>
            <td>删除</td>
            <td>修改</td>
        </tr>
        <%
try{
Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//定义连接字符串,东八区GMT%2B8
String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
//和数据库建立连接
Connection conn= DriverManager.getConnection(url,"root","yuan1234");
Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
ResultSet rs=st.executeQuery("select * from goods where storeid="+"\""+storeid+"\"");
if(rs.next())
{
	rs.last();
	RowCount=rs.getRow();
	PageCount=(RowCount+PageSize-1)/PageSize;//总页数，加1从1开始数

strPage=request.getParameter("page");
if(strPage==null)Page=1;
else{
	Page=Integer.parseInt(strPage);
	if(Page>PageCount)Page=PageCount;
	if(Page<1)Page=1;
}
if(PageCount>0)rs.absolute((Page-1)*PageSize+1);//跳转到指定记录位置
%>
        <%
int i=0;
while(i<PageSize&&rs!=null&&!rs.isAfterLast())
{
	out.print("<tr><td>"+rs.getString("id")+"</td>");
	out.print("<td>"+(rs.getString("name")==null?"":rs.getString("name"))+"</td>");
	out.print("<td>"+(rs.getString("price")==null?"":rs.getString("price"))+"</td>");
	out.print("<td>"+(rs.getString("count")==null?"":rs.getString("count"))+"</td>");
	out.print("<td><a href='deleteGoods.jsp?goodsid="+rs.getString("id")+"'>删除</a></td>");
	out.print("<td><a href='changeGoods.jsp?goodsid="+rs.getString("id")+"'>修改</a></td></tr>");
	i++;
	rs.next();
}
%>
        <%
}
rs.close();
st.close();
conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
    </table>
    <form action="goodsManage.jsp" method="get" align="center">
        <%
if(Page>1)
{
	out.print("&nbsp;<a href='goodsManage.jsp?page=1'>首&nbsp;页</a>&nbsp;");
	out.print("&nbsp;<a href='goodsManage.jsp?page="+(Page-1)+"'>上一页</a>&nbsp;");
}
out.print("&nbsp;第"+Page+"页&nbsp;");
if(Page<PageCount)
{
	out.print("&nbsp;<a href='goodsManage.jsp?page="+(Page+1)+"'>下一页</a>&nbsp;");
	out.print("&nbsp;<a href='goodsManage.jsp?page="+PageCount+"'>尾&nbsp;页</a>&nbsp;");
}
out.print("&nbsp;跳转到<input type='text' name='page' size=2>页&nbsp;共"+PageCount+"页&nbsp;<input type='submit' value='go'>&nbsp;");
%>
    </form>
    <%
%>
</body>
</html>