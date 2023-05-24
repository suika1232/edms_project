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
	@PostMapping("/idCheck")
	@ResponseBody
	public String doIdCheck(HttpServletRequest req) {
		
		String idCheckVal="ok";
		int idCount=0;
		String a=req.getParameter("idCheck");
		System.out.println(a);
		idCount=edao.emp_idc(a);
		System.out.println(idCount);
		try {
		if(idCount==0) {
			System.out.println("사용가능한 아이디");
		} else {
			idCheckVal="fail";
			System.out.println("이미 사용중인 아이디");
		}
		} catch(Exception ex) {
			 printExceptionMsg("doCheck", ex.getMessage());
			
		}
		System.out.println("개수 확인="+idCount);
		return idCheckVal;
	}
	private void printExceptionMsg(String string, String message) {
		// TODO Auto-generated method stub
		
	}
	
}
