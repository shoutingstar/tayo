package kr.co.tayo.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.tayo.service.MemberService;

@Controller
public class MemberController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MemberService service;
	
	/* 임시 메인 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		return "index";
	}
	
	/* 로그인 */
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm(Model model) {
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model, HttpServletRequest req) {
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		String page = "login";
		
		String loginId = service.login(id,pw);
		logger.info("loginId : "+loginId);
		
		if(loginId != null && !loginId.equals("")) {
			page = "loginMain";
			HttpSession session = req.getSession();
			session.setAttribute("loginId", loginId);
		}else {
			model.addAttribute("msg", "아이디 또는 패스워드를 확인해 주세요");
		}
		
		return page;
	}
	
	/* 로그아웃 */
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginId");
		return "redirect:/";
	}
	
	/* 회원가입 */
	@RequestMapping(value = "/joinForm")
	public String joinForm(HttpSession session) {
		return "join";
	}
	
	@RequestMapping(value = "/Join", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> Join(@RequestParam HashMap<String, String> params) {
		String id = params.get("id").replaceAll("\\s", "");
		String pw = params.get("pw").replaceAll("\\s", "");
		String pnum = params.get("pnum").replaceAll("[^0-9]", ""); //하이픈 제거
		String email = params.get("email").replaceAll("\\s", "");
		String add = params.get("add");
		String detailAdd = params.get("detailAdd");
		String name = params.get("name").replaceAll("\\s", "");
		String age = params.get("age").replaceAll("\\s", "");
		
		int row = service.join(id, pw, pnum, email, add, detailAdd, name, age);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", row);
		
		return map;
	}
	
	/* 회원가입-아이디 중복체크 */
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> idCheck(@RequestParam String id) {
		boolean idCheck = true;
		idCheck = service.idCheck(id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idCheck", idCheck);
		return map;
	}
	
	/* 아이디 찾기 */
	@RequestMapping(value = "/findIdForm")
	public String findIdForm() {
		return "findId";
	}
	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> findId(@RequestParam HashMap<String, String> params) {
		String name = params.get("name");
		String email = params.get("email");
		String pnum = params.get("pnum");
		
		String id = service.findId(name,email,pnum);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		return map;
	}
	
	/* 패스워드 찾기 */
	@RequestMapping(value = "/findPwForm")
	public String findPwForm() {
		return "findPw";
	}
	
	@RequestMapping(value = "/findPw", method = RequestMethod.POST)
	public String findPw(Model model, HttpServletRequest req) {
		String name = req.getParameter("mem_name");
		String email = req.getParameter("mem_email");
		String pnum = req.getParameter("mem_pnum");
		
		String id = service.findId(name,email,pnum);
		
		model.addAttribute("id",id);
		
		return "changePw";
	}
	
	/* 비밀번호 변경 */
	@RequestMapping(value = "/changePw", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> changePw(@RequestParam HashMap<String, String> params) {
		String id = params.get("id");
		String pw = params.get("pw");
		
		int row = service.update(id, pw);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("changePw", row);
		
		return map;
	}

}
