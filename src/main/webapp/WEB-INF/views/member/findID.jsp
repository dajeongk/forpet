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
    	
    	if('${msg}' == 'noID'){
    		alert("회원정보와 일치하는 아이디가 없습니다.");
    	}
    
    </script>
    
  </head>
  <body>

<!-- 헤더 -->    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

<div class="container mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto" align="center">
  <br><h3 style="font-weight: bold; color: #2C4B7B;">아이디 찾기</h3><br>
  <form id="findIDForm" action="findID" method="post">
    <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
	  <label class="form-check-label" for="inlineRadio1">이메일</label>
	</div>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
	  <label class="form-check-label" for="inlineRadio2">휴대폰 번호</label>
	</div>
	
  	<div class="form-group">
  	  <div class="col-sm-6">
  	    <input type="text" class="form-control" id="mem_name" name="mem_name" value="이름"> 
  	  </div>
  	</div>
  	<div class="form-group">
  	  <div class="col-sm-6">
  	    <input type="email" class="form-control" id="mem_email" name="mem_email" value="이메일"> 
  	  </div>
  	</div>
  	<div class="form-group">
  	  <div class="col-sm-6">
  	    <button type="submit" class="btn btn-secondary btn-lg btn-block disabled" id="btnfindID">아이디 찾기</button>	
  	  </div>
  	</div>
  </form>


  <!-- 풋터 -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    

  </body>
</html>
    