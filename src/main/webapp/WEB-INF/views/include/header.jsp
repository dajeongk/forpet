<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 헤더메뉴 css -->
<style>
#nav {
  list-style: none;
  padding: 5px 1px;
  margin: 0;
}
#nav ul{
  list-style: none;
  margin: 0;
  padding: 0;
  position: absolute;
  left: 0;
  top: 30px;
  text-align: left;
  opacity: 0;
}
#nav ul li{
  float: none;
  margin: 0;
  padding: 0;
}
#nav li{
  float: left;
  position: relative;
}
#nav li a{
  display: inline;
  margin : 0;

}
#nav li:hover ul{
  opacity: 1;
}
#nav li:hover ul li{
  height: 30px;
  overflow: visible;
  padding: 0;
}
#nav ul li:hover > a{
  margin : 0;
  padding: 5px;
  background: white;
  color: black;
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
}

</style>

<div id="top-banner" class="flexslider">
<ul class="banner" style="width:100%; background: #2C4B7B; text-align: center; opacity: 1;">  
  <li style="display: block; line-height: 250%;">
	<a style="color: white; font-weight: bold;">지금 회원가입하면  전 상품 무료배송! 🌼</a>
  </li>
</ul>
</div>
      
<div class="d-flex flex-column flex-md-row p-3 px-md-4 mb-3">
  <a href="/" class="my-0 mr-md-auto p-2 text-dark"><small>홈으로</small></a>
  <nav>  
    <ul id="nav">
      <li>
        <c:if test="${sessionScope.loginStatus == null }">
  	    <!-- 로그인 이전 -->
        <a class="p-2 text-dark" href="/member/login"><Small>로그인</Small></a> |
        <a class="p-2 text-dark" href="/member/join"><small>회원가입</small></a> |
        </c:if>
      </li>
      <li>
        <c:if test="${sessionScope.loginStatus != null }">
        <!-- 로그인 이후 -->
        <a class="p-2 text-dark" href="/member/logout"><small>로그아웃[${sessionScope.loginStatus.mem_name }님]</small></a> |
        <a class="p-2 text-dark" href="/member/confirmPW"><small>회원정보 수정</small></a> |
        </c:if>
      </li>
      <li><a class="p-2 text-dark" href="/user/cart/cart_list"><small>장바구니</small></a> |</li>
      <li><a class="order p-2 text-dark" href="/user/order/orderDetailList"><small>주문조회</small></a> |</li>
      <li><a class="p-2 text-dark" href="회원정보 조회주소"><small>마이페이지</small></a>
        <ul>
          <li>
            <a class="p-2 text-dark" href="/user/board/boardList"><small>문의게시판</small></a>
          </li>
          <li>
            <a class="p-2 text-dark" href="/user/board/boardWrite"><small>문의작성</small></a>
          </li>
        </ul>
      </li>
    </ul>
    </nav>
</div>

<div align="center">
	<a href="/" style="text-decoration: none">
	  <h1 style="color:#2C4B7B; font-weight: bold;">forpet</h1> <br><br>
	</a>
</div>


