package com.human.springboot;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.springboot.dao.NoteDAO;
import com.human.springboot.dao.TaskDAO;
import com.human.springboot.dto.note.UserDTO;
import com.human.springboot.dto.task.getReportDTO;
import com.human.springboot.dto.task.getUserDepartDTO;
import com.human.springboot.dto.task.getWorkDataDTO;
import com.human.springboot.dto.task.selectTaskDTO;
import com.human.springboot.dto.task.taskReportDTO;
import com.human.springboot.dto.task.userinfoDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class TaskController {
	@Autowired					
	private TaskDAO tdao;
	@Autowired
	private NoteDAO ndao;
	
	
	/*
	 * @GetMapping("/") public String login() { return "Ts/login"; }
	 */
	@GetMapping("/Taskhome")
	public String TaskHome(HttpServletRequest req,HttpSession session) {
		HttpSession login = req.getSession();
	  	
		String empId = (String) login.getAttribute("emp_id");
		
		int checkUser = tdao.checkUser(empId);
		
		userinfoDTO dto = null;
		
		if(checkUser==1) {
			dto	= tdao.userinfo(empId);
		}
		 Map<String, Object> userInfoMap = new HashMap<>();
		    
		 	userInfoMap.put("emp_no", dto.getEmp_no());
		    
		    userInfoMap.put("emp_name", dto.getEmp_name());
		    
		    userInfoMap.put("emp_position", dto.getEmp_position());
		    
		    userInfoMap.put("emp_depart", dto.getEmp_depart());
		    
		    userInfoMap.put("dep_name", dto.getDep_name());
		    
		    userInfoMap.put("managerName", dto.getManagerName());
		    
		    userInfoMap.put("managerNum", dto.getManagerNum());
		 
			session.setAttribute("userInfoMap", userInfoMap);
		return "task/task_home";
	}
	@GetMapping("/WorkLog")
	public String workLog() {
		return "task/task_write_report";
	}

	@GetMapping("/depWorkLog")
	public String workLog2() {
		return "task/task_depart_worklog";
	}
	@GetMapping("/MyWorkLog")
	public String MyWorkLog() {
		return "task/task_my_worklog";
	}
	/*
	 * @PostMapping("/login")
	 * 
	 * @ResponseBody public void loginID(HttpServletRequest req,HttpSession session)
	 * {
	 * 
	 * }
	 */

	@PostMapping("/getReport")
	@ResponseBody
	public Map<String,Object> getReport(HttpServletRequest req) {
		Map<String,Object> response = new HashMap<>();
		int repNo=Integer.parseInt(req.getParameter("repNo"));
		getReportDTO dto = tdao.getReport(repNo);
		
		String tag= dto.getReport_tag();
		String style= dto.getReport_style();
		
		response.put("tag", tag);
		response.put("style", style);
		
		return response;
	}
	@PostMapping("/getWorkData")
	@ResponseBody
	public String getMyWorkData(HttpServletRequest req) {
		
		ArrayList<getWorkDataDTO> dto
			= tdao.getWorkData(Integer.parseInt(req.getParameter("workNo")));
	
		JSONArray ja = new JSONArray();
			JSONObject jo = new JSONObject();
			
			jo.put("title", dto.get(0).getDwork_name());
			jo.put("writer", dto.get(0).getDwork_writer());
			
			getUserDepartDTO to = tdao.getUserDepart(req.getParameter("userName"));
			String departName = to.getDep_name();
			
			jo.put("departName", departName);
			jo.put("content", dto.get(0).getDwork_content());
			jo.put("notes", dto.get(0).getDwork_notes());
			jo.put("created", dto.get(0).getDwork_created());
			
			ja.put(jo);
			
		return ja.toString();
	}
	////////////////////////////////�μ�����///////////////////////////////////////
	
	/////////////////////////////////���� ����///////////////////////////////////////
	@PostMapping("/insertReport")
	@ResponseBody
	public void insertWorkLog(HttpServletRequest req){
		
		tdao.insertDailyWork(
			req.getParameter("title"),
			Integer.parseInt(req.getParameter("userID")),
			req.getParameter("depart"),
			req.getParameter("content"),
			req.getParameter("notes"),
			req.getParameter("created"),
			Integer.parseInt(req.getParameter("reportNo"))
		);
	}
	@PostMapping("/getMyWorkLog")
	@ResponseBody
	public Map<String, Object> getMyWorkLog(HttpServletRequest req, Model model) {
		
		Map<String , Object> response= new HashMap<>();
		int reportNum=Integer.parseInt(req.getParameter("repNo"));
		getReportDTO dto = tdao.getReport(reportNum);
		
		String tag= dto.getReport_tag();
		String style = dto.getReport_style();
		
		model.addAttribute("tablestyle",style);
		
		response.put("tag",tag);
		response.put("tablestyle",style);
		
		return response;
	}
	@PostMapping("/getWorkList")
	@ResponseBody
	public String getWorkList(HttpServletRequest req) {
		ArrayList<getWorkDataDTO> dto = 
			tdao.getWorkList(Integer.parseInt(req.getParameter("userID")));
		JSONArray ja = new JSONArray();
		for(int i =0; i<dto.size(); i++) {
			JSONObject jo = new JSONObject();
			
			jo.put("rep_no", dto.get(i).getReport_no());
			
			jo.put("WorkNum", dto.get(i).getDwork_id());

			jo.put("title",dto.get(i).getDwork_name());
			
			jo.put("content",dto.get(i).getDwork_content());
			
			jo.put("created",dto.get(i).getDwork_created());
			
			ja.put(jo);
		}
		return ja.toString();
	}
	@PostMapping("/updateWorkLog")
	@ResponseBody
	public void updateWorkLog(HttpServletRequest req) {
		String workNo = req.getParameter("workNo");
		
		String [] no  = workNo.split(",");
		
		for(int i = 0; i<no.length; i++) {
			
			int work_id=Integer.parseInt(no[i]);
			
			tdao.updateWorkLog(work_id);
		}
 	}
	/////////////////////////////�μ���������/////////////////////////////////
	@PostMapping("/getDworkLog") 
	@ResponseBody 
	public String getDworkLog(HttpServletRequest req) { 
		 
		ArrayList<getWorkDataDTO> dto = 
			tdao.getDworkLog(Integer.parseInt(req.getParameter("dep_id")));
		  
		  JSONArray ja = new JSONArray();
		  
	  		for(int i =0; i<dto.size(); i++) { 
	  		
	  			JSONObject jo = new JSONObject();
	  			
	  			jo.put("rep_no", dto.get(i).getReport_no());
	  		
	  			jo.put("WorkNo", dto.get(i).getDwork_id());
	  			
	  			jo.put("title",dto.get(i).getDwork_name());
	  			
	  			UserDTO name  = ndao.select_User(dto.get(i).getDwork_writer());
	  			
				jo.put("writer", name.getEmp_name());
				
				jo.put("content",dto.get(i).getDwork_content());
				
				jo.put("created",dto.get(i).getDwork_created());
				
				ja.put(jo);
	  		}
	  		return ja.toString();
	  }
	@GetMapping("/writeReport")
	public String wrirteReport () {
		return "task/ts_write_report";
	}
	////////////////////////////////////////////��������//////////////////////////////////
	
	
	@PostMapping("/insertTask_report")
	@ResponseBody
	public void insertTask_report(HttpServletRequest req) {
		
		int uesrID = Integer.parseInt(req.getParameter("userID"));
		System.out.println(uesrID);
		int taskNo = Integer.parseInt(req.getParameter("task"));
		System.out.println(taskNo);
		int depart = Integer.parseInt(req.getParameter("depart"));
		System.out.println(depart);
		int receiver = Integer.parseInt(req.getParameter("receiver"));
		System.out.println(receiver);
		
		String title = req.getParameter("title");
		System.out.println(title);
		String content = req.getParameter("content");
		System.out.println(content);
		String created = req.getParameter("created");
		System.out.println(created);
		
		tdao.insertTask_report(taskNo,depart,uesrID,title,content,created,receiver);
	}
	@PostMapping("/selectTask")
	@ResponseBody
	public String selectTask(HttpServletRequest req) {
		int userID = Integer.parseInt(req.getParameter("userID"));
		ArrayList<selectTaskDTO>dto = tdao.selectTask(userID);
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<dto.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("taskID", dto.get(i).getTask_id());
			jo.put("taskName", dto.get(i).getTask_name());
			
			ja.put(jo);
		}
		System.out.println(ja);
		return ja.toString();
	}
	@PostMapping("/selectUser")
	@ResponseBody
	public String selectUser(HttpServletRequest req) {
		int departNO = Integer.parseInt(req.getParameter("departNum"));
		ArrayList<UserDTO>dto = ndao.selectUser(departNO);
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<dto.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("emp_no", dto.get(i).getEmp_no());
			jo.put("emp_name", dto.get(i).getEmp_name());
			
			ja.put(jo);
			
			
		}
		System.out.println(ja);
		return ja.toString();
	}
	@PostMapping("insertTask")
	@ResponseBody
	public void insertTask(HttpServletRequest req) {
		String title=req.getParameter("title");
		int depart = Integer.parseInt(req.getParameter("depart"));
		int drafter = Integer.parseInt(req.getParameter("drafter"));
		int performer = Integer.parseInt(req.getParameter("performer"));
		String start =req.getParameter("start");
		String limit =req.getParameter("limit");
		String content = req.getParameter("content");
		System.out.println(title+","+depart+","+drafter+","+performer+","+start+","+limit+","+content);
		tdao.insertTask(title,depart,drafter,performer,start,limit,content);
		
	}
	///////////////������� ���� �Ǵ� ������ ����/////////////////
	@PostMapping("/selectReport")
	@ResponseBody
	public String selectReport(HttpServletRequest req) {
		
		int managerID= Integer.parseInt(req.getParameter("managerNum")); 
		int userID = Integer.parseInt(req.getParameter("userID"));
		ArrayList<taskReportDTO>dto=null;
		if(userID==managerID) {
			dto=tdao.selectReceiveReport(userID);
		}else {
			dto=tdao.selectReport(userID);
		}
		
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<dto.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			String human="";
			if(userID==managerID) {
				UserDTO name  = ndao.select_User(dto.get(i).getTr_writer());
				human = name.getEmp_name();
				jo.put("human", human);
			}else {
				UserDTO name  = ndao.select_User(dto.get(i).getTr_receiver());
				human= name.getEmp_name();
				jo.put("human", human);
			}
			jo.put("rceiverNum", dto.get(i).getTr_receiver());
			jo.put("writerNum",dto.get(i).getTr_writer());
			jo.put("tr_id",dto.get(i).getTr_id());
			jo.put("title", dto.get(i).getTr_title());
			jo.put("created", dto.get(i).getTr_created());
			jo.put("content", dto.get(i).getTr_content());
			
			
			ja.put(jo);
		}
		System.out.println(ja);
		return ja.toString();
	}
	@GetMapping("/requestTask")
	public String request() {
		return "task/task_report";
	}
	@PostMapping("/selectTasks")
	@ResponseBody
	public String selectTasks(HttpServletRequest req) {
		
		int userID =  Integer.parseInt(req.getParameter("userID"));
		int managerID= Integer.parseInt(req.getParameter("managerNum"));
		
		ArrayList<selectTaskDTO>dto=null;
		System.out.println(userID);
		System.out.println(managerID);
		if(userID==managerID) {
			dto=tdao.selectSendTask(userID);
		}else {
			System.out.println(userID);
			dto=tdao.selectReceiveTask(userID);
		}
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<dto.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("task_id",dto.get(i).getTask_id());
			jo.put("task_name",dto.get(i).getTask_name());
			jo.put("task_depart", dto.get(i).getTask_depart());
			jo.put("task_drafter", dto.get(i).getTask_drafter());
			if(userID==managerID) {
				UserDTO name = ndao.select_User(dto.get(i).getTask_performer());
				String task_performerName =name.getEmp_name();
				jo.put("task_human",task_performerName);
				jo.put("task_drafterName",dto.get(i).getTask_drafter());
			}else {
				UserDTO name  = ndao.select_User(dto.get(i).getTask_drafter());
				String task_drafterName= name.getEmp_name();
				jo.put("task_human", task_drafterName);
			}
			jo.put("task_performer", dto.get(i).getTask_performer());
			jo.put("task_started", dto.get(i).getTask_started());			
			jo.put("task_limit", dto.get(i).getTask_limit());
			jo.put("task_content", dto.get(i).getTask_content());
			
			ja.put(jo);
		}
		System.out.println(ja);
		return ja.toString();
	}
	@GetMapping("/detail")
	public String dtail() {
		return "task/task_detail";
	}
	@GetMapping("/detail/{type}/{id}/{userID}")
	public String dtail2(@PathVariable("type")String type,
						 @PathVariable("id")int id,
						 @PathVariable("userID")int userID,
						 Model model) {
		String human;
		System.out.println(id);
		System.out.println(type);
		if(type.equals("S_Task")) {
			
			selectTaskDTO sto = tdao.detailTask(id);
			
			UserDTO dto =ndao.select_User(sto.getTask_performer());
			
			human = dto.getEmp_name();
			
			model.addAttribute("human",human);
			
			model.addAttribute("sto",sto);
			
			model.addAttribute("type",type);
			
		}else if(type.equals("R_Task")) {
			
			selectTaskDTO sto = tdao.detailTask(id);
			
			UserDTO dto =ndao.select_User(sto.getTask_drafter());
			
			human = dto.getEmp_name();
			
			model.addAttribute("human",human);
			
			model.addAttribute("sto",sto);
			
			model.addAttribute("type",type);
			
		}else if(type.equals("S_Task_Report")) {
			
			taskReportDTO sto = tdao.detailTask_Report(id);
			
			UserDTO dto =ndao.select_User(sto.getTr_writer());
			
			human = dto.getEmp_name();
			
			model.addAttribute("human",human);
			
			model.addAttribute("sto",sto);
		
			model.addAttribute("type",type);
			
			
		}else if(type.equals("R_Task_Report")){
			
			taskReportDTO sto= tdao.detailTask_Report(id);
			System.out.println(sto);
			UserDTO dto =ndao.select_User(sto.getTr_writer());
			human = dto.getEmp_name();
			
			System.out.println("������ �̸�"+human);
			
			model.addAttribute("human",human);
			
			model.addAttribute("sto",sto);
			
			model.addAttribute("type",type);
		}else{
			
		}
		
		return "task/task_detail";
	} 	
	
}
