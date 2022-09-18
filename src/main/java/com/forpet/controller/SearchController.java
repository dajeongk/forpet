package com.forpet.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.SearchService;
import com.forpet.util.UploadFileUtils;

import lombok.Setter;

@RequestMapping("/*")
@Controller
public class SearchController {

	@Resource(name = "uploadPath") 
	private String uploadPath;	
	
	@Setter(onMethod_ = {@Autowired})
	private SearchService searchService;
	
	/* ------------
	       상품 검색목록 
	 -------------- */
	@GetMapping("/search")
	public String search( @ModelAttribute("cri") Criteria cri, Model model) {
		
		cri.setAmount(12);
		
		List<ProductVO> productList = searchService.getSearchProductList(cri);
		
		// 날짜 폴더명의 \(역슬래시)를 /로 변환
		for(int i=0; i<productList.size(); i++) {
			String pdt_img_foler = productList.get(i).getPdt_img_folder().replace("\\", "/");
			productList.get(i).setPdt_img_folder(pdt_img_foler);
		}
		
		// 페이징쿼리에 의한 상품목록
		model.addAttribute("productList", productList);
		
		// 페이지 개수
		int totalCount = searchService.getSearchProductCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
		return "/search";
		
	}
	
	
	/* ------------------------
	        상품목록에서 이미지 보여주기
	 -------------------------- */
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {

		// 이미지를 바이트 배열로 읽어오는 작업
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" +fileName);
	}
}
