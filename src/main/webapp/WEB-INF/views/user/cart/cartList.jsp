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
    /* 장바구니 테이블 css */
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


<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <h3 style="font-weight: bold; color: #2C4B7B;">장바구니</h3>
</div>

<div class="container-fluid">
  <div class="row">
   	<div class="col-lg-12">
   	  <div class="box box-primary">
   		<div class="box-header">
   		  <small>* 장바구니 상품정보입니다. 구매시 참고해주세요. </small>
   		</div>
   		<div class="box-body" align="center">
		<table class="table table-hover" id="cartListResult">
		  <thead style="text-align: center;">
		    <tr>
		      <th scope="col">이미지</th>	
		      <th scope="col">상품명</th>
		      <th scope="col">판매가</th>
		      <th scope="col">수량</th>
		      <th scope="col">적립</th>
		      <th scope="col">배송비</th>
		      <th scope="col">합계</th>
		      <th scope="col">삭제</th>
		    </tr>
		  </thead>
		  
		  <tbody style="text-align: center;">
		    <c:forEach items="${cartList }" var="cartVO">
		    <c:set var="price" value="${cartVO.pdt_buy_amount * cartVO.pdt_price  }"></c:set>
		    <tr>
		      <td scope="row"> 
		        <a class="move" href="${cartVO.pdt_number }" style="text-decoration: none;">
		          <img src="/user/cart/displayFile?folderName=${cartVO.pdt_img_folder }&fileName=s_${cartVO.pdt_img }" 
		      		 alt="..." style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/img/noImage.png'">	          
		        </a>
		      </td>
		      <td><c:out value="${cartVO.pdt_name }" /> </td>
		      <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cartVO.pdt_price }"></fmt:formatNumber> 원</td>
		      <td scope="row">
		        <input type="hidden" name="pdt_price" value='<c:out value="${cartVO.pdt_price }" />'>
		      	<input type="number" name="pdt_buy_amount" value='<c:out value="${cartVO.pdt_buy_amount }" />' class="form-control w-25" min="1">
		        <button type="button" name="btnCartAmountChange" data-crt_code="${cartVO.crt_code }" class="btn btn-light btn-sm">변경</button>
		      </td>
		      <td><c:out value="${cartVO.mem_point }" /></td>
		      <td>[기본배송]</td>
		      <td><span class="unitPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${price }"></fmt:formatNumber> 원</span></td>
		      <td><button type="button" name="btnCartDelete" data-crt_code = "${cartVO.crt_code }" class="btn btn-light btn-sm">삭제</button></td> 	
		    </tr>
		    <c:set var="sum" value="${sum + price }"></c:set>
		    </c:forEach>
		  </tbody>
		  
		  <tfoot style="text-align: right;">
		    <tr>
		      <!-- empty: 데이터가 존재하지 않으면 true, 존재하면 false -->
		      <c:if test="${!empty cartList }">
		      <td colspan="12">총 구매금액 : <span id="cartTotalPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sum }"></fmt:formatNumber> 원</span></td>
		      </c:if>
		      <c:if test="${empty cartList }">   
		      <td colspan="12" style="text-align: center;"> 장바구니에 담긴 상품이 없습니다. <hr></td> 
		      </c:if>	
		    </tr>
		  </tfoot>
		</table>
  		</div>
  		<div class="box-footer text-right">
  		  <button type="button" name="btnCartEmpty" class="btn btn-outline-secondary">장바구니 비우기</button>
  		  <button type="button" name="btnOrder" class="btn btn-secondary disabled">주문하기</button>
  		</div>

  	  </div>
    </div>
   </div>

  <!-- footer.jsp -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


  <script>
 
    $(function(){

		/* 수량변경 버튼 클릭 */
		$("button[name='btnCartAmountChange']").on("click", function(){

			let crt_code = $(this).data("crt_code");
			let pdt_buy_amount = $(this).parent().find("input[name='pdt_buy_amount']").val();
	
			if(confirm("수량을 변경하시겠습니까?")) {
				location.href = "/user/cart/cart_amount_update?crt_code=" + crt_code + "&pdt_buy_amount=" + pdt_buy_amount;
			}
		});
    
		/* 삭제버튼 클릭 */
		$("button[name='btnCartDelete']").on("click", function(){

			let crt_code = $(this).data("crt_code");
			
			if(confirm("상품을 삭제하시겠습니까?")) {
				location.href = "/user/cart/cart_delete?crt_code=" + crt_code;
			}
			
		});
		
		/* 장바구니 비우기 버튼 클릭 */
		$("button[name='btnCartEmpty']").on("click", function(){

			if(confirm("상품을 전체 삭제하시겠습니까?")) {
				location.href = "/user/cart/cart_empty";
			}
			

		});
		
		/* 주문하기 버튼 클릭 */
		$("button[name='btnOrder']").on("click", function() {
			
			let type = "cartOrder";
			location.href = "/user/order/orderListInfo?type=" + type;
			
		});
		
		
    });	

  </script>
  
  </body>
</html>
    