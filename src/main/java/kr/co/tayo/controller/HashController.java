package kr.co.tayo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import kr.co.tayo.dto.HashDTO;
import kr.co.tayo.service.HashService;

@Controller
public class HashController {
	Logger logger= LoggerFactory.getLogger(this.getClass());
	
	@Autowired HashService service;
	
	@RequestMapping(value="/")
	
	public String hash(Model model) {
		logger.info("리스트 불러오기");
		
	    ArrayList<HashDTO> list=service.list();
		logger.info("list.size:"+list.size());
		model.addAttribute("list",list);
		return "Hash";
	}
	
	@RequestMapping(value="/write")
	public String write(Model model,@RequestParam HashMap<String, String> params ) {
		logger.info("해시태그값 삽입");
		
		return service.write(params);
	}

	@RequestMapping(value="/delete")
	public String delete(Model model,@RequestParam String idx) {
		service.delete(idx);
		return "redirect:/";
	}
	@RequestMapping(value="/updateForm")
	public String updateForm(Model model,@RequestParam HashMap<String, String> ha_num) {
		logger.info("idx="+ha_num);
		String page="redirect:/";
		HashDTO dto= service.updateForm(ha_num);
		if(dto!=null) {
			page="update";
			model.addAttribute("hash", dto);
		}
		
		return page;
	}
	
	@RequestMapping(value="/update")
	public String update(Model model,@RequestParam HashMap<String, String>params) {
		logger.info("params:{}",params);
		return service.update(params);
	}

	
}
