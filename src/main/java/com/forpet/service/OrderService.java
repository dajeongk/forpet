package com.forpet.service;

import java.util.List;
import java.util.Map;

import com.forpet.domain.CartOrderInfo;
import com.forpet.domain.OrderPaymentInfo;
import com.forpet.domain.OrderVO;
import com.forpet.domain.PaymentVO;
import com.forpet.dto.Criteria;

public interface OrderService {

	/* 장바구니에서 주문하기  주문목록 */
	List<CartOrderInfo> cartOrderList(String mem_id);
	
	/* 직접 구매하기 주문목록 */
	List<CartOrderInfo> directOrderList(Integer pdt_number, int odr_amount);
	
	/* 주문 정보 저장 */
	void orderBuy(OrderVO o_vo, PaymentVO p_vo);
	
	/* 주문완료 내역 정보 */
	List<OrderPaymentInfo> orderComplete(String mem_id);
	
	/* 주문내역 조회 */
	List<Map<String, Object>> getOrderProductInfo(String mem_id, String startDate, String endDate, Criteria cri);
	
	/* 주문 데이터 개수  */
	int getTotalCount(String mem_id, String startDate, String endDate, Criteria cri);
}
