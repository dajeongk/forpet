package com.forpet.service;

import java.util.List;

import com.forpet.domain.CartVO;
import com.forpet.domain.CartVOList;

public interface CartService {

	/* 장바구니에 상품 추가 */
	void cart_add(CartVO vo);
	
	/* 장바구니 목록 */
	List<CartVOList> cart_list(String mem_id);
	
	/* 장바구니 수량 변경 */
	void cart_amount_update(Long crt_code, int pdt_buy_amount);
	
	/* 장바구니 상품 삭제*/
	void cart_delete(Long crt_code);
	
	/* 장바구니 비우기  : 상품 전체삭제  */
	void cart_empty(String mem_id);
}
