package com.human.springboot.dao;

import com.human.springboot.dto.SwBoardDTO;
import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SwDAO {
   
    ArrayList<SwBoardDTO> boardList(int category);
    void boardInsert(int category, int writer, String title, String content);
    SwBoardDTO boardView(int boardId);
    void boardHit(int board_id);
    int boardCount(int category);

    

}
