package com.human.springboot.dto.note;

import lombok.Data;

@Data
public class selectSeMgDTO {
	int note_id;
	int note_recipient;
	String emp_name ; 
	String note_content ; 
	String note_senddate;
}
