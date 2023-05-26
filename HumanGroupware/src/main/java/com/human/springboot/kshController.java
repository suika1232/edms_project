package com.human.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.springboot.dao.KshEmpDao;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class kshController {
	@Autowired
	private KshEmpDao edao;
	
	/*페이지 이동*/
	@GetMapping("/")
	public String doRoot() {
		return "redirect:/main";
	}
	@GetMapping("/main")
	public String doMain() {
		return "main";
	}
	@GetMapping("/signin")
	public String doSignin() {
		return "signin";
	}
	@GetMapping("/login")
	public String doLogin() {
		return "login";
	}
	/* 메소드명: InsertEmp
	 * 작성일: 2023-05-24 
	 * 작성자: 김상호
	 * 기능: 회원가입을 할때 필요한 정보들을 insert하는 기능이다.
	 * */
	@PostMapping("/InsertEmp")
	@ResponseBody
	public String doInsertEmp(HttpServletRequest req) {
	    String retval = "ok";
	    String emp_name = req.getParameter("name");
	    String emp_id = req.getParameter("emp_id");
	    String emp_pw = req.getParameter("passcode1");
	  	int emp_mobile = Integer.parseInt(req.getParameter("mobile"));
	    String emp_email = req.getParameter("email");
	    String emp_gender = req.getParameter("gender");
	    int emp_date = Integer.parseInt(req.getParameter("date"));

	    try {
	        if (emp_id != null && !emp_id.equals("")) {
	            edao.emp_insert(emp_id, emp_pw,emp_name, emp_mobile , emp_email,emp_gender, emp_date);
	        } else {
	            System.out.println("insert fail");
	        }
	    } catch (Exception e) {
	        throw new RuntimeException(e);
	    }
	    return retval;
	}
	/* 메소드명 : Emp_idc
	 * 작성일 : 2023-05-24
	 * 작성자 : 김상호
	 * 기능 : 회원가입에서 ID중복체크를 하는기능이다.
	 * */
	@PostMapping("/Emp_idc")
	@ResponseBody
	public String doEmp_idc(HttpServletRequest req) {
		String IDretval = "ok";
		int idCount = 0;
		String emp_id = req.getParameter("emp_id");
		System.out.println(emp_id);
		idCount = edao.emp_idc(emp_id);
		try {
			if(idCount == 0) {
				System.out.println("ok!");
			}else {
				IDretval = "fail";
				System.out.println("no");
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return IDretval;
	}
	
}
