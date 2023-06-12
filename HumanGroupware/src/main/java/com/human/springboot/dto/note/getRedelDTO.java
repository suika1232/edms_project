package com.human.springboot.dto.note;

import lombok.Data;

@Data
public class getRedelDTO {
	
	int note_id;
	int note_writer;
	String sender;
	String note_content;
	String note_senddate;
	
}
