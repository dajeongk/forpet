<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
    
    <%@include file="/WEB-INF/views/include/common.jsp" %>
    
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
	
	/* 테이블 css */
	.table td {
      vertical-align: middle;
    }
    
    .form-control {
      display: inline;
    }
	</style>
    
  </head>
  <body>
    
<!-- 헤더 -->
<%@include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

<div class="container-fluid">
  <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
    <br><br>
    <h3 style="font-weight: bold; color: #2C4B7B;">주문내역 조회</h3>
  </div>
  
  <div class="box-body">
    <div align="center">
      <div class="px-3 py-3 pt-md-5 pb-md-4 mx-auto text-left">
        <form id="searchForm" action="/user/order/orderDetailList" method="get">
		    
	           주문일 <input type="date" name="startDate"> ~ <input type="date" name="endDate">
		    
	      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	      <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	          
	      <button type="button" id="btnSearch" class="btn btn-light">조회</button>
 
	    </form>
	  </div>
      <table class="table" id="orderProductInfo">
        <thead class="thead-light" style="text-align: center;">
          <tr>
            <th scope="col">주문번호</th>
            <th scope="col">주문일</th>
            <th scope="col">이미지</th>	
            <th scope="col">상품명</th>
            <th scope="col">판매가</th>
            <th scope="col">수량</th>
            <th scope="col">총 구매금액</th>
            <th scope="col">배송처리상태</th>
            <th scope="col">주문처리상태</th>
          </tr>
        </thead>
        <tbody style="text-align: center;">
        <c:forEach items="${orderProductMap }" var="orderProduct">
          <tr><!-- Map의 키를 대문자로 사용(컬럼명) -->
            <td scope="col">${orderProduct.ODR_NUMBER }</td>
            <td><fmt:formatDate value="${orderProduct.ODR_DATE }" pattern="yyyy-MM-dd hh:mm" /></td>
            <td scope="col">	        
              <img src="/user/order/displayFile?folderName=${orderProduct.PDT_IMG_FOLDER }&fileName=s_${orderProduct.PDT_IMG }" 
       	           alt="..." style="width: 100; height: 100;" onerror="this.onerror=null; this.src='/img/noImage.png'">
            </td>
            <td scope="col">${orderProduct.PDT_NAME }</td>
            <td scope="col"><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderProduct.PDT_PRICE }"></fmt:formatNumber> 원</td>
            <td scope="col">${orderProduct.ODR_AMOUNT } 개</td>
            <td scope="col"><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderProduct.ODR_PRICE }"></fmt:formatNumber> 원</td>
            <td scope="col">${orderProduct.ODR_STATUS }</td>
            <td scope="col">${orderProduct.PAY_STATUS }</td>
          </tr>	
        </c:forEach>	      
        </tbody>    
      </table>
      
      <div class="px-3 py-3 pt-md-5 pb-md-4 mx-auto">
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
    
        <!--페이지 번호 클릭시 orderDetailList주소로 보낼 파라미터 작업-->
        <form id="actionForm" action="/user/order/orderDetailList" method="get">
          <input type="hidden" name="startDate" value="${startDate}">
          <input type="hidden" name="endDate" value="${endDate}">
          <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
          <input type="hidden" name="amount" value="${pageMaker.cri.amount}">    
        </form>
      </nav>
      </div>
         
    </div>
    
  </div>
  

  <!-- 풋터 -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


  <script>
 
    $(function(){	
    	
        let actionForm = $("#actionForm");
    	
    	/* 페이지 번호 클릭시 */
        $("ul.pagination li a.page-link").on("click", function(e){

          e.preventDefault();

          let pageNum = $(this).attr("href");

          actionForm.find("input[name='pageNum']").val(pageNum);

          // actionForm의 속성 변경
          actionForm.attr("method", "get");
          actionForm.attr("action", "/user/order/orderDetailList");
          
          actionForm.submit();
          
        });  

        let searchForm = $("#searchForm")

        /* 검색버튼 클릭시 pageNum 초기화 */
        $("#btnSearch").on("click", function(){

          searchForm.find("input[name='pageNum']").val(1);
          searchForm.submit();
          
        });	
    	
    	
    });	

  </script>
  
  
  </body>
</html>
    