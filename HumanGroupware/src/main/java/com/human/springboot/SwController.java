package com.human.springboot;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.ZoneId;

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
import com.human.springboot.dto.SwBoardDTO;
import com.human.springboot.dto.SwCommentDTO;
import com.human.springboot.dto.SwEdmsDTO;
import com.human.springboot.dto.SwEmpDTO;

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
            int writer = (int)userSession.getAttribute("emp_no");

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
    // 전자결재 목록 페이지
    @GetMapping("/edms/list")
    public String edmsList(){
        
        return "edms/edms_list";
    }
    // 반려문서함
    @GetMapping("/edms/reject")
    public String edmsRejectList(){
        
        return "edms/edms_reject_list";
    }
    // 결재목록 불러오기
    @PostMapping("/getEdmsList/{category}")
    @ResponseBody
    public String getEdmsList(@PathVariable("category")String category,
                                HttpServletRequest req){
        System.out.println("불러올 전자결재 목록: "+category);

        HttpSession session = req.getSession();
        ArrayList<SwEdmsDTO> edmsList = null;
        if(category.equals("all")){
            edmsList = sdao.edmsList();
        }else if(category.equals("reject")){
            edmsList = sdao.edmsRejectList((int)session.getAttribute("emp_no"));
        }

        JSONArray jArray = new JSONArray();
        for (SwEdmsDTO edms : edmsList) {
            JSONObject jObject = new JSONObject();
            jObject.put("edmsId", edms.getEdms_id());
            jObject.put("edmsCategory", edms.getEdms_category());
            jObject.put("edmsTitle", edms.getEdms_title());
            jObject.put("empName", edms.getEmp_name());
            jObject.put("depName", edms.getDep_name());
            jObject.put("edmsDate", edms.getEdms_date());
            jObject.put("edmsStatus", edms.getEdms_status());
            jArray.put(jObject);
        }
        return jArray.toString();
    }
    // 결재문서 상세확인
    @GetMapping("/edms/view/{edmsId}")
    public String edmsView(@PathVariable("edmsId")int edmsId, Model model, 
                            HttpServletRequest req){

        SwEdmsDTO edms = sdao.findEdms(edmsId);
        String edmsCategory = edms.getEdms_category();

        HttpSession session = req.getSession();
        String loginUser = (String)session.getAttribute("emp_id");
        SwEmpDTO userInfo = sdao.getUserInfo(loginUser);

        System.out.println("결재문서 접근유저: "+userInfo.getEmp_no());
        
        model.addAttribute("loginUser", userInfo);
        model.addAttribute("edmsId", edmsId);
        model.addAttribute("edmsTitle", edms.getEdms_title());
        
        model.addAttribute("empName", edms.getEmp_name());
        model.addAttribute("empDepart", edms.getDep_name());
        model.addAttribute("empPosition", edms.getPosition_name());

        model.addAttribute("midId", edms.getEdms_mid_approver());
        model.addAttribute("midName", 
                            sdao.getEmpName(edms.getEdms_mid_approver()));
        
        model.addAttribute("finalId", edms.getEdms_fnl_approver());
        model.addAttribute("finalName", 
                            sdao.getEmpName(edms.getEdms_fnl_approver()));
        
        model.addAttribute("edmsDate", edms.getEdms_date());
        System.out.println("불러올 문서날짜: "+edms.getEdms_date());
        model.addAttribute("edmsCategory", edmsCategory);
        model.addAttribute("edmsStatus", edms.getEdms_status());
        
        String midCheck = edms.getEdms_mid_chk();
        String finalCheck = edms.getEdms_fnl_chk();

        model.addAttribute("midCheck", midCheck);
        model.addAttribute("finalCheck", finalCheck);

        if(midCheck.equals("y")){
            if(finalCheck.equals("y")){
                model.addAttribute("edmsStep", "complete");
            }else{
                model.addAttribute("edmsStep", "final");
            }
        }else{
            model.addAttribute("edmsStep", "mid");
        }                                

        if(edmsCategory.equals("휴가")){
            SwEdmsDTO leave = sdao.edmsLeaveView(edmsId);
            String categoryDetail = leave.getLeave_category();
            model.addAttribute("leaveCategory", leave.getLeave_category());
            model.addAttribute("leaveStart", leave.getLeave_start());
            model.addAttribute("leaveEnd", leave.getLeave_end());
            model.addAttribute("detail", leave.getLeave_detail());
            model.addAttribute("leavePeriod", leave.getLeave_period());
            model.addAttribute("categoryDetail", categoryDetail);
        }else{
            SwEdmsDTO loa = sdao.edmsLoaView(edmsId);
            model.addAttribute("detail", loa.getLoa_detail());
            model.addAttribute("loaExpense", loa.getLoa_expense());
        }

        if(edms.getEdms_status().equals("반려")){
            model.addAttribute("edmsReason", edms.getEdms_reason());
        }

        return "edms/edms_approval";
    }
    // 전자결재 기안하기
    @GetMapping("/edms/draft")
    public String edmsDraft(){
        return "edms/edms_draft";
    }
    // 전자결재 직원 리스트 불러오기
    @PostMapping("/edms/emplist")
    @ResponseBody
    public String edmsEmpList(){
        ArrayList<SwEmpDTO> empList = sdao.empList();
        JSONArray jArray = new JSONArray();
        for (SwEmpDTO emp: empList) {
            JSONObject jObject = new JSONObject();
            jObject.put("empNo", emp.getEmp_no());
            jObject.put("empName", emp.getEmp_name());
            jObject.put("empPosition", emp.getPosition_name());
            jObject.put("empDepart", emp.getDep_name());
            jArray.put(jObject);
        }
        return jArray.toString();
    }
    // 전자결재 양식
    @GetMapping("/edms/template/{category}")
    public String edmsTemplateLeave(@PathVariable("category")String category,
                                     HttpServletRequest req, Model model){

        HttpSession session = req.getSession();
        String loginUser = (String) session.getAttribute("emp_id");
        SwEmpDTO userInfo = sdao.getUserInfo(loginUser);
        int empNo = userInfo.getEmp_no();
        String empName = userInfo.getEmp_name();
        String empDepart = userInfo.getDep_name();
        String empPosition = userInfo.getPosition_name();

        LocalDate now = LocalDate.now(ZoneId.of("Asia/Seoul"));
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();

        System.out.printf("현재날짜: %d 년 %d 월 %d 일 \n", year, month, day);

        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("day", day);

        model.addAttribute("empNo", empNo);
        model.addAttribute("empName", empName);
        model.addAttribute("empDepart", empDepart);
        model.addAttribute("empPosition", empPosition);
        
        System.out.println("선택된 양식: "+category);
        String goTo = "edms/edms_template_";
        goTo += category.equals("leave") ? "leave" : "loa";
        System.out.println("리턴: "+goTo);

        return goTo;
    }
    // 전자결재 상신
    @PostMapping("/edmsSend/{edmsCategory}")
    public String edmsSend(@PathVariable("edmsCategory")String edmsCategory,
                             HttpServletRequest req){
        int writerId = Integer.parseInt(req.getParameter("writerId"));
        int midId = Integer.parseInt(req.getParameter("midId"));
        int finalId = Integer.parseInt(req.getParameter("finalId"));
        String refList = req.getParameter("edmsRefList");
        
        String edmsTitle = req.getParameter("edmsTitle");
        edmsCategory = edmsCategory.equals("leave") ? "휴가" : "품의";

        sdao.edmsSend(writerId, midId, finalId, edmsTitle, edmsCategory, refList);

        if(edmsCategory.equals("휴가")){
            String category = req.getParameter("selectedLeaveCategory");
            String startDate = req.getParameter("startYear")+"-"+
                                req.getParameter("startMonth")+"-"+
                                req.getParameter("startDay");
            String endDate = req.getParameter("endYear")+"-"+
                                req.getParameter("endMonth")+"-"+
                                req.getParameter("endDay");
            String leaveDetail = req.getParameter("leaveDetail");
            int leavePeriod = Integer.parseInt(req.getParameter("leavePeriod"));

            System.out.println("카테고리: "+category);
            System.out.println("시작: "+startDate);
            System.out.println("종료: "+endDate);
            System.out.println("상세내용:"+leaveDetail);
            System.out.println("총 일수: "+leavePeriod);

            sdao.edmsLeave(category, startDate, endDate, leaveDetail, leavePeriod);

        }else if(edmsCategory.equals("품의")){
            System.out.println("loaExpense: ["+req.getParameter("loaExpense")+"]");

            String loaDetail = req.getParameter("loaDetail");
            int loaExpense = Integer.parseInt(req.getParameter("loaExpense"));

            System.out.println("상세: "+loaDetail);
            System.out.println("비용: "+loaExpense);

            sdao.edmsLoa(loaDetail, loaExpense);
        }
        return "redirect:/edms/list";
    }
    // 전자결재 결재하기
    @PostMapping("/edms/approval/{edmsId}")
    @ResponseBody
    public String edmsApproval(@PathVariable("edmsId")int edmsId,
                                HttpServletRequest req){
        // String approveLine = req.getParameter("edmsStep");
        try{
            int approver = Integer.parseInt(req.getParameter("approver"));
            String receive = req.getParameter("receive");
            System.out.println("결재처리: "+ receive);
            String reason = req.getParameter("reason");

            if(receive.equals("반려")){
                System.out.println("처리내용: "+reason);
                sdao.edmsApprovalReject(edmsId, approver, receive, reason);
            }else if(receive.equals("승인")){
                receive = "완료";
                sdao.edmsApprovalConfirm(edmsId, approver, receive);
            }

        }catch(Exception e){
            e.printStackTrace();
            return "fail";
        }
        
        return "complete";
    }

    // 임시 로그인 화면
    @GetMapping("/edms/login")
    public String edmsLoginPage(){
        return "temp/edms_login";
    } 
    // 임시 로그인
    @PostMapping("/edmslogin")
    public String edmsLogin(HttpServletRequest req){
        
        String userId = req.getParameter("loginId");
        String userPw = req.getParameter("loginPw");

        System.out.printf("loginID: %s loginPW: %s \n", userId, userPw);

        HttpSession userSession = req.getSession();

        if(sdao.userCheck(userId, userPw)){
            System.out.printf("유저 확인됨 %s \n", userId);
            SwEmpDTO userInfo = sdao.getUserInfo(userId);
            userSession.setAttribute("emp_id", userId);
            userSession.setAttribute("emp_no", userInfo.getEmp_no());
            userSession.setAttribute("userName", userInfo.getEmp_name());
            userSession.setAttribute("authority", userInfo.getBoard_authority());
            System.out.println(userInfo.getBoard_authority());
        }
        return "redirect:/edms/home";
    }
    // 임시 로그아웃
    @PostMapping("/edmslogout")
    public String testLogout(HttpServletRequest req){
        HttpSession userSession = req.getSession();
        userSession.invalidate();
        return "redirect:/edms/home";
    }
    // 임시 메인
    @GetMapping("/edms/home")
    public String tempHome(){
        return "temp/edms_layout";
    }
    // 파일 테스트 페이지
    @GetMapping("/test/download")
    public String testDownload(){
        return "temp/test_download";
    }
    // 테스트 업로드
    @PostMapping("/testupload")
    public String testUpload(@RequestParam(value="fileUpload")MultipartFile multi,
                            Model model){
        try {
            String fileName = multi.getOriginalFilename();
            String filePath = "D:/testimg/" + fileName;
            System.out.println(fileName);
            File file = new File(filePath);
            multi.transferTo(file);

            model.addAttribute("fileName", fileName);
            model.addAttribute("filePath", filePath);
        } catch (Exception e) {
           e.printStackTrace();
        }
        return "redirect:/test/download";
    }
    // 테스트 다운로드
    @GetMapping("/test/filedownload")
    public void testDownload(HttpServletResponse res,
                            HttpServletRequest req){
        try{
            String filePath = req.getParameter("filePath");
            String fileName = req.getParameter("fileName");
            byte[] fileByte = 
            FileUtils.readFileToByteArray(new File(filePath));

            res.setContentType("application/octet-stream");
            res.setHeader("Content-Disposition", "attachment; fileName=\""+
                            URLEncoder.encode(fileName, "UTF-8")+"\";");
            res.setHeader("Content-Transfer-Encoding", "Binary");

            res.getOutputStream().write(fileByte);
            res.getOutputStream().flush();
            res.getOutputStream().close();
            
        }catch(Exception e){
            e.printStackTrace();
        }

    }
    
    


    
    

}
