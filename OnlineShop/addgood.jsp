<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>�����Ʒ</title>
</head>

<body>
	<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
	<%
String storeid=(String)session.getAttribute("storeid");
if(storeid==null)response.sendRedirect("storeLogin.html");
int count=1;//����һ���������������ļ���������������
try{
	count=Integer.parseInt(application.getAttribute("counter").toString());
}
catch(Exception e){
    out.println("counterû����");
}
String head=null;
String []headstring=new String[4];
String[]filepathstring={"D:\\pt\\imeg","D:\\pt\\imeg","D:\\pt\\imeg","D:\\pt\\imeg"};//����
String filepath="D:\\pt\\imeg";//�ϴ���ͼƬ��������Ŀ¼/pt/imeg/
String []picturenum=null;
//out.print(picturenum.length);
try{
mySmartUpload.initialize(pageContext);
mySmartUpload.setAllowedFilesList("jpg,bmp,gif,png,JEPG,BMP,GIF,PNG,jpeg,JPG");//���ý����ļ�����
mySmartUpload.setMaxFileSize(10000000);    //�����ϴ��ļ��ĳ���
mySmartUpload.setTotalMaxFileSize(20000000);//�����ϴ��ļ����ܳ���
mySmartUpload.upload();
picturenum=mySmartUpload.getRequest().getParameterValues("picturenum");
out.print(picturenum.length);
out.print(mySmartUpload.getFiles().getCount());
for(int i=0;i<picturenum.length;i++)
{
	com.jspsmart.upload.File myfile=mySmartUpload.getFiles().getFile(Integer.parseInt(picturenum[i]));
	java.io.File f=new java.io.File(filepath+"\\"+myfile.getFileName());
	if(!myfile.isMissing())//�ϴ��ļ�
	{
		if(!f.exists()){
			myfile.saveAs(filepath+"\\"+myfile.getFileName());
			//head=myfile.getFileName();
			headstring[Integer.parseInt(picturenum[i])]=myfile.getFileName();
			out.print("�ϴ��ɹ�");
		}
		else{
			String str=null;
			while(true)
			{
				str=""+count;//���������Ľ�������������
				java.io.File fi=new java.io.File(filepath+"\\"+str+myfile.getFileName());
				if(!fi.exists())break;
				count++;
			}
			myfile.saveAs(filepath+"\\"+str+myfile.getFileName());
			//head=str+myfile.getFileName();
			headstring[Integer.parseInt(picturenum[i])]=str+myfile.getFileName();
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
Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//���������ַ���,������GMT%2B8
String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
//�����ݿ⽨������
Connection conn= DriverManager.getConnection(url,"root","yuan1234");
String goodsid=mySmartUpload.getRequest().getParameter("goodsid");//��������
String goodsname=mySmartUpload.getRequest().getParameter("goodsname");
String goodsprice=mySmartUpload.getRequest().getParameter("goodsprice");
String goodstag=mySmartUpload.getRequest().getParameter("goodstag");
String goodsintroduction=mySmartUpload.getRequest().getParameter("goodsintroduction");
String goodscount=mySmartUpload.getRequest().getParameter("goodscount");
Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
ResultSet rs=st.executeQuery("select id from goods where id="+"\""+goodsid+"\"");//�߲���ʱ�����ظ�
rs.last();
int last=rs.getRow();
if(last==0)
{//�������
	PreparedStatement ps=conn.prepareStatement("insert into goods(id,picture,name,price,tag,storeid,introduction,count,picture2,picture3,picture4)values(?,?,?,?,?,?,?,?,?,?,?)");
	ps.setString(1,goodsid);
	ps.setString(2, headstring[0]);
	ps.setString(3,("".equals(goodsname)?null:goodsname));
	ps.setString(4, ("".equals(goodsprice)?null:goodsprice));
	ps.setString(5, "".equals(goodstag)?null:goodstag);
	ps.setString(6, "".equals(storeid)?null:storeid);
	ps.setString(7, "".equals(goodsintroduction)?null:goodsintroduction);
	ps.setString(8,"".equals(goodscount)?null:goodscount);
	ps.setString(9,headstring[1]);
	ps.setString(10,headstring[2]);
	ps.setString(11,headstring[3]);
	ps.execute();
	ps.close();
	//response.sendRedirect("goodsManage.jsp");
}
else{
	for(int i=0;i<picturenum.length;i++)
	{
	java.io.File f=new java.io.File(filepath+"\\"+headstring[Integer.parseInt(picturenum[i])]);//������ʧ�ܵ����ļ��Ѿ��ϴ��ɹ��ˣ�����Ҫɾ��
	if(!f.isFile()){
		f.delete();
	}
	}
	out.println("<script>alert('��Ʒid�Ѵ���');window.location.href='addGoods.jsp';</script>");
	}
rs.close();
st.close();
conn.close();
}
catch(Exception e)
{
	for(int i=0;i<picturenum.length;i++)
	{
		java.io.File f=new java.io.File(filepath+"\\"+headstring[Integer.parseInt(picturenum[i])]);//�����Ʒ���ʧ�ܵ����ļ��Ѿ��ϴ��ɹ��ˣ�����Ҫɾ��
		if(!f.exists()){
			f.delete();
		}
	}
	e.printStackTrace();
	out.print("<script>alert('error');window.location.href='addGoods.jsp'");
}
%>
</body>

</html>