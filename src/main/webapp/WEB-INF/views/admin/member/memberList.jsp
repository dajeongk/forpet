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
    .table tbody tr td {
      vertical-align: middle;
      text-align: center;
    }
    .table th {
      text-align: center;
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
       	 회원목록 관리
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
  			MEMBER LIST
  		  </div>
  		<div class="box-body">
  		  <form id="searchForm" action="/admin/member/memberList" method="get">
 		    <select name="type">
 		      <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }" />>--</option>
	          <option value="N" <c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : '' }" />>이름</option>
	          <option value="I" <c:out value="${pageMaker.cri.type eq 'I' ? 'selected' : '' }" />>아이디</option>
  		    </select>
		      <input type="text" name="keyword" value="${pageMaker.cri.keyword }">
		      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		      <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		      <button type="button" id="btnSearch" class="btn btn-light">검색</button>
		  </form>
 		  <table class="table table-hover">
	      <thead>
	        <tr>
	          <th scope="col">이름</th>
	          <th scope="col">아이디</th>
	          <th scope="col">연락처</th>
	          <th scope="col">이메일</th>
	          <th scope="col">포인트</th>
	          <th scope="col">가입일</th>
	          <th scope="col">회원관리</th>
	        </tr>
	      </thead>
        <tbody>
          <c:forEach items="${memberList }" var="memberVO">
          <tr>
            <td><c:out value="${memberVO.mem_name }" /></td>
            <td><c:out value="${memberVO.mem_id }"/></td>
            <td><c:out value="${memberVO.mem_phone }"/></td>
            <td><c:out value="${memberVO.mem_email }"/></td>
            <td><c:out value="${memberVO.mem_point }" /></td>
            <td><fmt:formatDate value="${memberVO.mem_sign_date }" pattern="yyyy-MM-dd hh:mm" /></td>
            <td><button type="button" id="btnDetail" data-mem_id = "${memberVO.mem_id }" class="btn btn-light">상세</button></td>
          </tr>
          </c:forEach>
        </tbody>
      </table>

      <nav aria-label="...">
        <div class="form-gourp" align="center">
        <ul class="pagination">
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
 	    
        <!--페이지 번호 클릭시 memberList주소로 보낼 파라미터 작업-->
        <form id="actionForm" action="/admin/member/memberList" method="get">
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

  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3, Bootstrap 3.3.7, AdminLTE App -->
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp" %>


<script>

  $(document).ready(function(){
    
	let actionForm = $("#actionForm");  
	  
	/* 상세 버튼 클릭 */  
	$("#btnDetail").on("click", function() {
	  
	  actionForm.find("input[name='mem_id']").remove();
	      
      actionForm.append("<input type='hidden' name='mem_id' value='" + $(this).data("mem_id") + "'>");

      actionForm.attr("method", "get");
      actionForm.attr("action", "/admin/member/memberDetail");
      
      actionForm.submit();
      
	});
	  
 
    /* 페이지 번호 클릭 */
    $("ul.pagination li a.page-link").on("click", function(e){

      e.preventDefault();
      
      actionForm.find("input[name='mem_id']").remove();

      let pageNum = $(this).attr("href");

      actionForm.find("input[name='pageNum']").val(pageNum);

      // actionForm의 속성 변경
      actionForm.attr("method", "get");
      actionForm.attr("action", "/admin/member/memberList");
      
      actionForm.submit();
      
    });  

    let searchForm = $("#searchForm")

    // 검색버튼 클릭시 pageNum 초기화
    $("#btnSearch").on("click", function(){

      searchForm.find("input[name='pageNum']").val(1);
      searchForm.submit();
      
    });


  });

</script>

</body>
</html>