package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.springboot.dao.JieunDAO;
import com.human.springboot.dto.DepartmentDTO;
import com.human.springboot.dto.PositionDTO;

@Controller
public class JeController {

	@Autowired
	private JieunDAO JiDao;
	
// 페이지 접속 (풀네임)
	
	// 사원 조회 ( 페이지 접속 )
	@GetMapping("/hw/employee/inquiry")
	public String employeeInquiry() {
		
		return "employee/employee_inquiry";
	}
	
	// 사원 등록 ( 페이지 접속 )
	@GetMapping("/hw/employee/registration")
	public String employeeRegistration() {
		
		return "employee/employee_registration";
	}
	
	// 조직도 ( 페이지 접속 )
	@GetMapping("/hw/employee/organization")
	public String employeeOrganization() {
		
		return "employee/employee_organization";
	}
	
	// 사원 정보 추가 ( DB 정보 등록 )
//	@PostMapping("/emloyee_insert")
//	@ResponseBody
//	public String do_emloyee_insert(HttpServletRequest req) {
//		String cartInsrt = "ok";
//		try {	
//			String m_id = req.getParameter("m_id");
//			int p_id = Integer.parseInt(req.getParameter("prod_id"));
//			int cart_qty = Integer.parseInt(req.getParameter("cart_qty"));
//			
//			mdao.cart_insert(p_id, cart_qty, m_id);
//		} catch(Exception e) {
//			cartInsrt = "fail";
//			e.printStackTrace();
//		}
//		return cartInsrt;
//	}
	
	// 사원 조회 ( DB 정보 불러오기, select )
//	@PostMapping("/employee_list")
//	@ResponseBody
//	public String employee_list(HttpServletRequest req) {
//		String mid = req.getParameter("m_id");
//		ArrayList<EmpDTO> employee_list=EmpDao.employee_list(mid);
//		JSONArray ja = new JSONArray();
//		for(int i=0; i<employee_list.size(); i++) {
//		JSONObject jo = new JSONObject();
//		jo.put("cart_id", employee_list.get(i).getCart_id());
//		
//		ja.put(jo);
//	}
//	return ja.toString();
//	}
	
// select option 설정
	// 사원 정보 추가 ( 부서명 불러오기, select )
	@PostMapping("/department_select0")
	@ResponseBody
	public String doDepSelect() {			
		ArrayList<DepartmentDTO> department_select0 = JiDao.department_select0();
		JSONArray ja = new JSONArray();
		for(int i=0; i<department_select0.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("dep_name", department_select0.get(i).getDep_name());
			
			ja.put(jo);
		}
		return ja.toString();
	}
	// 사원 정보 추가 ( 직급명 불러오기, select )
	@PostMapping("/position_select0")
	@ResponseBody
	public String doPosSelect() {
		ArrayList<PositionDTO> position_select0 = JiDao.position_select0();
		JSONArray ja = new JSONArray();
		for(int i=0; i<position_select0.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("position_name",position_select0.get(i).getPosition_name());
			ja.put(jo);
		}
		return ja.toString();
	}
	// 사원 정보 추가 ( 고용형태 불러오기, select )
	@PostMapping("/form_select0")
	@ResponseBody
	public String doFormSelect() {
		ArrayList<PositionDTO> form_select0 = JiDao.form_select0();
		JSONArray ja = new JSONArray();
		for(int i=0; i<form_select0.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("job_type",form_select0.get(i).getJob_type());
			ja.put(jo);
		}
		return ja.toString();
	}

}

