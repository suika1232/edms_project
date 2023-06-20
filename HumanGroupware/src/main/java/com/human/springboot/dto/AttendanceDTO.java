package com.human.springboot.dto;

import lombok.Data;

@Data
public class AttendanceDTO {
	
	int attend_id;
	int emp_no;
	String attend_date;
	String start_time;
	String end_time;
	String night_time;
	String tardy_time;
	
	
	public String getNight_time() {
		return night_time;
	}
	public void setNight_time(String night_time) {
		this.night_time = night_time;
	}
	public String getTardy_time() {
		return tardy_time;
	}
	public void setTardy_time(String tardy_time) {
		this.tardy_time = tardy_time;
	}
	public int getAttend_id() {
		return attend_id;
	}
	public void setAttend_id(int attend_id) {
		this.attend_id = attend_id;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getAttend_date() {
		return attend_date;
	}
	public void setAttend_date(String attend_date) {
		this.attend_date = attend_date;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	
}
