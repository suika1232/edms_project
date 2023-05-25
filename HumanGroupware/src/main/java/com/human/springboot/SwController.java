package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.kafka.KafkaProperties.Jaas;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.springboot.dao.SwDAO;
import com.human.springboot.dto.SwBoardDTO;

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
    public String boardNoticePage(){
        return "board/board_notice";
    }

    // 사내게시판
    @GetMapping("/board/free")
    public String boardFreePage(){
        return "board/board_free";
    }
    // 게시판 글 목록 불러오기
    @PostMapping("/boardlist/{category}")
    @ResponseBody
    public String boardList(@PathVariable("category")String category){
        JSONArray jArray = new JSONArray();
        ArrayList<SwBoardDTO> boardList = null;
        if(category.equals("notice")){
            boardList = sdao.boardList(1);
        }else if(category.equals("free")){
            boardList = sdao.boardList(2);
        } 
        for (SwBoardDTO items : boardList) {
            JSONObject jObject = new JSONObject();
            jObject.put("boardId", items.getBoard_id());
            jObject.put("empName", items.getEmp_name());
            jObject.put("boardTitle", items.getBoard_title());
            jObject.put("boardContent", items.getBoard_content());
            jObject.put("boardCreated", items.getBoard_created());
            jObject.put("boardUpdated", items.getBoard_updated());
            jObject.put("boardHit", items.getBoard_hit());
            jArray.put(jObject);
        }
        return jArray.toString();
    }
    // 게시판 글 보기
    @GetMapping("/board/view/{boardId}")
    public String boardView(@PathVariable("boardId")int boardId, Model model){
        sdao.boardHit(boardId);
        SwBoardDTO board = sdao.boardView(boardId);
        model.addAttribute("boardId", board.getBoard_id());
        model.addAttribute("boardTitle", board.getBoard_title());
        model.addAttribute("boardContent", board.getBoard_content());
        model.addAttribute("empName", board.getEmp_name());
        model.addAttribute("boardCreated", board.getBoard_created());
        model.addAttribute("boardUpdated", board.getBoard_updated());
        model.addAttribute("boardHit", board.getBoard_hit());
        model.addAttribute("categoryName", board.getCategory_name());
        return "board/board_view";
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
