package com.human.springboot.dto;

import lombok.Data;

@Data
public class SwFreeBoardDTO {
    
    private int free_id;
    private String free_title;
    private String free_content;
    private int free_writer;
    private String free_created;
    private String free_updated;
    private int free_hit;
    private String free_file;
    private int free_comment;
    
}
