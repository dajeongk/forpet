<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>게시판</title>

	<%@include file="/WEB-INF/views/include/common.jsp" %>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <style>
      .uploadResult {
        width: 100%;
        background-color: gray;
      }
      
      .uploadResult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
      }
      
      .uploadResult ul li {
        list-style: none;
        padding: 10px;
      }
      
      .uploadResult ul li img {
        width: 100px;
      }
    </style>
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
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

<div class="container mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
  <h3 style="text-align: center; font-weight: bold; color: #2C4B7B;">문의 작성</h3><br>
  <div class="border row">
    <div class="col-12">
      <form id="boardForm" action="boardWrite" method="post" class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
        <div class="form-group">
          <label for="brd_title">제목</label>
          <select class="form-control w-25" name="brd_title" id="brd_title">
            <option value="상품 문의입니다.">상품 문의입니다.</option>
            <option value="배송 문의입니다.">배송 문의입니다.</option>
            <option value="기타 문의입니다.">기타 문의입니다.</option>
          </select>
        </div>
        <div class="form-group">
          <label for="brd_content">문의 내용</label>
          <textarea class="form-control" id="brd_content" name="brd_content"  rows="5"></textarea>
        </div>   
        <div class="form-group mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto" style="text-align: center;">
          <button type="button" id="btnCancel" class="btn btn-outline-secondary">취소</button>
          <button type="submit" class="btn btn-outline-primary">등록</button>
        </div>
        
      </form>
    </div>
  </div>
    
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>

  <script>
  
    $(function(){

      /* 취소 선택 */
      $("#btnCancel").on("click", function(){

        location.href = "/user/board/boardList";
        
      });


    });
   
  
  </script>

    
  </body>
</html>

