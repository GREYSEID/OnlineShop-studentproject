<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>ע��</title>
</head>

<body>
	<%String userid=(String)session.getAttribute("userid");
String storeid=(String)session.getAttribute("storeid");
String action=request.getParameter("action");
if(userid==null&&storeid==null){
	if("2".equals(action))out.print("<span>�û�δ��¼</span><script>alert(\"�û�δ��¼\");window.location.href='storeLogin.html';</script>");
	else out.print("<span>�û�δ��¼</span><script>alert(\"�û�δ��¼\");window.location.href='loginregister.html';</script>");
}
else {
	session.invalidate();
	if("2".equals(action)){
		out.println("ע���ɹ���ɾ���˺�����ϵ����Ա"+"<a href='mailto:greyseid@hotmail.com'>greyseid@hotmail.com</a>");
		response.setHeader("Refresh", "3;url=goodsManage.jsp");
	}
	else{out.println("ע���ɹ���ɾ���˺�����ϵ����Ա"+"<a href='mailto:greyseid@hotmail.com'>greyseid@hotmail.com</a>");
	response.setHeader("Refresh", "3;url=index.jsp");//��ʱ5s��ת
	}
	//response.sendRedirect("index.jsp");
}
%>
</body>

</html>