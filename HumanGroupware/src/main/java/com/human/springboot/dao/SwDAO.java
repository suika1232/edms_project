package com.human.springboot.dao;

import com.human.springboot.dto.EmployeeDTO;
import com.human.springboot.dto.SwBoardDTO;
import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SwDAO {
   
    ArrayList<SwBoardDTO> boardList(String category, int page, int amount);
    SwBoardDTO boardView(int boardId);
    void boardInsert(int category, int writer, String title, String content);
    void boardUpdate(int board_id, String title, String content);
    void boardDelete(int board_id);
    void boardHit(int board_id);
    int boardCount(String category);

    boolean userCheck(String id, String pw);
    EmployeeDTO getUserInfo(String userId);

}
