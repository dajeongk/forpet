package com.forpet.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.forpet.domain.CartOrderInfo;
import com.forpet.domain.OrderPaymentInfo;
import com.forpet.domain.OrderVO;
import com.forpet.domain.PaymentVO;
import com.forpet.dto.Criteria;

public interface OrderMapper {
	
	/* 장바구니에서 주문하기  주문목록 */
	List<CartOrderInfo> cartOrderList(String mem_id);
	
	/* 직접 구매하기 주문목록 */
	List<CartOrderInfo> directOrderList(@Param("pdt_number") Integer pdt_number, @Param("odr_amount") int odr_amount);
	
	
	/* 주문하기 기능  : 주문 테이블, 주문상세 테이블, 장바구니 테이블 */
	// 1) 주문정보 저장 
	void orderSave(OrderVO o_vo); // odr_number 필드에 시퀀스 값이 채워짐.
	// 2) 주문상세정보 저장 
	void orderDetailSave(@Param("odr_number") Long odr_number, @Param("mem_id") String mem_id);
	// 3) 결제정보 저장
	void paymentSave(PaymentVO p_vo);
	
	
	/* 주문완료 내역 정보 */
	List<OrderPaymentInfo> orderComplete(String mem_id);
	
	/* 주문내역 조회 */
	List<Map<String, Object>> getOrderProductInfo(@Param("mem_id") String mem_id, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("cri") Criteria cri);
	
	/* 주문 데이터 개수  */
	int getTotalCount(@Param("mem_id") String mem_id, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("cri") Criteria cri);
}
