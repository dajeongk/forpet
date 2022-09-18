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


<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <br><h2 style="font-weight: bold; color: #2C4B7B;">주문 결제</h2>
</div>

<div class="container">
  <div class="row">
   	<div class="col-lg-12">
   	  <div class="box box-primary">
   		<div class="box-header px-3 py-3 pt-md-5 pb-md-4 mx-auto">
   		  <small>* 고객님의 주문 상품을 확인해주세요. </small>
   		</div>
   		<div class="box-body" align="center">
		<table class="table table-hover" id="cartListResult">
		  <thead style="text-align: center;">
		    <tr>
		      <th scope="col">이미지</th>	
		      <th scope="col">상품명</th>
		      <th scope="col">판매가</th>
		      <th scope="col">수량</th>
		      <th scope="col">배송비</th>
		      <th scope="col">합계</th>
		    </tr>
		  </thead>
		  
		  <tbody style="text-align: center;">
		    <c:forEach items="${cartOrderList }" var="cartOrderInfo">
		    <c:set var="price" value="${cartOrderInfo.pdt_buy_amount * cartOrderInfo.pdt_price  }"></c:set>
		    <tr>
		      <td scope="row"> 
		        <a class="move" href="${cartOrderInfo.pdt_number }" style="text-decoration: none;">
		          <img src="/user/order/displayFile?folderName=${cartOrderInfo.pdt_img_folder }&fileName=s_${cartOrderInfo.pdt_img }" 
		      		 alt="..." style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/img/noImage.png'">	          
		        </a>
		      </td>
		      <td><c:out value="${cartOrderInfo.pdt_name }" /> </td>
		      <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${price }"></fmt:formatNumber> 원</td>
		      <td scope="row">
		        <input type="hidden" name="pdt_price" value='<c:out value="${cartOrderInfo.pdt_price }" />'>
		      	<c:out value="${cartOrderInfo.pdt_buy_amount }" /> 개
		      </td>
		      <td>무료배송</td>
		      <c:set var="sum" value="${sum + price}"></c:set>
		      <td><span class="unitPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${price }"></fmt:formatNumber> 원</span></td>
		    </tr>  
		    </c:forEach>	    
		  </tbody>
		  <tfoot style="text-align: right;" class="px-3 py-3 pt-md-5 pb-md-4 mx-auto">
		    <tr>
		      <!-- empty: 데이터가 존재하지 않으면 true, 존재하면 false -->
		      <c:if test="${!empty cartOrderList }">
		      <td colspan="12"><br>총 구매금액 : <span id="cartTotalPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sum }"></fmt:formatNumber> 원</span></td>
		      </c:if>
		      <c:if test="${empty cartOrderList }">   
		      <td colspan="12" style="text-align: center;"> 주문 상품이 없습니다. <hr></td> 
		      </c:if>	
		    </tr>
		  </tfoot>
		</table>
  		</div>
  			
  	  </div>
    </div>
   </div>
   
   <div align="center">
     <hr><br><h3 style="font-weight: bold; color: #2C4B7B;">주문자 정보</h3><br>
  	 <form id="orderForm" action="join_ok" method="post"> 
	   <div class="form-group w-50 text-left">
	     <label for="mem_name">이름</label>
	     <input type="text" class="form-control" id="s_mem_name" name="mem_name" value="${sessionScope.loginStatus.mem_name }" readonly>
	     <input type="hidden" class="form-control" id="s_mem_postcode" value="${sessionScope.loginStatus.mem_postcode }">
	     <input type="hidden" class="form-control" id="s_mem_addr" value="${sessionScope.loginStatus.mem_addr }">
	     <input type="hidden" class="form-control" id="s_mem_addr_d" value="${sessionScope.loginStatus.mem_addr_d }">
	   </div>
	   <div class="form-group w-50 text-left">
	     <label for="mem_phone">휴대폰 번호</label>
	     <input type="text" class="form-control" id="s_mem_phone" name="mem_phone" value="${sessionScope.loginStatus.mem_phone }" readonly>
	   </div>
	   <div class="w-50 text-left">
	     <label for="mem_email">이메일</label>
	     <input type="email" class="form-control" id="s_mem_email" name="mem_email" placeholder="email@example.com" value="${sessionScope.loginStatus.mem_email }" readonly>
	   </div>
	 
	   <br><hr><br><h3 style="font-weight: bold; color: #2C4B7B;">배송지 정보</h3><br>
	   <input type="checkbox" id="same" style="text-align: right;"> 주문자 정보와 동일 
	   <div class="form-group w-50 text-left">
	     <label for="mem_name">이름</label>
	     <input type="text" class="form-control" id="mem_name" name="odr_name">
	   </div>
	   <div class="form-group w-50 text-left">
	     <label for="mem_phone">휴대폰 번호</label>
	     <input type="text" class="form-control" id="mem_phone" name="odr_phone">
	   </div>
	   <div class="form-group w-50 text-left">    
	     <label class="form-label">배송지 선택</label><br> 
	     <div class="form-check form-check-inline">      	     
	       <input class="form-check-input" type="radio" name="receiveAddr" id="receiveAddr1" value="1" checked>
	   	   <label class="form-check-label">기본 배송지</label> 
	   	 </div>
	   	 <div class="form-check form-check-inline">
	   	   <input class="form-check-input" type="radio" name="receiveAddr" id="receiveAddr2" value="2" >
	   	   <label class="form-check-label">신규 배송지</label>
	   	 </div>
	   </div>
	   <div class="w-50 text-left">
	     <label for="sample2_postcode">우편번호</label>
	     <div class="form-group row">
	       <div  class="col-md-8">
	         <input type="text" class="form-control" id="sample2_postcode" name="odr_postcode" value="${sessionScope.loginStatus.mem_postcode }">
	       </div>
	       <div class="col-md-4">
	         <input type="button" class="btn btn-outline-secondary btn-block" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
	       </div>
	     </div>
	   </div>
	   <div class="form-group row w-50 text-left">
	     <label for="sample2_address" class="col-form-label">주소</label>
	     <input type="text" class="form-control" id="sample2_address" name="odr_addr" value="${sessionScope.loginStatus.mem_addr }">
	   </div>
	   <div class="form-group row w-50 text-left">
	     <label for="sample2_detailAddress" class="col-form-label">상세주소</label>
	     <input type="text" class="form-control" id="sample2_detailAddress" name="odr_addr_d" value="${sessionScope.loginStatus.mem_addr_d }">
	     <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">	
	   </div>
	   <div class="form-group w-50 text-left">
	     <label for="mem_phone">배송 메세지</label>
	     <textarea type="text" class="form-control" name="odr_message" row="3" placeholder="20자 이내로 작성해주세요."></textarea>
	  	 <input type="hidden" name="odr_total_price" value="${sum }">
	   </div>
	   
	   <br><hr><br><h3 style="font-weight: bold; color: #2C4B7B;">결제 정보</h3><br>
	   <div class="form-group w-50 text-left">
         <label for="pay_method">결제수단</label>
         <select name="pay_method" id="pay_method" class="form-control">
           <option value="">결제수단을 선택하세요.</option>
           <option value="무통장입금">무통장입금</option>
           <option value="카카오페이">카카오페이</option>
           <option value="핸드폰결제">핸드폰결제</option>
           <option value="신용카드">신용카드</option>
           <option value="페이코">페이코</option>
         </select>         
       </div>
       <div class="form-group w-50 text-left">
         <label for="pay_nobank">입금은행</label>
         <select name="bank" id="bank" class="form-control">
           <option value="">입금은행을 선택하세요.</option>
           <option value="000000000000">국민은행 (000000000000)</option>
           <option value="111111111111">신한은행 (111111111111)</option>
           <option value="222222222222">우리은행 (222222222222)</option>
           <option value="333333333333">농협은행 (333333333333)</option>
           <option value="444444444444">하나은행 (444444444444)</option>
         </select>
         <input type="hidden" name="pay_nobank" id="pay_nobank" value="">
         <input type="hidden" name="pay_nobank_price" id="pay_nobank_price" value="${sum }"> 
	   </div>
       <div class="form-group w-50 text-left">
	     <label for="pay_nobank_user">입금자명</label>
	     <input type="text" class="form-control" id="pay_nobank_user" name="pay_nobank_user">
	   </div>   
	 </form>
	  
	  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
        <button type="button" id="btnCancel" class="btn btn-outline-secondary">주문취소</button>   
  		<button type="button" id="btnOrder" class="btn btn-secondary disabled">주문하기</button>
  		<input type="image" id="kakaopay" src="/img/payment_icon_yellow_small.png" class="btn btn-link" disabled>
  	  </div>
	  
	</div>

  <!-- footer.jsp -->
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


  <script>
 
    $(function(){

    	/* 체크박스 : 위 정보와 동일 선택 */
		$("#same").on("click", function(){

			if($("#same").is(":checked") == true) {

				$("#mem_name").val($("#s_mem_name").val());
				$("#mem_phone").val($("#s_mem_phone").val());
			}else {
				$("#mem_name").val("");
				$("#mem_phone").val("");
			}	
		});
    	
		/* 라디오버튼 : 자택 또는 타지역 선택 */
		$("input[name='receiveAddr']").on("click", function(){

			if($("input[name='receiveAddr']:checked").val() == 1) { // 자택	
				$("#sample2_postcode").val($("#s_mem_postcode").val());
				$("#sample2_address").val($("#s_mem_addr").val());
				$("#sample2_detailAddress").val($("#s_mem_addr_d").val());		
			}else if($("input[name='receiveAddr']:checked").val() == 2) { // 기타
				$("#sample2_postcode").val("");
				$("#sample2_address").val("");
				$("#sample2_detailAddress").val("");
			}	
		});

		/* 결제수단 선택 */
		var pay_method;

		$("#pay_method").on("change", function(){
			
			if($("#pay_method option:selected").val() == "") {
				alert("결제수단을 선택하세요.");
				return;
			}

			$("#btnOrder").attr("disabled", false);      // 비활성화 -> 활성화
			$("input#kakaopay").attr("disabled", true);

			if($("#pay_method option:selected").val() == "카카오페이") {
				alert("카카오페이 이미지를 클릭하세요.");
				pay_method = $("#pay_method option:selected").val();
				$("#btnOrder").attr("disabled", true); // 활성화 -> 비활성화
				$("input#kakaopay").attr("disabled", false); // 비활성화 -> 활성화

				return;
			}

		});

		/* 카카오페이 이미지 클릭 (ajax구문 사용) */
		$("input#kakaopay").on("click", function(e){

			e.preventDefault();
			
			// 카카오페이에서 요청하는 필수 입력값
			// 주문자
			let odr_name = $("input[name='odr_name']").val();
			// 연락처 
			let odr_phone = $("input[name='odr_phone']").val();
			// 이메일
			let odr_email = $("#s_mem_email").val();
			// 전체금액 
			let odr_total_price = $("input[name='odr_total_price']").val();

			// 단위금액
			// 할인이 적용된 금액
			// 적립금
			// 쿠폰

			$.ajax({
				url: '/user/order/orderPay',
				type: 'get',
				data: {
					totalAmount : odr_total_price,

					odr_name :  $("input[name='odr_name']").val(),
					odr_postcode :  $("input[name='odr_postcode']").val(),
					odr_addr :  $("input[name='odr_addr']").val(),
					odr_addr_d :  $("input[name='odr_addr_d']").val(),
					odr_phone :  $("input[name='odr_phone']").val(),
					odr_total_price : odr_total_price,
					odr_message : $("textarea[name='odr_message']").val(),
					pay_status : '결제완료',

					pay_method : $("#pay_method option:selected").val(),
					pay_total_price: odr_total_price,
				},
				success: function(response) {
					
					location.href = response.next_redirect_pc_url;
				}
			});

		});

		
		/* 무통장 입금시 입금은행 선택 */
		$("#bank").on("change", function(){
		
			if($("#bank").val() == "") {
				alert("입금은행을 선택하세요.");
			}
			
			$("#btnOrder").attr("disabled", true);      
			$("input#kakaopay").attr("disabled", false);
			
			// 무통장입금 선택시 주문버튼 활성화
			if($("#pay_method option:selected").val() == "무통장입금") {
				
				pay_method = $("#pay_method option:selected").val();
				$("#btnOrder").attr("disabled", false); 
				$("input#kakaopay").attr("disabled", true); 

				return;
			}
			
				
		});

		/* 주문하기 버튼 클릭 */
		$("#btnOrder").on("click", function(){

			// 유효성 검사
			
			$("#orderForm").attr("action", "/user/order/orderSave?type=" + "무통장입금");
			$("#orderForm").submit();
		});

		
    	
    });	

  </script>
  
  <!-- 다음 API -->
  <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
  <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
  </div>
	
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        // 태그참조변수.style.css속성명령어 = '값';
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
  </script>
  
  </body>
</html>
    