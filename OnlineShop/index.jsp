<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html lang="zh">
<% 
String userid=(String)session.getAttribute("userid");
String boolcodeout="inline";
String boolcodein="none";
String boolblockout="block";
String boolblockin="none";
String head="/pt/imeg/timg1.jpg";
String nickname=null;
if(userid!=null){//检测用户是否登录，登录了就显示个人信息等，没登陆就显示登录注册页面
	boolcodeout="none";
	boolcodein="inline";
	boolblockout="none";
	boolblockin="block";

try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//定义连接字符串,东八区GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//和数据库建立连接
	Connection conn= DriverManager.getConnection(url,"root","********");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
	ResultSet rs=st.executeQuery("select nickname,head from myuser where id="+"\""+userid+"\"");//获取用户的昵称头像，显示
	rs.next();
	nickname=rs.getString("nickname");
	head=rs.getString("head");
	if(head!=null){
		String gbk=URLEncoder.encode(head,"gb18030");//有中文要转码,jsp的src地址相当于打开一个网页图片，不能有中文要转码
		head="/pt/imeg/"+gbk;
	}
	else head="/pt/imeg/timg1.jpg";
	rs.close();
	st.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
}
}
%>

<head>
    <title>淘淘</title>
    <meta name="author" content="GREYSEID">
    <meta charset="gb18030">
    <link rel="stylesheet" type="text/css" href="taotao.css">
    <style>
        .theimgstyle {
            height: 333px;
            width: 333px;
        }

        .thegoodsstyle {
            width: 303px;
            height: 30px;
            background-color: rgb(214, 214, 214);
            border: 0;
            float: left;
        }

        .buygoodsstyle {
            width: 30px;
            height: 30px;
            background-color: rgb(214, 214, 214);
            border: 0;
            float: left;
        }

        .imgli {
            background: gray;
            border-radius: 8px;
            width: 16px;
            height: 16px;
            margin-right: 4px;
            float: left;
        }

        .imgli:hover {
            background: black;
            cursor: pointer;
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
        var currtime = 0;
        <%
            String[]goodsl = new String[4];
        String[]goodsp = new String[4];
        int count = -1;
        try {//对推荐栏，也就是公告窗口进行操作
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            //定义连接字符串,东八区GMT%2B8
            String url = "jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai";
            //和数据库建立连接
            Connection conn = DriverManager.getConnection(url, "root", "********");
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
            String str = "select id,picture from goods " + "where count+0>0 ";
            ResultSet rs = st.executeQuery(str);
            while (rs.next() && count < 3) {
                count++;
                goodsl[count] = "Goods.jsp?goodsid=" + rs.getString("id");//获取4个商品
                goodsp[count] = "/pt/imeg/" + ((rs.getString("picture") == null || "".equals(rs.getString("picture")) ? ("timg (3).jpg") : rs.getString("picture")));
            }
            if (count < 3) {
                for (int i = count; i < 3;)//如果不足4个商品，就补足，放为空
                {
                    count++;
                    i++;
                    goodsl[count] = "";
                    goodsp[count] = "/pt/imeg/timg (3).jpg";
                }
            }
            rs.close();
            st.close();
            conn.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        %>
            function imgchange() {/*根据点击的推荐栏的选项进行移动*/
                if (currtime > 3) currtime = 0;
                if (currtime < 0) currtime = 3;
                var lis = document.getElementById("imgname");
                var a = lis.firstElementChild;
                var img = a.firstElementChild;
                var imgli = document.getElementsByClassName("imgli");
                for (var i = 0; i < 4; i++)/*点击的按钮进行点击效果显示*/ {
                    if (i == currtime) imgli[i].style.background = 'black';
                    else imgli[i].style.background = 'gray';
                }
                switch (currtime) {
                    case 0: a.href = '<%=goodsl[0] %>';
                        img.src = '<%=goodsp[0] %>';
                        break;
                    case 1: a.href = '<%=goodsl[1] %>';
                        img.src = '<%=goodsp[1] %>';
                        break;
                    case 2: a.href = '<%=goodsl[2] %>';
                        img.src = '<%=goodsp[2] %>';
                        break;
                    case 3: a.href = '<%=goodsl[3] %>';
                        img.src = '<%=goodsp[3] %>';
                        break;
                    default: a.href = '';
                        img.src = '/pt/imeg/timg (3).jpg';
                        break;
                }
                currtime++;
            }
        setInterval("imgchange()", 5000);
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
                <a href="https://www.taobao.com/"><img src="1.jpg" style="height: 100%;width:100%;" /></a>
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
                        <input type="submit" value="LOGIN"><a href="currentregister.jsp"
                            style="font-size: 5px;cursor: default;">REGISTER</a>
                    </div>
                </form>
                <div style="display:<%=boolblockin %>;height:100%;width:100%;">
                    <div style="float:left;position: relative;top: 40%;"><span style="">welcome!!!&nbsp;<a
                                href="userimf.jsp"><%=nickname %></a></span></div>
                    <div
                        style="width:100px;height:100px;border-radius:50%;overflow: hidden;float:right;position: relative;top: 10%;">
                        <img alt="头像" src="<%=head%>" style="height:100%;width: 100%"></div>
                </div>
            </div>
        </div>
    </div>
    <!--做个分类栏-->
    <div style="width: 1500px;height: 1800px;margin:0 auto;">
        <!--目标是放上去显示二级目录,点击之后接收数据库中传来的数据放入<table>中-->
        <div class="liststyle" style='z-index:1;'>
            <h3
                style="text-align: center;border: 1px solid #4a93ff;background-color: #4a93ff;color: white;width: 200px;border-top-left-radius: 15px;border-top-right-radius: 15px;margin-bottom: 0;margin-top: 0;">
                分类导航
            </h3>
            <ul style="float:right;margin-top: 0;">
                <li class="showhide"><a class="one">女装 / 男装 / 内衣<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("连衣裙","gb18030")%>'>连衣裙</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("春夏新品","gb18030")%>'>春夏新品</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("T恤","gb18030")%>'>T恤</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("衬衫","gb18030")%>'>衬衫</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">鞋靴 / 箱包 / 配件<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("女包","gb18030")%>'>女包</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("骚包","gb18030")%>'>骚包</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("双肩包","gb18030")%>'>双肩包</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("男包","gb18030")%>'>男包</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">童装玩具 / 孕产 / 用品<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("连衣裙","gb18030")%>'>连衣裙</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("保暖连体","gb18030")%>'>保暖连体</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("裤子","gb18030")%>'>裤子</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("羽绒","gb18030")%>'>羽绒</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">家电 / 数码 / 手机<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("游戏主机","gb18030")%>'>游戏主机</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("数码精选","gb18030")%>'>数码精选</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("手机壳套","gb18030")%>'>手机壳套</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("苹果手机壳","gb18030")%>'>苹果手机壳</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">美妆 / 洗护 / 保健品<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("洗发水","gb18030")%>'>洗发水</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("护发素","gb18030")%>'>护发素</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("发膜","gb18030")%>'>发膜</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("头发造型","gb18030")%>'>头发造型</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">珠宝 / 眼镜 / 手表<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("琥珀蜜蜡","gb18030")%>'>琥珀蜜蜡</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("翠手镯","gb18030")%>'>翡翠手镯</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("钻戒","gb18030")%>'>钻戒</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("铂金","gb18030")%>'>铂金</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">运动 / 户外 / 乐器<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("鱼线","gb18030")%>'>鱼线</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("鱼线轮","gb18030")%>'>鱼线轮</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("户外鞋","gb18030")%>'>户外鞋</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("登山包","gb18030")%>'>登山包</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">游戏 / 动漫 / 影视<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("手办","gb18030")%>'>手办</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("盲盒","gb18030")%>'>盲盒</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("航海王","gb18030")%>'>航海王</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("命运之夜","gb18030")%>'>命运之夜</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">美食 / 生鲜 / 零食<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("荔枝","gb18030")%>'>荔枝</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("水果","gb18030")%>'>水果</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("百香果","gb18030")%>'>百香果</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("芒果","gb18030")%>'>芒果</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">鲜花 / 宠物 / 农资<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("进口狗粮","gb18030")%>'>进口狗粮</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("宠物服饰","gb18030")%>'>宠物服饰</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("狗厕所","gb18030")%>'>狗厕所</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("宠物窝","gb18030")%>'>宠物窝</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">面料集采 / 装修 / 建材<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("色卡专拍","gb18030")%>'>色卡专拍</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("T恤汗布","gb18030")%>'>T恤汗布</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("螺纹针织面料","gb18030")%>'>螺纹针织面料</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("全棉竹节卫衣","gb18030")%>'>全棉竹节卫衣</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">家具 / 家饰 / 家纺<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("裤袜","gb18030")%>'>裤袜</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("连衣裙","gb18030")%>'>连衣裙</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("连衣裙","gb18030")%>'>连衣裙</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("连衣裙","gb18030")%>'>连衣裙</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">汽车 / 二手车 / 用品<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("窗帘","gb18030")%>'>窗帘</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("地毯","gb18030")%>'>地毯</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("沙发垫","gb18030")%>'>沙发垫</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("十字绣","gb18030")%>'>十字绣</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">办公 / DIY / 五金电子<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("定制T恤","gb18030")%>'>定制T恤</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("文化衫","gb18030")%>'>文化衫</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("工作服","gb18030")%>'>工作服</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("卫衣定制","gb18030")%>'>卫衣定制</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">百货 / 餐厨 / 家庭保健<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("收纳整理","gb18030")%>'>收纳整理</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("收纳箱","gb18030")%>'>收纳箱</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("儿童收纳柜","gb18030")%>'>儿童收纳柜</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("压缩袋","gb18030")%>'>压缩袋</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">学习 / 卡券 / 本地服务<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("劳动节福利","gb18030")%>'>劳动节福利</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("超市卡","gb18030")%>'>超市卡</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("沃尔玛","gb18030")%>'>沃尔玛</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("家乐福","gb18030")%>'>家乐福</a></span>
                    </div>
                </li>
            </ul>
        </div>
        <div style="height: 1800px;width: 1020px;float: left;text-align: center;">
            <div style="width: 1020px;height: 300px;margin: 0 auto;position:relative;z-index:0;">
                <!--  <a href=''><img alt='图片' src='/pt/imeg/timg (3).jpg' style='width:100%;height: 100%;'></a>-->
                <!--  将热度高的商品放在首页图片轮播区，推荐的算法暂时不会，所以就简单地将商品表格中地商品展示在首页中-->
                <div style='position:absolute;right:20px;bottom:20px;'>
                    <ul>
                        <li class='imgli' onmouseover='currtime=0;imgchange();' onclick="currtime=0;imgchange();"></li>
                        <li class='imgli' onmouseover='currtime=1;imgchange();' onclick="currtime=1;imgchange();"></li>
                        <li class='imgli' onmouseover='currtime=2;imgchange();' onclick="currtime=2;imgchange();"></li>
                        <li class='imgli' onmouseover='currtime=3;imgchange();' onclick="currtime=3;imgchange();"></li>
                    </ul>
                </div>
                <a style='left:0;' class='arrow' onclick='currtime=currtime-2;imgchange();'>←</a><a style='right:0px;'
                    onclick='imgchange();' class='arrow'>→</a>
                <div style="width: 100%;height: 100%;">
                    <div id='imgname'><a href=''><img alt='图片' src='/pt/imeg/timg (3).jpg'
                                style='width:1020px;height: 300px;'></a></div>
                </div>
            </div>
            <div style="height:1200px;">
                <!-- <table style="border-collapse:separate; border-spacing:5px 0;">-->
                <%
            String picture=null;
            String  introduction=null;
            String goodsid=null;
            request.setCharacterEncoding("gb18030");
            String tag=request.getParameter("tag");
            String storeid=request.getParameter("storeid");
            int PageSize=9;//一页显示9条
            int RowCount=0;//记录总数
            int PageCount=1;//总页数
            int Page=1;//显示的页码
            String strPage=null;//接收页码
            String[]goodslist=request.getParameterValues("goodslist");
            String s="";
            String sr=" ( ";
            if(goodslist!=null){
            	for(int i=0;i<goodslist.length;i++)
		            {
		            	if(i==0){
		            		sr+=" id="+goodslist[i];
		            		s+="&goodsid="+goodslist[i];
		            	}
		            	else{
		            		s+="&goodsid="+goodslist[i];
		                	sr+=" or id="+goodslist[i];
		            	}
		            }
            }
            sr+=" )";
            try{
            	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            	//定义连接字符串,东八区GMT%2B8
            	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
            	//和数据库建立连接
            	Connection conn= DriverManager.getConnection(url,"root","********");
            	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
            	String str="select id,picture,introduction,name from goods "+"where count+0>0 "+(((tag==null||"".equals(tag))?"":" and tag like '"+tag+"' ")+((storeid==null||"".equals(storeid))?"":(" and storeid="+storeid))+(" (  )".equals(sr)?"":" and "+sr));
            	ResultSet rs=st.executeQuery(str);
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
            	int i=0;
            	while(i<PageSize&&rs!=null&&!rs.isAfterLast())
            	{
            		goodsid=rs.getString("id");
            		introduction=rs.getString("name");//改成获取名字数据
            		picture=rs.getString("picture");
            		introduction=(introduction==null?"":introduction);
            		picture=(picture==null||"".equals(picture)?"timg (3).jpg":URLEncoder.encode(picture,"gb18030"));
            		out.print("<div style='height:363px;width:333px;float:left;margin:3px;'>");
            		out.print("<a href='Goods.jsp?goodsid="+goodsid+"'>"+"<div class='theimgstyle'>"+"<img alt='这是图片' src='/pt/imeg/"+picture+"'style='height: 333px;width: 333px;'></div></a>");
            		out.print("<a href='Goods.jsp?goodsid="+goodsid+"'>"+"<div class='thegoodsstyle'>"+introduction+"</div></a><a class='buygoodsstyle' href='addCart.jsp?action=1&num=1&goodsid="+goodsid+"'><img alt='购物车' src='timg (3).jpg' style='width:100%;height:100%;'></a>");
            		out.print("</div>");
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
            </div>
            <div style="margin:0 auto;">
                <form action="index.jsp" method="get" style="">
                    <%
				if(Page>1)
				{
					out.print("&nbsp;<a href='index.jsp?page=1"+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>首&nbsp;页</a>&nbsp;");
					out.print("&nbsp;<a href='index.jsp?page="+(Page-1)+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>上一页</a>&nbsp;");
				}
				out.print("&nbsp;第"+Page+"页&nbsp;");
				if(Page<PageCount)
				{
					out.print("&nbsp;<a href='index.jsp?page="+(Page+1)+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>下一页</a>&nbsp;");
					out.print("&nbsp;<a href='index.jsp?page="+PageCount+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>尾&nbsp;页</a>&nbsp;");
				}
				out.print("&nbsp;跳转到"+((tag==null||"".equals(tag))?"":"<input type='hidden' name='tag' value="+tag+">")+((storeid==null||"".equals(storeid))?"":"<input type='hidden' name='storeid' value='"+storeid+"'>")+"<input type='text' name='page' size=2>页&nbsp;共"+PageCount+"页&nbsp;");
				if(goodslist!=null)
					{
						for(int i=0;i<goodslist.length;i++)
							{
								out.print("<input type='hidden' name='goodslist' value="+goodslist[i]+">");
							}
					}
				out.print("<input type='submit' value='go'>&nbsp;");
				%>
                </form>
            </div>
        </div>
        <div class="store">
            <%
        try{//因为不会推荐算法，所以简单展示一下表格中前几项的商标
        	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        	//定义连接字符串,东八区GMT%2B8
        	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
        	//和数据库建立连接
        	Connection conn= DriverManager.getConnection(url,"root","********");
        	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
        	String str="select storeid,picture from storeacc";
        	ResultSet rs=st.executeQuery(str);
        	//rs.last();
        	//if(rs.getRow()>0){
       		int flag=0;
       		//rs.first();
       		while(rs.next()&&flag!=8)//显示商店信息
       		{
       			out.print("<a href='index.jsp?storeid="+rs.getString("storeid")+"'><img src='"+(rs.getString("picture")==null||"".equals(rs.getString("picture"))?"timg.jpg":"/pt/imeg/"+URLEncoder.encode(rs.getString("picture"),"gb18030"))+"' alt='这是商标'></a>");
       			flag++;
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
    <img onclick="imgclick()" src="timg (1).jpg" alt="图片" id="imgclick" style="height: 100px;width: 100px;">
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div class="final">
        <!--结尾-->
        <div style="text-align: center;">免责声明<br>
            本网站所展示的信息为网站所有者自行提供，内容真实性、准确性、合法性由网站所有者负责<br>
            如果本网站展示信息侵犯您的版权或其他合法权益，请联系<a href="mailo:GREYSEID@hotmail.com">GREYSEID@hotmail.com</a>
        </div>
    </div>
</body>

</html>
