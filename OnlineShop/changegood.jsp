<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>������Ʒ</title>
</head>

<body>
	<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
	<%
String storeid=(String)session.getAttribute("storeid");
if(storeid==null)response.sendRedirect("goodsManage.jsp");
String goodspicture=null;
String oldpicture=null;
String[]goodspicturestring=new String[4];
String[]oldpicturestring=new String[4];
String[]picturenum=null;
int count=1;
try{
	count=Integer.parseInt(application.getAttribute("counter").toString());
}
catch(Exception e){
    out.println("counterû����");
}
String filepath="D:\\pt\\imeg";//�ϴ���ͼƬ��������Ŀ¼/pt/imeg/
try{
mySmartUpload.initialize(pageContext);
mySmartUpload.setAllowedFilesList("jpg,bmp,gif,png,JPG,BMP,GIF,PNG,jpeg,JPEG");//���ý����ļ�����
mySmartUpload.setMaxFileSize(10000000);    //�����ϴ��ļ��ĳ���
mySmartUpload.setTotalMaxFileSize(20000000);//�����ϴ��ļ����ܳ���
mySmartUpload.upload();
picturenum=mySmartUpload.getRequest().getParameterValues("picturenum");
for(int i=0;i<picturenum.length;i++)
{
	com.jspsmart.upload.File myfile=mySmartUpload.getFiles().getFile(Integer.parseInt(picturenum[i]));
	java.io.File f=new java.io.File(filepath+"\\"+myfile.getFileName());
	if(!myfile.isMissing())
	{
		if(!f.exists()){
			myfile.saveAs(filepath+"\\"+myfile.getFileName());
			goodspicturestring[Integer.parseInt(picturenum[i])]=myfile.getFileName();
			out.print("�ϴ��ɹ�");
		}
		else{
			String str=null;
			while(true)
			{
				str=""+count;//��ֹ����
				java.io.File fi=new java.io.File(filepath+"\\"+str+myfile.getFileName());
				if(!fi.exists())break;
				count++;
			}
			myfile.saveAs(filepath+"\\"+str+myfile.getFileName());
			goodspicturestring[Integer.parseInt(picturenum[i])]=str+myfile.getFileName();
			count++;
			application.setAttribute("counter",count);
			out.print("�ϴ��ɹ�");
		}
	}
}
}
catch(SecurityException e)
{
	e.printStackTrace();
	out.print(e);
}
catch(Exception e)
{
	out.print(e);
	e.printStackTrace();
}
%>
	<%
try{
	request.setCharacterEncoding("gb18030");
	String goodsid=mySmartUpload.getRequest().getParameter("goodsid");
	String goodsname=mySmartUpload.getRequest().getParameter("goodsname");
	String goodsprice=mySmartUpload.getRequest().getParameter("goodsprice");
	String goodstag=mySmartUpload.getRequest().getParameter("goodstag");
	String goodsintroduction=mySmartUpload.getRequest().getParameter("goodsintroduction");
	String goodscount=mySmartUpload.getRequest().getParameter("goodscount");
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet res=stmt.executeQuery("select picture,picture2,picture3,picture4 from goods where id='"+goodsid+"'");
	res.next();
	//oldpicture=res.getString("picture");
	oldpicturestring[0]=res.getString("picture");
	oldpicturestring[1]=res.getString("picture2");
	oldpicturestring[2]=res.getString("picture3");
	oldpicturestring[3]=res.getString("picture4");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	String sql="update goods set "+((goodsname==null||goodsname.equals(""))?("name=null"):("name='"+goodsname+"'"))+
			((goodspicturestring[0]==null)?"":(",picture='"+goodspicturestring[0]+"'"))+
			((goodspicturestring[1]==null)?"":(",picture2='"+goodspicturestring[1]+"'"))+
			((goodspicturestring[2]==null)?"":(",picture3='"+goodspicturestring[2]+"'"))+
			((goodspicturestring[3]==null)?"":(",picture4='"+goodspicturestring[3]+"'"))+
			((goodsprice==null)?(",price=null"):(",price='"+goodsprice+"'"))+
			((goodstag==null||goodstag.equals(""))?(",tag=null"):(",tag='"+goodstag+"'"))+
			((goodsintroduction==null||goodsintroduction.equals(""))?(",introduction=null"):(",introduction='"+goodsintroduction+"'"))
			+((goodscount==null||goodscount.equals(""))?(",count=null"):(",count='"+goodscount+"'"))+" where id='"+goodsid+"'";
	int result=st.executeUpdate(sql);
	if(result==0)
	{
		for(int i=0;i<picturenum.length;i++)
		{
			java.io.File file=new File(filepath+goodspicturestring[Integer.parseInt(picturenum[i])]);
			if(!file.exists())file.delete();
		}
		out.print("����ʧ��");
		response.sendRedirect("changeGoods.jsp?goodsid="+goodsid);
	}
	else{
		for(int i=0;i<picturenum.length;i++)
		{
			java.io.File file=new java.io.File(filepath+"\\"+(oldpicturestring[Integer.parseInt(picturenum[i])]==null?"":oldpicturestring[Integer.parseInt(picturenum[i])]));//���³ɹ�����ͼƬɾ��
			if(!file.isFile())file.delete();
		}
		}
	res.close();
	stmt.close();
	conn.close();
	response.sendRedirect("changeGoods.jsp?goodsid="+goodsid+"");
}
catch(Exception e)
{
	for(int i=0;i<picturenum.length;i++)
	{
		java.io.File file=new java.io.File(filepath+"\\"+(goodspicturestring[Integer.parseInt(picturenum[i])]==null?"":goodspicturestring[Integer.parseInt(picturenum[i])]));//����ʧ��Ҫ���ϴ����ļ�ɾ��
		if(!file.isFile())file.delete();
	}
	e.printStackTrace();
}
%>
</body>

</html>