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
    
    	if('${msg}' == "noPW") {
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
  <br><h2 style="font-weight: bold; color: #2C4B7B;">비밀번호 확인</h2><br>
  <p>회원님의 소중한 개인정보 보호를 위해 <br>
          비밀번호 확인 후 변경이 가능합니다. </p><br>
          
  <div class="form-group">
    <form id="confirmPWForm" action="confirmPW" method="post">
      <div class="form-group">
        <div class="w-50">
        <input type="text" class="form-control" id="mem_id" name="mem_id" value="${sessionScope.loginStatus.mem_id }" readonly>
        </div>
      </div>
      <div class="form-group">
        <div class="w-50">
        <input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="비밀번호" required>
        </div>
      </div>
      <div class="form-group">
        <div class="w-50">
        <button type="submit" class="btn btn-secondary disabled btn-lg btn-block" id="btnconfirmPW">확인</button>
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

      /* 비밀번호 확인 버튼 클릭 */
      $("#btnconfirmPW").on("submit", function(){

        return true;
      });
      
    });

  </script>

  </body>
</html>
    