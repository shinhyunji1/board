<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<title> JSP 게시판 웹 사이트</title>

		<style type="text/css">
		  a, a:hover{
		    color: #000000;
		    text-decoration: none;
		  }
		</style>

</head>
<body>

  <%
    //메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
    String id = null;
	  if(session.getAttribute("id") != null){
	    id = (String)session.getAttribute("id");
	  }
	  int pageNumber = 1;
	  if (request.getParameter("pageNumber") != null){
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	  }
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
	      <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
	         <thead>
	           <tr>
	               <th style="backgroud-color: #eeeeee; text-align: center;">번호</th>
	               <th style="backgroud-color: #eeeeee; text-align: center;">제목</th>
	               <th style="backgroud-color: #eeeeee; text-align: center;">작성자</th>
	               <th style="backgroud-color: #eeeeee; text-align: center;">작성일</th>
	           </tr>
	         </thead>
	         <tbody>
	         
	         <%
	           BoardDAO boardDAO = new BoardDAO();
	           ArrayList<Board> list = boardDAO.getList(pageNumber);
	           for (int i = 0; i < list.size(); i++){
	         %>
	           <tr>
	             <td><%= list.get(i).getNo() %></td>
	             <td><a href = "view.jsp?no=<%= list.get(i).getNo() %>"><%= list.get(i).getTitle().replaceAll(" ", "&nbsp;")
	                 .replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
	             <td><%= list.get(i).getId() %></td>
	             <td><%= list.get(i).getDate().substring(0,11) + list.get(i).getDate().substring(11, 13) + "시" + list.get(i).getDate().substring(14, 16) + "분" %></td>
	           </tr>
	           <%
	           }
	           %>
	         </tbody>
	      </table>
	      
	      <!-- 페이징 처리 영역 -->
		      <%
		        if(pageNumber != 1){
		      %>
		        <a href="board.jsp?pageNumber=<%=pageNumber - 1 %>"
		          class="btn btn-success btn-arraw-left">이전</a>
		      <%
		        }if(boardDAO.nextPage(pageNumber + 1)){
		      %>
		        <a href="board.jsp?pageNumber=<%=pageNumber + 1 %>"
		          class="btn btn-success btn-arraw-left">다음</a>
		      <%
		        }
		      %>
	      
	      <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
      </div>
   </div>
   
   
   <script src="https://code.jquery.com/jquery-3.3.7.min.js"></script>
   <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   <script src="js/bootstrap.js"></script>
   
</body>
</html>