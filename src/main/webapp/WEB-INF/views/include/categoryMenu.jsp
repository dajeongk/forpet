<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="border-top shadow-sm border-bottom shadow-sm">  
	<nav class="navbar navbar-expand-lg navbar-light">
	  <a class="navbar-brand font-weight-bold" href="#" style="color: #2C4B7B;">
	    <img src="/img/category.jpg" alt="..." style="width:24px;"> 카테고리
	  </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	 
	  <!-- 1차 카테고리 --> 	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <c:forEach items="${mainCategoryList }" var="categoryVO">
	      <li class="nav-item dropdown active">
	        <a class="nav-link dropdown-toggle font-weight-bold" href="${categoryVO.ctg_code }" role="button" data-toggle="dropdown" aria-expanded="false">
	          ${categoryVO.ctg_name }
	        </a>
	        <!-- 2차 카테고리 -->
	        <div class="dropdown-menu subCategory">
	        </div>
	      </li>
	      </c:forEach>
	    </ul>
	    <form id="searchForm" action="/search" method="get" class="form-inline my-2 my-lg-0">
	      <input type="text" name="keyword" value="${pageMaker.cri.keyword}" class="form-control mr-sm-2" placeholder="검색어를 입력해주세요." aria-label="Search">
	      <button class="btn btn-default my-2 my-sm-0" type="submit">
	        <img src="/img/search.png" style="width: 25px; height: 25px;">
	      </button>
	    </form>
	    <!--페이지 번호 클릭시 list주소로 보낼 파라미터 작업-->
		<form id="actionForm" action="" method="get">
		  <input type="hidden" name="ctg_code" value="${ctg_code}">
	      <input type="hidden" name="ctg_name" value="${ctg_name}"> 
		  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		  <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		  <input type="hidden" name="type" value="${pageMaker.cri.type}">
		  <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	  </div>
	</nav>
</div>

  <script>

	$(function(){
  
	  /* 1차 카테고리 클릭 */
	  $("ul.navbar-nav li.nav-item a").on("click",function(){
  
		let selectedCategory = $(this);
		let url = "/user/product/subCategoryList/" + $(this).attr("href");
  
		
		$.getJSON(url, function(result){ // result : 2차 카테고리 정보
  
		  // 2차 카테고리 추가
		  let subCategoryList = selectedCategory.next(); // <div> 태그
		  subCategoryList.children().remove(); // <a>태그 모두 제거
  
		  let subCategoryStr = "";
  
		  for(let i=0; i<result.length; i++) {
  
			// jQuery문법을 사용하여 이벤트 적용을 통한 주소요청
			subCategoryStr += "<a class='dropdown-item' href='" + result[i].ctg_code + "'>" + result[i].ctg_name + "</a>";
		  }

		  subCategoryList.append(subCategoryStr);
 
		});
  
	  });
  
		/* 2차 카테고리 클릭 */
		$("ul.navbar-nav li.nav-item div.subCategory").on("click", "a", function(e){
		  e.preventDefault();
  
		  let ctg_code = $(this).attr("href");
		  let ctg_name = $(this).text();
		  
		  location.href = "/user/product/productList/" + ctg_code + "/" + encodeURIComponent(ctg_name);
  
		});
  
	});
  
  </script>