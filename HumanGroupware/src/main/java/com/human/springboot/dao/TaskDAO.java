package com.human.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.human.springboot.dto.task.getReportDTO;
import com.human.springboot.dto.task.getUserDepartDTO;
import com.human.springboot.dto.task.getWorkDataDTO;
import com.human.springboot.dto.task.selectTaskDTO;
import com.human.springboot.dto.task.taskReportDTO;
import com.human.springboot.dto.task.userinfoDTO;

@Mapper
public interface TaskDAO {
	
	int checkUser(String ID);
	userinfoDTO userinfo(String ID);
	
	void insertDailyWork(String title,int userID,String depart,String content,
						String notes,String created,int reportNo);
						
	getReportDTO getReport(int reportNum);
	getUserDepartDTO getUserDepart(String userName);
	
	ArrayList<getWorkDataDTO> getWorkData(int userID);
	ArrayList<getWorkDataDTO> getWorkList(int userID);
	ArrayList<getWorkDataDTO> getDworkLog(int dep_id);
	
	void updateWorkLog(int work_id);
	void insertTask_report(int taskNo,int depart,int userID,String title,String content,String created,int receiver);
	
	ArrayList<selectTaskDTO> selectTask(int userID);
	
	void insertTask(String title,int depart,int drafter,int performer,String start,String limit,String content);
	
	ArrayList<taskReportDTO> selectReport(int userID);
	ArrayList<taskReportDTO> selectReceiveReport(int userID);
	
	ArrayList<selectTaskDTO> selectSendTask(int userID);
	ArrayList<selectTaskDTO> selectReceiveTask(int userID);
	
	selectTaskDTO detailTask(int taskID);
	taskReportDTO detailTask_Report(int task_reportID);
}
