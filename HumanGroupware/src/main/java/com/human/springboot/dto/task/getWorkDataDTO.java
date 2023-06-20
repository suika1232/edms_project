package com.human.springboot.dto.task;

import lombok.Data;

@Data
public class getWorkDataDTO {
	int report_no;
	int dwork_id;
	String dwork_name;
	int dwork_writer;
	int dwork_depart;
	String dwork_content;
	String dwork_notes;
	String dwork_created;
}
