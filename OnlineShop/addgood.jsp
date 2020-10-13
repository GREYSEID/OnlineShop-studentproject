<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>添加商品</title>
</head>

<body>
	<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
	<%
String storeid=(String)session.getAttribute("storeid");
if(storeid==null)response.sendRedirect("storeLogin.html");
int count=1;//设置一个数，遇到重名文件进行重命名操作
try{
	count=Integer.parseInt(application.getAttribute("counter").toString());
}
catch(Exception e){
    out.println("counter没设置");
}
String head=null;
String []headstring=new String[4];
String[]filepathstring={"D:\\pt\\imeg","D:\\pt\\imeg","D:\\pt\\imeg","D:\\pt\\imeg"};//无用
String filepath="D:\\pt\\imeg";//上传的图片放在虚拟目录/pt/imeg/
String []picturenum=null;
//out.print(picturenum.length);
try{
mySmartUpload.initialize(pageContext);
mySmartUpload.setAllowedFilesList("jpg,bmp,gif,png,JEPG,BMP,GIF,PNG,jpeg,JPG");//设置接收文件类型
mySmartUpload.setMaxFileSize(10000000);    //限制上传文件的长度
mySmartUpload.setTotalMaxFileSize(20000000);//限制上传文件的总长度
mySmartUpload.upload();
picturenum=mySmartUpload.getRequest().getParameterValues("picturenum");
out.print(picturenum.length);
out.print(mySmartUpload.getFiles().getCount());
for(int i=0;i<picturenum.length;i++)
{
	com.jspsmart.upload.File myfile=mySmartUpload.getFiles().getFile(Integer.parseInt(picturenum[i]));
	java.io.File f=new java.io.File(filepath+"\\"+myfile.getFileName());
	if(!myfile.isMissing())//上传文件
	{
		if(!f.exists()){
			myfile.saveAs(filepath+"\\"+myfile.getFileName());
			//head=myfile.getFileName();
			headstring[Integer.parseInt(picturenum[i])]=myfile.getFileName();
			out.print("上传成功");
		}
		else{
			String str=null;
			while(true)
			{
				str=""+count;//遇到重名的进行重命名操作
				java.io.File fi=new java.io.File(filepath+"\\"+str+myfile.getFileName());
				if(!fi.exists())break;
				count++;
			}
			myfile.saveAs(filepath+"\\"+str+myfile.getFileName());
			//head=str+myfile.getFileName();
			headstring[Integer.parseInt(picturenum[i])]=str+myfile.getFileName();
			count++;
			application.setAttribute("counter",count);
			out.print("上传成功");
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
//定义连接字符串,东八区GMT%2B8
String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
//和数据库建立连接
Connection conn= DriverManager.getConnection(url,"root","********");
String goodsid=mySmartUpload.getRequest().getParameter("goodsid");//接收数据
String goodsname=mySmartUpload.getRequest().getParameter("goodsname");
String goodsprice=mySmartUpload.getRequest().getParameter("goodsprice");
String goodstag=mySmartUpload.getRequest().getParameter("goodstag");
String goodsintroduction=mySmartUpload.getRequest().getParameter("goodsintroduction");
String goodscount=mySmartUpload.getRequest().getParameter("goodscount");
Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
ResultSet rs=st.executeQuery("select id from goods where id="+"\""+goodsid+"\"");//高并发时会有重复
rs.last();
int last=rs.getRow();
if(last==0)
{//添加数据
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
	java.io.File f=new java.io.File(filepath+"\\"+headstring[Integer.parseInt(picturenum[i])]);//如果添加失败但是文件已经上传成功了，所以要删除
	if(!f.isFile()){
		f.delete();
	}
	}
	out.println("<script>alert('商品id已存在');window.location.href='addGoods.jsp';</script>");
	}
rs.close();
st.close();
conn.close();
}
catch(Exception e)
{
	for(int i=0;i<picturenum.length;i++)
	{
		java.io.File f=new java.io.File(filepath+"\\"+headstring[Integer.parseInt(picturenum[i])]);//如果商品添加失败但是文件已经上传成功了，所以要删除
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
