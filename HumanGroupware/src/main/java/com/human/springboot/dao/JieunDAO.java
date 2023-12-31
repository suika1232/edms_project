package com.human.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.human.springboot.dto.AttendanceDTO;
import com.human.springboot.dto.DepartmentDTO;
import com.human.springboot.dto.EmpDepartPositionDTO;
import com.human.springboot.dto.EmployeeDTO;
import com.human.springboot.dto.PositionDTO;

@Mapper 
public interface JieunDAO {

// 옵션 리스트 ( select )
	ArrayList<DepartmentDTO> department_select0();		// 부서명
	ArrayList<PositionDTO> position_select0();					// 직급명
	ArrayList<PositionDTO> form_select0();						// 고용형태
	ArrayList<EmployeeDTO> attendance_employee0();		// 수신인 불러오기 ( 이름+이메일 )
	ArrayList<EmpDepartPositionDTO> employee_search(String s, String b, String c, String i, String o);		// 사원 조회
	ArrayList<EmpDepartPositionDTO> all_organization();						// 조직도 불러오기
	ArrayList<EmpDepartPositionDTO> attendance_list(String a, String b);	// 직원별 근태조회 ( 부서, 날짜 )
	ArrayList<EmployeeDTO> employeeData_select(String a);					// 직원 정보 불러오기
	ArrayList<EmployeeDTO> id_load_select(String a);							// 직원 번호 불러오기
	ArrayList<EmpDepartPositionDTO>leave_select_list(String a, String b);	// 휴가 직원 불러오기
	ArrayList<PositionDTO> exemploye_select1(String a, String b);			// 부서, 직급, 고용형태 id 노출
	ArrayList<DepartmentDTO> exemployee_select2(String a);					// 부서, 직급, 고용형태 id 노출
	ArrayList<EmpDepartPositionDTO>dep_boss_name_select();				// 부서장명 불러오기
	ArrayList<PositionDTO> position_name_select();								// 직급명 불러오기
	
	// 입사일자, position(부서, 직급), 고용형태, 핸드폰, 이메일, 주소
	void employee_update0(String emp_join, int emp_position, int emp_depart, String emp_id);	
	
	// 퇴근시간 업데이트
	void attendance_end_id(int a, String b, String c);
	
	// 추가
	void department_insert(String a, int b, int c);		// 부서 추가
	void position_insert(String a, String b);				// 직급 추가
	
	// 삭제
	void department_delete(int a);		// 부서 삭제
	void position_delete(int a);			// 직급 삭제
	
	// 출근시간 입력
	void attendance_start_id(String a);
	
	// 출근 1회 체크 제한
	int attendance_chack(int a, String b);
}
