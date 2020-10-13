<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="GB18030">
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
String goodsname=null;
request.setCharacterEncoding("gb18030");
String goodsid=request.getParameter("goodsid");
String picture=null;
String store=null;
String storeid=null;
String count=null;
String tag=null;
String price=null;
String introduction=null;
String address=null;
String picture2=null;
String picture3=null;
String picture4=null;
String defaultpicture="/pt/imeg/timg (3).jpg";
String thepicture=defaultpicture;
int i=0;
Boolean flag=false;
String disabled="disabled";
if(goodsid!=null&&goodsid!=""){
try{
    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    //定义连接字符串,东八区GMT%2B8
    String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
    //和数据库建立连接
    Connection conn= DriverManager.getConnection(url,"root","********");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	ResultSet rs=st.executeQuery("select A.*,B.store,B.address from goods A,storeacc B where  A.storeid=B.storeid and id="+"\""+goodsid+"\"");
	rs.next();//获取商品数据，然后显示
	picture=rs.getString("picture");
	store=rs.getString("store");
	count=rs.getString("count");
	tag=rs.getString("tag");
	goodsname=rs.getString("name");
	price=rs.getString("price");
	introduction=rs.getString("introduction");
	address=rs.getString("address");
	picture2=rs.getString("picture2");
	picture3=rs.getString("picture3");
	picture4=rs.getString("picture4");
	storeid=rs.getString("storeid");
	i = Integer.parseInt(count);//将库存转换为整数
	if(i>0)
	{
		flag=true;
		disabled="";
	}
	thepicture=(picture==null||"".equals(picture))?defaultpicture:("/pt/imeg/"+URLEncoder.encode(picture,"gb18030"));
	picture2=(picture2==null||"".equals(picture2))?defaultpicture:("/pt/imeg/"+URLEncoder.encode(picture2,"gb18030"));
	picture3=(picture3==null||"".equals(picture3))?defaultpicture:("/pt/imeg/"+URLEncoder.encode(picture3,"gb18030"));
	picture4=(picture4==null||"".equals(picture4))?defaultpicture:("/pt/imeg/"+URLEncoder.encode(picture4,"gb18030"));
	rs.close();
	st.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
}
%>
    <title><%=goodsname %></title>
    <link rel="stylesheet" type="text/css" href="taotao.css">
    <style>
        table {
            width: 700px;
        }

        td {
            height: 50px;
            width: 300px;
        }

        img {
            width: 40px;
            height: 40px;
        }

        a.arrow {
            color: black;
            position: absolute;
            top: 100px;
            width: 50px;
            height: 100px;
            background-color: gray;
            opacity: 0.5;
            text-align: center;
            line-height: 100px;
        }

        a.arrow:hover {
            background-color: black;
            color: white;
        }

        .goods {}

        .goods a {
            width: 150px;
            display: block;
        }

        .goods .astyle {
            width: 150px;
            height: 180px;
        }

        .goods img {
            width: 100%;
            height: 100%;
        }

        .goods .divstyle {
            width: 150px;
            height: 30px;
            background-color: rgb(214, 214, 214);
            ;
        }

        .goods .divdiv {
            width: 150px;
            height: 150px;
        }
    </style>
    <script>
        function login() {
            location.href = "loginregister.html?" + "login=true";
        }
        function register() {
            location.href = "loginregister.html?" + "login=false";
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
        function number() {
            var num = document.getElementById("num").value;
            if (num == "0") document.getElementById("num").value = 1;
            if (!isNaN(num)) {
                var temp = parseInt(num);
                if (temp ><%= count %>) {
                    temp =<%=count %>;
                    document.getElementById("num").value = temp;
                    alert('库存不够');
                }
            }
        }
        function addcart() {
            var num = document.getElementById("num").value;
            document.getElementById("form").action = "addCart.jsp";
            if (!isNaN(num)) {
                document.getElementById("submit").click();
            }
        }
        function pay() {
            window.location.href = "createorder.jsp?goods=" +<%=goodsid %> +"&num=" + document.getElementById("num").value + "&allprice=" + parseFloat(document.getElementById("num").value) * parseFloat(<%=price %>);
        }
        var currimg = 0;
        var flag = 0;
        function switchimg() {
            var imglist = document.getElementsByName("img");
            if (currimg >= imglist.length) currimg = 0;
            if (currimg < 0) {
                for (var i = 0; i < imglist.length; i++) {
                    if (imglist[i].style.display != "none")
                        if (currimg < i) currimg = i;/*找最右的值*/
                }
            }
            if (imglist[currimg].style.display != "none") {
                document.getElementById("picture").src = imglist[currimg].src;
                currimg++;
            }
            else {
                currimg++;
                flag++;
                if (flag == 8) {
                    flag = 0;
                    clearInterval(time);
                    return 0;/*防止一直递归*/
                }
                switchimg();
            }
        }
        var time = setInterval("switchimg()", 5000);
    </script>
</head>

<body style="margin: 0;padding: 0;overflow: visible;background-color: #f5f5f5;" onload="showTime()">
    <!--取消body前的空隙-->
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
    <div style="background-color: white;width: 100%;height: 150px;">
        <div style="width: 1500px;height: 150px;border:  0;background-color: white;margin: 0 auto;">
            <div style="width: 25%;height: 150px;float: left;">
                <a href="https://www.taobao.com/"><img src="1.jpg" style="height: 100%;width:100%" /></a>
            </div>
            <div style="float: left;height: 100%;width:50%;">
                <center>
                    <form action="search.jsp" style="padding: 40px 0;">
                        <input type="text" id="searchText" placeholder="SEARCH" class="searchstyle" name='search'><input
                            type="submit" value="搜索" class="searchButton">
                    </form>
                </center>
            </div>
            <div style="float: left;height: 100%;width: 25%;">
                <form action="login.jsp" class="loginregister" style="display:<%=boolblockout%>;">
                    <label for="userid">账&nbsp;号 </label><input type="text" id="userid" placeholder="USERID"
                        class="lrstyle" required="required" name="userid"><br>
                    <label for="userpwd">密&nbsp;码 </label><input type="password" id="userpwd" placeholder="PASSWORD"
                        class="lrstyle" required="required" name="userpwd">
                    <div>
                        <input type='hidden' name='action' value='1'><input type='hidden' name='goodsid'
                            value='<%=goodsid %>'>
                        <input type="submit" value="LOGIN"><a href="currentregister.jsp"
                            style="font-size: 5px;cursor: default;">REGISTER</a>
                    </div>
                </form>
                <div style="display:<%=boolblockin %>;height:100%;width:100%;">
                    <%
                String head="";
                String nickname="";
                try{
                	if(userid!=null&&!"".equals(userid))
                	{
	                	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	                    //定义连接字符串,东八区GMT%2B8
	                    String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	                    //和数据库建立连接
	                    Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	                	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	                	ResultSet rs=st.executeQuery("select nickname,head from myuser where id="+userid);
	                	while(rs.next())
	                	{
	                		nickname=rs.getString("nickname");
	                		head=rs.getString("head")==null||"".equals(rs.getString("head"))?"/pt/imeg/timg1.jpg":"/pt/imeg/"+URLEncoder.encode(rs.getString("head"),"gb18030");
	                	}
	                	rs.close();
	                	st.close();
	                	conn.close();
                	}
                }
                catch(Exception e)
                {
                	e.printStackTrace();
                }
                %>
                    <div style="float:left;position: relative;top: 40%;"><span style="">welcome!!!&nbsp;<a
                                href="userimf.jsp"><%=nickname %></a></span></div>
                    <div
                        style="width:100px;height:100px;border-radius:50%;overflow: hidden;float:right;position: relative;top: 10%;">
                        <img alt="头像" src="<%=head %>" style="height:100%;width: 100%"></div>
                </div>
            </div>
        </div>
    </div>
    <div style="width: 1500px;height: 1800px;margin:0 auto;">
        <div style='width: 35%;float:left;height: 100%;'>
            <%
String storepicture="";
String storeaddress="";
String storephone="";
String storeemail="";
try{//因为不会推荐算法，所以简单展示一下表格中前几项的商品
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	String str="select picture,email,phone,address from storeacc where storeid="+storeid;
	ResultSet rs=st.executeQuery(str);
	while(rs.next())//显示商店信息
	{
		storepicture=rs.getString("picture");
		storeemail=rs.getString("email");
		storephone=rs.getString("phone");
		storeaddress=rs.getString("address");
	}
	rs.close();
	st.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
finally{}
%>
            <br>
            <div>
                <a href='index.jsp?storeid=<%=storeid %>'><img style='width: 100px;height: 100px;' alt="店图"
                        src="<%=storepicture==null||"".equals(storepicture)?"/pt/imeg/timg (3).jpg":"/pt/imeg/"+URLEncoder.encode(storepicture,"gb18030") %>"></a>
                <p>店名：<a href='index.jsp?storeid=<%=storeid %>'><%=store %></a></p>
                <p>邮箱：<a href='mailo:<%=storeemail %>'><%=storeemail==null||"".equals(storeemail)?"":storeemail %></a>
                </p>
                <p>联系电话：<%=storephone==null||"".equals(storephone)?"":storephone %>
                <p>
                <p>地址：<%=storeaddress==null||"".equals(storeaddress)?"":storeaddress %></p>
            </div>
        </div>
        <div style="float:left;width:50%;height: 100%;float:left;">
            <h1 style="<%=disabled=="disabled"?"":"visibility:hidden;"%>position:relative;left:25%;">已下架</h1>
            <table cellspacing="0" style=''>
                <caption style='float:left;'>商品编号:<%=goodsid %></caption>
                <tbody>
                    <tr>
                        <td rowspan="4" style='position: relative;'>
                            <a style='left:0;' class='arrow' onclick='currimg=currimg-2;switchimg();'>←</a>
                            <a style='right:0px;' onclick='switchimg();' class='arrow'>→</a>
                            <div style="height: 300px;width: 300px;margin:0 auto;"><img alt="图片" src="<%=thepicture %>"
                                    style="width: 100%;height:100%;" id="picture"></div>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;"><%=goodsname==null?"":goodsname %></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">库存:<%=count %></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">价格:<%=price %></td>
                    </tr>
                    <tr>
                        <td style='text-align:center;'>
                            <img alt='图片' src='<%=thepicture%>' name='img'
                                style='display:<%=(defaultpicture.equals(picture)?"none":"inline-block") %>;'
                                onclick='currimg=0;switchimg();' onmouseover='currimg=0;switchimg();'>
                            <img alt='图片' src='<%=picture2%>' name='img'
                                style='display:<%=(defaultpicture.equals(picture2)?"none":"inline-block") %>;'
                                onclick='currimg=1;switchimg();' onmouseover='currimg=1;switchimg();'>
                            <img alt='图片' src='<%=picture3%>' name='img'
                                style='display:<%=(defaultpicture.equals(picture3)?"none":"inline-block") %>;'
                                onclick='currimg=2;switchimg();' onmouseover='currimg=2;switchimg();'>
                            <img alt='图片' src='<%=picture4%>' name='img'
                                style='display:<%=(defaultpicture.equals(picture4)?"none":"inline-block") %>;'
                                onclick='currimg=3;switchimg();' onmouseover='currimg=3;switchimg();'>
                        </td>
                        <td><%=store %></td>
                    </tr>
                    <tr>
                        <td style='text-align:center;'>
                            <form action="addCart.jsp" method="get" id="form"
                                onkeydown="if(event.keyCode==13)return false;">
                                <input type="hidden" value="<%=goodsid %>" name="goodsid">
                                <button
                                    onclick="var num=document.getElementById('num').value;if(!isNaN(num)){var temp=parseInt(num);temp++;if(temp><%=count %>)temp=<%=count %>; document.getElementById('num').value=temp; }"
                                    type="button">↑</button><input type="text" value=1 name="num" size=1 id="num"
                                    onkeyup="number()" oninput="value=value.replace(/\D|^0/g,'')"><button type="button"
                                    onclick="var num=document.getElementById('num').value;if(!isNaN(num)){var temp=parseInt(num);temp--;if(temp<=0)document.getElementById('num').value=1;else document.getElementById('num').value=temp;}">↓</button>
                                <input type="submit" id="submit" hidden>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:center;'><button onclick="addcart()" <%=disabled %>>加入购物车</button><button
                                onclick="pay()" <%=disabled %>>立即购买</button></td>
                    </tr>
                    <tr>
                        <td colspan="2">商店地址:<%=address==null?"":address %></td>
                    </tr>
                    <tr>
                        <td colspan="2" rowspan="3"><%=introduction==null?"":introduction %></td>
                    </tr>
                    <tr></tr>
                    <tr></tr>
                </tbody>
            </table>
        </div>
        <div style='height:100%;width:15%;float: left;' class='goods'>
            <%
        try{//因为不会推荐算法，所以简单展示一下表格中前几项的商品
        	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        	//定义连接字符串,东八区GMT%2B8
        	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
        	//和数据库建立连接
        	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
        	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
        	String str="select id,picture,name from goods";
        	ResultSet rs=st.executeQuery(str);
        	//rs.last();
        	//if(rs.getRow()>0){
       		int v=0;
       		//rs.first();
       		while(rs.next()&&v!=8)//显示商品信息
       		{
       			out.print("<a href='Goods.jsp?goodsid="+rs.getString("id")+"'><div class='divdiv' ><img src='"+(rs.getString("picture")==null||"".equals(rs.getString("picture"))?"/pt/imeg/timg (3).jpg":"/pt/imeg/"+URLEncoder.encode(rs.getString("picture"),"gb18030"))+"' alt='这是商品'></div></a>");
       			out.print("<a href='Goods.jsp?goodsid="+rs.getString("id")+"'><div class='divstyle' >"+rs.getString("name")+"</div></a><br>");
       			v++;
       		}
        	//}

        	rs.close();
        	st.close();
        	conn.close();
        }
        catch(Exception e)
        {
        	e.printStackTrace();
        }
        finally{}
        %>
        </div>
    </div>
</body>

</html>
