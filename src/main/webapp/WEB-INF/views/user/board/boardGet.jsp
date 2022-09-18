<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>forpet</title>

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
	
	<style>
	  .form-control[readonly] {
	    background-color: white;
	  
	  }
	</style>
	
  </head>
  <body>
    
<!-- 헤더 -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

<div class="container mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
  <h3 style="text-align: center; font-weight: bold; color: #2C4B7B;">문의내용</h3><br>
  <div class="border row">
    <div class="col-12 mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
     	<div class="form-group">       
     	  <label for="brd_title">제목</label>
          <input type="text" class="form-control" id="brd_title" name="brd_title" value="${board.brd_title }" readonly>
        </div>
        <div class="form-group row">
          <div class="col-5">
            <label for="mem_id">작성자</label>
            <input type="text" class="form-control" id="mem_id" name="mem_id" value="${board.mem_id }" readonly>
          </div>
          <div class="col-7">
            <label for="brd_date">작성일</label>
            <input type="text" class="form-control" id="brd_date" name="brd_date" value="<fmt:formatDate value="${board.brd_date }" pattern="yyyy-MM-dd hh:ss"/>" readonly>
          </div>
        </div>        
        <div class="form-group">
          <label for="brd_content">문의 내용</label>
          <textarea class="form-control" id="brd_content" name="brd_content"  rows="5" readonly>${board.brd_content }</textarea>
        </div>
        <div class="form-group row mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto" >
          <div class="col-6" style="text-align: left;">
            <button type="button" id="btn_delete" class="btn btn-outline-danger">삭제</button>                 
          </div>
          <div class="col-6" style="text-align: right;">
            <button type="button" id="btn_list" class="btn btn-outline-secondary">목록</button>
            <button type="button" id="btn_modify" class="btn btn-outline-primary">수정</button> 
          </div>
        </div>
		
		<!-- 수정버튼 클릭시 boardModify주소로 보낼 파라미터 작업  -->
		<form id="operForm" action="/user/board/boardModify" method="get">
		  <input type="hidden" name="brd_number" value="${board.brd_number}">
		  <input type="hidden" name="pageNum" value="${cri.pageNum}">
		  <input type="hidden" name="amount" value="${cri.amount}">
		  <input type="hidden" name="type" value="${cri.type}">
		  <input type="hidden" name="keyword" value="${cri.keyword}">
		</form>
		
    </div>
  </div>
  
  <!-- 풋터 -->  
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>

  <script>

    $(function(){

      /* 수정 버튼 클릭 */
      $("#btn_modify").on("click", function(){

        location.href = "/user/board/boardModify";
        
        operForm.submit();
        
      });

      /* 목록 버튼 클릭 */
      $("#btn_list").on("click", function(){
	  
          // 글번호, 페이징정보  
          let pageNum = $("input[name='pageNum']").val();
          let amount = $("input[name='amount']").val();
          let type = $("input[name='type']").val();
          let keyword = $("input[name='keyword']").val();
            
          location.href = "/user/board/boardList?type=" + type + "&keyword=" + keyword + "&pageNum=" + pageNum + "&amount=" + amount;
        
      });
      

      /* 삭제 버튼 클릭 */
      $("#btn_delete").on("click", function(){
          
          if(!confirm("문의글을 삭제하시겠습니까?")) return;

          $("#operForm").attr("action", "/user/board/boardDelete");
          $("#operForm").attr("method", "post");
          $("#operForm").submit();
          
          alert("삭제되었습니다.");

        });

    });
    
  </script>
    
  </body>
</html>

