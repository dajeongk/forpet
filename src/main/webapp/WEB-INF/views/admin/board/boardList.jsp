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
    /* 문의게시판 테이블 css */
    .table td {
      vertical-align: middle;
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
       	 상품문의 목록
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
  			PRODUCT Q&A LIST
  		</div>
  		<div class="box-body">
  		  <div class="mb-3 px-3 py-3 pt-md-5 pb-md-4 mx-auto">
		    <form id="boardListForm" action="/admin/board/boardList" method="get" class="form-inline">
			  <select name="type" class="form-control mr-sm-2">
				  <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }" />>제목</option>
				  <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }" />>내용</option>
				  <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }" />>작성자</option>
				  <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }" />>제목+내용</option>
				  <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }" />>제목+작성자</option>
				  <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }" />>제목+작성자+내용</option>
			  </select>
			  <input type="text" name="keyword" value="${pageMaker.cri.keyword }" class="form-control mr-sm-2">
			  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			  <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			  <button type="button" id="btnSearch" class="btn btn-light">검색</button>	  
		    </form>
		  </div>
		  
 		  <table class="table" style="text-align: center;">
		    <thead style="text-align: center;">
			  <tr>			
		        <th scope="col">글번호</th>
		        <th scope="col">제목</th>
		        <th scope="col">작성자</th>
		        <th scope="col">등록일</th>     
			  </tr>
			  </thead>
			  <tbody>
			    <c:forEach items="${boardList }" var="board">
			    <tr>
			      <td scope="row"><c:out value="${board.brd_number }" /></td>
			      <td>
			        <a class="move" href="${board.brd_number }" style="color: black;">
			          <c:out value="${board.brd_title }" escapeXml="true" />
			        </a>
			      </td>
			      <td><c:out value="${board.mem_id }" /></td>
			      <td><fmt:formatDate value="${board.brd_date }" pattern="yyyy-MM-dd hh:mm" /></td>
			    </tr>
			    </c:forEach>
			  </tbody>
		  </table>
		  
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
 	    
            <!-- 페이지 번호 클릭시 boardList주소로 보낼 파라미터 작업 -->
            <form id="actionForm" action="/admin/board/boardList" method="get">
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


<script>

  $(document).ready(function(){
    
	let boardListForm = $("#boardListForm"); 
	
	let actionForm = $("#actionForm");
	
	/* 페이지 번호 클릭 */
	$("ul.pagination li a.page-link").on("click", function(e) {
		
		e.preventDefault(); 

		// 현재 선택한 페이지번호 변경작업.  
		let pageNum = $(this).attr("href");
		
		actionForm.find("input[name='pageNum']").val(pageNum);	
		actionForm.attr("action", "/admin/board/boardList");

		actionForm.submit();

	});
		
	/* 목록에서 제목 클릭 */
	$("a.move").on("click", function(e) {

		e.preventDefault(); 
		
		let brd_number = $(this).attr("href");

		boardListForm.find("input[name='brd_number']").remove();

		boardListForm.append("<input type='hidden' name='brd_number' value='" + brd_number + "'>");
		boardListForm.attr("action", "/admin/board/boardGet");

		boardListForm.submit();

	});
	
     	
	/* 검색버튼 클릭시 pageNum 초기화 */
	$("#btnSearch").on("click", function(){

		boardListForm.find("input[name='pageNum']").val(1);
    	boardListForm.submit();
      
    });

  });

</script>

</body>
</html>