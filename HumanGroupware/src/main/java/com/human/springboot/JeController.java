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
import com.human.springboot.dto.EmpDepartPositionDTO;
import com.human.springboot.dto.EmployeeDTO;
import com.human.springboot.dto.PositionDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class JeController {

	@Autowired
	private JieunDAO JiDao;
	
// 페이지 접속 (풀네임)
	
	// 사원 조회 ( 페이지 접속 )
	@GetMapping("/employee/inquiry")
	public String employeeInquiry() {
		return "employee/employee_inquiry";
	}
	// 사원 등록 ( 페이지 접속 )
	@GetMapping("/employee/registration")
	public String employeeRegistration() {
		return "employee/employee_registration";
	}
	// 조직도 ( 페이지 접속 )
	@GetMapping("/employee/organization")
	public String employeeOrganization() {
		return "employee/employee_organization";
	}
	// 근태 현황 ( 페이지 접속 )
	@GetMapping("/attendance/current")
	public String attendanceCurrent() {
		return "attendance/attendance_current";
	}
	// 근태 관리 ( 페이지 접속 )
	@GetMapping("/attendance/management")
	public String attendanceManagement() { 
		return "attendance/attendance_management";
	}
	// 사원별 근태 현황
	@GetMapping("/attendance/byEmployee")
	public String attendanceByEmployee() {
		return "attendance/attendance_ByEmployee";
	}
	
	// 사원 정보 수정 ( update )
	@PostMapping("/employee_update0")
	@ResponseBody
	public String doEmpUpdate(HttpServletRequest req) {
		
	    String retval = "ok";
	    try {
	    	String emp_join=req.getParameter("emp_join");
	    	int emp_position=Integer.parseInt(req.getParameter("emp_position"));
	    	int emp_depart=Integer.parseInt(req.getParameter("emp_depart"));
			String emp_id=req.getParameter("emp_id");
			System.out.println(emp_id);
			
			JiDao.employee_update0(emp_join, emp_position,emp_depart ,emp_id);
	    } catch (Exception e) {
	    	e.printStackTrace();
	        retval = "fail";
	    }
	    return retval;
	}
	
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
			jo.put("dep_manager", department_select0.get(i).getDep_manager());
			jo.put("dep_parent", department_select0.get(i).getDep_parent());
			jo.put("dep_id", department_select0.get(i).getDep_id());
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
	
	// 수신인 ( 수신인+이메일 불러오기, select )
	@PostMapping("/attendance_employee0")
	@ResponseBody
	public String doAttenEmployee() {
		ArrayList<EmployeeDTO> attendance_employee0 = JiDao.attendance_employee0();
		JSONArray ja = new JSONArray();
		for(int i=0; i<attendance_employee0.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("emp_name", attendance_employee0.get(i).getEmp_name());
			jo.put("emp_email", attendance_employee0.get(i).getEmp_email());
			ja.put(jo);
		}
		return ja.toString();
	}
	
	// 사원 조회 ( 검색 후 불러오기, select )
	@PostMapping("/employee_search")
	@ResponseBody
	public String doAllSelectend(HttpServletRequest req) {
		String emp_name = req.getParameter("emp_name");
		String emp_mobile = req.getParameter("emp_mobile");
		String emp_email = req.getParameter("emp_email");
		String dep_name = req.getParameter("dep_name");
		String position_name = req.getParameter("position_name");
		ArrayList<EmpDepartPositionDTO> employee_search = JiDao.employee_search(emp_name, emp_mobile, emp_email,dep_name,position_name);
		JSONArray ja = new JSONArray();
		for(int i=0; i<employee_search.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("position_name", employee_search.get(i).getPosition_name());
			jo.put("job_type", employee_search.get(i).getJob_type());
			jo.put("emp_name", employee_search.get(i).getEmp_name());
			jo.put("emp_mobile", employee_search.get(i).getEmp_mobile());
			jo.put("emp_email", employee_search.get(i).getEmp_email());
			jo.put("emp_gender", employee_search.get(i).getEmp_gender());
			jo.put("dep_name", employee_search.get(i).getDep_name());
			jo.put("emp_id", employee_search.get(i).getEmp_id());
			jo.put("emp_img", employee_search.get(i).getEmp_img());
			ja.put(jo);
		}
		return ja.toString();
	}
	
	// 사원별 근태 조회 ( 검색 후 불러오기, select )
	@PostMapping("/attendance_list")
	@ResponseBody
	public String doAttList(HttpServletRequest req) {
		String dep_name = req.getParameter("dep_name");
		ArrayList<EmpDepartPositionDTO> attendance_list = JiDao.attendance_list(dep_name);
		JSONArray ja = new JSONArray();
		for(int i=0; i<attendance_list.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("emp_name", attendance_list.get(i).getEmp_name());
			jo.put("dep_name", attendance_list.get(i).getDep_name());
			jo.put("position_name", attendance_list.get(i).getPosition_name());
			ja.put(jo);
		}
		return ja.toString();
	}
	
	// 조직도 부서이름 불러오기
	@PostMapping("/all_organization")
	@ResponseBody
	public String doDepartment_ul() {
		ArrayList<EmpDepartPositionDTO> all_organization = JiDao.all_organization();
		JSONArray ja = new JSONArray();
		for(int i=0; i<all_organization.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("dep_name", all_organization.get(i).getDep_name());
			jo.put("emp_name",all_organization.get(i).getEmp_name());
			jo.put("position_name",all_organization.get(i).getPosition_id());
			ja.put(jo);
		}
		return ja.toString();
	}

	// 고용형태 직급 id 뽑기
	@PostMapping("/exemploye_select1")
	@ResponseBody
	public String doExEmployee(HttpServletRequest req) {
		String position_name = req.getParameter("position_name");
		String job_type = req.getParameter("job_type");
			ArrayList<PositionDTO> exemploye_select1 = JiDao.exemploye_select1(position_name, job_type);
			JSONArray ja = new JSONArray();
			for(int i=0; i<exemploye_select1.size(); i++) {
				JSONObject jo = new JSONObject();
				jo.put("position_id", exemploye_select1.get(i).getPosition_id());
				ja.put(jo);
			}
			return ja.toString();
}
	
	// 부서 id 뽑기
		@PostMapping("/exemployee_select2")
		@ResponseBody
		public String doExEmployeeDep(HttpServletRequest req) {
			String dep_name = req.getParameter("dep_name");
				ArrayList<DepartmentDTO> exemployee_select2 = JiDao.exemployee_select2(dep_name);
				JSONArray ja = new JSONArray();
				for(int i=0; i<exemployee_select2.size(); i++) {
					JSONObject jo = new JSONObject();
					jo.put("dep_id", exemployee_select2.get(i).getDep_id());
					ja.put(jo);
				}
				return ja.toString();
	}
	// 부서 추가 insert
		@PostMapping("/department_insert")
		@ResponseBody
		public String personorder(HttpServletRequest req) {
			String retval="ok";
			String dep_name = req.getParameter("dep_name");
			int dep_parent = Integer.parseInt(req.getParameter("dep_parent"));
			int dep_manager = Integer.parseInt(req.getParameter("dep_manager"));
			try {
				System.out.println(dep_name);
				System.out.println(dep_parent);
				System.out.println(dep_manager);
				JiDao.department_insert(dep_name,dep_parent, dep_manager);
			} catch(Exception e) {
				retval = e.getMessage();
				e.printStackTrace();
			}
			return retval;
		}
}

