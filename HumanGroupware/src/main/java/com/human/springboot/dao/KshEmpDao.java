package com.human.springboot.dao;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface KshEmpDao {
	//emp_insert == 회원가입 insert문
	void emp_insert(String id,String pw, String name, int mobile, String email, String gender, int birth);
	//emp_idc == 회원가입한 아이디 중복체크 (ID duplicate check)
	int emp_idc(String id);
}
