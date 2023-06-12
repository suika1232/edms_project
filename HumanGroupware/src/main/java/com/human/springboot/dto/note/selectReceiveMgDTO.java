package com.human.springboot;

import lombok.Data;

@Data
public class selectReceiveMgDTO {
	int sender_id;
	int note_id;
	String emp_name;
	String note_content;
	String note_senddate;
	String note_read;
}
