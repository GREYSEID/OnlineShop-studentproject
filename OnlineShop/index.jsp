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
if(userid!=null){//����û��Ƿ��¼����¼�˾���ʾ������Ϣ�ȣ�û��½����ʾ��¼ע��ҳ��
	boolcodeout="none";
	boolcodein="inline";
	boolblockout="none";
	boolblockin="block";

try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
	ResultSet rs=st.executeQuery("select nickname,head from myuser where id="+"\""+userid+"\"");//��ȡ�û����ǳ�ͷ����ʾ
	rs.next();
	nickname=rs.getString("nickname");
	head=rs.getString("head");
	if(head!=null){
		String gbk=URLEncoder.encode(head,"gb18030");//������Ҫת��,jsp��src��ַ�൱�ڴ�һ����ҳͼƬ������������Ҫת��
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
    <title>����</title>
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
        try {//���Ƽ�����Ҳ���ǹ��洰�ڽ��в���
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            //���������ַ���,������GMT%2B8
            String url = "jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai";
            //�����ݿ⽨������
            Connection conn = DriverManager.getConnection(url, "root", "yuan1234");
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
            String str = "select id,picture from goods " + "where count+0>0 ";
            ResultSet rs = st.executeQuery(str);
            while (rs.next() && count < 3) {
                count++;
                goodsl[count] = "Goods.jsp?goodsid=" + rs.getString("id");//��ȡ4����Ʒ
                goodsp[count] = "/pt/imeg/" + ((rs.getString("picture") == null || "".equals(rs.getString("picture")) ? ("timg (3).jpg") : rs.getString("picture")));
            }
            if (count < 3) {
                for (int i = count; i < 3;)//�������4����Ʒ���Ͳ��㣬��Ϊ��
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
            function imgchange() {/*���ݵ�����Ƽ�����ѡ������ƶ�*/
                if (currtime > 3) currtime = 0;
                if (currtime < 0) currtime = 3;
                var lis = document.getElementById("imgname");
                var a = lis.firstElementChild;
                var img = a.firstElementChild;
                var imgli = document.getElementsByClassName("imgli");
                for (var i = 0; i < 4; i++)/*����İ�ť���е��Ч����ʾ*/ {
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
    <!--ȡ��bodyǰ�Ŀ�϶-->
    <div class="firsttitle">
        <a href="loginregister.html?login=true"
            style="color: red;margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">��¼</a>
        <a href="currentregister.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodeout%>;">ע��</a>
        <a href="userimf.jsp" style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">����ҳ��</a>
        <a href="Cart.jsp" style="margin-left: 10px;margin-right: 10px;">�ҵĹ��ﳵ</a>
        <a href="orderManage.jsp?action=1"
            style="margin-left: 10px;margin-right: 10px;display: <%=boolcodein%>;">�����¼</a>
        <a href="logout.jsp" style="margin-left: 10px;margin-right: 10px;">ע��</a>
        <a href="index.jsp" style="margin-left: 10px;margin-right: 10px;">��ҳ</a>
        <span id="time" style="float:right;width: 150px;"> </span>
        <a href="goodsManage.jsp" style="float: right;margin-left: 10px;margin-right: 10px;">�̼����</a>
        <a href="mailo:GREYSEID@hotmail.com" style="float: right;margin-left: 10px;margin-right: 10px;">�ͷ�</a>
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
                            type="submit" value="����" class="searchButton">
                    </form>
                </center>
            </div>
            <div style="float: left;height: 100%;width: 25%;">
                <form action="login.jsp" class="loginregister" style="display:<%=boolblockout%>;">
                    <label for="userid">��&nbsp;�� </label><input type="text" id="userid" placeholder="USERID"
                        class="lrstyle" required="required" name="userid"><br>
                    <label for="userpwd">��&nbsp;�� </label><input type="password" id="userpwd" placeholder="PASSWORD"
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
                        <img alt="ͷ��" src="<%=head%>" style="height:100%;width: 100%"></div>
                </div>
            </div>
        </div>
    </div>
    <!--����������-->
    <div style="width: 1500px;height: 1800px;margin:0 auto;">
        <!--Ŀ���Ƿ���ȥ��ʾ����Ŀ¼,���֮��������ݿ��д��������ݷ���<table>��-->
        <div class="liststyle" style='z-index:1;'>
            <h3
                style="text-align: center;border: 1px solid #4a93ff;background-color: #4a93ff;color: white;width: 200px;border-top-left-radius: 15px;border-top-right-radius: 15px;margin-bottom: 0;margin-top: 0;">
                ���ർ��
            </h3>
            <ul style="float:right;margin-top: 0;">
                <li class="showhide"><a class="one">Ůװ / ��װ / ����<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����ȹ","gb18030")%>'>����ȹ</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("������Ʒ","gb18030")%>'>������Ʒ</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("T��","gb18030")%>'>T��</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����","gb18030")%>'>����</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">Ьѥ / ��� / ���<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("Ů��","gb18030")%>'>Ů��</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("ɧ��","gb18030")%>'>ɧ��</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("˫���","gb18030")%>'>˫���</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("�а�","gb18030")%>'>�а�</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">ͯװ��� / �в� / ��Ʒ<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����ȹ","gb18030")%>'>����ȹ</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("��ů����","gb18030")%>'>��ů����</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����","gb18030")%>'>����</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����","gb18030")%>'>����</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">�ҵ� / ���� / �ֻ�<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("��Ϸ����","gb18030")%>'>��Ϸ����</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("���뾫ѡ","gb18030")%>'>���뾫ѡ</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("�ֻ�����","gb18030")%>'>�ֻ�����</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("ƻ���ֻ���","gb18030")%>'>ƻ���ֻ���</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">��ױ / ϴ�� / ����Ʒ<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("ϴ��ˮ","gb18030")%>'>ϴ��ˮ</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>������</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("��Ĥ","gb18030")%>'>��Ĥ</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("ͷ������","gb18030")%>'>ͷ������</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">�鱦 / �۾� / �ֱ�<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("��������","gb18030")%>'>��������</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>�������</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("���","gb18030")%>'>���</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����","gb18030")%>'>����</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">�˶� / ���� / ����<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����","gb18030")%>'>����</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>������</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����Ь","gb18030")%>'>����Ь</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("��ɽ��","gb18030")%>'>��ɽ��</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">��Ϸ / ���� / Ӱ��<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("�ְ�","gb18030")%>'>�ְ�</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("ä��","gb18030")%>'>ä��</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>������</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("����֮ҹ","gb18030")%>'>����֮ҹ</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">��ʳ / ���� / ��ʳ<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("��֦","gb18030")%>'>��֦</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("ˮ��","gb18030")%>'>ˮ��</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("�����","gb18030")%>'>�����</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("â��","gb18030")%>'>â��</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">�ʻ� / ���� / ũ��<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("���ڹ���","gb18030")%>'>���ڹ���</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("�������","gb18030")%>'>�������</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>������</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>������</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">���ϼ��� / װ�� / ����<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("ɫ��ר��","gb18030")%>'>ɫ��ר��</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("T������","gb18030")%>'>T������</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("������֯����","gb18030")%>'>������֯����</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("ȫ���������","gb18030")%>'>ȫ���������</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">�Ҿ� / ���� / �ҷ�<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����","gb18030")%>'>����</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����ȹ","gb18030")%>'>����ȹ</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����ȹ","gb18030")%>'>����ȹ</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����ȹ","gb18030")%>'>����ȹ</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">���� / ���ֳ� / ��Ʒ<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("����","gb18030")%>'>����</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("��̺","gb18030")%>'>��̺</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("ɳ����","gb18030")%>'>ɳ����</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("ʮ����","gb18030")%>'>ʮ����</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">�칫 / DIY / ������<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("����T��","gb18030")%>'>����T��</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("�Ļ���","gb18030")%>'>�Ļ���</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>������</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("���¶���","gb18030")%>'>���¶���</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">�ٻ� / �ͳ� / ��ͥ����<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("��������","gb18030")%>'>��������</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("������","gb18030")%>'>������</a></span>
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("��ͯ���ɹ�","gb18030")%>'>��ͯ���ɹ�</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("ѹ����","gb18030")%>'>ѹ����</a></span>
                    </div>
                </li>
                <li class="showhide"><a class="one">ѧϰ / ��ȯ / ���ط���<span class="arrowstyle">></span></a>
                    <div class="hidehide">
                        <span><a class="two"
                                href='index.jsp?tag=<%=URLEncoder.encode("�Ͷ��ڸ���","gb18030")%>'>�Ͷ��ڸ���</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("���п�","gb18030")%>'>���п�</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("�ֶ���","gb18030")%>'>�ֶ���</a></span>
                        <span><a class="two" href='index.jsp?tag=<%=URLEncoder.encode("���ָ�","gb18030")%>'>���ָ�</a></span>
                    </div>
                </li>
            </ul>
        </div>
        <div style="height: 1800px;width: 1020px;float: left;text-align: center;">
            <div style="width: 1020px;height: 300px;margin: 0 auto;position:relative;z-index:0;">
                <!--  <a href=''><img alt='ͼƬ' src='/pt/imeg/timg (3).jpg' style='width:100%;height: 100%;'></a>-->
                <!--  ���ȶȸߵ���Ʒ������ҳͼƬ�ֲ������Ƽ����㷨��ʱ���ᣬ���Ծͼ򵥵ؽ���Ʒ����е���Ʒչʾ����ҳ��-->
                <div style='position:absolute;right:20px;bottom:20px;'>
                    <ul>
                        <li class='imgli' onmouseover='currtime=0;imgchange();' onclick="currtime=0;imgchange();"></li>
                        <li class='imgli' onmouseover='currtime=1;imgchange();' onclick="currtime=1;imgchange();"></li>
                        <li class='imgli' onmouseover='currtime=2;imgchange();' onclick="currtime=2;imgchange();"></li>
                        <li class='imgli' onmouseover='currtime=3;imgchange();' onclick="currtime=3;imgchange();"></li>
                    </ul>
                </div>
                <a style='left:0;' class='arrow' onclick='currtime=currtime-2;imgchange();'>��</a><a style='right:0px;'
                    onclick='imgchange();' class='arrow'>��</a>
                <div style="width: 100%;height: 100%;">
                    <div id='imgname'><a href=''><img alt='ͼƬ' src='/pt/imeg/timg (3).jpg'
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
            int PageSize=9;//һҳ��ʾ9��
            int RowCount=0;//��¼����
            int PageCount=1;//��ҳ��
            int Page=1;//��ʾ��ҳ��
            String strPage=null;//����ҳ��
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
            	//���������ַ���,������GMT%2B8
            	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
            	//�����ݿ⽨������
            	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
            	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
            	String str="select id,picture,introduction,name from goods "+"where count+0>0 "+(((tag==null||"".equals(tag))?"":" and tag like '"+tag+"' ")+((storeid==null||"".equals(storeid))?"":(" and storeid="+storeid))+(" (  )".equals(sr)?"":" and "+sr));
            	ResultSet rs=st.executeQuery(str);
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
            	int i=0;
            	while(i<PageSize&&rs!=null&&!rs.isAfterLast())
            	{
            		goodsid=rs.getString("id");
            		introduction=rs.getString("name");//�ĳɻ�ȡ��������
            		picture=rs.getString("picture");
            		introduction=(introduction==null?"":introduction);
            		picture=(picture==null||"".equals(picture)?"timg (3).jpg":URLEncoder.encode(picture,"gb18030"));
            		out.print("<div style='height:363px;width:333px;float:left;margin:3px;'>");
            		out.print("<a href='Goods.jsp?goodsid="+goodsid+"'>"+"<div class='theimgstyle'>"+"<img alt='����ͼƬ' src='/pt/imeg/"+picture+"'style='height: 333px;width: 333px;'></div></a>");
            		out.print("<a href='Goods.jsp?goodsid="+goodsid+"'>"+"<div class='thegoodsstyle'>"+introduction+"</div></a><a class='buygoodsstyle' href='addCart.jsp?action=1&num=1&goodsid="+goodsid+"'><img alt='���ﳵ' src='timg (3).jpg' style='width:100%;height:100%;'></a>");
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
					out.print("&nbsp;<a href='index.jsp?page=1"+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>��&nbsp;ҳ</a>&nbsp;");
					out.print("&nbsp;<a href='index.jsp?page="+(Page-1)+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>��һҳ</a>&nbsp;");
				}
				out.print("&nbsp;��"+Page+"ҳ&nbsp;");
				if(Page<PageCount)
				{
					out.print("&nbsp;<a href='index.jsp?page="+(Page+1)+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>��һҳ</a>&nbsp;");
					out.print("&nbsp;<a href='index.jsp?page="+PageCount+(tag==null||"".equals(tag)?"":"&tag="+URLEncoder.encode(tag,"gb18030"))+(storeid==null||"".equals(storeid)?"":"&storeid="+storeid)+s+"'>β&nbsp;ҳ</a>&nbsp;");
				}
				out.print("&nbsp;��ת��"+((tag==null||"".equals(tag))?"":"<input type='hidden' name='tag' value="+tag+">")+((storeid==null||"".equals(storeid))?"":"<input type='hidden' name='storeid' value='"+storeid+"'>")+"<input type='text' name='page' size=2>ҳ&nbsp;��"+PageCount+"ҳ&nbsp;");
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
        try{//��Ϊ�����Ƽ��㷨�����Լ�չʾһ�±����ǰ������̱�
        	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        	//���������ַ���,������GMT%2B8
        	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
        	//�����ݿ⽨������
        	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
        	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
        	String str="select storeid,picture from storeacc";
        	ResultSet rs=st.executeQuery(str);
        	//rs.last();
        	//if(rs.getRow()>0){
       		int flag=0;
       		//rs.first();
       		while(rs.next()&&flag!=8)//��ʾ�̵���Ϣ
       		{
       			out.print("<a href='index.jsp?storeid="+rs.getString("storeid")+"'><img src='"+(rs.getString("picture")==null||"".equals(rs.getString("picture"))?"timg.jpg":"/pt/imeg/"+URLEncoder.encode(rs.getString("picture"),"gb18030"))+"' alt='�����̱�'></a>");
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
    <img onclick="imgclick()" src="timg (1).jpg" alt="ͼƬ" id="imgclick" style="height: 100px;width: 100px;">
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div class="final">
        <!--��β-->
        <div style="text-align: center;">��������<br>
            ����վ��չʾ����ϢΪ��վ�����������ṩ��������ʵ�ԡ�׼ȷ�ԡ��Ϸ�������վ�����߸���<br>
            �������վչʾ��Ϣ�ַ����İ�Ȩ�������Ϸ�Ȩ�棬����ϵ<a href="mailo:GREYSEID@hotmail.com">GREYSEID@hotmail.com</a>
        </div>
    </div>
</body>

</html>