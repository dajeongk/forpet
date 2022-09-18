package com.forpet.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forpet.domain.CategoryVO;
import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.UserProductService;
import com.forpet.util.UploadFileUtils;

import lombok.Setter;

@RequestMapping("/user/product/*")
@Controller
public class UserProductController {

	@Resource(name = "uploadPath") 
	private String uploadPath;	
	
	@Setter(onMethod_ = {@Autowired})
	private UserProductService userProductService;
	
	/* ---------------
	    2차 카테고리 정보  
	 ------------------ */
	@ResponseBody
	@GetMapping("/subCategoryList/{ctg_code}")
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("ctg_code") Integer ctg_code) {
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CategoryVO>>(userProductService.getSubCategoryList(ctg_code), HttpStatus.OK);
		
		return entity;
	}
	
	/* ---------
	       상품 목록
	 ----------- */
	@GetMapping("/productList/{ctg_code}/{ctg_name}")
	public String productList(@PathVariable("ctg_code") Integer ctg_code, @PathVariable("ctg_name") String ctg_name, 
							  @ModelAttribute("cri") Criteria cri, Model model) {
			
		cri.setAmount(12);
		
		List<ProductVO> productList = userProductService.getProductListBySubCategory(ctg_code, cri);
		
		// 날짜 폴더명의 \(역슬래시)를 /로 변환
		for(int i=0; i<productList.size(); i++) {
			String pdt_img_foler = productList.get(i).getPdt_img_folder().replace("\\", "/"); 
			productList.get(i).setPdt_img_folder(pdt_img_foler);
		}
		
		// 페이징쿼리에 의한 상품목록
		model.addAttribute("productList", productList);
		
		// 페이지 개수
		int totalCount = userProductService.getProductCountBySubCategory(ctg_code, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
		return "/user/product/productList";
	}
	
	/* ----------------------
	      상품목록에서 이미지 보여주기
	 ------------------------ */
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {		
		
		// 이미지를 바이트 배열로 읽어오는 작업
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" +fileName);
	}
	
	/* --------------------
	       상품목록 : 상품상세정보 
	 ---------------------- */
	@GetMapping("/productDetail")
	public String productDetail(@RequestParam("pdt_number") Integer pdt_number, @ModelAttribute("ctg_code") Integer ctg_code, 
								@ModelAttribute("ctg_name") String ctg_name, @ModelAttribute("cri") Criteria cri, Model model) {
		
		ProductVO vo = userProductService.getProductByNum(pdt_number);
		vo.setPdt_img_folder(vo.getPdt_img_folder().replace("\\", "/"));
		
		model.addAttribute("productVO", vo);
		
		return "/user/product/productDetail";
	
	}
	
	/* -----------------------
	       모달 대화상자 : 상품상세정보 
	  ------------------------ */
	@ResponseBody
	@GetMapping("/productDetail/{pdt_number}")
	public ResponseEntity<ProductVO> productDetail(@PathVariable("pdt_number") Integer pdt_number) {
		
		ResponseEntity<ProductVO> entity = null;
		
		ProductVO vo = userProductService.getProductByNum(pdt_number);
		vo.setPdt_img_folder(vo.getPdt_img_folder().replace("\\", "/")); // 날짜폴더명 변환
		
		entity = new ResponseEntity<ProductVO>(vo, HttpStatus.OK);
		
		return entity;
	}
}
