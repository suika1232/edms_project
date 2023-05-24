package com.human.springboot.dao;

import com.human.springboot.dto.SwFreeBoardDTO;
import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SwDAO {
    
    ArrayList<SwFreeBoardDTO> freeBoardList();
    void freeBoardInsert(String title, String content, int writer);
 
}
