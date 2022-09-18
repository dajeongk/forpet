<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin</title>
  
  <!-- AdminLTE css파일 -->
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>

  <link rel="stylesheet" href="/css/admLogin.css">

  <script>
  	
  	let msg = "${msg}";
  
  	if(msg == "noID") {
  		alert("관리자 아이디를 확인해주세요.");
  	}else if(msg == "noPW") {
  		alert("비밀번호가 일치하지 않습니다.");
  	}
  	
  
  </script>
</head>
<body>
<div class="login">
	<h1 style="font-weight: bold;">관리자 로그인</h1><br>
    <form id="admLoginForm" action="admLogin_ok" method="post">
    	<input type="text" id="adm_id" name="adm_id" placeholder="Username" required="required" />
        <input type="password" id="adm_pw" name="adm_pw" placeholder="Password" required="required" />
        <button type="submit" id="btnSignIn" class="btn btn-primary btn-block btn-large" >LOGIN</button>
    </form>
</div>

<script src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script>
	
</body>
</html>