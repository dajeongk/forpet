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
  
  <!-- AdminLTE css파일 -->
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
  
  <style>
    /* 주문상품정보 테이블 css */
    #orderProductInfo th {
      text-align: center;
    }
    #orderProductInfo td {
      vertical-align: middle;
    }
    
    .form-control {
      display: inline;
    }
    </style>
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
       	 주문상세 관리
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
  			ORDER DETAIL
  		</div>
  		<div class="box-body">
  		  <div>
            <h3 style="font-weight: bold;">주문상세 내역</h3>
          </div>
           
          <br><h4>* 주문정보</h4>
          <table class="table table-bordered">
		    <thead>
		      <tr>
		        <th scope="row">주문번호</th>
		        <td>${orderVO.odr_number }</td>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <th scope="row">주문일</th>
		        <td><fmt:formatDate value="${orderVO.odr_date }" pattern="yyyy-MM-dd hh:mm" /></td>
		      </tr>
		      <tr>
		        <th scope="row">주문자</th>
		        <td>${orderVO.mem_id }</td>
		      </tr>
		      <tr>
		        <th scope="row">주문처리상태</th>
		        <td>${orderVO.odr_status }</td>
		      </tr>
		    </tbody>
		  </table>     		  		  
 	      
 	      <br><h4>* 결제정보</h4>
          <table class="table table-bordered">
		    <thead>
		      <tr>
		        <th scope="row">총 주문금액</th>
		        <td><p><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderVO.odr_total_price }"></fmt:formatNumber> 원</p></td>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <th scope="row">총 할인금액</th>
		        <td>0원</td>
		      </tr>
		      <tr>
		        <th scope="row">총 결제금액</th>
		        <td><p><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVO.pay_total_price }"></fmt:formatNumber> 원</p></td>
		      </tr>
		      <tr>
		        <th scope="row">결제수단</th>
		        <td>${paymentVO.pay_method }</td>
		      </tr>
		    </tbody>
		  </table>   

          <br><h4>* 주문 상품정보</h4>
          <div align="center">
          <table class="table" id="orderProductInfo">
		    <thead class="thead-light" style="text-align: center;">
		      <tr>
		        <th scope="col">이미지</th>	
		        <th scope="col">상품명</th>
		        <th scope="col">판매가</th>
		        <th scope="col">수량</th>
		        <th scope="col">총 구매금액</th>
		        <th scope="col">배송처리상태</th>
		        <th scope="col">주문처리상태</th>
		        <th scope="col">주문취소</th>
		      </tr>
		    </thead>
		    <tbody style="text-align: center;">
		      <c:forEach items="${orderProductMap }" var="orderProduct">
		      <tr><!-- Map의 키를 대문자로 사용(컬럼명) -->
		        <td scope="col">
		        <img src="/admin/order/displayFile?folderName=${orderProduct.PDT_IMG_FOLDER }&fileName=s_${orderProduct.PDT_IMG }" 
              	   alt="..." onerror="this.onerror=null; this.src='/img/noImage.png'"></td>
		        <td scope="col">${orderProduct.PDT_NAME }</td>
		        <td scope="col"><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderProduct.PDT_PRICE }"></fmt:formatNumber> 원</td>
		        <td scope="col">${orderProduct.ODR_AMOUNT } 개</td>
		        <td scope="col"><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderProduct.ODR_PRICE }"></fmt:formatNumber> 원</td>
		        <td scope="col">${orderProduct.ODR_STATUS }</td>
		        <td scope="col">${orderProduct.PAY_STATUS }</td>
		        <td scope="col"><button type="button" name="btnOrderCancel" data-odr_number="${orderProduct.ODR_NUMBER }" data-pdt_number="${orderProduct.PDT_NUMBER }" data-odr_price="${orderProduct.ODR_PRICE }" class="btn btn-light">취소</button></td>
		      </tr>	
		      </c:forEach>	      
		    </tbody>    
		  </table>   
		  </div>
       
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


<script>

  $(document).ready(function(){
    
    /* 주문상품 개별 취소 */
    $("button[name='btnOrderCancel']").on("click", function(){

      if(!confirm("주문을 취소하시겠습니까?")) return;

      let odr_number = $(this).data("odr_number");
      let pdt_number = $(this).data("pdt_number");
	  let odr_price = $(this).data("odr_price");
      
      location.href = "/admin/order/orderUnitProductCancel?odr_number=" + odr_number + "&pdt_number=" + pdt_number + "&odr_price=" + odr_price;

    });


  });

</script>

</body>
</html>