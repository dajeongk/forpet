package com.forpet.service;

import java.util.List;
import java.util.Map;

import com.forpet.domain.OrderVO;
import com.forpet.domain.PaymentVO;
import com.forpet.dto.Criteria;

public interface AdminOrderService {

	/* 주문 목록 */
	List<OrderVO> getOrderList(String startDate, String endDate, Criteria cri);
	
	/* 주문 데이터 개수 */
	int getOrderTotalCount(String startDate, String endDate, Criteria cri);
	
	/* 주문 배송상태 변경 */
	void orderStatusChange(Long odr_number, String odr_status);
	
	/* 선택한 주문정보 삭제 */
	void orderDelete(Long odr_number);
	
	/* 주문상세 내역 : 주문 정보 */
	OrderVO getOrderInfo(Long odr_number);
	
	/* 주문상세 내역 : 결제정보 */
	PaymentVO getPaymentInfo(Long odr_number);
	
	/* 주문상품 정보 */
	List<Map<String, Object>> getOrderProductInfo(Long odr_number);
	
	/* 주문상품 개별취소 */
	void orderUnitProductCancel(Long odr_number, Integer pdt_number, int odr_price);
	
	/* 주문변경 목록  (목록과 카운트 작업은 동일하게 해야함.) */
	List<OrderVO> getOrderChangeList(String startDate, String endDate, Criteria cri);

	/* 주문변경 데이터 개수 */
	int getOrderChangeTotalCount(String startDate, String endDate, Criteria cri);
}

