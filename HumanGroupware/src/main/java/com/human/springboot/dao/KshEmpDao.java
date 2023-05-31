package com.human.springboot.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.human.springboot.dto.KshEmpDto;


@Mapper
public interface KshEmpDao {
	//emp_insert == 회원가입 insert문
	void emp_insert(String id,String pw, String name, int mobile, String email, String gender, int birth);
	
	//emp_idc == 회원가입한 아이디 중복체크 (ID duplicate check)
	int emp_idc(String id);
	
	//emp_login == 로그인
	List<KshEmpDto> emp_login_session(String id, String pw);
	String emp_login(String id, String pw);
	
	//emp_findID == 회원아이디 찾기
	ArrayList<KshEmpDto> FindID(String name ,int mobile ,String email);
	
	//emp_findPW == 회원비밀번호 찾기
	int FindPW(String name, String id, int mobile);
	
	//emp_PwChange == 회원비밀번호 변경
	void PwChange(String pw ,String id);
}
