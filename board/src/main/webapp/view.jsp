<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<title> JSP 게시판 웹 사이트</title>
</head>
<body>

  <%
    //메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
    String id = null;
    if(session.getAttribute("id") != null){
      id = (String)session.getAttribute("id");
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
  %>

   <nav class="navbar navbar-default">
        <div class="navbar-header">
             <button type="button" class="navbar-toggle collapsed"
             data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
             aria-expanded="false">
             <span class="icon-bar"></span>
             <span class="icon-bar"></span>
             <span class="icon-bar"></span>
             </button>
             <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li>
            <li class="active"><a href="board.jsp">게시판</a></li>
          </ul>
          
          <%
            // 로그인 하지 않았을 때 보여지는 화면
            if(id == null){
          %>
          
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" 
              data-toggle="dropdown" role="button" aria-haspopup="true" 
              aria-expanded="false">접속하기<span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="login.jsp">로그인</a></li>
                <li><a href="join.jsp">회원가입</a></li>
              </ul>    
            </li>
          </ul>
          
          <%
            // 로그인이 되어 있는 상태에서 보여주는 화면
            } else {
          %>
          
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" 
              data-toggle="dropdown" role="button" aria-haspopup="true" 
              aria-expanded="false">회원관리<span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="logoutAction.jsp">로그아웃</a></li>
              </ul>    
            </li>
          </ul>
          
          <%
            }
          %>
          
        </div>
   </nav>
   
   <div class="container">
      <div class="row">
        <form method="post" action="writeAction.jsp">
		        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
		           <thead>
		             <tr>
		                 <th colspan="2" style="backgroud-color: #eeeeee; text-align: center;">게시판 글쓰기 보기</th>
		             </tr>
		           </thead>
		           <tbody>
		             <tr>
		               <td style="width: 20%">글 제목</td>
		               <td colspan="2"><%= board.getTitle().replaceAll(" ", "&nbsp;")
                .replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
		             </tr>
		             <tr>
                   <td>작성자</td>
                   <td colspan="2"><%= board.getId() %></td>
                 </tr>
		             <tr>
                   <td>작성일자</td>
                   <td colspan="2"><%= board.getDate().substring(0,11) + board.getDate().substring(11, 13) + "시" + board.getDate().substring(14, 16) + "분" %></td>
                 </tr>
		             <tr>
                   <td>내용</td>
                   <td colspan="2" style="height: 200px; text-align: left;"><%= board.getContent().replaceAll(" ", "&nbsp;")
              .replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                 </tr>
		           </tbody>
		        </table>
		        <a href ="board.jsp" class="btn btn-primary">목록</a>
		        
		        <%
		          if (id != null && id.equals(board.getId())){
		        %>
		        
		          <a href ="update.jsp?no=<%=no %>" class="btn btn-primary">수정</a>
		          <a onclick="return confirm('정말로 삭제하시겠습니까?')" href ="deleteAction.jsp?no=<%=no %>" class="btn btn-primary">삭제</a>
		        
		        <%
		          }
		        %>
        </form>
      </div>
   </div>
   
   
   <script src="https://code.jquery.com/jquery-3.3.7.min.js"></script>
   <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   <script src="js/bootstrap.js"></script>
   
</body>
</html>