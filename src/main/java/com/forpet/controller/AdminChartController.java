package com.forpet.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.forpet.domain.ChartVO;
import com.forpet.service.AdminChartService;

import lombok.Setter;

@RequestMapping("/admin/chart/*")
@Controller
public class AdminChartController {

	@Setter(onMethod_ = {@Autowired})
	private AdminChartService chartService;
	
	/* ------------------------
	    1차 카테고리 이름별 매출 통계 
	 -------------------------- */
	@GetMapping("/overall")
	public void overall(Model model) {
		
		List<ChartVO> primary_list = chartService.primaryChart();
		
		String primaryData = "[";		
		primaryData	+= "['1차 카테고리', '매출'],";
		
		int i=0;
		for(ChartVO vo : primary_list) {
			primaryData += "['" + vo.getPrimary_code() + "'," + vo.getSales_p() + "]";
			i++;
			
			// 마지막 데이터 삽입시 콤마(,) 추가하지 않는다.
			if(i < primary_list.size()) primaryData += ",";
		}
		
		primaryData += "]";
		
		model.addAttribute("primaryData", primaryData);
	}
	
}
