package com.human.springboot.dto.task;

import lombok.Data;

@Data
public class taskReportDTO {
	
	int tr_id;
	int tr_no;
	int tr_depart;
	int tr_writer;
	
	String tr_title;
	String tr_content;
	String tr_condition;
	String tr_created;
	
	int tr_receiver;
}
