package kr.co.tayo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.tayo.dto.HashDTO;
import kr.co.tayo.service.HashService;

@Controller
public class AjaxHashController {
	Logger logger =LoggerFactory.getLogger(getClass());
	@Autowired HashService service;
	
	@RequestMapping(value="/listCall")
	@ResponseBody
	public HashMap<String, Object>listCall(){
		HashMap<String, Object> map= new HashMap<String, Object>();
		ArrayList<HashDTO> list=service.list();
		map.put("list",list);
		return map;
	}
	
	@RequestMapping(value="/del")
	@ResponseBody
	public HashMap<String, Object>del(@RequestParam(value="delList[]")ArrayList<String> delList){
		logger.info("list:{}",delList);
		int cnt=service.del(delList);
		String msg=delList.size()+" 개 삭제 요청중";
		msg += cnt+"개 삭제 완료 하였습니다.";
		HashMap<String, Object> map= new HashMap<String, Object>();
		map.put("msg", msg);
		return map;
	
	}
	
	
	
	  @RequestMapping(value="/search")
	 
	@ResponseBody public HashMap<String, Object>search(@RequestParam
	  HashMap<String, String> param){ 
		  HashMap<String, Object> map= new HashMap<String, Object>(); 
		  ArrayList<HashDTO>list=service.search(param); 
	  logger.info("list:"+list);
	  map.put("list",list);
	 
	  
	  return map; 
	  }
	
	/*
	 * @RequestMapping(value="/search")
	 * 
	 * @ResponseBody public HashMap<String, Object>search(@RequestParam String
	 * param){ logger.info("param:"+param); ArrayList<HashDTO>
	 * search=service.search(param); HashMap<String, Object> map= new
	 * HashMap<String, Object>(); logger.info("serach:"+search);
	 * map.put("search",search);
	 * 
	 * 
	 * return map; }
	 */
	
}
