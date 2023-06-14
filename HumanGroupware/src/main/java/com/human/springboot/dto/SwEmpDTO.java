package com.human.springboot.dto;

import lombok.Data;

@Data
public class SwEmpDTO {
    
    private int emp_no;
    private String emp_id;
    private String emp_name;
    private int emp_position;
    private int emp_depart;
    private String emp_email;
    private String board_authority;

    private int dep_id;
    private String dep_name;

    private int position_id;
    private String position_name;
}
