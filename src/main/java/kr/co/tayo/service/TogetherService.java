package kr.co.tayo.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.tayo.dao.TogetherDAO;
import kr.co.tayo.dto.TogetherDTO;

@Service
public class TogetherService {
	
	Logger logger =LoggerFactory.getLogger(getClass());

	@Autowired TogetherDAO dao;
	
	public HashMap<String,Object> list(int page) {
		int offset=(page-1)*10;
		int totalCount=dao.totalCount();
		logger.info("total count : "+ totalCount);
		
		int totalPages=totalCount/10;
		if(totalCount%10>0) {
			totalPages=(totalCount/10)+1;
		}
		
		logger.info("총 페이지 수 : "+ totalPages);
		logger.info("총 페이지 수 2: "+Math.ceil(totalCount/10));
		
		HashMap<String, Object> result=new HashMap<String, Object>();
		result.put("total",totalPages);
		result.put("list", dao.list(offset));		
		return result;
	}
	
	//public ArrayList<TogetherDTO> list() {
	//	logger.info("dao 호출");
	//	return dao.list();
	//}

	public void write(HashMap<String, String> params) {
		dao.write(params);
		logger.info("게시글 작성");
		
	}

	public TogetherDTO detail(String num) {
		logger.info("상세보기");
		TogetherDTO dto=dao.detail(num);
		logger.info("dto:" +dto);
		if(dto!=null) { 
			dao.upHit(num);
		}		
		return dto;
	}

	public TogetherDTO updateForm(String num) {
		logger.info("updateForm 요청");
		return dao.detail(num);
	}

	public void update(HashMap<String, String> params) {
		dao.update(params);			
	}

	public void delete(String num) {
		logger.info("삭제 요청");
		dao.delete(num);
	}
	

	
	
	
}
