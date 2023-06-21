package com.human.springboot.dto;

import lombok.Data;

@Data
public class KshEmpDto {
	//employee
	private int emp_no;
	private String emp_name;
	private String emp_id;
	private String emp_password;
	private int emp_mobile;
	private String emp_email;
	private String emp_gender;
	private int emp_birth;
	private int emp_position;
	private int emp_depart;
	private String emp_img;
	//position
	private int position_id;
	private String position_name;
	private String job_type;
	//department
	private int dep_id;
	private String dep_name;
	private int dep_manager;
	private int dep_parent;
	
	
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}
	public String getEmp_password() {
		return emp_password;
	}
	public void setEmp_password(String emp_password) {
		this.emp_password = emp_password;
	}
	public int getEmp_mobile() {
		return emp_mobile;
	}
	public void setEmp_mobile(int emp_mobile) {
		this.emp_mobile = emp_mobile;
	}
	public String getEmp_email() {
		return emp_email;
	}
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	public String getEmp_gender() {
		return emp_gender;
	}
	public void setEmp_gender(String emp_gender) {
		this.emp_gender = emp_gender;
	}
	public int getEmp_birth() {
		return emp_birth;
	}
	public void setEmp_birth(int emp_birth) {
		this.emp_birth = emp_birth;
	}
	public int getEmp_position() {
		return emp_position;
	}
	public void setEmp_position(int emp_position) {
		this.emp_position = emp_position;
	}
	public int getEmp_depart() {
		return emp_depart;
	}
	public void setEmp_depart(int emp_depart) {
		this.emp_depart = emp_depart;
	}
	public String getEmp_img() {
		return emp_img;
	}
	public void setEmp_img(String emp_img) {
		this.emp_img = emp_img;
	}
	public String getEmp_address() {
		return emp_address;
	}
	public void setEmp_address(String emp_address) {
		this.emp_address = emp_address;
	}
	private String emp_address;
	
}
