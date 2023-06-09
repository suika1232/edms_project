package com.human.springboot.dto;

import lombok.Data;

@Data
public class SwCommentDTO {
    
    // board_comment
    private int comment_no;
    private int board_id;
    private int writer;
    private String content;  
    private String created;

    private String emp_name;
}
