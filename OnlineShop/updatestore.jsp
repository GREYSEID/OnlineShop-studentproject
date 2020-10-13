<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>更新信息</title>
</head>
<body>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload"/>
<%
int count=1;
//request.setCharacterEncoding("gb18030");
try{
	count=Integer.parseInt(application.getAttribute("counter").toString());
}
catch(Exception e){
    out.println("counter没设置");
}
String head=null;
String filepath="D:\\pt\\imeg";//上传的图片放在虚拟目录/pt/imeg/
try{
mySmartUpload.initialize(pageContext);
mySmartUpload.setAllowedFilesList("jpg,bmp,gif,png,JEPG,BMP,GIF,PNG,jpeg,JPG");//设置接收文件类型
mySmartUpload.setMaxFileSize(10000000);    //限制上传文件的长度
		  mySmartUpload.setTotalMaxFileSize(20000000);//限制上传文件的总长度
mySmartUpload.upload();
com.jspsmart.upload.File myfile=mySmartUpload.getFiles().getFile(0);
java.io.File f=new java.io.File(filepath+"\\"+myfile.getFileName());
if(!myfile.isMissing())
{
	if(!f.exists()){
		myfile.saveAs(filepath+"\\"+myfile.getFileName());
		head=myfile.getFileName();
		out.print("上传成功");
	}
	else{
		String str=null;
		while(true)
		{
			str=""+count;
			java.io.File fi=new java.io.File(filepath+"\\"+str+myfile.getFileName());
			if(!fi.exists())break;
			count++;
		}
		myfile.saveAs(filepath+"\\"+str+myfile.getFileName());
		head=str+myfile.getFileName();
		count++;
		application.setAttribute("counter",count);
		out.print("上传成功");
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
        	String storeid=(String)session.getAttribute("storeid");
            if(storeid==null)response.sendRedirect("goodsManage.jsp");
               Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
          	  //定义连接字符串,东八区GMT%2B8
          	  String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai";
          	  //和数据库建立连接
          	  Connection conn= DriverManager.getConnection(url,"root","********");
	          	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//参数设置默认的话rs只能用next()
		        String email=mySmartUpload.getRequest().getParameter("storeemail");
		        String name=mySmartUpload.getRequest().getParameter("storename");
		        String pwd=mySmartUpload.getRequest().getParameter("storepwd");
		      	String phone=mySmartUpload.getRequest().getParameter("storephone");
		      	String address=mySmartUpload.getRequest().getParameter("storeaddress");
		      	String city=mySmartUpload.getRequest().getParameter("storecity");
		      	String sql="update storeacc set "+((name==null)?"":(" store='"+name+"'"))
      			+((email==null)?"":(" ,email='"+email+"'"))
      			+((pwd==null)?"":(",storepwd='"+pwd+"'"))
      			+((phone==null)?"":(",phone='"+phone+"'"))+((address==null)?"":(",address='"+address+"'"))
      			+((city==null||("null".equals(city)))?" ,city=null":(" ,city='"+city+"'"))
      			+((head==null)?"":(",picture='"+head+"'"))+" where storeid='"+storeid+"'";
		      	int result=st.executeUpdate(sql);
		      	if(result==0){
		      		java.io.File f=new java.io.File(filepath+head);//如果更新失败但是文件已经上传成功了，所以要删除
		        	if(!f.exists()){
		        		f.delete();
		        		out.print("删除成功");
		        	}
		      		out.print("<script>alert('更新失败');window.location.href='userimf.jsp';</script>");
		      	}
		      	st.close();
				conn.close();
				response.sendRedirect("storeuserimf.jsp");
        }
        catch(Exception e)
        {
        	out.print(e);
        	e.printStackTrace();
        	java.io.File f=new java.io.File(filepath+head);//如果更新失败但是文件已经上传成功了，所以要删除
        	if(!f.exists()){
        		f.delete();
        		out.print("删除成功");
        	}
        }
        %>
</body>
</html>
