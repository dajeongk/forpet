<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Admin</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
  <!-- AdminLTE css파일들 -->
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
</head>

<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/nav.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 style="font-weight: bold;">
       	 주문목록 관리
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

  <!-- Main content -->
  <section class="content container-fluid">

  <div class="row"> 
    <div class="col-md-12">
  	  <div class="box box-primary">
  	    <div class="box-header">
  			ORDER LIST
  		</div>
  		<div class="box-body">
  		  <form id="searchForm" action="/admin/order/orderList" method="get">
 		    
 		         주문일 <input type="date" name="startDate"> ~ <input type="date" name="endDate">
 		    
 		    <select name="type">
	  	      <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }" />>--</option>
	          <option value="O" <c:out value="${pageMaker.cri.type eq 'O' ? 'selected' : '' }" />>주문번호</option>
	          <option value="M" <c:out value="${pageMaker.cri.type eq 'M' ? 'selected' : '' }" />>주문자</option>
  		    </select>
		      <input type="text" name="keyword" value="${pageMaker.cri.keyword }">
		      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		      <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		          
		      <button type="button" id="btnSearch" class="btn btn-light">검색</button>
  
		  </form>
		  
 		  <table class="table table-hover">
	      <thead>
	        <tr>
	          <th scope="col"><input type="checkbox" id="checkAll" name="checkAll"></th>
	          <th scope="col">주문일</th>
	          <th scope="col">주문번호</th>
	          <th scope="col">주문자</th>
	          <th scope="col">주문금액</th>
	          <th scope="col">결제상태</th>	
	          <th scope="col">주문상태</th>          
	          <th scope="col">주문관리</th>     
	        </tr>
	      </thead>
	      
          <tbody>
            <c:forEach items="${orderList }" var="orderVO">
        
            <tr>
              <td scope="row"><input type="checkbox" class="check" value="${orderVO.odr_number }"></td>
              <td><fmt:formatDate value="${orderVO.odr_date }" pattern="yyyy-MM-dd hh:mm" /></td>
              <td><c:out value="${orderVO.odr_number }" escapeXml="true" /></td>
              <td><c:out value="${orderVO.odr_name }" /></td>           
              <td><p><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderVO.odr_total_price }"></fmt:formatNumber> 원</p></td>
              <td><c:out value="${orderVO.pay_status }" /></td>
              <td>
                <select name="odr_status">
                  <option value="주문접수" ${orderVO.odr_status eq '주문접수'? 'selected':''}>주문접수</option>
                  <option value="결제완료" ${orderVO.odr_status eq '결제완료'? 'selected':''}>결제완료</option>
                  <option value="배송준비중" ${orderVO.odr_status eq '배송준비중'? 'selected':''}>배송준비중</option>
                  <option value="배송처리중" ${orderVO.odr_status eq '배송처리중'? 'selected':''}>배송처리중</option>
                  <option value="배송완료" ${orderVO.odr_status eq '배송완료'? 'selected':''}>배송완료</option>
                  <option value="주문취소" ${orderVO.odr_status eq '주문취소'? 'selected':''}>주문취소</option>
                  <option value="취소요청" ${orderVO.odr_status eq '취소요청'? 'selected':''}>취소요청</option>
                  <option value="취소완료" ${orderVO.odr_status eq '취소완료'? 'selected':''}>취소완료</option>
                  <option value="교환요청" ${orderVO.odr_status eq '교환요청'? 'selected':''}>교환요청</option>
                  <option value="교환완료" ${orderVO.odr_status eq '교환완료'? 'selected':''}>교환완료</option>
                  <option value="환불요청" ${orderVO.odr_status eq '환불요청'? 'selected':''}>환불요청</option>
                  <option value="환불완료" ${orderVO.odr_status eq '환불완료'? 'selected':''}>환불완료</option>
                </select>
                <button type="button" name="btnChangeOrderStatus" data-odr_number = "${orderVO.odr_number }" class="btn btn-warning btn-sm">변경</button>
              </td>
              <td><button type="button" name="btnOrderDetail" data-odr_number = "${orderVO.odr_number }" class="btn btn-light btn-sm">상세</button></td>
            </tr>
            </c:forEach>
          </tbody>
        </table>

		<div>
		  <button type="button" name="btnCheckDelete" data-odr_number = "${orderVO.odr_number }" class="btn btn-danger btn-sm">삭제</button>
		</div>

        <nav aria-label="...">
          <div class="form-gourp" align="center">
          <ul class="pagination justify-content-center">
            <!-- 이전표시 -->
            <c:if test="${pageMaker.prev }">
              <li class="page-item">
                <a class="page-link" href="${pageMaker.startPage - 1 }">이전</a>
              </li>
            </c:if>
    
            <!-- 페이지번호 표시.  1  2  3  4  5 -->
            <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num" >
    	      <li class='page-item ${pageMaker.cri.pageNum == num ? "active": "" }'><a class="page-link" href="${num}">${num}</a></li>
            </c:forEach>
   
            <!-- 다음표시 -->
            <c:if test="${pageMaker.next }">
              <li class="page-item">
                <a class="page-link" href="${pageMaker.endPage + 1 }">다음</a>
              </li>
            </c:if>
          </ul>
 	      </div>	
 	    
          <!--페이지 번호 클릭시 orderList주소로 보낼 파라미터 작업-->
          <form id="actionForm" action="/admin/order/orderList" method="get">
            <input type="hidden" name="startDate" value="${startDate}">
            <input type="hidden" name="endDate" value="${endDate}">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <input type="hidden" name="type" value="${pageMaker.cri.type}">
            <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">        
          </form>
        </nav>

  	    </div>
  	  </div>
  	</div>
  </div>
  </section>
  <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3, Bootstrap 3.3.7, AdminLTE App -->
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp" %>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->

<script>

  $(document).ready(function(){
    

    /* 배송상태 변경 */
    $("button[name='btnChangeOrderStatus']").on("click", function(){

      // 주문번호, 선택한 배송상태 값
      let odr_number = $(this).data("odr_number");
      let odr_status = $(this).parent().find("select[name='odr_status'] option:selected").val();

      $.ajax({
          url:'/admin/order/orderStatusChange',
          data: { odr_number : odr_number, odr_status : odr_status},
          dataType: 'text',
          success: function(result) {
            if(result == "success") {
              alert("배송상태가 변경되었습니다.");
            }
          }
        });

    });

    /* 체크박스 모두 선택 */
    let isCheck = true;

    $("#checkAll").on("click", function(){

      $(".check").prop("checked", this.checked); 

      isCheck = this.checked;

    });

    /* 체크박스 개별 선택 */
    $(".check").on("click", function(){

      $("#checkAll").prop("checked", this.checked);
      
      // 체크박스가 1개 이상 선택되었을 경우 : 모두 선택 체크박스 해제
      $(".check").each(function(){
    	  
        if(!$(this).is(":checked")) { 
          $("#checkAll").prop("checked", false);
          
        }
      });
    
    });

    /* 체크박스 선택 삭제 */
    $("button[name='btnCheckDelete']").on("click", function(){

      if($(".check:checked").length == 0) {
        alert("삭제할 주문정보를 선택하세요.");
        return;
      }

      let isOrderDelete = confirm("선택한 주문정보를 삭제하시겠습니까?");
      
      if(!isOrderDelete) return;

      // 삭제할 주문번호 - 배열 (자바스크립트 배열문법)
      let odrNumberArr = [];
      
      $(".check:checked").each(function(){
        odrNumberArr.push($(this).val());
      });


      $.ajax({
        url: '/admin/order/orderCheckedDelete',
        type: 'post',
        dataType: 'text',
        data: { odrNumberArr : odrNumberArr },
        success: function(result) {
          if(result == "success") {
            alert("주문정보가 삭제되었습니다.");

            location.href = "/admin/order/orderList";
          }
        }
      });

    });

    let actionForm = $("#actionForm");

    /* 상세 버튼 클릭 */
    $("button[name='btnOrderDetail']").on("click", function(){

      actionForm.find("input[name='odr_number']").remove();
      
      actionForm.append("<input type='hidden' name='odr_number' value='" + $(this).data("odr_number") + "'>");

      actionForm.attr("method", "get");
      actionForm.attr("action", "/admin/order/orderDetail");
      
      actionForm.submit();

    }); 
    
    /* 페이지 번호 클릭시 */
    $("ul.pagination li a.page-link").on("click", function(e){

      e.preventDefault();

      let pageNum = $(this).attr("href");

      actionForm.find("input[name='pageNum']").val(pageNum);

      // actionForm의 속성 변경
      actionForm.attr("method", "get");
      actionForm.attr("action", "/admin/order/orderList");
      
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