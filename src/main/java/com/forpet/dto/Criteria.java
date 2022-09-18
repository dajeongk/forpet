package com.forpet.dto;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {

	private int pageNum; // 현재 페이지번호
	private int amount;  // 게시물 출력개수
	
	private String type;    // 검색종류(상품명 , 제조사, 상품명or제조사)
	private String keyword; // 검색어
	
	// 기본생성자 정의
	public Criteria() {
		this(1, 10); // 다른 생성자 메서드 호출
	}

	// 매개변수가 있는 생성자 정의
	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;  // 1
		this.amount = amount;  // 10
	}
	
	// 검색기능. xml mapper파일에서 사용될 메서드명의 규칙 : get이름() 
	public String[] getTypeArr() {
		
		// 검색항목. ex) 상품명 - N, 제조사 - C, 상품명or제조사 - NC
		return type == null? new String[] {} : type.split("");  // {"N", "C"}
	}
	
	/* 주소에 Criteria클래스 파라미터 추가 */
	public String getListLink() {
		
		// 메서드 체이닝문법.
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();
	}
	
}
