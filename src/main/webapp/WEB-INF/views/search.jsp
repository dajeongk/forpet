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
<%@include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  
</div>

<div class="album py-5">
    <div class="container">
      <form id="searchForm" action="/search" method="get" class="form-inline">  
	    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	    <input type="hidden" name="amount" value="${pageMaker.cri.amount }"> 
   	  </form>
    
      <div class="row">
      <c:forEach items="${productList }" var="productVO">
        <div class="col-md-3">
          <div class="card mb-4 shadow-sm">
            <!-- <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#eceeef"/><text x="50%" y="50%" fill="#55595c" dy=".3em">Thumbnail</text></svg>
			 -->
			<!-- 상품 이미지 -->
			<a class="move" href="${productVO.pdt_number }">
			  <img src="/user/product/displayFile?folderName=${productVO.pdt_img_folder }&fileName=s_${productVO.pdt_img }" 
              	   alt="..." class="bd-placeholder-img card-img-top" onerror="this.onerror=null; this.src='/img/noImage.png'">
            </a>
            <div class="card-body">
              <p class="card-text">
              ${productVO.pdt_name }<br>
              <fmt:setLocale value="ko_KR"/><fmt:formatNumber type="number" maxFractionDigits="3" value="${productVO.pdt_price }"></fmt:formatNumber>원<br>
              </p>
              <div class="d-flex justify-content-between align-items-center">
              	<small class="text-muted">후기 ${productVO.rvw_cnt }</small>
              	<div class="btn-group" align="right">
                  <button type="button" name="btnCartOrder" class="btn btn-sm btn-default" data-pdt_number=${productVO.pdt_number }>
                    <img src="/img/cart.png" style="width: 20px; height: 20px;">
                  </button>
              	</div>  	
              </div>
            </div>
          </div>
        </div>
        
	  </c:forEach> 	
      </div>
    </div>
    
    <div class="px-3 py-3 pt-md-5 pb-md-4 mx-auto">
      <nav aria-label="..." style="text-align: center;">
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
	  
	    <!--페이지 번호 클릭시 list주소로 보낼 파라미터 작업-->
		<form id="actionForm" action="" method="get">
		  <input type="hidden" name="ctg_code" value="${ctg_code}">
	      <input type="hidden" name="ctg_name" value="${ctg_name}"> 
		  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		  <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		  <input type="hidden" name="type" value="${pageMaker.cri.type}">
		  <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	  </nav>
	</div>

  <!-- 풋터 -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>

<!-- Modal대화상자 : 상품 상세보기 -->
  <div class="modal fade" id="modal_productDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">장바구니 담기</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
          	<div class="col-md-6">
          	  <img src="" id="modal_detail_image" 
			       alt="..." class="bd-placeholder-img card-img-top" onerror="this.onerror=null; this.src='/img/noImage.png'">
          	</div>
            <div class="col-md-6">
            <form>
              <div class="form-group row">
                <label for="pdt_name" class="col-form-label col-4">상품명</label>
                <div class="col-8">
                  <input type="text" class="form-control" id="pdt_name" readonly>
                  <input type="hidden" class="form-control" id="pdt_number">
                </div> 
              </div>
              <div class="form-group row">
                <label for="pdt_price" class="col-form-label col-4">판매가격</label>
                <div class="col-8">
                  <input type="text" class="form-control" id="pdt_price" readonly>
                </div> 
              </div>
              <div class="form-group row">
                <label for="pdt_company" class="col-form-label col-4">제조사</label>
                <div class="col-8">
                  <input type="text" class="form-control" id="pdt_company" readonly>
                </div> 
              </div>
              <div class="form-group row">
                <label for="pdt_buy_amount" class="col-form-label col-4">수량</label>
                <div class="col-8">
                  <input type="number" class="form-control" id="pdt_buy_amount" min="1" value="1">
                </div> 
              </div>
            </form>
            </div>
          </div>
        <div class="modal-footer">
          <button type="button" name="btnModalCart" class="btn btn-light">장바구니</button>
          <button type="button" name="btnModalBuy" class="btn btn-primary disabled">구매하기</button>
        </div>
       </div>
     </div>
    </div>
  </div>

  <script>

    $(function(){
    	
      /* 구매, 장바구니 버튼 클릭시 모달 대화상자 출력 */
      $("button[name='btnCartOrder']").on("click", function(){

        $("#modal_productDetail").modal('show');

        let url = "/user/product/productDetail/" + $(this).data("pdt_number");
        
        // 모달대화상자 : 수량 1로 초기화
        $("div#modal_productDetail input#pdt_buy_amount").val(1);

        $.getJSON(url, function(result) {


          // 상품코드
          $("div#modal_productDetail input#pdt_number").val(result.pdt_number);
          // 상품명
          $("div#modal_productDetail input#pdt_name").val(result.pdt_name);
          // 판매가격
          $("div#modal_productDetail input#pdt_price").val($.numberWithCommas(result.pdt_price) + " 원");
          // 제조사
          $("div#modal_productDetail input#pdt_company").val(result.pdt_company);
          // 상품 이미지
          let url = "/user/product/displayFile?folderName=" + result.pdt_img_folder + "&" + "fileName=" + result.pdt_img;
          
          $("div#modal_productDetail img#modal_detail_image").attr("src", url);

        });

      });

      /* 모달 대화상자 : 장바구니에 상품 추가 (Ajax) */
      $("button[name='btnModalCart']").on("click", function(){

        $.ajax({
          url:'/user/cart/cart_add',
          data: { pdt_number : $("div#modal_productDetail input#pdt_number").val(), pdt_buy_amount : $("div#modal_productDetail input#pdt_buy_amount").val()},
          dataType: 'text',
          beforeSend: function(xmlHttpRequest) { 	// 인터셉트 기능으로 인해 추가.
        	  xmlHttpRequest.setRequestHeader("AJAX", "true"); 
		  },
          success: function(result) {
            if(result == "success") {
              alert("장바구니에 상품이 추가되었습니다.");
              if(confirm("장바구니로 이동하시겠습니까?")) {
                location.href = "/user/cart/cart_list";
              }
            }
          },
          error: function(xhr, status, error) { 	// 인터셉트 기능으로 인해 추가.
        	  alert("로그인후 이용할 수 있습니다.");
        	  location.href = "/member/login";
        	  
          }
        });

      });
      
   	  /* 모달 대화상자 : 구매하기. (non-ajax) */
      $("button[name='btnModalBuy']").on("click", function(){
        
        let pdt_number = $("div#modal_productDetail input#pdt_number").val();
        let odr_amount = $("div#modal_productDetail input#pdt_buy_amount").val();

        let url = "/user/order/orderListInfo?pdt_number=" + pdt_number + "&odr_amount=" + odr_amount + "&type=directOrder";

        location.href = url;
        
      });
      
   	  // actionForm 참조
      let actionForm = $("#actionForm");
      
   	  /* 페이지 번호 클릭 */
      $("ul.pagination li a.page-link").on("click", function(e){

        e.preventDefault();

        let pageNum = $(this).attr("href");

        actionForm.find("input[name='pageNum']").val(pageNum);

        let url = "/search";
        
        // actionForm의 속성 변경
        actionForm.attr("method", "get");
        actionForm.attr("action", url);

        actionForm.submit();

      });
      
 	 /* 상품이미지 클릭 */
     $("div.container a.move").on("click", function(e){
       
       e.preventDefault();

       let pdt_number = $(this).attr("href");
	
       actionForm.find("input[name='pdt_number']").remove();
       
       actionForm.attr("method", "get");
       actionForm.attr("action", "/user/product/productDetail");

       actionForm.append("<input type='hidden' name='pdt_number' value='" + pdt_number + "'>");
       actionForm.submit(); 


      });
      
   });
    
    // 숫자값 3자리마다 콤마
	$.numberWithCommas = function(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}  
  </script>
    
  </body>
</html>
    