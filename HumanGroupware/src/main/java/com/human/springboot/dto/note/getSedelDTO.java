package com.human.springboot.dto.note;

import lombok.Data;

@Data
public class getSedelDTO {
	
	int note_id;
	int note_recipient;
	String receiver;
	String note_content;
	String note_senddate;
	
	
}
