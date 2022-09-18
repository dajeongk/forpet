package com.forpet.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.forpet.domain.CartOrderInfo;
import com.forpet.domain.OrderPaymentInfo;
import com.forpet.domain.OrderVO;
import com.forpet.domain.PaymentVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.CartMapper;
import com.forpet.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = {@Autowired})
	private CartMapper cartMapper;
	
	@Setter(onMethod_ = {@Autowired})
	private OrderMapper orderMapper;
	
	/* 장바구니에서 주문하기  주문목록  */
	@Override
	public List<CartOrderInfo> cartOrderList(String mem_id) {
		
		return orderMapper.cartOrderList(mem_id);
	}
	
	/* 직접 구매하기 주문목록 */
	@Override
	public List<CartOrderInfo> directOrderList(Integer pdt_number, int odr_amount) {
		
		return orderMapper.directOrderList(pdt_number, odr_amount);
	}

	/* 주문내역 저장 */
	@Transactional
	@Override
	public void orderBuy(OrderVO o_vo, PaymentVO p_vo) {
		
		// 1) 주문 정보 저장. 
		orderMapper.orderSave(o_vo);
				
		// 2) 주문상세 정보 저장(장바구니 테이블에서 이동)
		Long odr_number = o_vo.getOdr_number();
		String mem_id = o_vo.getMem_id();
		
		orderMapper.orderDetailSave(odr_number, mem_id);
		
		// 3) 장바구니 삭제
		cartMapper.cart_empty(mem_id);
		
		// 4) 결제정보 저장하기
		p_vo.setOdr_number(odr_number);
		orderMapper.paymentSave(p_vo);
	}

	/* 주문완료 내역 정보 */
	@Override
	public List<OrderPaymentInfo> orderComplete(String mem_id) {
		
		return orderMapper.orderComplete(mem_id);
	}

	/* 주문내역 조회 */
	@Override
	public List<Map<String, Object>> getOrderProductInfo(String mem_id, String startDate, String endDate, Criteria cri) {
		
		return orderMapper.getOrderProductInfo(mem_id, startDate, endDate, cri);
	}

	/* 주문 데이터 개수  */
	@Override
	public int getTotalCount(String mem_id, String startDate, String endDate, Criteria cri) {
		
		return orderMapper.getTotalCount(mem_id, startDate, endDate, cri);
	}

	

}
