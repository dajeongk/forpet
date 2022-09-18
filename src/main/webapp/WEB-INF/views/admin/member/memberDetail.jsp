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
    /* 테이블 css */
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
       	 회원상세 관리
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
  			MEMBER DETAIL
  		</div>
  		<div class="box-body">
  		  <div>
            <h3 style="font-weight: bold;">회원상세 정보</h3>
          </div>

          <table class="table table-bordered">
		    <thead>
		      <tr>
		        <th scope="row">아이디</th>
		        <td>${memberVO.mem_id }</td>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <th scope="row">이름</th>
		        <td>${memberVO.mem_name }</td>
		      </tr>
		      <tr>
		        <th scope="row">연락처</th>
		        <td>${memberVO.mem_phone }</td>
		      </tr>
		      <tr>
		        <th scope="row">이메일</th>
		        <td>${memberVO.mem_email }</td>
		      </tr>
		      <tr>
		        <th scope="row">인증여부</th>
		        <td>${memberVO.mem_authcode }</td>
		      </tr>
		      <tr>
		        <th scope="row">우편번호</th>
		        <td>${memberVO.mem_postcode }</td>
		      </tr>
		      <tr>
		        <th scope="row">주소</th>
		        <td>${memberVO.mem_addr } | ${memberVO.mem_addr_d }</td>
		      </tr>
		      <tr>
		        <th scope="row">포인트</th>
		        <td>${memberVO.mem_point }</td>
		      </tr>
		      <tr>
		        <th scope="row">가입일</th>
		        <td><fmt:formatDate value="${memberVO.mem_sign_date }" pattern="yyyy-MM-dd hh:mm" /></td>
		      </tr>
		    </tbody>
		  </table>
		  <br>
		  <div class="form-group row">
            <div class="col-sm-6" style="text-align: left;">
              <button type="button" id="btnDelete" class="btn btn-danger">회원삭제</button>                 
            </div>
            <div class="col-sm-6" style="text-align: right;">
              <button type="button" id="btnList" class="btn btn-light">목록</button>		           
            </div>
          </div>
		       	
		  <!-- 주소로 보낼 파라미터 작업 -->
		  <form id="operForm" action="" method="get">
		    <input type="hidden" name="mem_id" value="${memberVO.mem_id}">
		    <input type="hidden" name="pageNum" value="${cri.pageNum}">
		    <input type="hidden" name="amount" value="${cri.amount}">
		    <input type="hidden" name="type" value="${cri.type}">
		    <input type="hidden" name="keyword" value="${cri.keyword}">
		  </form>     		  		  
   
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
    
    /* 회원삭제 버튼 클릭 */
    $("#btnDelete").on("click", function(){
          
   	  let mem_id = $("input[name='mem_id']").val();
   	  
      if(!confirm(mem_id + "님을 삭제하시겠습니까?")) return;

      $("#operForm").attr("action", "/admin/member/memberDelete");
      $("#operForm").attr("method", "post");
      $("#operForm").submit();
      
      alert("삭제되었습니다.");

    });
    
    /* 목록 버튼 클릭 */
    $("#btnList").on("click", function(){
  	  
      // 글번호, 페이징정보  
      let pageNum = $("input[name='pageNum']").val();
      let amount = $("input[name='amount']").val();
      let type = $("input[name='type']").val();
      let keyword = $("input[name='keyword']").val();
        
      location.href = "/admin/member/memberList?type=" + type + "&keyword=" + keyword + "&pageNum=" + pageNum + "&amount=" + amount;
        
    });


  });

</script>

</body>
</html>