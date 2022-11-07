package kr.co.tayo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.tayo.dto.TogetherDTO;
import kr.co.tayo.service.TogetherService;

@Controller
public class TogetherController {
	
	Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired TogetherService service;
	
	
	// 같이가볼래 목록
	//@RequestMapping(value = "/")
	//public String home(Model model){
	//	logger.info("리스트 호출");
	//	ArrayList<TogetherDTO> list=service.list();
	//	model.addAttribute("list", list);
	//	return "list";
	//}
	
	@RequestMapping(value = "/")
	public String main() {
		return "list";
	}
	
	@RequestMapping(value = "/listCall")
	@ResponseBody
	public HashMap<String, Object> listCall(@RequestParam int page) {
		logger.info("list 요청 : "+page);
		HashMap<String, Object> map=new HashMap<String, Object>();
		return service.list(page);
	}
	

	
	// 같이가볼래 글작성폼으로 이동
	@RequestMapping(value = "/writeForm")
	public String WriteForm(Model model) {
		logger.info("게시글 작성 이동");
		return "writeForm";
	}
	
	// 같이가볼래 글 작성
	@RequestMapping(value = "/write")
	public String write(Model model,
		@RequestParam HashMap<String, String> params) { 
		logger.info("params : {}",params);
		service.write(params);
		return "redirect:/";
	}
	  
	// 같이가볼래 글 상세보기 (댓글 추가해야함)
	@RequestMapping(value = "/detail")
	public String detail(Model model, @RequestParam String num) {
		logger.info("num : {}",num);
		String page="redirect:/";
		TogetherDTO dto=service.detail(num);
		if(dto!=null) {
			page="detail";
			model.addAttribute("total",dto);
		}		
		return page;
	}
	
	// 같이가볼래 글 수정하기	
	@RequestMapping(value = "/updateForm")
	public String update(Model model, @RequestParam String num) {
		
		logger.info("num:{}",num);
		String page="redirect:/";
		TogetherDTO dto=service.updateForm(num);
		
		if(dto!=null) {
			page="updateForm";
			model.addAttribute("total",dto);
		}		
		return page;
	}
	
	@RequestMapping(value = "/update")
	public String update(@RequestParam HashMap<String, String> params) {
		logger.info("params:{}",params);
		service.update(params);
		return "redirect:/detail?num="+params.get("num");
	}
		
	// 갈이가볼래 글 삭제하기
	@RequestMapping(value = "/delete")
	public String delete(@RequestParam String num) {		
		logger.info("num="+num);
		service.delete(num);	
		return "redirect:/";
	}
}
