package com.human.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.human.springboot.dto.note.UserDTO;

@Mapper
public interface NoteDAO {
	void SendMg(String content,int writer,int receiver);
	void updateNoteRead(String read,int noteNum);
	UserDTO select_User(int id);
	ArrayList<serchDTO> serch_User();
	
	ArrayList<selectReceiveMgDTO> selectReceiveMg(int id,int pagenum, int amount);
	ArrayList<selectSeMgDTO> selectSeMg(int id, int pageNum, int amount);
	
	ArrayList<carringReMgDTO> carringReMg(int id, int noteid);
	ArrayList<carringSeMgDTO> carringSeMg(int id, int noteid);
	
	ArrayList<getRedelDTO> getRedel(int id,int pageNum,int amount);
	ArrayList<getSedelDTO> getSedel(int id,int pageNum,int amount);
	
	int selectSeTotal(int userid);
	int selectReTotal(int userid);
	
	int countSedel(int userid);
	int countRedel(int userid);
	
	void delSeMg(int noteid);
	void delReMg(int noteid);
	
	void updateSeDel(int noteid);
	void updateReDel(int noteid);
	int selectDeleteNote(int noteid);
	
	void deleteNote(int noteid);
	
	void recoverSedel(int noteid);
	void recoverRedel(int noteid);
}
