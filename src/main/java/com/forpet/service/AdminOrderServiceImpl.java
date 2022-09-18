package com.forpet.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.forpet.domain.OrderVO;
import com.forpet.domain.PaymentVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.AdminOrderMapper;

import lombok.Setter;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

	@Setter(onMethod_ = {@Autowired})
	private AdminOrderMapper adminOrderMapper;

	/* 주문 목록 */
	@Override
	public List<OrderVO> getOrderList(String startDate, String endDate, Criteria cri) {
		
		return adminOrderMapper.getOrderList(startDate, endDate, cri);
	}

	/* 주문 데이터 개수 */
	@Override
	public int getOrderTotalCount(String startDate, String endDate, Criteria cri) {

		return adminOrderMapper.getOrderTotalCount(startDate, endDate, cri);
	}

	/* 주문 배송상태 변경 */
	@Override
	public void orderStatusChange(Long odr_number, String odr_status) {
		
		adminOrderMapper.orderStatusChange(odr_number, odr_status);
	}

	/* 선택한 주문정보 삭제 */
	@Transactional
	@Override
	public void orderDelete(Long odr_number) {
		
		// 주문삭제 기능 : 관련된 작업 모두 삭제. 트랜잭션 설정.
		// 주문테이블 삭제
		adminOrderMapper.orderDelete(odr_number);
		// 주문상세테이블 삭제
		adminOrderMapper.orderDetailDelete(odr_number);
		// 결제테이블 삭제
		adminOrderMapper.paymentDelete(odr_number);
			
	}

	/* 주문상세 내역 : 주문 정보 */
	@Override
	public OrderVO getOrderInfo(Long odr_number) {
		
		return adminOrderMapper.getOrderInfo(odr_number);
	}

	/* 주문상세 내역 : 결제정보 */
	@Override
	public PaymentVO getPaymentInfo(Long odr_number) {
		
		return adminOrderMapper.getPaymentInfo(odr_number);
	}

	/* 주문상품 정보 */
	@Override
	public List<Map<String, Object>> getOrderProductInfo(Long odr_number) {
		
		return adminOrderMapper.getOrderProductInfo(odr_number);
	}

	/* 주문상품 개별취소 */
	@Transactional
	@Override
	public void orderUnitProductCancel(Long odr_number, Integer pdt_number, int odr_price) {
		
		// 주문상세테이블의 데이터가 1개이면 주문테이블, 결제테이블의 주문정보 삭제 
		if(adminOrderMapper.getOrderDetailProductCount(odr_number) == 1) {
			// 주문테이블 삭제
			adminOrderMapper.orderDelete(odr_number);
			// 결제테이블 삭제
			adminOrderMapper.paymentDelete(odr_number);
		}
		
		// 1) 주문상세테이블 : 주문개별상품 데이터 삭제
		adminOrderMapper.orderDetailProductDelete(odr_number, pdt_number);
		// 2) 주문테이블 : 총 주문금액 변경
		adminOrderMapper.orderTotalPriceUpdate(odr_number, odr_price);
		// 3) 결제테이블 : 결제 총금액 변경
		adminOrderMapper.paymentTotalPriceUpdate(odr_number, odr_price);
		
	}

	/* 주문변경 목록  */
	@Override
	public List<OrderVO> getOrderChangeList(String startDate, String endDate, Criteria cri) {
		
		return adminOrderMapper.getOrderChangeList(startDate, endDate, cri);
	}

	/* 주문변경 데이터 개수 */
	@Override
	public int getOrderChangeTotalCount(String startDate, String endDate, Criteria cri) {
		
		return adminOrderMapper.getOrderChangeTotalCount(startDate, endDate, cri);
	}
	
}
