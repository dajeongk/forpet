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
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

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
    
    
	<style>
	/* 페이지네이션 css */
	.page-link {
	  color: #000; 
	  background-color: #fff;
	  border: 1px solid #ccc; 
	}
	
	.page-item.active .page-link {
	 z-index: 1;
	 color: #555;
	 font-weight:bold;
	 background-color: #f1f1f1;
	 border-color: #ccc;
	 
	}
	
	.page-link:focus, .page-link:hover {
	  color: #000;
	  background-color: #fafafa; 
	  border-color: #ccc;
	}
	</style>
    	
  </head>
  <body>
  
<!-- 헤더 -->
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

<div class="container-fluid" align="center">
  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
  <br><h3 style="font-weight: bold; color: #2C4B7B;" >문의 게시판</h3><br>
  
  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
    <div align="left">
    <form id="boardListForm" action="/user/board/boardList" method="get" class="form-inline">
	  <select name="type" class="form-control mr-sm-2">
		  <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }" />>제목</option>
		  <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }" />>내용</option>
		  <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }" />>작성자</option>
		  <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }" />>제목+내용</option>
		  <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }" />>제목+작성자</option>
		  <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }" />>제목+작성자+내용</option>
	  </select>
	  <input type="text" name="keyword" value="${pageMaker.cri.keyword }" class="form-control mr-sm-2">
	  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	  <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	  <button type="button" id="btnSearch" class="btn btn-light">검색</button>	  
    </form>
    </div>
  </div>
  
  
  <table class="table" style="text-align: center;">
    <thead>
	  <tr>
        <th scope="col">글번호</th>
        <th scope="col">제목</th>
        <th scope="col">작성자</th>
        <th scope="col">등록일</th>     
	  </tr>
	  </thead>
	  <tbody>
	    <c:forEach items="${boardList }" var="board">
	    <tr>
	      <th scope="row"><c:out value="${board.brd_number }" /></th>
	      <td>
	        <a class="move" href="${board.brd_number }" style="color: black;">
	          <c:out value="${board.brd_title }" escapeXml="true" />
	        </a>
	      </td>
	      <td><c:out value="${board.mem_id }" /></td>
	      <td><fmt:formatDate value="${board.brd_date }" pattern="yyyy-MM-dd hh:mm" /></td>
	    </tr>
	    </c:forEach>
	  </tbody>
  </table>
   
  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">	
    <nav aria-label="...">
	  <ul class="pagination justify-content-center">
	    <!-- 이전표시 -->
	    <c:if test="${pageMaker.prev }">
		  <li class="page-item">
		    <a class="page-link" href="${pageMaker.startPage - 1 }">&lt;&lt;</a>
	      </li>
	    </c:if>
	    
	    <!-- 페이지번호 표시.  1  2  3  4  5 -->
        <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num" >
          <li class='page-item ${pageMaker.cri.pageNum == num ? "active": "" }'><a class="page-link" href="${num}">${num}</a></li>
	    </c:forEach>
	   
	   	<!-- 다음표시 -->
	      <c:if test="${pageMaker.next }">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.endPage + 1 }">&gt;&gt;</a>
		    </li>
	      </c:if>
	  </ul>
	  
	  <!-- 페이지 번호 클릭시 boardList주소로 보낼 파라미터 작업 -->
      <form id="actionForm" action="/user/board/boardList" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">			
		<input type="hidden" name="type" value="${pageMaker.cri.type}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	  </form>
    </nav>
  </div>
</div>

  <!-- 풋터 -->		
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>

  <script>
  
	$(document).ready(function(){
		
		let boardListForm = $("#boardListForm"); 
		
		let actionForm = $("#actionForm");
		
		/* 페이지 번호 클릭시 동작 */
		$("ul.pagination li a.page-link").on("click", function(e) {
			
			e.preventDefault(); 

			// 현재 선택한 페이지번호 변경작업.  
			let pageNum = $(this).attr("href");
			
			actionForm.find("input[name='pageNum']").val(pageNum);	
			actionForm.attr("action", "/user/board/boardList");
	
			actionForm.submit();
	
		});
			
		/* 목록에서 제목을 클릭시 */
		$("a.move").on("click", function(e) {
	
			e.preventDefault(); 
			
			let brd_number = $(this).attr("href");
	
			boardListForm.find("input[name='brd_number']").remove();
	
			boardListForm.append("<input type='hidden' name='brd_number' value='" + brd_number + "'>");
			boardListForm.attr("action", "/user/board/boardGet");
	
			boardListForm.submit();
	
		});
		
		/* 상품문의 작성 버튼 클릭 */
        $("#boardWrite").on("click", function(){

          location.href = "/user/board/boardWrite";
          
        });
	
        	
		/* 검색버튼 클릭시 pageNum 초기화 */
		$("#btnSearch").on("click", function(){

			boardListForm.find("input[name='pageNum']").val(1);
	    	boardListForm.submit();
	      
	    });
		
		
	});

  </script>


  </body>
</html>

