<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>�̼�insert</title>
</head>

<body>
	<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
	<%
//request.setCharacterEncoding("GB18030");
int count=1;
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
Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//���������ַ���,������GMT%2B8
String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
//�����ݿ⽨������
Connection conn= DriverManager.getConnection(url,"root","yuan1234");
String id=mySmartUpload.getRequest().getParameter("id");
String email=mySmartUpload.getRequest().getParameter("email");
String name=mySmartUpload.getRequest().getParameter("name");
String pwd=mySmartUpload.getRequest().getParameter("pwd");
String phone=mySmartUpload.getRequest().getParameter("phone");
String address=mySmartUpload.getRequest().getParameter("address");
String city=mySmartUpload.getRequest().getParameter("city");
Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
ResultSet rs=st.executeQuery("select storeid from storeacc where storeid="+"\""+id+"\"");
rs.last();
int last=rs.getRow();
if(last==0)
{
	PreparedStatement ps=conn.prepareStatement("insert into storeacc(storeid,email,store,storepwd,phone,address,city,picture)values(?,?,?,?,?,?,?,?)");
	ps.setString(1,(id));
	ps.setString(2,"".equals(email)?null:email);
	ps.setString(3,"".equals(name)?null:name);
	ps.setString(4,(pwd));
	ps.setString(5,("".equals(phone)?null:phone));
	ps.setString(6,("".equals(address)?null:address));
	ps.setString(7,(city));
	ps.setString(8, head);
	ps.execute();
	ps.close();
	session.setAttribute("storeid", id);
	response.sendRedirect("goodsManage.jsp");
}
else{
	java.io.File f=new java.io.File(filepath+"\\"+head);//���ע��ʧ�ܵ����ļ��Ѿ��ϴ��ɹ��ˣ�����Ҫɾ��
	if(!f.exists()){
		f.delete();
	}
	out.println("<script>alert('�û����Ѵ���');window.location.href='storecurrentregister.jsp';</script>");
	}
rs.close();
st.close();
conn.close();
}
catch(Exception e)
{
	java.io.File f=new java.io.File(filepath+"\\"+head);//���ע��ʧ�ܵ����ļ��Ѿ��ϴ��ɹ��ˣ�����Ҫɾ��
	if(!f.exists()){
		f.delete();
	}
	e.printStackTrace();
	out.print("<script>alert('error'); window.location.href = 'storecurrentregister.jsp'");
}
%>
</body >

</html >