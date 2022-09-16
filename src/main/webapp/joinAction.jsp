<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID")!= null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('이미 로그인이 되어있습니다.')");
		wr.println("location.href = 'main.jsp'");
		wr.println("</script>");
	}
	
		if(user.getUserID() == null || user.getUserPassword() == null ||user.getUserName() == null 
		||user.getUserGender() == null ||user.getUserEmail() == null){
			PrintWriter wr = response.getWriter();
			wr.println("<script>");
			wr.println("alert('입력하지 않은 목록 확인.')");
			wr.println("history.back()");
			wr.println("</script>");
		} else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter wr = response.getWriter();
				wr.println("<script>");
				wr.println("alert('이미 존재하는 아이디입니다.')");
				wr.println("history.back()");
				wr.println("</script>");
			}
			else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter wr = response.getWriter();
				wr.println("<script>");
				wr.println("location.href = 'main.jsp'");
				wr.println("</script>");
			}
		}	
	%>	
</body>
</html>