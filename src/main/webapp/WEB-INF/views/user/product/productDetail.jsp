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
      
      /* 상품후기 별 평점 */
      #star_rvw_score a.rvw_score {
        font-size: 22px;
        text-decoration: none;
        color: lightgray;
      }
	
	  /* 별 평점 클릭시 jquery의 addClass(), removeClass()메서드를 이용하여 사용할 css선택자*/
      #star_rvw_score a.rvw_score.on {
        color: #eeb51a;
      }
      
    </style>
    
    <style>
    /* 상세페이지 테이블 */
    .table td {
      vertical-align: middle;
    }
    
    .form-control {
      display: inline;
    }
    
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
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
    <script id="reviewTemplate" type="text/x-handlebars-template">
      {{#each.}}
 	  <hr> 	
      <div class="list-group">
        <div class="d-flex w-100 justify-content-between">
          <h5 class="mb-1">{{idfourdisplay mem_id}}</h5>
          <p>
		 	<small>{{prettifyDate rvw_date}}</small>
		    <input type="hidden" name="rvw_score" value="{{rvw_score}}">
		  </p>
        </div>
		<div class="d-flex w-100 justify-content-between">
		  <h6 class="mb-1" style="color: #eeb51a;">{{displayStar rvw_score}}</h6>	  
		</div>
 		<div class="d-flex w-100 justify-content-between pt-md-3">
          <p class="mb-1"><span class="rvw_content">{{rvw_content}}</span></p>
          <p>
            {{modifyview mem_id rvw_number}}
		    {{deleteview mem_id rvw_number}}
          </p>
 		</div>
		</div>
      </div>
	    
      {{/each}}
    </script>
       
  </head>
  <body>
    
<!-- 헤더 -->
<%@include file="/WEB-INF/views/include/header.jsp" %>

<!-- 1차 카테고리 메뉴 -->
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>


<div class="container">
  <div class="box-header px-3 py-3 pt-md-5 pb-md-4 mx-auto">
    
  </div>
  
  <div class="box-body">
    <div class="row">
  	  <div class="col-6">
  	    <img src="/user/product/displayFile?folderName=${productVO.pdt_img_folder }&fileName=${productVO.pdt_img }" 
		     alt="..." class="bd-placeholder-img card-img-top" style="width: 100%; height: 100%;" onerror="this.onerror=null; this.src='/img/noImage.png'">
  	  </div>
  	  <div class="col-6">
  	    <input type="hidden" id="pdt_number" value="${productVO.pdt_number }">
  	    
  	    <small>&gt; ${ctg_name }</small><br>
  	    <span class="badge badge-warning">New</span>
  	    <h5 style="font-weight: bold;">${productVO.pdt_name }</h5><hr>
  	    <table class="table table-borderless" id="cartListResult">
		  <tbody>
		    <tr>
		      <th scope="row">판매가</th>	
		      <td><p><fmt:formatNumber type="number" maxFractionDigits="3" value="${productVO.pdt_price }"></fmt:formatNumber> 원</p></td>
		    </tr>
		    <tr>
		      <th scope="row">브랜드</th>
		      <td>${productVO.pdt_company }</td>
		    </tr>  
		    <tr>
		      <th scope="row">수량</th>
		      <td>
		        <button type="button" name="btnMinus" class="minus btn btn-light">-</button>
		        <input type="number" name="pdt_buy_amount" id="pdt_buy_amount" class="amount" min="1" max="${productVO.pdt_sell_amount }" value="1" style="text-align: center;" readonly>
		      	<button type="button" name="btnPlus" class="plus btn btn-light" data-pdt_sell_amount="${productVO.pdt_sell_amount }">+</button>
		      	<input type="hidden" name="pdt_price" value="${productVO.pdt_price }">
		      	<input type="hidden" name="pdt_buy_amount" value="${productVO.pdt_buy_amount }">
		      	<input type="hidden" name="pdt_sell_amount" value="${productVO.pdt_sell_amount }">	      	
		      </td>		    	
		    </tr>
		    <tr>
		      <th scope="row">배송비</th>
		      <td>무료배송</td>
		    </tr>  
  	      </tbody>
  	     </table>
  	   </div>
     </div>  
  </div>
  
  <div class="box-footer text-right">
    <hr><p>총 상품금액 : <span class="total_price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${productVO.pdt_price * productVO.pdt_buy_amount }"></fmt:formatNumber></span> 원</p><br>
    <button type="button" id="btnCart" class="btn btn-outline-secondary">장바구니 </button>
  	<button type="button" id="btnOrder" class="btn btn-secondary disabled">구매하기</button>
  </div>
  
  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
    <ul class="nav nav-tabs" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="home-tab" data-toggle="tab" data-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">상세설명</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="profile-tab" data-toggle="tab" data-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">상품후기(<span id="rvw_cnt">${productVO.rvw_cnt }</span>)</button>
      </li>
    </ul>
    
    
    <div class="border tab-content" id="myTabContent">
      <!-- 상품 상세설명 -->
      <div class="tab-pane fade show active mb-3 px-3 py-3 pt-md-5 pb-md-4" id="home" role="tabpanel" aria-labelledby="home-tab">
      	${productVO.pdt_detail }
      </div>
      <!-- 상품후기 -->
      <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
        <div class="row mb-3 px-3 py-3 pt-md-5 pb-md-4">
	      <div class="col-6">
	        <h4>REVIEW</h4>
	      </div>
	      <div class="col-6" align="right">
	        <button type="button" id="btnReview" class="btn btn-outline-secondary">상품후기 작성</button>
	      </div>      
	    </div>
	    
	    <!-- 상품후기 출력위치 -->
        <div id="reviewListResult" class="mb-3 px-3 py-3 mx-auto">

        </div>
        <hr>
        <!-- 상품후기 페이징 출력위치-->
        <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
          <nav aria-label="Page navigation example">
            
            <ul  id="reviewPagingResult" class="pagination justify-content-center">
            
            </ul>
          </nav>
        </div>    	       
      </div>
              
    </div>
 
  </div>
  
  <!-- 풋터 -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>

  <script>

    $(function(){
     	 
    	// ----------------------- 상품 -------------------------------
    	
       /* 수량 증가 버튼 클릭 */
       $(".plus").on("click", function(){
    	   
         var num = $(".amount").val();
         var plusNum = Number(num) + 1;
        
         let max = $(this).data("pdt_sell_amount");
         let pdt_price = $("input[name='pdt_price']").val();
        
         let total_price1 = num * pdt_price;
         let total_price2 = plusNum * pdt_price;
        

         if(plusNum >= max) {
           $(".amount").val(num);
           $(".total_price").text($.numberWithCommas(total_price1));
           
         }else {
           $(".amount").val(plusNum);
           $(".total_price").text($.numberWithCommas(total_price2));
         }
        
        
       });

       /* 수량 감소 버튼 클릭 */
       $(".minus").on("click", function(){
    	   
         var num = $(".amount").val();
         var minusNum = Number(num) - 1;
        
         let max = $(this).data("pdt_sell_amount");
         let pdt_price = $("input[name='pdt_price']").val();
        
         let total_price1 = num * pdt_price;
         let total_price2 = minusNum * pdt_price;

         if(minusNum <= 0) {
           $(".amount").val(num);
           $(".total_price").text($.numberWithCommas(total_price1));
          
         }else {
           $(".amount").val(minusNum);
           $(".total_price").text($.numberWithCommas(total_price2));
         }
       });
      

   	    /* 장바구니에 상품 추가 (ajax) */
        $("#btnCart").on("click", function(){
       	
          $.ajax({
            url:'/user/cart/cart_add',
            data: { pdt_number : $("#pdt_number").val(), pdt_buy_amount : $("#pdt_buy_amount").val()},
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
   	
        /* 구매하기 버튼 클릭시. non-ajax */
        $("#btnOrder").on("click", function(){

          let pdt_number = $("#pdt_number").val(); // 구매상품코드
          let odr_amount = $("#pdt_buy_amount").val(); // 구매수량

          let url = "/user/order/orderListInfo?pdt_number="+pdt_number+"&odr_amount="+odr_amount+"&type=directOrder";

          location.href = url;

        });
    	
    	        
        // ------------------------- 상품 후기 -------------------------------- 
        
        /* 평점 별 클릭시 색상변경 */
        $("#star_rvw_score a.rvw_score").on("click", function(e){

          e.preventDefault();

          $(this).parent().children().removeClass("on"); // 별평점<a>태그의 on클래스 선택자 제거
          $(this).addClass("on").prevAll("a").addClass("on"); 
          
        });
        
    	/* 상품후기작성 버튼 클릭 : 모달대화상자 */
        $("#btnReview").on("click", function(){

          $("button.btnReview").hide();
          $("button#btnReviewWrite").show();

          $("#reviewModal").modal('show');
         
          // 별점, 내용 초기화
          $("#star_rvw_score a.rvw_score").parent().children().removeClass("on");
          let rvw_content = $("#rvw_content").val("");
                   
        });

        /* 상품후기 목록 : 수정 버튼 클릭  - 모달대화상자 */
        $("div#reviewListResult").on("click", "button#btnModify", function(e){
          
          e.preventDefault();	 
        	
          $("button.btnReview").hide();
          $("button#btnReviewModify").show();

          // 1) 수정내용
          let rvw_number = $(this).data("rvw_number");
          let rvw_content = $(this).parents("div.list-group").find("p span.rvw_content").text();

          $("textarea#rvw_content").val(rvw_content);
          $("input#rvw_number").val(rvw_number);

          // 2) 별 평점
          let rvw_score = $(this).parents("div.list-group").find("p input[name='rvw_score']").val();
          
          // 별 a태그 5개
          $("#star_rvw_score a").each(function(index, item) {

            if(index < rvw_score) {
              $(item).addClass('on');
            }else {
              $(item).removeClass('on');
            }
          });

          $("#reviewModal").modal('show');
          
        });
      
        
  	    /* 상품후기 목록 : 삭제 버튼 클릭 */ 
        $("div#reviewListResult").on("click", "button#btnDelete", function(){
        	          
            let rvw_number = $(this).data("rvw_number"); 
            let rvw_cnt = $("#rvw_cnt").val();


            if(!confirm('상품후기를 삭제하시겠습니까?')) return;
          
            let data = { rvw_number : rvw_number, rvw_cnt : rvw_cnt };

            $.ajax({
              url: '/user/review/delete/' + rvw_number, // 주소를 경로형식으로 사용.
              headers: {
                  "Content-Type" : "application/json", "X-HTTP-Method-Override" : "DELETE"
                },
              type: 'delete',
              dataType: 'text',
              data: JSON.stringify(data),
              success : function(result) {
                if(true) {
                  alert("상품후기가 삭제되었습니다.");
                  
                  $("span#rvw_cnt").text(result);
         
                  //상품후기 목록
                  url = "/user/review/list/" + $("#pdt_number").val() + "/" + reviewPage;

                  getPage(url);

                }
              }
            });    
        });
        
        /* 리뷰 모달 대화상자 : 등록 버튼 클릭 */
        $("#btnReviewWrite").on("click", function(){
          
          let rvw_score = 0;
          let rvw_content = $("#rvw_content").val();
          let pdt_number = $("#pdt_number").val();
          let rvw_cnt = $("#rvw_cnt").val();

          // 별 5개 
          $("#star_rvw_score a.rvw_score").each(function(i, e){
            if($(this).attr('class') == 'rvw_score on') {
              rvw_score += 1;
            }
          });

          if(rvw_score == 0) {
            alert("별 평점을 선택해주세요.");
            return;
          }

          if(rvw_content == "") {
            alert("내용을 입력해주세요.");
            return;
          }
          
       	  // 자바스크립트 Object객체 구문
          let data = { pdt_number : pdt_number, rvw_content : rvw_content, rvw_score : rvw_score, rvw_cnt : rvw_cnt };

          $.ajax({
            url: '/user/review/new',
            /* 컨트롤러에서 전송데이터 포맷이 설정되어 있으므로 클라이언트에서 보내는 데이터의 MIME설정을 헤더에 추가해야함. */
            headers: {
            	"Content-Type" : "application/json", "X-HTTP-Method-Override" :"POST"
            },
            type: 'post',
            dataType: 'text',
            data: JSON.stringify(data),
            success: function(result) {
              if(true) {
                alert("상품후기가 등록되었습니다.");
                
                $("span#rvw_cnt").text(result);
                
                // 상품후기 목록 
                reviewPage = 1;
                url = "/user/review/list/" + $("#pdt_number").val() + "/" + reviewPage;
                getPage(url);

                // 상품후기 대화상자 숨김
                $("#reviewModal").modal('hide');
                
                // 별점, 내용 초기화
                $("#star_rvw_score a.rvw_score").parent().children().removeClass("on");
                $("#rvw_content").val("");
                
              }
            }
          });
        });

        /* 리뷰 모달 대화상자 : 수정 버튼 클릭 */
        $("#btnReviewModify").on("click", function(){
          
          let rvw_number = $("#rvw_number").val();
          let rvw_content = $("#rvw_content").val();
          let rvw_score = 0;

          // 별 5개 
          $("#star_rvw_score a.rvw_score").each(function(i, e){
            if($(this).attr('class') == 'rvw_score on') {
              rvw_score += 1;
            }
          });

          if(rvw_score == 0) {
            alert("별 평점을 선택해주세요.");
            return;
          }

          if(rvw_content == "") {
            alert("내용을 입력해주세요.");
            return;
          }
		
          // 자바스크립트 Object객체 구문
          let data = { rvw_number : rvw_number, rvw_content : rvw_content, rvw_score : rvw_score };

          $.ajax({
            url: '/user/review/modify',
            // 컨트롤러에서 전송데이터 포맷이 설정되어 있으므로 클라이언트에서 보내는 데이터의 MIME설정을 헤어데 추가해야함.
            headers: {
            	"Content-Type" : "application/json", "X-HTTP-Method-Override" :"PATCH"
            },
            type: 'patch',
            dataType: 'text',
            data: JSON.stringify(data),
            success: function(result) {
              if(result == "success") {
                alert("상품후기가 수정되었습니다.");
                
                // 상품후기 목록 
                url = "/user/review/list/" + $("#pdt_number").val() + "/" + reviewPage;             
                getPage(url);

                // 상품후기 대화상자 숨김
                $("#reviewModal").modal('hide');
                
                // 별점, 내용 초기화
                $("#star_rvw_score a.rvw_score").parent().children().removeClass("on");
                $("#rvw_content").val("");
              
              }
            }
          });

        });

    });

    let reviewPage = 1;
    let url = "/user/review/list/" + ${productVO.pdt_number} + "/" + reviewPage;
    
    getPage(url);
    
    /* 상품 상세페이지 */
    function getPage(pageInfo) {

      $.getJSON(pageInfo, function(data) {

        if(data.list.length > 0) {

          // 함수 : 상품후기 목록 (데이터, 출력위치, 핸들바템플릿)
          printReviewList(data.list, $("#reviewListResult"), $("#reviewTemplate"));
          // 함수 : 페이징 기능 (데이터, 출력위치)
          printReviewPaging(data.pageMaker, $("#reviewPagingResult"));

        }
      });
    }

    /* 상품후기 출력 함수 (데이터, 출력위치, 핸들바템플릿) */
    let printReviewList = function(reviewArrData, target, templateObj) {

      // 핸들바 코드가 존재하는 상품후기 코드 컴파일
      let template = Handlebars.compile(templateObj.html());

      // 상품후기 목록 데이터 + 상품후기 UI템플릿 결합된 소스
      let html = template(reviewArrData);

      target.children().remove();
      target.append(html);
    }

    /* 상품후기 등록일 : 사용자정의 Helper함수 */
    Handlebars.registerHelper("prettifyDate", function(timeValue) {

      let dateObj = new Date(timeValue);
      let year = dateObj.getFullYear();
      let month = dateObj.getMonth() + 1;
      let date = dateObj.getDate();

      return year + "." + month + "." + date;
      
    });
   
    /* 평점 별 표시 */
    Handlebars.registerHelper("displayStar", function(rating){

    let star = "";
    switch(rating) {
      case 1:
        star = "★☆☆☆☆";
        break;
      case 2:
        star = "★★☆☆☆";
        break;
      case 3:
        star = "★★★☆☆";
        break;
      case 4:
        star = "★★★★☆";
        break;
      case 5:
        star = "★★★★★";
        break;
    }

    return star;
    });

    /* 아이디 4글자만 출력 */
    Handlebars.registerHelper("idfourdisplay", function(userid){

    return userid.substring(0, 4) + "*****";
    
    });

    /* 로그인 사용자와 댓글 사용자가 일치할 경우 : 수정, 삭제버튼 표시 */
    Handlebars.registerHelper("modifyview", function(review_mem_id, rvw_number) {
      
      let result = "";
      let login_mem_id = "${sessionScope.loginStatus.mem_id}";

      if(review_mem_id == login_mem_id) {
        result = "<button type='button' id='btnModify' data-rvw_number='" + rvw_number + "' class='btn btn-outline-secondary'>수정</button>";
      }

      return new Handlebars.SafeString(result);
      
    });
    
    Handlebars.registerHelper("deleteview", function(review_mem_id, rvw_number) {
        
        let result = "";
        let login_mem_id = "${sessionScope.loginStatus.mem_id}";

        if(review_mem_id == login_mem_id) {
          result = "<button type='button' id='btnDelete' data-rvw_number='" + rvw_number + "' class='btn btn-outline-danger'>삭제</button>";
        }

        return new Handlebars.SafeString(result);
        
      });

    /* 상품후기 페이징 함수 (데이터, 출력위치) */
    let printReviewPaging = function(pageMaker, target) {

    let pagingStr = "";

    // 이전 표시
    if(pageMaker.prev) {
      pagingStr += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1);
      pagingStr += "'>&lt;&lt;</a></li>";
    }

    // 페이지번호 표시
    for(let i=pageMaker.startPage; i<=pageMaker.endPage; i++) {
      let classStr = pageMaker.cri.pageNum == i ? "active'" : "";
      pagingStr += "<li class='page-item " + classStr + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
    }

    // 다음 표시
    if(pageMaker.next) {
      pagingStr += "<li class='page-item'><a class='page-link' href='" + (pageMaker.endPage + 1);
      pagingStr +=  "'>&gt;&gt;</a></li>";
    }

    target.children().remove();
    target.html(pagingStr);
    }

    /* 이전, 페이지번호, 다음 클릭 */
    $("nav ul#reviewPagingResult").on("click", "li a.page-link", function(e){

	    e.preventDefault();
	
	    // 상품후기 목록 
	    reviewPage = $(this).attr("href");
	
	    url = "/user/review/list/" + $("#pdt_number").val() + "/" + reviewPage;
	    getPage(url);
	    
    });
          
 	/* 숫자값 3자리마다 콤마 */
	$.numberWithCommas = function(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
    
  </script>
  
  <!-- 상품후기 Modal Dialog -->
	<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">상품리뷰 작성</h5>	       
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="col-form-label">평점:</label>
	            <p id="star_rvw_score">
	              <a class="rvw_score" href=#>★</a>
	              <a class="rvw_score" href=#>★</a>
	              <a class="rvw_score" href=#>★</a>
	              <a class="rvw_score" href=#>★</a>
	              <a class="rvw_score" href=#>★</a>
	            </p>
	          </div>
	          <div class="form-group">
	            <label for="rvw_content" class="col-form-label">내용</label>
	            <textarea class="form-control" id="rvw_content"></textarea>
                <input type="hidden" name="rvw_number" id="rvw_number">
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
	        <button type="button" id="btnReviewWrite" class="btn btn-primary disabled btnReview">등록</button>
            <button type="button" id="btnReviewModify" class="btn btn-primary disabled btnReview">수정</button>         
	      </div>
	    </div>
	  </div>
	</div>

  </body>
</html>
    