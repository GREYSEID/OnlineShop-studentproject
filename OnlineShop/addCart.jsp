<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��ӵ����ﳵ</title>
</head>
<body>
<%
String goodsid=null;
String num=null;
goodsid=request.getParameter("goodsid");
num=request.getParameter("num");
if(goodsid==null||"".equals(goodsid)||num==null||"".equals(num))out.print("<script>window.location.href='index.jsp';</script>");//���ܶ��response.sendRedirect
Cookie goodscookie=null;
Cookie[]cookies=null;
Cookie numcookie=null;
cookies=request.getCookies();//��ȡcookie
String str="";
String str1="";
String[]goodslist=null;
String[]numlist=null;
int flag=0;
if(cookies!=null)
{
	for(int i=0;i<cookies.length;i++)//ͨ�������ҵ���Ӧcookie
	{
		if("goodsid".equals(cookies[i].getName()))
		{
			goodscookie=cookies[i];
		}
		if("num".equals(cookies[i].getName()))
		{
			numcookie=cookies[i];
		}
	}
	if(goodscookie!=null&&numcookie!=null)
	{
		str=goodscookie.getValue();
		str1=numcookie.getValue();
		goodslist=str.split("\\|");//ת��������
		numlist=str1.split("\\|");
		for(int i=0;i<goodslist.length;i++)
		{
			if(goodslist[i].equals(goodsid))//cookie�������Ҫ��ӵ���Ʒ
			{
				int x=Integer.parseInt(numlist[i]);//������������
				x=x+Integer.parseInt(num);
				if(x>0){
					numlist[i]=""+x;
					String g="";
					String n="";
					for(int z=0;z<goodslist.length;z++)//��ӽ��ַ�������
					{
						g+=goodslist[z]+"|";
						n+=numlist[z]+"|";
					}
					goodscookie.setValue(g);
					numcookie.setValue(n);
					goodscookie.setMaxAge(60*60*24);
					numcookie.setMaxAge(60*60*24);
					response.addCookie(goodscookie);//����cookie
					response.addCookie(numcookie);
					flag=1;
				}
				else{//�޳�����С��0�Ļ���
					String g="";
					String n="";
					for(int z=0;z<goodslist.length;z++)
					{
						if(!goodsid.equals(goodslist[z]))
						{
							g+=goodslist[z]+"|";
							n+=numlist[z]+"|";
						}
					}
					goodscookie.setValue(g);
					numcookie.setValue(n);
					goodscookie.setMaxAge(60*60*24);
					numcookie.setMaxAge(60*60*24);
					response.addCookie(goodscookie);
					response.addCookie(numcookie);
					flag=2;
				}
			}
			/*else{
				goodscookie.setValue(str+goodsid+"|");
				numcookie.setValue(""+str1+num+"|");
				response.addCookie(goodscookie);
				response.addCookie(numcookie);
			}*/
		}
	}
	else{//�����ڶ�Ӧcookie�ʹ���cookie
		if(goodsid!=null||num!=null){
			if(Integer.parseInt(num)>0){
				goodscookie=new Cookie("goodsid",goodsid+"|");
				numcookie=new Cookie("num",num+"|");
				goodscookie.setMaxAge(60*60*24);
				numcookie.setMaxAge(60*60*24);
				response.addCookie(goodscookie);
				response.addCookie(numcookie);
			}
		}
	}
}
else{//ѹ��û��cookie�ʹ���cookie
	if(goodsid!=null||num!=null){
		if(Integer.parseInt(num)>0){
			goodscookie=new Cookie("goodsid",goodsid+"|");
			numcookie=new Cookie("num",num+"|");
			goodscookie.setMaxAge(60*60*24);
			numcookie.setMaxAge(60*60*24);
			response.addCookie(goodscookie);
			response.addCookie(numcookie);
		}
	}
}
if(flag==0)//���cookie��û�и���Ʒ��ֱ����ĩβ���
{
	goodscookie.setValue(str+goodsid+"|");
	numcookie.setValue(""+str1+num+"|");
	goodscookie.setMaxAge(60*60*24);
	numcookie.setMaxAge(60*60*24);
	response.addCookie(goodscookie);
	response.addCookie(numcookie);
}
String action=request.getParameter("action");
if("1".equals(action))out.print("<script>window.location.href='index.jsp';</script>");
else response.sendRedirect("Goods.jsp?goodsid="+goodsid);
%>
</body>
</html>