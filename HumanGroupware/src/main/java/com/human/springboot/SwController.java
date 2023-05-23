package com.human.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SwController {
    
    // 테스트용
    @GetMapping("/temp/main")
    public String tempMain(){
        return "temp/temp_layout";
    }

    // 공지사항
    @GetMapping("/hw/board/notice")
    public String boardNotice(){
        return "board/board_notice";
    }

    // 사내게시판
    @GetMapping("/hw/board/free")
    public String boardFree(){
        return "board/board_free";
    }

    // 게시판 글 작성
    @GetMapping("/hw/board/insert")
    public String boardInsert(){
        return "board/board_insert";
    }

    
    

}
