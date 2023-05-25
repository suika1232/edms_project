package com.human.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class SwController {
    
    // 테스트용
    @GetMapping("/temp/main")
    public String tempMainPage(){
        return "temp/temp_layout";
    }

    // 공지사항
    @GetMapping("/hw/board/notice")
    public String boardNoticePage(HttpServletRequest req, Model model){
        HttpSession session = req.getSession();
        String userAuth = (String) session.getAttribute("userAuth");
        if(userAuth == null || userAuth.equals("")){
            userAuth = "user";
        }
        return "board/board_notice";
    }

    // 사내게시판
    @GetMapping("/hw/board/free")
    public String boardFreePage(HttpServletRequest req, Model model){
        HttpSession session = req.getSession();
        session.setAttribute("userAuth", "admin");
        String userAuth = (String) session.getAttribute("userAuth");
        if(userAuth == null || userAuth.equals("")){
            userAuth = "user";
        }
        return "board/board_free";
    }

    // 게시판 글 작성 페이지
    @GetMapping("/hw/board/newpost/{category}")
    public String boardInsertPage(@PathVariable("category")String category, 
                                    HttpServletRequest req, 
                                    Model model){
        HttpSession session = req.getSession();
        String userAuth = (String) session.getAttribute("userAuth");
        if(userAuth == null || userAuth.equals("")){
            userAuth = "user";
        }
        model.addAttribute("userAuth", userAuth);
        model.addAttribute("category", category);
        return "board/board_newpost";
    }

    @PostMapping("/board_insert")
    public String boardInsert(HttpServletRequest req){
        String category = req.getParameter("boardCategory");
        String title = req.getParameter("boardTitle");
        String content = req.getParameter("boardContent");
        System.out.println("제목: "+title);
        System.out.println("내용: "+content);
        if(category.equals("notice")){
            return "redirect:/hw/board/notice";
        }
        return "redirect:/hw/board/free";
    }


    
    

}
