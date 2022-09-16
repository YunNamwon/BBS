<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbeans" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>


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
	if(userID == null){
		PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('로그인을 하시오.')");
		wr.println("location.href = 'login.jsp'");
		wr.println("</script>");
	} else{
		if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
					PrintWriter wr = response.getWriter();
					wr.println("<script>");
					wr.println("alert('입력하지 않은 목록 확인.')");
					wr.println("history.back()");
					wr.println("</script>");
				} else{
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
					if(result == -1){
						PrintWriter wr = response.getWriter();
						wr.println("<script>");
						wr.println("alert('글쓰기 실패.')");
						wr.println("history.back()");
						wr.println("</script>");
					}
					else {
						PrintWriter wr = response.getWriter();
						wr.println("<script>");
						wr.println("location.href = 'bbs.jsp'");
						wr.println("</script>");
					}
				}

	}
			
	%>	
</body>
</html>