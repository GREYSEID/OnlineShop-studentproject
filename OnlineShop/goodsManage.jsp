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
    <title>��Ʒ����</title>
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
        <a href="storeLogin.html"
            style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">��¼</a>
        <a href="storecurrentregister.jsp"
            style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">ע��</a>
        <a href="storeuserimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">�̼���Ϣ�޸�</a>
        <a href="orderManage.jsp?action=2"
            style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">�����¼</a>
        <a href="logout.jsp?action=2" style="margin-left: 10px;margin-right: 10px;">ע��</a>
        <a href="goodsManage.jsp" style="margin-left: 10px;margin-right: 10px;">��ҳ</a>
        <span id="time" style="float:right;width: 150px;"> </span>
        <a href="index.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">�ͻ����</a>
        <a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">�ͷ�</a>
    </div>
    <%
int PageSize=20;//һҳ��ʾ20��
int RowCount=0;//��¼����
int PageCount=1;//��ҳ��
int Page=1;//��ʾ��ҳ��
String strPage=null;//����ҳ��
%>
    <button onclick="window.location.href='addGoods.jsp';">�����Ʒ</button>
    <button onclick="window.location.href='orderManage.jsp?action=2'">������ѯ</button>
    <button onclick="window.location.href='storeuserimf.jsp'">�����Ϣ�޸�</button>
    <button onclick="window.location.href='logout.jsp'">ע��</button>
    <table align="center">
        <tr>
            <td>��Ʒid</td>
            <td>��Ʒ��</td>
            <td>�۸�</td>
            <td>���</td>
            <td>ɾ��</td>
            <td>�޸�</td>
        </tr>
        <%
try{
Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//���������ַ���,������GMT%2B8
String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
//�����ݿ⽨������
Connection conn= DriverManager.getConnection(url,"root","yuan1234");
Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
ResultSet rs=st.executeQuery("select * from goods where storeid="+"\""+storeid+"\"");
if(rs.next())
{
	rs.last();
	RowCount=rs.getRow();
	PageCount=(RowCount+PageSize-1)/PageSize;//��ҳ������1��1��ʼ��

strPage=request.getParameter("page");
if(strPage==null)Page=1;
else{
	Page=Integer.parseInt(strPage);
	if(Page>PageCount)Page=PageCount;
	if(Page<1)Page=1;
}
if(PageCount>0)rs.absolute((Page-1)*PageSize+1);//��ת��ָ����¼λ��
%>
        <%
int i=0;
while(i<PageSize&&rs!=null&&!rs.isAfterLast())
{
	out.print("<tr><td>"+rs.getString("id")+"</td>");
	out.print("<td>"+(rs.getString("name")==null?"":rs.getString("name"))+"</td>");
	out.print("<td>"+(rs.getString("price")==null?"":rs.getString("price"))+"</td>");
	out.print("<td>"+(rs.getString("count")==null?"":rs.getString("count"))+"</td>");
	out.print("<td><a href='deleteGoods.jsp?goodsid="+rs.getString("id")+"'>ɾ��</a></td>");
	out.print("<td><a href='changeGoods.jsp?goodsid="+rs.getString("id")+"'>�޸�</a></td></tr>");
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
	out.print("&nbsp;<a href='goodsManage.jsp?page=1'>��&nbsp;ҳ</a>&nbsp;");
	out.print("&nbsp;<a href='goodsManage.jsp?page="+(Page-1)+"'>��һҳ</a>&nbsp;");
}
out.print("&nbsp;��"+Page+"ҳ&nbsp;");
if(Page<PageCount)
{
	out.print("&nbsp;<a href='goodsManage.jsp?page="+(Page+1)+"'>��һҳ</a>&nbsp;");
	out.print("&nbsp;<a href='goodsManage.jsp?page="+PageCount+"'>β&nbsp;ҳ</a>&nbsp;");
}
out.print("&nbsp;��ת��<input type='text' name='page' size=2>ҳ&nbsp;��"+PageCount+"ҳ&nbsp;<input type='submit' value='go'>&nbsp;");
%>
    </form>
    <%
%>
</body>
</html>