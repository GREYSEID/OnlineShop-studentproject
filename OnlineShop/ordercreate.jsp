<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="javax.swing.*,java.io.*,java.util.*,javax.servlet.*,java.net.*,java.sql.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>��������</title>
</head>

<body>
	<%
String userid=(String)session.getAttribute("userid");
if(userid==null)out.print("<script>window.location.href='loginregister.html'</script>");
request.setCharacterEncoding("gb18030");
String address=request.getParameter("address");
String name=request.getParameter("name");
String phone=request.getParameter("phone");
String[] goodslist=request.getParameterValues("goods");
String[] numlist=request.getParameterValues("num");
float[]pricelist=new float[goodslist.length];//ÿ����Ʒ��Ӧ�ļ۸�
float[]countlist=new float[goodslist.length];//ÿ���������ܼ�
String[]goodsstoreidlist=new String[goodslist.length];//ÿ���̵��Ӧ���̵�id
Map<String, String> storemap = new HashMap<String,String>();
String[]goodsstr=new String[goodslist.length];
String[]numstr=new String[goodslist.length];
String[]pricestr=new String[goodslist.length];
String[]storename=new String[goodslist.length];//�̵�
int storenum=0;//�̵���������������
try{
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	//���������ַ���,������GMT%2B8
	String url ="jdbc:mysql://localhost:3306/company?useSSL=FALSE&serverTimezone=Asia/Shanghai"; 
	//�����ݿ⽨������
	Connection conn= DriverManager.getConnection(url,"root","yuan1234");
	Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);//��������Ĭ�ϵĻ�rsֻ����next()
	String s="select A.*,B.store from goods A ,storeacc B where A.storeid=B.storeid and ( id="+goodslist[0];
	for(int i=1;i<goodslist.length;i++)//��֪��ɸѡ��������᲻�����
	{
		s+=" or id="+goodslist[i];
	}
	s+=" )";
	ResultSet rs=st.executeQuery(s);
	String nowstore="";
	while(rs.next())
	{
		if(!nowstore.equals(rs.getString("storeid"))){
			storemap.put(rs.getString("storeid"),""+storenum);
			storename[storenum]=rs.getString("storeid");
			storenum++;
			nowstore=rs.getString("storeid");
		}
		for(int i=0;i<goodslist.length;i++)
		{
			if(goodslist[i].equals(rs.getString("id"))){
				pricelist[i]=Float.parseFloat(rs.getString("price"));
				goodsstoreidlist[i]=rs.getString("storeid");
				if(Integer.parseInt(numlist[i])>Integer.parseInt(rs.getString("count")))out.print("<script>alert('id"+goodslist[i]+"��治��'); window.location.href = 'Cart.jsp';</script>");
			}
		}
	}
	for(int i=0;i<goodslist.length;i++)
	{
		String wherestore=storemap.get(goodsstoreidlist[i]);
		int whestore=Integer.parseInt(wherestore);
		if(goodsstr[whestore]==null)goodsstr[whestore]=""+goodslist[i]+"|";
		else goodsstr[whestore]+=goodslist[i]+"|";
		if(numstr[whestore]==null)numstr[whestore]=""+numlist[i]+"|";
		else numstr[whestore]+=numlist[i]+"|";
		countlist[whestore]+=Float.parseFloat(numlist[i])*pricelist[i];
		Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		String sql="update goods set count=count-"+numlist[i]+" where id="+goodslist[i];//��ȥ��Ʒ��Ӧ����
		int result=stmt.executeUpdate(sql);
		if(result==0)out.print("<script>alert('��������ʧ��');window.location.href='Cart.jsp'</script>");
		stmt.close();
	}
	{
		Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet res=stmt.executeQuery("select address from myuser where id="+userid);//��ȡ��ַ��Ϣ
		res.next();
		if(address==null||"".equals(address))address=res.getString("address");
		if(name==null||"".equals(name))name=res.getString("name");
		if(phone==null||"".equals(phone))phone=res.getString("phone");
		res.close();
		stmt.close();
	}
	String[]orderid=new String[storenum];
	for(int i=0;i<storenum;i++)
	{
		String str="insert into orderlist(id,userid,storeid,goodslist,numlist,price,address,status,name,phone,time)values(?,?,?,?,?,?,?,?,?,?,?) ";
		PreparedStatement ps=conn.prepareStatement(str);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//��ȡʱ��
		String date=df.format(new java.util.Date());
		orderid[i]=Long.toString(System.currentTimeMillis());
		ps.setString(1, orderid[i]);
		ps.setString(2, userid);
		ps.setString(3, storename[i]);
		ps.setString(4, goodsstr[i]);
		ps.setString(5, numstr[i]);
		ps.setString(6, ""+countlist[i]);
		ps.setString(7, address);
		ps.setString(8,"��֧��");
		ps.setString(9,name);
		ps.setString(10,phone);
		ps.setString(11,date);
		ps.execute();
		ps.close();
	}
	String stri="pay.jsp?allprice="+request.getParameter("allprice")+"&"+"orderid="+orderid[0];//��ת��֧������
	for(int i=1;i<storenum;i++)
	{
		stri+="&orderid="+orderid[i];
	}
	rs.close();
	st.close();
	conn.close();
	//ɾ����������֮��Ĺ��ﳵ������
	Cookie goodscookie=null;
	Cookie[]cookies=null;
	Cookie numcookie=null;
	cookies=request.getCookies();
	String str="";
	String str1="";
	String[]goodslist1=null;//���ﳵ����Ʒ
	String[]numlist1=null;
	if(cookies!=null)
	{
		for(int i=0;i<cookies.length;i++)
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
			goodslist1=str.split("\\|");
			numlist1=str1.split("\\|");
			for(int n=0;n<goodslist.length;n++)
			{
				String strin="";
				String g="";
				for(int i=0;i<goodslist1.length;i++)//�ڹ��ﳵѰ�Ҷ����е���Ʒ
				{
					if(!goodslist1[i].equals(goodslist[n])){
						strin+=goodslist1[i]+"|";
						g+=numlist1[i]+"|";
					}
				}
				goodscookie.setValue(g);
				numcookie.setValue(strin);
				goodscookie.setMaxAge(60*60*24);
				numcookie.setMaxAge(60*60*24);
				response.addCookie(goodscookie);
				response.addCookie(numcookie);
			}
		}
	}
	response.sendRedirect(stri);
}
catch(Exception e)
{
	e.printStackTrace();
}
//response.sendRedirect("pay.jsp?allprice=")
%>
</body>

</html>