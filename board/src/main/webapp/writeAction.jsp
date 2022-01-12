<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="title" />
<jsp:setProperty name="board" property="content" />

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
		     } else {
		       if (board.getTitle() == null || board.getContent() == null) {
		             
		             PrintWriter script = response.getWriter();
		             script.println("<script>");
		             script.println("alert('나머지 기입해주세요.')");
		             script.println("history.back()");
		             script.println("</script>");
		           } else {
		             
		             BoardDAO boardDAO = new BoardDAO();
		             int result = boardDAO.write(board.getTitle(), id, board.getContent());
		             if (result == -1) {
		               PrintWriter script = response.getWriter();
		               script.println("<script>");
		               script.println("alert('글쓰기에 실패했습니다.')");
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