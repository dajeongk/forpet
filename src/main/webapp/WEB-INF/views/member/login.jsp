<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>forpet</title>
	<meta name="theme-color" content="#563d7c">
	<%@include file="/WEB-INF/views/include/common.jsp" %>
	
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
   
    <script>
    
    	let msg = "${msg}";
    	if(msg == "idFail") {
    		alert("아이디를 확인하세요.");
    	}else if(msg == "pwFail") {
    		alert("비밀번호를 확인하세요.");
    	}
    
    </script>
    
  </head>
  <body>

<!-- 헤더 -->    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

<div class="container">
  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto" align="center">
	<br><h2 style="font-weight: bold; color: #2C4B7B;">로그인</h2><br>
	
    <div>
    <form id="loginForm" action="login_ok" method="post">
      <div class="form-group">
        <div class="col-sm-6">
        <input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="아이디">
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-6">
        <input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="비밀번호">
        </div>
      </div>
      <div class="form-group">
        <a href="/member/findID" class="text-dark">아이디 찾기</a> |
        <a href="/member/findPW" class="text-dark">비밀번호 찾기</a>
      </div>
      <div class="form-group">
        <div class="col-sm-6">
          <button type="submit" class="btn btn-secondary disabled btn-lg btn-block"  id="btnLogin">로그인</button>
        </div>	
      </div>  
    </form>		
	</div>

  </div>

<!-- 풋터 -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>  

  <script>
   
  $(document).ready(function(){

    let loginForm = $("#loginForm");

    // 로그인 버튼 클릭 : 로그인 정보 전송
    $("#btnLogin").on("submit", function(){

      // 유효성 검사
      if($("#mem_id").val() == "") {
        alert("아이디를 입력하세요.");
        $("#mem_id").focus();
        return false;
      }

      if($("#mem_pw").val() == "") {
        alert("비밀번호를 입력하세요.");
        $("#mem_pw").focus();
        return false;
      }

      return true;
    });
    
  });
    
  </script>

  </body>
</html>
    