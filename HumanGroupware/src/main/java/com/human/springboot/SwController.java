package com.human.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SwController {
    
    @GetMapping("/humangw/board/notice")
    public String boardNotice(){
        return "board/board_notice";
    }

    @GetMapping("/humangw/board/free")
    public String boardFree(){
        return "board/board_free";
    }

}
