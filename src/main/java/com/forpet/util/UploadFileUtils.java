package com.forpet.util;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

public class UploadFileUtils {

	/* -------------------------------------------------
	    1. 파일 업로드 작업. 리턴값 : 업로드한 실제파일명(DB에 저장) 
	---------------------------------------------------- */
	public static String uploadFile(String uploadFolder, String uploadDateFolerPath, MultipartFile uploadFile) {
		
		String uploadFileName = ""; // 실제 업로드한 파일명
		
		// 업로드 날짜폴더 생성
		File uploadPath = new File(uploadFolder, uploadDateFolerPath); // C:\\Dev\\upload\\2022\\07\\19
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 하위 디렉토리까지 생성
		}
		
		String uploadClientFileName = uploadFile.getOriginalFilename();
		
		// 중복되지 않는 고유의 문자열 생성
		UUID uuid = UUID.randomUUID();
		
		// 업로드시 중복되지 않는 파일 이름 생성
		uploadFileName = uuid.toString() + "_" + uploadClientFileName;
		
		try {
			// 유일한 파일이름으로 객체 생성 
			File saveFile = new File(uploadPath, uploadFileName);
			uploadFile.transferTo(saveFile); // 파일 업로드(파일복사)
			
			if(checkImageType(saveFile)) {
				
				// 썸네일 작업 
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
			
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
			
				thumbnail.close();
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		
		return uploadFileName; 
	}
	
	
	/* ---------------------------------------
	    2. 날짜를 이용한 업로드 폴더생성 및 폴더이름 반환
	------------------------------------------ */
	public static String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);  // "2022-07-19"
		
		return str.replace("-", File.separator); // "2022-07-19" -> "2022\07\19"
	}
		
	
	/* ----------------------
	    3. 이미지 파일여부 체크
	------------------------- */
	private static boolean checkImageType(File saveFile) {
		
		boolean isImage = false;
		
		try { // MIME타입. ex) text/html, text/plain, image/jpeg
			String contentType = Files.probeContentType(saveFile.toPath()); 
		
			isImage = contentType.startsWith("image");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return isImage;
	}
	
	/* ----------------------------- 
	    4. 이미지를 바이트 배열로 읽어오기
	-------------------------------- */
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) {
	
		File file = new File(uploadPath, fileName); // 이미지 파일 정보를 이용하여 File 객체 생성
		
		// 이미지 파일이 존재하지 않을 경우
		if(!file.exists()) {
			uploadPath = "C:\\Dev\\upload\\imsi\\";
			fileName = "s_noImage.png";
			
			file = new File(uploadPath, fileName);
		}
		
		ResponseEntity<byte[]> entity = null;
		
		// 브라우저에게 서버에서 보내는 데이터에 대한 설명
		HttpHeaders headers = new HttpHeaders();
		
		try {
			// 브라우저에게 보낼 데이터의 MIME정보를 패킷의 헤더부분에 추가
			headers.add("Content-type", Files.probeContentType(file.toPath()));
			entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return entity;
	}
	
	/* ----------------------------------
	    5. 파일 삭제(원본 이미지, 썸네일 이미지)
	------------------------------------- */
	public static void deleteFile(String uploadPath, String fileName) {
			
		/*
		 uploadPath : c:\\Dev\\upload 
		 fileName : 2022/07/21/s_d1ca2ec5-59a8-48f9-af10-1265570b3b61_forest.jpg
		 */
		
		String front = fileName.substring(0, 11); // 2022/07/21
		String end = fileName.substring(13);	 // d1ca2ec5-59a8-48f9-af10-1265570b3b61_forest.jpg
		String origin = front + end;			 // 2022/07/21/d1ca2ec5-59a8-48f9-af10-1265570b3b61_forest.jpg
		
		// 1) 원본 이미지 삭제
		new File(uploadPath + origin.replace('/', File.separatorChar)).delete(); 
		// 2) 썸네일 이미지 삭제 
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		
	}
	
}
