package kr.co.tayo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.tayo.dao.Member_DAO;


@Service
public class MemberService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired Member_DAO dao;
	
	//로그인
	public String login(String id, String pw) {
		return dao.login(id, pw);
	}

	//회원가입
	public int join(String id, String pw, String pnum, String email, String add, String detailAdd, String name,
			String age) {
		return dao.join(id,pw,pnum,email,add,detailAdd,name,age);
	}
	
	//회원가입-아이디 중복체크
	public boolean idCheck(String id) {
		String idCheck = dao.idCheck(id);
		return idCheck == null ? false : true;
	}
	
	//아이디 찾기
	public String findId(String name, String email, String pnum) {
		return dao.findId(name, email, pnum);
	}
	
	//비밀번호 변경
	public int update(String id, String pw) {
		return dao.update(id, pw);
	}

}