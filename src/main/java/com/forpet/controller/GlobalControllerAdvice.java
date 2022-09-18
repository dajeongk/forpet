package com.forpet.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.forpet.service.UserProductService;

import lombok.Setter;

@ControllerAdvice(basePackages = {"com.forpet.controller"})
public class GlobalControllerAdvice {

	@Setter(onMethod_ = {@Autowired})
	private UserProductService userProductService; 
	
	/* 1차 카테고리 Model 작업  */
	@ModelAttribute
	public void categoryList(Model model) {	
		
		model.addAttribute("mainCategoryList", userProductService.getCategoryList());
	}
	
}
