package com.human.springboot.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.human.springboot.dto.KshBoardDto;
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
	
	// /employee/mypage == mypage emp_id에 맞는 정보를 갖고온다
	ArrayList<KshEmpDto> emp_list(String emp_id);
	
	// Mypage_pw == 마이페이지 회원 비밀번호 변경
	void Mypage_pw(String pw , String id);
	
	//Mypage_mobile == 마이페이지 전화번호 변경
	void Mypage_mobile(int mobile, String id);
	
	//Mypage_img == 마이페이지에서 이미지 넣기
	void Mypage_img(String img, String id);
	
	//Mypage_address == 마이페이지에서 주소 넣기
	void Mypage_address(String address , String id);
	
	//Mypage_emp_delete == 마이페이지에서 회원 삭제
	void Mypage_delete(String id);
	
	//Main_Search == 메인에서 회원 검색
	ArrayList<KshEmpDto> Main_Search(String name);
	
	//Board_Free == 메인에서 자유게시판 갖고오기
	ArrayList<KshBoardDto> Free_list(String emp_id);
	
	//Board_Notice == 메인에서 공지사항 갖고오기
	ArrayList<KshBoardDto> Notice_list(String emp_id);
	
	//Task_list == 메인에서 업무 갖고오기
	ArrayList<KshEmpDto> Task_list(String emp_id); 
	//Main_Get == 메인에서 depart,img 갖고오기
	ArrayList<KshEmpDto> Main_Get(String emp_id);
}
