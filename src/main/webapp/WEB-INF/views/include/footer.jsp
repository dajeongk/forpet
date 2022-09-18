<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 풋터메뉴 css -->    
<style>
.company {
  padding-left: 20px;
}

.bottom {
  padding-left: 30px;
}

#footer_menu {
  list-style: none;
  padding: 5px 1px;
  padding-left: 25px;
  margin: 0;
  color: white;
}
#footer_menu ul{
  list-style: none;
  margin: 0;
  padding: 0;
  position: absolute;
  left: 0;
  top: 30px;
  text-align: left;
  opacity: 0;
}
#footer_menu ul li{
  float: none;
  margin: 0;
  padding: 0;
}
#footer_menu li{
  float: left;
  position: relative;
}
#footer_menu li a{
  display: inline;
  margin : 0;
}

.title {
  color: #2C4B7B;
  font-weight: bold;
  padding-top: 20px;
  padding-left: 30px;
}

.footer_info {
  padding-left: 30px;
}
.footer_info li a {
  text-decoration: none;
}

</style>    

    
<footer class="pt-4 my-md-5 footer">
    
<div class="footer">
  <!-- 풋터 메뉴 -->
	<div class="footer_menu">
	  <nav>
	    <ul id="footer_menu">
	      <li><a href="#" class="btn"><small>홈</small></a></li>
	      <li><a href="#" class="btn"><small>회사소개</small></a></li>
		  <li><a href="#" class="btn"><small>이용안내</small></a></li>
		  <li><a href="#" class="btn"><small>이용약관</small></a></li>
		  <li><a href="#" class="btn"><small>개인정보처리방침</small></a></li>
	    </ul>
	  </nav>	
	</div>
  <br><hr>

  <div class="row">
    <div class="col-6 col-md">
      <h4 class="title">FORPET</h4>
        <ul class="footer_info list-unstyled text-small">
          <li><a class="text-muted" href="#"><small>대표자 : 김다정  </small></a></li>
          <li><a class="text-muted" href="#"><small>사업자등록번호 :  123-456-789 </small></a></li>
          <li><a class="text-muted" href="#"><small>개인정보보호책임자 :  김다정 </small></a></li>
          <li><a class="text-muted" href="#"><small>통신판매업 : 제 2022-서울강남-01570호</small></a></li>
          <li><a class="text-muted" href="#"><small>Tel : 1234-1234 </small></a></li>
          <li><a class="text-muted" href="#"><small>Email : forpet@email.com</small></a></li>
        </ul>
      </div>
      <div class="col-6 col-md">
        <h4 class="title">고객만족센터</h4>
        <ul class="footer_info list-unstyled text-small">
          <li><a class="text-muted" href="#">02-1004-1004</a></li>
          <li><a class="text-muted" href="#"><small>평일 : am10:00 - pm18:00</small></a></li>
          <li><a class="text-muted" href="#"><small>점심시간 : pm12:00-pm13:00</small></a></li>
          <li><a class="text-muted" href="#"><small>(토요일 / 일요일 / 공휴일 휴무)</small></a></li>
        </ul>
      </div>
      <div class="col-6 col-md">
        <h4 class="title">입금계좌 정보</h4>
        <ul class="footer_info list-unstyled text-small">
          <li><a class="text-muted" href="#"><small>신한은행 : 111-111-1111</small></a></li>
          <li><a class="text-muted" href="#"><small>예금주 : 주식회사 포어펫</small></a></li><br>
          <li>
            <select onchange="window.open(this.value,'bank','')" >
              <option selected="">인터넷뱅킹 바로가기</option>
			  <option value="http://www.kbstar.com"> 국민은행 </option>
			  <option value="http://www.scfirstbank.com"> 제일은행 </option>
			  <option value="http://www.wooribank.com"> 우리은행 </option>
			  <option value="http://www.kiupbank.co.kr"> 기업은행 </option>
			  <option value="http://www.kjbank.com"> 광주은행 </option>
			  <option value="http://www.daegubank.co.kr"> 대구은행 </option>
			  <option value="http://www.hanabank.com"> 하나은행 </option>
			  <option value="http://www.shinhan.com"> 신한은행 </option>
			  <option value="http://www.keb.co.kr"> 외환은행 </option>
			  <option value="http://www.jbbank.co.kr"> 전북은행 </option>
			  <option value="http://www.pusanbank.co.kr"> 부산은행 </option>
			  <option value="http://www.chb.co.kr"> 조흥은행 </option>
			  <option value="http://www.goodbank.com"> 한미은행 </option>
			  <option value="http://www.chejubank.co.kr"> 제주은행 </option>
			  <option value="http://www.kyongnambank.co.kr"> 경남은행</option>
			  <option value="http://www.epostbank.go.kr"> 우체국 </option>
			  <option value="http://banking.nonghyup.com"> 농협 </option>
		  </select>
		  </li>
        </ul>
      </div>
      <div class="col-6 col-md">
        <h4 class="title">교환/반품 주소</h4>
        <ul class="footer_info list-unstyled text-small">
          <li><a class="text-muted" href="#"><small>서울특별시 노원구 상계로64</small></a></li>
          <li><a class="text-muted" href="#"><small>(주)포어펫 물류창고</small></a></li>
          <li><a class="text-muted" href="#"><small>64, Sanggye-ro, Nowon-gu, Seoul, Republic of Korea</small></a></li>
          <li><a class="text-muted" href="#"><small>* 공지사항 및 이용안내를 참고하여 반품요청해주세요.</small></a></li>
        </ul>
      </div>
    </div>
    <div class="bottom pt-4">
      <small>© copyright (c) www.forpet.co.kr all rights reserved.</small>
    </div>
 </div>
</footer>