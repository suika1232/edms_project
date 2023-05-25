package com.human.springboot.dto;

import lombok.Data;

@Data
public class SwBoardDTO {
    
    private int board_id;
    private String board_title;
    private String board_content;
    private int board_writer;
    private String board_created;
    private String board_updated;
    private int board_hit;
    private String board_file_name;
    private String board_file_path;
    private int board_comment;

    private int board_category;
    private String category_name;

    private String emp_name;
    
}
