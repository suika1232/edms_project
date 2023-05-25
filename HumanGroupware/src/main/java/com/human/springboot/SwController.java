package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.human.springboot.dao.SwDAO;
import com.human.springboot.dto.SwFreeBoardDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class SwController {

    @Autowired
    private SwDAO sdao;
    
    // 테스트용
    @GetMapping("/temp/main")
    public String tempMainPage(){
        return "temp/temp_layout";
    }

    // 공지사항
    @GetMapping("/board/notice")
    public String boardNoticePage(HttpServletRequest req, Model model){
        return "board/board_notice";
    }

    // 사내게시판
    @GetMapping("/board/free")
    public String boardFreePage(HttpServletRequest req, Model model){
        return "board/board_free";
    }
    // 게시판 글 목록 불러오기
    @PostMapping("/boardlist/{category}")
    public String boardList(@PathVariable("category")String category){
        JSONArray jArray = new JSONArray();
        if(category.equals("notice")){
        
        }else if(category.equals("free")){
            ArrayList<SwFreeBoardDTO> freeList = sdao.freeBoardList();
            for (SwFreeBoardDTO items : freeList) {
                JSONObject jObject = new JSONObject();
                jObject.put("boardID", items.getBoard_id());
                jObject.put("boardWriter", items.getBoard_writer());
                jObject.put("boardTitle", items.getBoard_title());
                jObject.put("boardContent", items.getBoard_content());
                jObject.put("boardCreated", items.getBoard_created());
                jObject.put("boardUpdated", items.getBoard_updated());
                jObject.put("boardHit", items.getBoard_hit());
                jArray.put(jObject);
            }
        } 
        return jArray.toString();
    }

    // 게시판 글 작성 페이지
    @GetMapping("/board/newpost/{category}")
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
