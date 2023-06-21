package com.human.springboot.dao;


import com.human.springboot.dto.SwBoardDTO;
import com.human.springboot.dto.SwCommentDTO;
import com.human.springboot.dto.SwEdmsDTO;
import com.human.springboot.dto.SwEmpDTO;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SwDAO {
   
    ArrayList<SwBoardDTO> boardList(String category, int page, int amount, String searchCategory, String keyword);
    SwBoardDTO boardView(int boardId);
    void boardInsert(int category, int writer, String title, 
                        String content, String fileName, String filePath);
    void boardUpdate(int board_id, String title, String content, String fileName, String filePath);
    void boardDelete(int board_id);
    void boardHit(int board_id);
    int boardCommentCount(int board_id);
    int boardCount(String category, String serachCategory, String keyword);
    SwBoardDTO boardFile(int board_id);
    boolean boardFileCheck(int board_id);

    void addComment(int board_id, int writer, String content);
    void deleteComment(int comment_no);
    void deleteAllComment(int board_id);

    ArrayList<SwCommentDTO> commentList(int board_id);

    boolean userCheck(String id, String pw);
    SwEmpDTO getUserInfo(String userId);

    ArrayList<SwEmpDTO> empList();
    void edmsSend(int drater, int appMid, int appFinal, String title, String category, String refList);
    void edmsLeave(String category, String startDate, String endDate, String detail, int period);
    ArrayList<SwEdmsDTO> edmsList();
    ArrayList<SwEdmsDTO> edmsRejectList(int drafter);

    SwEdmsDTO findEdms(int edmsId);
    String getEmpName(int empNo);
    SwEdmsDTO edmsLeaveView(int edmsId);

    void edmsApprovalConfirm(int edmsId, int approverId, String status);
    void edmsApprovalReject(int edmsId, int approverId, String status, String reason);
   
    void edmsLoa(String edmsDetail, int expense);
    SwEdmsDTO edmsLoaView(int edmsId);

}
