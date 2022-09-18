package com.forpet.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.forpet.kakaopay.ApproveResponse;
import com.forpet.kakaopay.ReadyResponse;

// 인터페이스 없이 단독 클래스 구성.
@Service
public class KakaoPayServiceImpl {

	/*
	  KakaoPay API
  	- HttpURLConnection을 이용한 HTTP통신
  	- RestTemplate를  이용한 작업. 
	 */
	
	
	/* ------------------------
	    KakaoPay에서 요청하는 정보
	 -------------------------- */
	public ReadyResponse payReady(String itemName, int quantity, String mem_id, int totalAmount) {
		
		String order_id = "100";
		
		// 카카오 pay가 요청한 결제요청 request정보를 구성
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("cid", "TC0ONETIME"); // 테스트 가맹점ID
		parameters.add("partner_order_id", order_id); // 가맹점 주문번호.
		parameters.add("partner_user_id", mem_id); // 가맹점 회원ID
		parameters.add("item_name", itemName); // 상품명 
		parameters.add("quantity", String.valueOf(quantity)); // 상품수량 
		parameters.add("total_amount", String.valueOf(totalAmount)); // 상품총액
		parameters.add("tax_free_amount", "0"); // 상품비과세금액
		parameters.add("approval_url", "http://localhost:9090/user/order/orderApproval");  // 결제요청 성공시 redirect url
		parameters.add("cancel_url", "http://localhost:9090/user/order/orderCancel"); // 결제 취소시 redirect url
		parameters.add("fail_url", "http://localhost:9090/user/order/orderFail"); // 결제 실패시 redirect url
		
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());
			
		// 외부 URL통신
		RestTemplate template = new RestTemplate();
		String url = "https://kapi.kakao.com/v1/payment/ready";
		
		// 1번째 요청
		ReadyResponse readyResponse = template.postForObject(url, requestEntity, ReadyResponse.class);
		
		return readyResponse;
	}
	
	
	/*---------------------------
	   2번째 요청 : 결제 승인요청 메서드
	 ---------------------------- */
	public ApproveResponse payApprove(String tid, String pgToken, String mem_id) {
		
		String order_id = "100";
		
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("cid", "TC0ONETIME"); // 테스트 가맹점ID
		parameters.add("tid", tid); // 카카오 페이에서 보내준 결재고유 ID
		parameters.add("partner_order_id", order_id); // 주문번호
		parameters.add("partner_user_id", mem_id); // 주문자
		parameters.add("pg_token", pgToken); // 
		
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());
		
		// 외부 URL통신
		RestTemplate template = new RestTemplate();
		String url = "https://kapi.kakao.com/v1/payment/approve";
		
		// 2번째요청(결제승인)
		ApproveResponse readyResponse = template.postForObject(url, requestEntity, ApproveResponse.class);
		
		return readyResponse;
		
		
	}
	
	/* ---------------------------------------------
	    KakaoPay request의 두번사용시 공통 Header정보 설정
	 ----------------------------------------------- */
	private HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK 470c4fd6fbf1e9e08aa1c1afad77b2d8");
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		return headers;
	}
	
}
