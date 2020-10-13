<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="GB18030">
	<title>注销</title>
</head>

<body>
	<%String userid=(String)session.getAttribute("userid");
String storeid=(String)session.getAttribute("storeid");
String action=request.getParameter("action");
if(userid==null&&storeid==null){
	if("2".equals(action))out.print("<span>用户未登录</span><script>alert(\"用户未登录\");window.location.href='storeLogin.html';</script>");
	else out.print("<span>用户未登录</span><script>alert(\"用户未登录\");window.location.href='loginregister.html';</script>");
}
else {
	session.invalidate();
	if("2".equals(action)){
		out.println("注销成功，删除账号请联系管理员"+"<a href='mailto:greyseid@hotmail.com'>greyseid@hotmail.com</a>");
		response.setHeader("Refresh", "3;url=goodsManage.jsp");
	}
	else{out.println("注销成功，删除账号请联系管理员"+"<a href='mailto:greyseid@hotmail.com'>greyseid@hotmail.com</a>");
	response.setHeader("Refresh", "3;url=index.jsp");//延时5s跳转
	}
	//response.sendRedirect("index.jsp");
}
%>
</body>

</html>