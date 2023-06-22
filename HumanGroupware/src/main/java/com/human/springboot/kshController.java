package com.human.springboot;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.human.springboot.dao.KshEmpDao;
import com.human.springboot.dao.SwDAO;
import com.human.springboot.dto.KshBoardDto;
import com.human.springboot.dto.KshEmpDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class kshController {
	@Autowired
	private KshEmpDao edao;
	
	@Autowired
	private SwDAO sdao;
	
	
	/*페이지 이동*/
	@GetMapping("/")
	public String doRoot() {
		return "redirect:temp/temp_main";
	}
	@GetMapping("/temp/temp_main")
	public String doTemp_main() {
		return "temp/temp_main";
	}
	@GetMapping("/employee/main")
	public String doMain() {
		return "employee/main";
	}
	@GetMapping("/employee/signin")
	public String doSignin() {
		return "employee/signin";
	}
	@GetMapping("/employee/mypage")
	public String doMypage() {
		return "employee/mypage";
	}
	/* 메소드명 : /employee/login And /employee/logout
	 * 작성일 : 2023-05-30
	 * 작성자 : 김상호
	 * 기능 : session을 받고 받은 session을 무효화하는 기능이다. 
	 */
	@GetMapping("/employee/login")
	public String doLogin(HttpServletRequest req, Model model) {
	    String emp_id = req.getParameter("emp_id");
	    		
	    model.addAttribute("login", emp_id);
	    
	    return "employee/login";
	}

	@GetMapping("/employee/logout")
	public String doLogout(HttpServletRequest req) {
	    req.getSession().invalidate();
	    return "redirect:/temp/temp_main";
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
	@PostMapping("/employee/login_session")
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
					login.setAttribute("emp_no", login_session.get(i).getEmp_no());
					login.setAttribute("userInfo", sdao.getUserInfo(id));
					login.setAttribute("emp_id", login_session.get(i).getEmp_id());
					login.setAttribute("emp_name", login_session.get(i).getEmp_name());
					login.setAttribute("emp_position", login_session.get(i).getEmp_position());
					login.setAttribute("emp_depart", login_session.get(i).getEmp_depart());
					}
			}else {
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
	/* 메소드명 : /Mypage_list
	 * 작성일 : 2023-06-01
	 * 작성자 : 김상호
	 * 기능 : DB에 있는 정보를 마이페이지에서 보여주는 기능이다.
	 */
	@PostMapping("/Mypage_list")
	@ResponseBody
	public String doMypage_list(HttpServletRequest req) {
	    HttpSession login = req.getSession();
	    login.getAttribute("emp_id");

	    if (login.getAttribute("emp_id") == null) {
	        return "login";
	    }
	    
	    JSONArray list = new JSONArray();
	    try {
	        ArrayList<KshEmpDto> edto = edao.emp_list((String) login.getAttribute("emp_id"));

	        for (int i = 0; i < edto.size(); i++) {
	            JSONObject jo = new JSONObject();
	            KshEmpDto ked = edto.get(i);
	            
	            jo.put("emp_name", ked.getEmp_name());
	            jo.put("emp_id", ked.getEmp_id());
	            jo.put("emp_password", ked.getEmp_password());
	            jo.put("emp_birth", ked.getEmp_birth());
	            jo.put("emp_mobile", ked.getEmp_mobile());
	            jo.put("emp_email", ked.getEmp_email());
	            jo.put("emp_gender", ked.getEmp_gender());
	            jo.put("dep_name", ked.getDep_name());
	            jo.put("position_name", ked.getPosition_name());
	            jo.put("emp_img", ked.getEmp_img());
	            jo.put("emp_address", ked.getEmp_address());
	            
	            list.put(jo);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list.toString();
	}
	/* 메소드명 : Mypage_pw
	 * 작성일 : 2023-06-05
	 * 작성자 : 김상호
	 * 기능 : 마이페이지에서 비밀번호를 변경하는 기능입니다.
	 */
	@PostMapping("/Mypage_pw")
	@ResponseBody
	public String doMyPage_pw(HttpServletRequest req) {
		String checkVal = "ok";
		String id = req.getParameter("id");
		String pw = req.getParameter("password");
		String repw = req.getParameter("password2");
		
		try {
			if(pw.equals(repw)) {
				edao.Mypage_pw(pw, id);
			} else {
				checkVal ="checkfalse";
			}
		} catch(Exception e) {
			checkVal ="fail";
		}
		return checkVal;
	}
	/* 메소드명 : Mypage_mobile
	 * 작성일 : 2023-06-05
	 * 작성자 : 김상호
	 * 기능 : 마이페이지에서 모바일 번호를 변경하는 기능입니다.
	 */
	@PostMapping("/Mypage_mobile")
	@ResponseBody
	public String doMypage_mobile(HttpServletRequest req) {
		String checkVal ="ok";
		String id = req.getParameter("id");
		int mobile = Integer.parseInt(req.getParameter("mobile"));
		HttpSession session=req.getSession();
		
		try {
			edao.Mypage_mobile(mobile, id);
			session.setAttribute("emp_id", id);
		} catch (Exception e) {
			checkVal="fail";
		}
		return checkVal;
	}
	/* 메소드명 : Mypage_img
	 * 작성일 : 2023-06-07
	 * 작성자 : 김상호
	 * 기능 : 마이페이지에서 해당 아이디를 받아와서 이미지를 넣는 기능이고,
	 * 		 DB에다가 해당 경로를 서버에다가 저장합니다.
	 */
	@PostMapping("/Mypage_img")
	@ResponseBody
	public String doMypage_img(@RequestParam(value="img")MultipartFile multi, HttpServletRequest req) {
		String fileName = multi.getOriginalFilename();
		String id = req.getParameter("id");
		HttpSession session = req.getSession();	
		String filePath = "C:/Users/admin/git/HumanGroupware/HumanGroupware/src/main/resources/static/img/";
		File file = new File(filePath + fileName);
		try {
			multi.transferTo(file);
			edao.Mypage_img(filePath + fileName, id);
			session.setAttribute("emp_id", id);
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
		System.out.println(file);
		return "ok";
		
	}
	/* 메소드명 : Mypage_address
	 * 작성일 : 2023-06-07
	 * 작성자 : 김상호
	 * 기능 : 마이페이지에서 해당 아이디를 받아와서 주소를 넣는 기능입니다.
	 */
	@PostMapping("/Mypage_address")
	@ResponseBody
	public String doMypage_address(HttpServletRequest req) {
		String checkVal = "ok";
		String id = req.getParameter("id");
		String address = req.getParameter("address");
		HttpSession session = req.getSession();
		
		try {
			edao.Mypage_address(address, id);
			session.setAttribute("emp_id", id);
		} catch(Exception e) {
			checkVal = "fail";
		}
		return checkVal;
	}
	/* 메소드명 : Mypage_emp_delete
	 * 작성일 : 2023-06-07
	 * 작성자 : 김상호
	 * 기능 : 마이페이지에서 회원을 삭제 하는 기능입니다.
	 */
	@PostMapping("/Mypage_emp_delete")
	@ResponseBody
	public String doMypage_emp_delete(HttpServletRequest req) {
		String checkVal = "ok";
		String id = req.getParameter("emp_id");
		HttpSession session = req.getSession();
		try {
			session.invalidate();
			edao.Mypage_delete(id);
		} catch(Exception e) {
			checkVal = "fail";
		}
		return checkVal;
	}
	/* 메소드명 : Mypage_Search
	 * 작성일 : 2023-06-09
	 * 작성자 : 김상호
	 * 기능 : 메인페이지에서 emp_name으로 employee에 있는 회원을 검색하는 기능입니다.
	 */
	@PostMapping("/Main_Search")
	@ResponseBody
	public String doMain_Search(HttpServletRequest req, @RequestParam("Search_Emp") String Search_Emp) {
	    HttpSession login = req.getSession();
	    login.getAttribute("emp_id");

	    if (login.getAttribute("emp_id") == null) {
	        return "login";
	    }

	    JSONArray ja = new JSONArray();
	    try {
	        ArrayList<KshEmpDto> edto = edao.Main_Search(Search_Emp);
	        for (int i = 0; i < edto.size(); i++) {
	            JSONObject jo = new JSONObject();
	            KshEmpDto ked = edto.get(i);

	            jo.put("emp_img", ked.getEmp_img());
	            jo.put("emp_name", ked.getEmp_name());
	            jo.put("emp_birth", ked.getEmp_birth());
	            jo.put("emp_mobile", ked.getEmp_mobile());
	            jo.put("emp_email", ked.getEmp_email());
	            jo.put("emp_gender", ked.getEmp_gender());
	            jo.put("dep_name", ked.getDep_name());
	            jo.put("position_name", ked.getPosition_name());

	            ja.put(jo);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return ja.toString();
	}
	/* 메소드명 : Board_Free
	 * 작성일 : 2023-06-13
	 * 작성자 : 김상호
	 * 기능 : 메인페이지에서 자유 게시판을 보여주는 기능입니다.
	 */
	@PostMapping("/Board_Free")
	@ResponseBody
	public String doBoard_Free(HttpServletRequest req) {
		HttpSession login = req.getSession();
		login.getAttribute("emp_id");
		
		if(login.getAttribute("emp_id") == null ) {
			return "login";
		}
		
		JSONArray ja = new JSONArray();
		try {
			ArrayList<KshBoardDto> bdto = edao.Free_list((String) login.getAttribute("emp_id"));
			for(int i=0; i<bdto.size(); i++) {
				JSONObject jo = new JSONObject();
				KshBoardDto kbd = bdto.get(i);
				
				jo.put("board_id", kbd.getBoard_id());
				jo.put("board_title", kbd.getBoard_title());
				jo.put("emp_name", kbd.getEmp_name());
				jo.put("board_created", kbd.getBoard_created());
				
				ja.put(jo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ja.toString();
	}
	/* 메소드명 : Board_Notice 
	 * 작성일 : 2023-06-13
	 * 작성자 : 김상호
	 * 기능 : 메인페이지에서 공지사항을 보여주는 기능입니다.
	 */
	@PostMapping("/Board_Notice")
	@ResponseBody
	public String doBoard_Notice(HttpServletRequest req) {
		HttpSession login = req.getSession();
		login.getAttribute("emp_id");
		
		if(login.getAttribute("emp_id") == null ) {
			return "login";
		}
		JSONArray ja = new JSONArray();
		try {
			ArrayList<KshBoardDto> bdto = edao.Notice_list((String) login.getAttribute("emp_id"));
			for(int i=0; i<bdto.size(); i++) {
				JSONObject jo = new JSONObject();
				KshBoardDto kbd = bdto.get(i);
				
				jo.put("board_id", kbd.getBoard_id());
				jo.put("board_title", kbd.getBoard_title());
				jo.put("emp_name", kbd.getEmp_name());
				jo.put("board_created", kbd.getBoard_created());
				
				ja.put(jo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ja.toString();
	}
	/* 메소드명 : Main_Get
	 * 작성일 : 2023-06-13
	 * 작성자 : 김상호
	 * 기능 : main page에서 img랑 depart를 가져온다
	 */
	@PostMapping("/Main_Get")
	@ResponseBody
	public String doMain_Get(HttpServletRequest req) {
		HttpSession login = req.getSession();
		login.getAttribute("emp_id");
		
		if(login.getAttribute("emp_id") == null ) {
			return "login";
		}
		JSONArray ja = new JSONArray();
		try {
			ArrayList<KshEmpDto> edto = edao.Main_Get((String) login.getAttribute("emp_id"));
			for(int i=0; i<edto.size(); i++) {
				JSONObject jo = new JSONObject();
				KshEmpDto ked = edto.get(i);
				
				jo.put("emp_img", ked.getEmp_img());
				jo.put("emp_position", ked.getEmp_position());
				jo.put("emp_depart", ked.getEmp_depart());
				ja.put(jo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ja.toString();
	}
	/* 메소드명 : Main_Session
 	 * 작성일 : 2023-06-19
 	 * 작성자 : 김상호
 	 * 기능 : 메인페이지에서 세션정보가 없으면 페이지에 못들어가게 막는 코드입니다.
	 */
	@PostMapping("/Main_Session")
	@ResponseBody
	public String doMain_Session(HttpServletRequest req) {
		String checkVal ="ok";
		HttpSession login = req.getSession();
	    login.getAttribute("emp_id");

	    if (login.getAttribute("emp_id") == null) {
	        return "login";
	    }
	    return checkVal;
	}
	/* 메소드명 : Main_Task 
	 * 작성일 : 2023-06-21
	 * 작성자 : 김상호
	 * 기능 : 메인페이지에서 세션정보를 받아서 개인 별 해당 ID 마다 지시받은 업무가 보여지게 하는 코드입니다.
	 */
	@PostMapping("/Main_Task")
	@ResponseBody
	public String doMain_Task(HttpServletRequest req) {
		HttpSession login = req.getSession();
		login.getAttribute("emp_id");
		
		if(login.getAttribute("emp_id") == null ) {
			return "login";
		}
		JSONArray ja = new JSONArray();
		try {
			ArrayList<KshEmpDto> edto = edao.Task_list((String) login.getAttribute("emp_id"));
			for(int i=0; i<edto.size(); i++) {
				JSONObject jo = new JSONObject();
				KshEmpDto ked = edto.get(i);
				
				jo.put("emp_no", ked.getEmp_no());
				jo.put("task_name", ked.getTask_name());
				jo.put("emp_name", ked.getEmp_name());
				jo.put("task_id", ked.getTask_id());
				jo.put("task_content", ked.getTask_content());
				jo.put("task_started", ked.getTask_started());
				jo.put("task_limit", ked.getTask_limit());
				
				ja.put(jo);				
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ja.toString();
	}
}
