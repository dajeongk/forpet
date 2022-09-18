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

<div class="container">
  <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
    <h4 style="font-weight: bold; color: #2C4B7B;">주문이 완료되었습니다.</h4>
    <small>주문하신 내역은 '주문상세내역'에서 확인하실 수 있습니다.</small>
  </div>
  
  <div class="box-body px-3 py-3 pt-md-5 pb-md-4 mx-auto">
    <div class="row">
  	  <div class="col-12">
  	    <table class="table table-borderless" id="cartListResult" style="white-space: normal;">
		  <tbody>
		  	<c:forEach items="${orderVO }" var="orderVO">
		    <tr class="pt-md-5 pb-md-4 mx-auto">
		      <th scope="row">주문번호</th>	
		      <td><c:out value="${orderVO.odr_number }" /></td>
		    </tr>
		    <tr>
		      <th scope="row">배송지</th>
		      <td>[<c:out value="${orderVO.odr_postcode }" />] <c:out value="${orderVO.odr_addr }" /> | <c:out value="${orderVO.odr_addr_d }" /> <br />
		     	  <c:out value="${orderVO.odr_name }" /> | <c:out value="${orderVO.odr_phone }" /> <br />
		     	       배송메세지 : <c:out value="${orderVO.odr_message }" />
		      </td>
		    </tr> 
		    <tr>
		      <th scope="row">결제정보</th>
		      <td><p><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderVO.pay_total_price }"></fmt:formatNumber> 원</p></td>	 	         	
		    </tr>   
		    <tr>
		      <th scope="row">결제수단 정보</th>
		      <td><c:out value="${orderVO.pay_method }" /></td>	 	      
		    </tr>  
		    </c:forEach>
  	      </tbody>
  	     </table>
  	 </div>
   </div> 
   
   <div class="row px-3 py-3 pt-md-5 pb-md-4 mx-auto" style="text-align: center;">
  	 <div class="col-12">
  	   <button id="btnOrderDetail" class="btn btn-outline-secondary">주문 상세내역</button>
  	   <button id="btnHome" class="btn btn-secondary disabled">홈으로 가기</button>
  	 </div>
   </div>
      
  </div>

  <!-- 풋터 -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


  <script>
 
    $(function(){	
    	
      /* 주문 상세내역 버튼 클릭 */	
      $("#btnOrderDetail").on("click", function(){

        location.href = "/user/order/orderDetailList";
        
      });
      
      /* 홈으로 가기 버튼 클릭 */	
      $("#btnHome").on("click", function(){

        location.href = "/";
        
      });
      
    });	

  </script>
  
  
  </body>
</html>
    