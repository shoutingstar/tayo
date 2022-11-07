package kr.co.tayo.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class AdminController {
	Logger logger= LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value="/admin")
	
	public String admmin(Model model) {

		return "admin";
	}
}
