package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.CartVO;
import com.forpet.domain.CartVOList;
import com.forpet.mapper.CartMapper;

import lombok.Setter;

@Service
public class CartServiceImpl implements CartService {

	@Setter(onMethod_ = {@Autowired})
	private CartMapper cartMapper;
	
	/* 장바구니에 상품 추가 */
	@Override
	public void cart_add(CartVO vo) {
		
		cartMapper.cart_add(vo);
		
	}

	/* 장바구니 목록 */
	@Override
	public List<CartVOList> cart_list(String mem_id) {
		
		return cartMapper.cart_list(mem_id);
	}

	/* 장바구니 수량 변경 */
	@Override
	public void cart_amount_update(Long crt_code, int pdt_buy_amount) {
		
		cartMapper.cart_amount_update(crt_code, pdt_buy_amount);
	}

	/* 장바구니 상품 삭제*/
	@Override
	public void cart_delete(Long crt_code) {
		
		cartMapper.cart_delete(crt_code);
	}

	/* 장바구니 비우기 : 상품 전체삭제 */
	@Override
	public void cart_empty(String mem_id) {
		
		cartMapper.cart_empty(mem_id);
	}

}
