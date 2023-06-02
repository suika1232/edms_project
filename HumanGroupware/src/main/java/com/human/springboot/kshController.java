package com.human.springboot;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.springboot.dao.KshEmpDao;
import com.human.springboot.dto.KshEmpDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
	public String doLogin(HttpServletRequest req,Model model) {
		String emp_id = req.getParameter("emp_id");
		model.addAttribute("login", emp_id);
		
		
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
		idCount = edao.emp_idc(emp_id);
		try {
			if(idCount == 0) {
				IDretval = "ok";
			}else {
				IDretval = "fail";
				
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return IDretval;
	}
	/* 메소드명: login_session
	 * 작성일 : 2023-05-30
	 * 작성자 : 김상호
	 * 기능 : 로그인하는 기능입니다. 
	 */
	@PostMapping("/login_session")
	@ResponseBody
	public String doLodin_session(HttpServletRequest req) {
		String loginVal ="ok";
		HttpSession login = req.getSession();
		String id = req.getParameter("emp_id");
		String pw = req.getParameter("emp_password");
		List<KshEmpDto> login_session = edao.emp_login_session(id, pw);
		String login_id_pw = edao.emp_login(id, pw);
		
		try {
			if(login_id_pw != (null)) {
				for(int i=0; i<login_session.size(); i++) {
					login.setAttribute("emp_id", login_session.get(i).getEmp_id());
					login.setAttribute("emp_name", login_session.get(i).getEmp_name());
				}
			}else {
				System.out.println("id or pw = x");
				loginVal = "fail";
			}
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
		return loginVal;
	}
	/* 메소드명: emp_findID 
	 * 작성일 : 2023-05-30
	 * 작성자 : 김상호
	 * 기능 : 회원 아이디를 찾는 기능입니다.
	 */
	@PostMapping("/emp_findID")
	@ResponseBody
	public String doEmp_findID(HttpServletRequest req) {
		String name = req.getParameter("FIN");
		String mobileParam = req.getParameter("FIM");
		int mobile = 0; // 기본값 설정 
		
	    if (mobileParam != null && !mobileParam.isEmpty()) {
	        mobile = Integer.parseInt(mobileParam);
	    }
	    
		String email = req.getParameter("FIE");
		ArrayList<KshEmpDto> id_list = edao.FindID(name, mobile, email);
		System.out.println(id_list.size());
		JSONArray ja= new JSONArray();
		try {
			for(int i=0; i<id_list.size(); i++) {
				JSONObject jo=new JSONObject();
				jo.put("IDdialog",id_list.get(i).getEmp_id());
				ja.put(jo);
			}
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
		return ja.toString();
	}
	/* 메소드명 : emp_findPW
	 * 작성일 : 2023-05-30
	 * 작성자 : 김상호
	 * 기능 : emp_id,emp_name,emp_mobile 을 이용하여 비밀번호를 찾는다.
	 */
	@PostMapping("/emp_findPW")
	@ResponseBody
	public String doEmp_findPW(HttpServletRequest req) {
		String findVal ="";
		String name = req.getParameter("FPN");
		String id = req.getParameter("FPI");
		String mobileParam = req.getParameter("FPM");
		int mobile = 0; // 기본값 설정 
		
	    if (mobileParam != null && !mobileParam.isEmpty()) {
	        mobile = Integer.parseInt(mobileParam);
	    }
	    int pw = 0;
	    try {
	    	pw = edao.FindPW(name, id, mobile);
	    	if(pw != 0) {
	    		findVal = "ok";
	    	}else {
	    		findVal ="fail a";
	    	}
	    } catch(Exception e) {
	    	findVal ="fail";
	    }
	    return findVal;
	}
	/* 메소드명 : emp_PwChange
	 * 작성일 : 2023-05-30
	 * 작성자 : 김상호
	 * 기능 : 비밀번호 찾은 후 비밀번호를 변경한다.
	 */
	@PostMapping("/Emp_PwChange")
	@ResponseBody
	public String doemp_pwchange(HttpServletRequest req) {
		String changeVal = "ok";
		String id = req.getParameter("FPI");
		String pw = req.getParameter("PWC");
		String repw = req.getParameter("REPWC");
		
		try {
			if(pw.equals(repw)) {
				edao.PwChange(pw, id);
			} else {
				changeVal = "checkfalse";
			}
		} catch(Exception e) {
			changeVal ="fail";
		}
		return changeVal;
	}
	
}
