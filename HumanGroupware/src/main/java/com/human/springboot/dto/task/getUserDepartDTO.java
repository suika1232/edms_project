package com.human.springboot.dto.task;

import lombok.Data;

@Data
public class getUserDepartDTO {
	String emp_name;
	String managerName;
	int managerNum;
	int dep_id;
	String dep_name;
}
