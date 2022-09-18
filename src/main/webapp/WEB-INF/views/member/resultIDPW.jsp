<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
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
    
  </head>
  <body>
  
<!-- 헤더 -->    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>


<div class="container" align="center">
  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
    <div class="form-group">
  
  	  <c:if test="${mem_id != null }">
      <br><h3 style="font-weight: bold; color: #2C4B7B;">ID 찾기 결과</h3><br>
  	  <p> 회원님께서 가입하신 아이디입니다. </p><br>
  	   	  ID : ${mem_id }  
  	  </c:if>
  	
  	  <c:if test="${mail != null }">
  	  <br><h3 style="font-weight: bold; color: #2C4B7B;">임시비밀번호 발급</h3><br>
  	  <p>이메일로 임시비밀번호를 발송했습니다.</p>
  	  </c:if>
  	
    </div>
  </div>

  <!-- 풋터 -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>

<%@include file="/WEB-INF/views/include/common.jsp" %>
    

  </body>
</html>
    