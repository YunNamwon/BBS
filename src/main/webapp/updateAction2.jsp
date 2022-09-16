<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbeans" %>
<%@ page import = "java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

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
	} 
	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	 if(bbsID == 0){
		PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('유효하지 않는 글입니다.')");
		wr.println("location.href = 'bbs.jsp'");
		wr.println("</script>");
	} 
	Bbeans bbs = new BbsDAO().getBbs(bbsID);
	if(!userID.equals(bbs.getUserID())){
		PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('권한이 없습니다.')");
		wr.println("location.href = 'bbs.jsp'");
		wr.println("</script>");
	} else{
		if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
				|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
					PrintWriter wr = response.getWriter();
					wr.println("<script>");
					wr.println("alert('입력하지 않은 목록 확인.')");
					wr.println("history.back()");
					wr.println("</script>");
				} else{
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
					if(result == -1){
						PrintWriter wr = response.getWriter();
						wr.println("<script>");
						wr.println("alert('수정 실패.')");
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