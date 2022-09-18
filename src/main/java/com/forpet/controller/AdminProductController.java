package com.forpet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forpet.domain.CategoryVO;
import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.AdminProductService;
import com.forpet.util.UploadFileUtils;

import lombok.Setter;

@RequestMapping("/admin/product/*")
@Controller
public class AdminProductController {

	@Resource(name = "uploadPath") 
	private String uploadPath;	
	
	@Setter(onMethod_ = {@Autowired})
	private AdminProductService admPdtService;
	
	/* --------------------------
	       상품등록 폼 : 1차 카테고리 정보  
	 ---------------------------- */
	@GetMapping("/productInsert")
	public void productInsert(Model model) {
		
		model.addAttribute("cateList", admPdtService.getCateList());
	}
	
	/* --------------------------
	       상품등록 폼 : 2차 카테고리 정보  
	 ---------------------------- */
	@ResponseBody
	@GetMapping("subCategoryList/{categoryCode}")
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("categoryCode") Integer categoryCode) {
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CategoryVO>>(admPdtService.getSubCateList(categoryCode), HttpStatus.OK);
	
		return entity;
	}
	
	/* --------------------------------------------------------------
	    CKEditor 웹에디터를 통한 이미지 업로드(상세설명에서 사용하는 설명이미지 파일) 
	 ---------------------------------------------------------------- */
	@PostMapping("/imageUpload") 
	public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		
	
		// 입출력 스트림방식으로 파일 업로드 구현
		OutputStream out = null;
		// 개체의 형식화된 표현을 텍스트 출력스트림에 출력하는 기능을 제공
		PrintWriter printWriter = null; 
		
		// 클라이언트의 브라우저에게 보내는 정보
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		try {
		String fileName = upload.getOriginalFilename(); // 클라이언트에서 업로드한 원본 파일명.
		byte[] bytes = upload.getBytes(); // 업로드 파일
		
			// 서버측의 업로드폴더 경로 작업. 1)프로젝트 내부 2)외부
			// 1) 프로젝트 내부
			String uploadTomcatTempPath = req.getSession().getServletContext().getRealPath("/") + "resources\\upload\\"; 
				
			// 2) 외부 폴더 - 톰캣의 server.xml에 설정정보 참고
			String uploadPath = "C:\\Dev\\upload\\ckeditor\\";
			
			uploadPath = uploadPath + fileName;
			
			out = new FileOutputStream(new File(uploadPath)); 
			out.write(bytes); 
			
			// CKEditor에게 보낼 파일정보
			printWriter = res.getWriter();
			
			// 클라이언트에서 요청할 이미지 주소 정보
			String fileUrl = "/upload/" + fileName;
			
			//  CKEditor 4.x version에서 요구하는 json포맷
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); 

			
		}catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			if(out != null) {
				try {
					out.close();
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) {
				printWriter.close();
			}
		}
		
	}
	
	/* -------------
	       상품 정보 저장
	 --------------- */
	@PostMapping("/productInsert")
	public String productInsert(ProductVO vo, RedirectAttributes rttr) {

		// 파일 업로드 작업(이미지 파일명이 저장될 pdt_img필드에 업로드한 후 실제 파일명을 저장)
		String uploadDateFolerPath = UploadFileUtils.getFolder();
		vo.setPdt_img_folder(uploadDateFolerPath); // 날짜 폴더명
		vo.setPdt_img(UploadFileUtils.uploadFile(uploadPath, uploadDateFolerPath, vo.getUploadFile())); // 실제 업로드한 파일명
		 	
		// 상품정보 저장
		admPdtService.productInsert(vo);
		
		return "redirect:/admin/product/productList";
	}
	
	/* -------------------------
	       상품 목록 : 페이징, 검색 추가
	 --------------------------- */
	@GetMapping("/productList")
	public void productList(@ModelAttribute("cri") Criteria cri, Model model) {
		
		List<ProductVO> productList = admPdtService.getProductList(cri);
		
		// 날짜 폴더명의 \(역슬래시)를 /로 변환
		for(int i=0; i<productList.size(); i++) {
			String pdt_img_foler = productList.get(i).getPdt_img_folder().replace("\\", "/"); 
			productList.get(i).setPdt_img_folder(pdt_img_foler);
		}
		
		// 페이징쿼리에 의한 상품목록
		model.addAttribute("productList", productList);
		
		// 페이지 개수
		int totalCount = admPdtService.getProductTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
	}
	
	/* -----------------------
	       상품목록에서 이미지 보여주기
	 ------------------------- */
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {

		// 이미지를 바이트 배열로 읽어오는 작업
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" +fileName);
	}

	/* ------------
	       상품수정 폼
	 -------------- */
	@GetMapping("/productModify")
	public void productModify(@RequestParam("pdt_number") Integer pdt_number, @ModelAttribute("cri") Criteria cri, Model model, String folderName, String fileName) {
			
		// 1차 카테고리 정보
		model.addAttribute("cateList", admPdtService.getCateList());
		
		// 상품 정보
		ProductVO vo = admPdtService.getProductByNum(pdt_number);
		vo.setPdt_img_folder(vo.getPdt_img_folder().replace("\\", "/"));
		
		model.addAttribute("productVO", vo);
		
		// 상품정보에서 1차 카테고리 코드 참조
		Integer ctg_code_prt = vo.getCtg_code_prt();
		// 1차를 부모로 하는 2차 카테고리 정보
		model.addAttribute("subCateList", admPdtService.getSubCateList(ctg_code_prt));
		
	}
	
	/* ------------
	       상품 수정하기
	 -------------- */
	@PostMapping("/productModify")
	public String productModify(ProductVO vo, Criteria cri, RedirectAttributes rttr) {
		
		
		// 상품 이미지 변경한 경우 : 파일업로드 
		if(!vo.getUploadFile().isEmpty()) {
			
			// 1) 등록된 이미지 파일 삭제(날짜폴더명, 변경전 이미지파일명)
			UploadFileUtils.deleteFile(uploadPath, vo.getPdt_img_folder() + "\\s_" + vo.getPdt_img());
			
			// 상품수정 이미지 파일업로드
			String uploadDateFolerPath = UploadFileUtils.getFolder();
			vo.setPdt_img_folder(uploadDateFolerPath); // 날짜 폴더명
			vo.setPdt_img(UploadFileUtils.uploadFile(uploadPath, uploadDateFolerPath, vo.getUploadFile())); // 실제 업로드한 파일명
				
		}
		
		// 2) 상품정보 수정
		admPdtService.productModify(vo);
		
		return "redirect:/admin/product/productList" + cri.getListLink();
	}
	
	/* ------------
	       상품 삭제하기
	 -------------- */
	@GetMapping("/productDelete") 
	public String delete(@RequestParam("pdt_number") Integer pdt_number, @ModelAttribute("cri") Criteria cri, String pdt_img_folder, String pdt_image) {
		
		// 이미지 파일 삭제
		UploadFileUtils.deleteFile(uploadPath, pdt_img_folder + "\\s_" + pdt_image);
		
		admPdtService.productDelete(pdt_number);
		
		return "redirect:/admin/product/productList" + cri.getListLink();
	}
	
}
