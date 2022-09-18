package com.forpet.controller;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.forpet.domain.ProductVO;
import com.forpet.service.UserProductService;

import lombok.Setter;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Setter(onMethod_ = {@Autowired})
	private UserProductService userProductService;
	
	/* -----------
	       메인 페이지 
	 ------------- */
	@GetMapping("/")
	public String index(Integer ctg_code, String ctg_name, Model model) {
		
		// 1) 강아지 장난감 카테고리
		List<ProductVO> productList = userProductService.bestCategoryList(303);
		
		// 날짜 폴더명의 \(역슬래시)를 /로 변환 
		for(int i=0; i<productList.size(); i++) {
			String pdt_img_foler = productList.get(i).getPdt_img_folder().replace("\\", "/"); 
			productList.get(i).setPdt_img_folder(pdt_img_foler);
		}
		
		model.addAttribute("productList", productList);
		
		// 2) 고양이 간식 카테고리
		List<ProductVO> productList2 = userProductService.bestCategoryList(402);
		
		// 날짜 폴더명의 \(역슬래시)를 /로 변환
		for(int i=0; i<productList2.size(); i++) {
			String pdt_img_foler = productList2.get(i).getPdt_img_folder().replace("\\", "/"); 
			productList2.get(i).setPdt_img_folder(pdt_img_foler);
		}
				
		model.addAttribute("productList2", productList2);
		
		return "index";
	}
	
}
