package com.human.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.human.springboot.dto.DepartmentDTO;
import com.human.springboot.dto.PositionDTO;

@Mapper
public interface JieunDAO {

// 옵션 리스트 ( select )
	ArrayList<DepartmentDTO> department_select0();		// 부서명
	ArrayList<PositionDTO> position_select0();					// 직급명
	ArrayList<PositionDTO> form_select0();						// 고용형태
	
}
