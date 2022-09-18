package com.forpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forpet.domain.CartVO;
import com.forpet.domain.CartVOList;

public interface CartMapper {
	
	/* 장바구니에 상품 추가 */
	void cart_add(CartVO vo);
	
	/* 장바구니 목록 */
	List<CartVOList> cart_list(String mem_id);
	
	/* 장바구니 상품 수량 변경 */
	void cart_amount_update(@Param("crt_code") Long crt_code, @Param("pdt_buy_amount") int pdt_buy_amount);

	/* 장바구니 상품 삭제*/
	void cart_delete(Long crt_code);
	
	/* 장바구니 비우기  : 상품 전체삭제  */
	void cart_empty(String mem_id);
	
}
