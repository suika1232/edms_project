package com.human.springboot.dto.task;

import lombok.Data;

@Data
public class selectTaskDTO {
	int task_id;
	String task_name;
	int task_depart;
	int task_drafter;
	int task_performer;
	String task_started;
	String task_limit;
	String task_content;
}
