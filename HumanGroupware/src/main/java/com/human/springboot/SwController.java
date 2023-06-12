package com.human.springboot;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.human.springboot.dao.SwDAO;
import com.human.springboot.dto.EmployeeDTO;
import com.human.springboot.dto.SwBoardDTO;
import com.human.springboot.dto.SwCommentDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
    public String boardNoticePage(HttpServletRequest req){
        return "board/board_notice";
    }

    // 사내게시판
    @GetMapping("/board/free")
    public String boardFreePage(HttpServletRequest req){
        HttpSession userSession = req.getSession();
        if(userSession.getAttribute("loginUser") == null){
            userSession.setAttribute("userNO", 0);
        }
        return "board/board_free";
    }
    // 게시판 글 목록
    @PostMapping("/boardlist/{category}/{page}/{search}/{keyword}")
    @ResponseBody
    public String boardList(@PathVariable("category")String category,
                            @PathVariable("page")int page,
                            @PathVariable("search")String searchCategory,
                            @PathVariable("keyword")String keyword){

        int amount = 10; // 한 페이지 표시 갯수
        int total = sdao.boardCount(category, searchCategory, keyword); // notice or free
        int totalPage = (int)Math.ceil(total*1.0/amount);
        System.out.println("currentPage:"+page);
        System.out.println("totalPage:"+totalPage);

        System.out.println("검색유형: "+searchCategory);
        System.out.println("검색 키워드: "+keyword);

        ArrayList<SwBoardDTO> boardList = sdao.boardList(category, page, amount, searchCategory, keyword);
        JSONArray jArray = new JSONArray(); 

        for (SwBoardDTO items : boardList) {
            JSONObject jObject = new JSONObject();
            int commentCount = 0;
            jObject.put("boardId", items.getBoard_id());
            if(category.equals("notice")){
                jObject.put("boardNo", items.getNotice_no());
            }else{
                jObject.put("boardNo", items.getFree_no());
                commentCount = sdao.boardCommentCount(items.getBoard_id());
                jObject.put("commentCount",commentCount);
            }
            jObject.put("empName", items.getEmp_name());
            jObject.put("boardTitle", items.getBoard_title());
            jObject.put("boardContent", items.getBoard_content());
            jObject.put("boardCreated", items.getBoard_created());
            jObject.put("boardUpdated", items.getBoard_updated());
            jObject.put("boardHit", items.getBoard_hit());
            jObject.put("totalPage", totalPage);

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
        model.addAttribute("boardWriter", board.getBoard_writer());
        model.addAttribute("empName", board.getEmp_name());
        model.addAttribute("boardCreated", board.getBoard_created());
        model.addAttribute("boardUpdated", board.getBoard_updated());
        model.addAttribute("boardHit", board.getBoard_hit());
        model.addAttribute("categoryName", board.getCategory_name());

        String boardFileName = board.getBoard_file_name();
        System.out.println("첨부파일명: "+boardFileName);
        System.out.println("첨부파일경로: "+board.getBoard_file_path());
        if(boardFileName != null){
            
            model.addAttribute("boardFileName", boardFileName);
            model.addAttribute("boardFilePath", board.getBoard_file_path());
        }
        ArrayList<SwCommentDTO> commentList = sdao.commentList(boardId);
        model.addAttribute("commentList", commentList);

        return "board/board_view";
    }

    // 게시판 글 작성
    @GetMapping("/board/write/{category}")
    public String boardInsertPage(@PathVariable("category")String category, 
                                  Model model){

        model.addAttribute("category", category);
        return "board/board_write";
    }
    //게시판 글 저장(새글작성,수정 통합)
    @PostMapping("/boardInsert")
    public String boardInsert(HttpServletRequest req,
                            @RequestParam(value="boardFile", required = false)MultipartFile multi){
        String categoryName = "";
        try {
            HttpSession userSession = req.getSession();
            int writer = (int)userSession.getAttribute("userNo");

            categoryName = req.getParameter("boardCategory");
            String title = req.getParameter("boardTitle");
            String content = req.getParameter("boardContent");
            String flag = req.getParameter("flag");

            System.out.println("제목: "+title);
            System.out.println("내용: "+content);

            String originalFileName = null;
            String filePath = null;
            String fileName = null;

            if(!multi.isEmpty()){
                originalFileName = multi.getOriginalFilename();
                String fileExt = FilenameUtils.getExtension(originalFileName);
                System.out.println("업로드 파일명:"+originalFileName);
                System.out.println("확장자: "+fileExt);
                fileName = UUID.randomUUID().toString()+"."+fileExt;
                filePath = "D:/testimg/"+fileName;
                
                File file = new File(filePath);
                multi.transferTo(file);
            }

            int category = categoryName.equals("notice") ? 1 : 2;

            if(flag.equals("y")){
                int boardId = Integer.parseInt(req.getParameter("boardId"));
                if(sdao.boardFileCheck(boardId)){
                    SwBoardDTO boardFile = sdao.boardFile(boardId);
                    Path oldFile = Paths.get(boardFile.getBoard_file_path());
                    Files.deleteIfExists(oldFile);                
                }
                sdao.boardUpdate(boardId, title, content, originalFileName, filePath);
                System.out.println("수정됨");
                return "redirect:/board/"+categoryName;
            }
            sdao.boardInsert(category, writer, title, content, originalFileName, filePath);
            System.out.println("작성됨");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/board/"+categoryName;
    }
    //게시판 글 수정(내용 불러오기)
    @GetMapping("/boardUpdate/{boardId}")
    public String boardUpdate(@PathVariable("boardId")int boardId, Model model){
        SwBoardDTO board = sdao.boardView(boardId);
    
        model.addAttribute("boardId", board.getBoard_id());
        model.addAttribute("category", board.getCategory_name());
        model.addAttribute("boardTitle", board.getBoard_title());
        model.addAttribute("boardContent", board.getBoard_content());
        model.addAttribute("flag", "y");

        return "board/board_write";
    }
    //게시판 글 삭제
    @PostMapping("/boardDelete")
    @ResponseBody
    public String boardDelete(@RequestParam(value="boardId")String boardId){
        try {
            if(sdao.boardCommentCount(Integer.parseInt(boardId)) > 0){
                sdao.deleteAllComment(Integer.parseInt(boardId));
            }
            if(sdao.boardFileCheck(Integer.parseInt(boardId))){
                SwBoardDTO boardFile = sdao.boardFile(Integer.parseInt(boardId));
                Path path = Paths.get(boardFile.getBoard_file_path());
                Files.deleteIfExists(path);
            }
            sdao.boardDelete(Integer.parseInt(boardId));
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "complete";
    }
    // 게시판 댓글작성
    @PostMapping("/addComment")
    @ResponseBody
    public String addComment(HttpServletRequest req){
        try{
            int boardId = Integer.parseInt(req.getParameter("boardId"));
            int writer = Integer.parseInt(req.getParameter("writer"));
            String content = req.getParameter("content");

            System.out.println("글번호: "+boardId+" 댓글작성자: "+writer+" 내용: "+content);

            sdao.addComment(boardId, writer, content);
        }catch(Exception e){
            e.printStackTrace();
            return "fail";
        }
        return "complete";
    }
    // 게시판 댓글삭제
    @PostMapping("/deleteComment")
    @ResponseBody
    public String deleteComment(HttpServletRequest req){
        try {
            int commentNo = Integer.parseInt(req.getParameter("commentId"));
            sdao.deleteComment(commentNo);
        } catch (Exception e) {
           e.printStackTrace();
           return "fail";
        }
        return "complete";
    }
    // 게시판 파일 다운로드
    @GetMapping("/board/download/{boardId}")
    public void boardDownload(@PathVariable("boardId")int boardId, 
                                HttpServletResponse res){
        try{
            SwBoardDTO boardFileInfo = sdao.boardFile(boardId);
            File file = new File(boardFileInfo.getBoard_file_path());
            byte[] fileByte = FileUtils.readFileToByteArray(file);

            res.setContentType("application/octet-stream");
            res.setHeader("Content-Disposition", "attachment; fileName=\""+
                            URLEncoder.encode(boardFileInfo.getBoard_file_name(), 
                                              "UTF-8")+"\";");
            res.setHeader("Content-Transfer-Encoding", "Binary");

            res.getOutputStream().write(fileByte);
            res.getOutputStream().flush();
            res.getOutputStream().close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    // 임시 로그인 화면
    @GetMapping("/temp/login")
    public String tempLoginPage(){
        return "temp/temp_login";
    } 
    // 임시 로그인
    @PostMapping("/testlogin")
    public String testLogin(HttpServletRequest req){
        
        String userId = req.getParameter("loginId");
        String userPw = req.getParameter("loginPw");

        System.out.printf("loginID: %s loginPW: %s \n", userId, userPw);

        HttpSession userSession = req.getSession();

        if(sdao.userCheck(userId, userPw)){
            System.out.printf("유저 확인됨 %s \n", userId);
            EmployeeDTO userInfo = sdao.getUserInfo(userId);
            userSession.setAttribute("loginUser", userId);
            userSession.setAttribute("userNo", userInfo.getEmp_no());
            userSession.setAttribute("userName", userInfo.getEmp_name());
            userSession.setAttribute("authority", userInfo.getBoard_authority());
        }
        return "redirect:/temp/home";
    }
    // 임시 로그아웃
    @PostMapping("/testlogout")
    public String testLogout(HttpServletRequest req){
        HttpSession userSession = req.getSession();
        userSession.invalidate();
        return "redirect:/temp/home";
    }
    // 임시 메인
    @GetMapping("/temp/home")
    public String tempHome(){
        return "temp/temp_layout";
    }
    // 파일 테스트 페이지
    @GetMapping("/test/download")
    public String testDownload(){
        return "temp/test_download";
    }
    // 테스트 업로드
    @PostMapping("/testupload")
    public String testUpload(@RequestParam(value="fileUpload")MultipartFile multi){
        try {
            String fileName = multi.getOriginalFilename();
            System.out.println(fileName);
            File file = new File("D:/testimg/"+fileName);
            multi.transferTo(file);
        } catch (Exception e) {
           e.printStackTrace();
        }
        return "redirect:/test/download";
    }
    // 테스트 다운로드
    @GetMapping("/test/filedownload")
    public void testDownload(HttpServletResponse res){
        try{
            byte[] fileByte = 
            FileUtils.readFileToByteArray(new File("D:/testimg/\uC5D0\uC5B4\uD504\uB77C\uC774\uC5B4.jpg"));

            res.setContentType("application/octet-stream");
            res.setHeader("Content-Disposition", "attachment; fileName=\""+
                            URLEncoder.encode("air.jpg", "UTF-8")+"\";");
            res.setHeader("Content-Transfer-Encoding", "Binary");

            res.getOutputStream().write(fileByte);
            res.getOutputStream().flush();
            res.getOutputStream().close();
            
        }catch(Exception e){
            e.printStackTrace();
        }

    }
    
    


    
    

}
