package kr.co.tayo.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.tayo.dao.HashDAO;
import kr.co.tayo.dto.HashDTO;

@Service
public class HashService {

	@Autowired HashDAO dao;
	Logger logger= LoggerFactory.getLogger(this.getClass());
	
	public ArrayList<HashDTO> list() {
		logger.info("DB필요해서 DAO 호출"); //dao를 실행했다는 로거를 찍어줌
		
		return dao.list();
	}


	public String write(HashMap<String, String> params) {
		HashDTO dto= new HashDTO();
		
		int row=dao.write(params);	
		return "redirect:/";
	}


	
	public int del(ArrayList<String> delList) {
		int total=0;
		
		for(String id:delList) {
			total+= dao.delete(id);
		}
		logger.info("총 지운 갯수: "+total);
		return total;
		
	}
	public String update(HashMap<String, String> params) {
		HashDTO dto= new HashDTO();
		
		int row=dao.update(params);
		return "redirect:/";
	}
	public void delete(String idx) {
		
	}


	public HashDTO updateForm(HashMap<String, String> ha_num) {
		HashDTO dto= dao.Form(ha_num);
		return dto;
	}



	
	  public ArrayList<HashDTO> search(@RequestParam HashMap<String, String> param){ 
		  logger.info("DB필요해서 DAO 호출");
	  
		  logger.info("param:"+ param);
	  
		  HashDTO dto= new HashDTO();
	  	  
		  return dao.search(param); 
	 }
	  
	 



}


