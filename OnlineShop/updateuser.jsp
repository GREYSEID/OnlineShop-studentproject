<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��������</title>
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
    out.println("counterû����");
}
String head=null;
String filepath="D:\\pt\\imeg";//�ϴ���ͼƬ��������Ŀ¼/pt/imeg/
try{
mySmartUpload.initialize(pageContext);
mySmartUpload.setAllowedFilesList("jpg,bmp,gif,png,JEPG,BMP,GIF,PNG,jpeg,JPG");//���ý����ļ�����
mySmartUpload.setMaxFileSize(10000000);    //�����ϴ��ļ��ĳ���
		  mySmartUpload.setTotalMaxFileSize(20000000);//�����ϴ��ļ����ܳ���
mySmartUpload.upload();
com.jspsmart.upload.File myfile=mySmartUpload.getFiles().getFile(0);
java.io.File f=new java.io.File(filepath+"\\"+myfile.getFileName());
if(!myfile.isMissing())
{
	if(!f.exists()){
		myfile.saveAs(filepath+"\\"+myfile.getFileName());
		head=myfile.getFileName();
		out.print("�ϴ��ɹ�");
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
		out.print("�ϴ��ɹ�");
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
        	String userid=(String)session.getAttribute("userid");
            if(userid==null)response.sendRedirect("index.jsp");
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
          	  //���������ַ���,������GMT%2B8
          	    String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai";
          	  //�����ݿ⽨������
          	    Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	          	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
		        String email=mySmartUpload.getRequest().getParameter("useremail");
		        String name=mySmartUpload.getRequest().getParameter("username");
		        String nickname=mySmartUpload.getRequest().getParameter("usernickname");
		        String age=mySmartUpload.getRequest().getParameter("userage");
		        String pwd=mySmartUpload.getRequest().getParameter("userpwd");
		      	String phone=mySmartUpload.getRequest().getParameter("userphone");
		      	String address=mySmartUpload.getRequest().getParameter("useraddress");
		      	String city=mySmartUpload.getRequest().getParameter("usercity");
		      	String sql="update myuser set "+((name==null)?"":(" name='"+name+"'"))+((nickname==null)?"":(",nickname='"+nickname+"'"))
      			+((email==null)?"":(" ,email='"+email+"'"))
      			+((age==null||age.equals(""))?(",age=null"):(" ,age='"+age+"'"))+((pwd==null)?"":(",pwd='"+pwd+"'"))
      			+((phone==null)?"":(",phone='"+phone+"'"))+((address==null)?"":(",address='"+address+"'"))
      			+((city==null||("null".equals(city)))?",city=null":(" ,city='"+city+"'"))
      			+((head==null)?"":(",head='"+head+"'"))+" where id='"+userid+"'";
		      	int result=st.executeUpdate(sql);
		      	if(result==0){
		      		java.io.File f=new java.io.File(filepath+head);//�������ʧ�ܵ����ļ��Ѿ��ϴ��ɹ��ˣ�����Ҫɾ��
		        	if(!f.exists()){
		        		f.delete();
		        		out.print("ɾ���ɹ�");
		        	}
		      		out.print("<script>alert('����ʧ��');window.location.href='userimf.jsp';</script>");
		      	}
		      	st.close();
				conn.close();
				response.sendRedirect("userimf.jsp");
        }
        catch(Exception e)
        {
        	out.print(e);
        	e.printStackTrace();
        	java.io.File f=new java.io.File(filepath+head);//�������ʧ�ܵ����ļ��Ѿ��ϴ��ɹ��ˣ�����Ҫɾ��
        	if(!f.exists()){
        		f.delete();
        		out.print("ɾ���ɹ�");
        	}
        }
        %>
</body>
</html>