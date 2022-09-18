package com.forpet.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.forpet.domain.OrderVO;
import com.forpet.domain.PaymentVO;
import com.forpet.dto.Criteria;

public interface AdminOrderMapper {

	/* 주문 목록 */
	List<OrderVO> getOrderList(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("cri") Criteria cri);
	
	/* 주문 데이터 개수 */
	int getOrderTotalCount(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("cri") Criteria cri);
	
	
	/* 주문 배송상태 변경 */
	void orderStatusChange(@Param("odr_number") Long odr_number, @Param("odr_status") String odr_status);

	
	/* 선택한 주문정보 삭제 */
	// 1) 주문테이블 삭제
	void orderDelete(Long odr_number);
	// 2) 주문상세테이블 삭제
	void orderDetailDelete(Long odr_number);
	// 3) 결제테이블 삭제
	void paymentDelete(Long odr_number);
	
	
	/* 주문상세 내역 : 주문정보 */
	OrderVO getOrderInfo(Long odr_number);
	
	/* 주문상세 내역 : 결제정보 */
	PaymentVO getPaymentInfo(Long odr_number);
	
	/* 주문상품 정보 */
	List<Map<String, Object>> getOrderProductInfo(Long odr_number);
	
	
	/* 주문상품 개별취소 */
	// 1) 주문상세테이블 : 주문개별상품 데이터 삭제
	void orderDetailProductDelete(@Param("odr_number") Long odr_number, @Param("pdt_number") Integer pdt_number);
	// 2) 주문테이블 : 총 주문금액 변경
	void orderTotalPriceUpdate(@Param("odr_number") Long odr_number, @Param("odr_price") int odr_price);
	// 3) 결제테이블 : 결제 총금액 변경
	void paymentTotalPriceUpdate(@Param("odr_number") Long odr_number, @Param("odr_price") int odr_price);

	
	/* 주문상세테이블의 데이터 1개인지 확인 */
	int getOrderDetailProductCount(Long odr_number);
	
	
	/* 주문변경 목록  */
	List<OrderVO> getOrderChangeList(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("cri") Criteria cri);
	
	/* 주문 데이터 개수 */
	int getOrderChangeTotalCount(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("cri") Criteria cri);
}
