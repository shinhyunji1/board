<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> JSP 게시판 웹 사이트</title>
</head>
<body>
   <%
   
		   String id = null;
		   if(session.getAttribute("id") != null){
		     id = (String)session.getAttribute("id");
		   }
		   
		   if(id == null){
		       PrintWriter script = response.getWriter();
		       script.println("<script>");
		       script.println("alert('로그인을 하세요.')");
		       script.println("location.href='login.jsp'");
		       script.println("</script>");
		     } 
		   
		   int no = 0;
		    if (request.getParameter("no") != null){
		      no = Integer.parseInt(request.getParameter("no"));
		    }
		    
		    if (no == 0){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('유효하지 않는 글입니다.')");
		      script.println("location.href='board.jsp'");
		      script.println("</script>");
		    }
		    
		    Board board = new BoardDAO().getBoard(no);
		    if (!id.equals(board.getId())) {
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('권한이 없습니다.')");
		      script.println("location.href='board.jsp'");
		      script.println("</script>");
		    } else {
		      if(request.getParameter("title") == null || request.getParameter("content") == null
		          || request.getParameter("title").equals("") || request.getParameter("content").equals("")){
		             PrintWriter script = response.getWriter();
		             script.println("<script>");
		             script.println("alert('나머지 기입해주세요.')");
		             script.println("history.back()");
		             script.println("</script>");
		           } else {
		             
		             BoardDAO boardDAO = new BoardDAO();
		             int result = boardDAO.update(no, request.getParameter("title"), request.getParameter("content"));
		             if (result == -1) {
		               PrintWriter script = response.getWriter();
		               script.println("<script>");
		               script.println("alert('글 수정에 실패했습니다.')");
		               script.println("history.back()");
		               script.println("</script>");
		               
		             } else {
		               PrintWriter script = response.getWriter();
		               script.println("<script>");
		               script.println("location.href='board.jsp'");
		               script.println("</script>");
		               
		             }
		             
		           }
		       
		     }
   
      
   
  
 %>
   
</body>
</html>