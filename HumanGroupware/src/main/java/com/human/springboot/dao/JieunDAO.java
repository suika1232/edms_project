package com.human.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.human.springboot.dto.DepartmentDTO;
import com.human.springboot.dto.EmployeeDTO;
import com.human.springboot.dto.PositionDTO;

@Mapper
public interface JieunDAO {

// 옵션 리스트 ( select )
	ArrayList<DepartmentDTO> department_select0();		// 부서명
	ArrayList<PositionDTO> position_select0();					// 직급명
	ArrayList<PositionDTO> form_select0();						// 고용형태
	ArrayList<EmployeeDTO> attendance_employee0();		// 수신인 불러오기 ( 이름+이메일 )
	
	// 입사일자, position(부서, 직급), 고용형태, 핸드폰, 이메일, 주소
	void employee_update0(int emp_position, int emp_depart, int mobile, String emp_id);	// 직원 정보 업데이트
	
	// 부서, 직급, 고용형태 id 노출
	ArrayList<PositionDTO> exemploye_select1(String a, String b);
	ArrayList<DepartmentDTO> exemployee_select2(String a);

}
