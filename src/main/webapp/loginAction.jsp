<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>

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
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){
			session.setAttribute("userID", user.getUserID());
			PrintWriter wr = response.getWriter();
			wr.println("<script>");
			wr.println("location.href = 'main.jsp' ");
			wr.println("</script>");
		}
		else if(result == 0){
			PrintWriter wr = response.getWriter();
			wr.println("<script>");
			wr.println("alert('비밀번호가 틀립니다.')");
			wr.println("history.back()");
			wr.println("</script>");
		}
		else if(result == -1){
			PrintWriter wr = response.getWriter();
			wr.println("<script>");
			wr.println("alert('존재하지 않는 아이디입니다.')");
			wr.println("history.back()");
			wr.println("</script>");
		}
		else if(result == -2){
			PrintWriter wr = response.getWriter();
			wr.println("<script>");
			wr.println("alert('데이터베이스 오류.')");
			wr.println("history.back()");
			wr.println("</script>");
		}
	%>	
</body>
</html>