package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import jakarta.servlet.http.HttpServletRequest;

@Controller

public class NoteController {
	
	@Autowired
	
	private NoteDAO ndao;
	
//-------------------------------- 새로운 메시지작성  페이지관련 매핑---------------------------------------//	
	
	@GetMapping("/New")
	public String asdd() {		
		return "Mg/NewMg";
	}
	
	@PostMapping("/userName")
	@ResponseBody
	public String UserId(HttpServletRequest req) {
		
		int id = Integer.parseInt(req.getParameter("user"));
		
		UserDTO dto = ndao.select_User(id);

		String writer = dto.getEmp_name();

		return writer;
	}
	
	@PostMapping("/serchUser")
	@ResponseBody
	public String serchUser() {
		
		ArrayList<serchDTO> dto = ndao.serch_User();
		
		JSONArray ja = new JSONArray();
		
		for(int i = 0; i<dto.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("no", dto.get(i).emp_no);
			jo.put("name", dto.get(i).emp_name);
			jo.put("depart", dto.get(i).dep_name);
			
			ja.put(jo);
			
		}
		return ja.toString();
	}
	
	@PostMapping("/sendMg")
	@ResponseBody
	public String SendMg(HttpServletRequest req) {
		
		String retval = "ok";
		
		String content = req.getParameter("Content");
		
		int writer = Integer.parseInt(req.getParameter("Writer"));
		
		int receiver =Integer.parseInt(req.getParameter("Receiver")); 
		
		ndao.SendMg(content,writer,receiver);

		return retval;
	}
//--------------------------------보낸메시지함, 받은메시지함  페이지관련 매핑-----------------------------------//
	
	@GetMapping("/receive")
	public String receiveMg() {
		return "Mg/ReceiveMgList";
	}
	
	@GetMapping("/send")
	public String sendMg() {
		return "Mg/SendMgList";
	}
	
	@PostMapping("/selectSendMessage")
	@ResponseBody
	public String selectSeMg(HttpServletRequest req) {
		
		int userId =Integer.parseInt(req.getParameter("userId"));
		int total= ndao.selectSeTotal(userId);
		
		jh_pagination pg = new jh_pagination();
		pg.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		pg.setAmount(Integer.parseInt(req.getParameter("amount")));
		
		int pageNum = pg.getPageNum();
		int amount = pg.getAmount();
		
		int totalPage = (int)Math.ceil(total*1.0/amount);
		
		ArrayList<selectSeMgDTO>dto = ndao.selectSeMg(userId, pageNum , amount);
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<dto.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("noteNum", dto.get(i).getNote_id());
			jo.put("content", dto.get(i).getNote_content());
			jo.put("senddate", dto.get(i).getNote_senddate());
			
			jo.put("receiver", dto.get(i).getEmp_name());
			jo.put("receiverId", dto.get(i).getNote_recipient());
			
			jo.put("total", total);
			jo.put("totalPage", totalPage);
			
			ja.put(jo);
			
		}
		return ja.toString();
	}
	
	@PostMapping("/selectReceiveMessage")
	@ResponseBody
	public String selectReList(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("user"));
		int total = ndao.selectReTotal(id); //로그인된 유저의 받은 메시지의 총 갯수 가져옴 
		
		jh_pagination pg = new jh_pagination();
	
		pg.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		pg.setAmount(Integer.parseInt(req.getParameter("amount")));

		int pagenum = pg.getPageNum();
		int amount = pg.getAmount();
		
		int totalPage = (int)Math.ceil(total*1.0/amount); //총 페이지 갯수 
		
		
		ArrayList<selectReceiveMgDTO>dto = ndao.selectReceiveMg(id, pagenum, amount);
		
		JSONArray ja =new JSONArray();
		for(int i=0; i<dto.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("senderId",dto.get(i).getSender_id());
			
			jo.put("noteread", dto.get(i).getNote_read());
			jo.put("noteNum",dto.get(i).getNote_id());
			
			jo.put("sender", dto.get(i).getEmp_name());
			
			jo.put("content", dto.get(i).getNote_content());
			jo.put("senddate", dto.get(i).getNote_senddate());
			
			jo.put("total",total);
			jo.put("totalPage", totalPage);
			
			ja.put(jo);
		}
		return ja.toString();
	}
	
	@PostMapping("/updateRead")
	@ResponseBody
	public void read(HttpServletRequest req) {
		
		int noteNum = Integer.parseInt(req.getParameter("noteNum"));
		
		String read = req.getParameter("noteRead");
		
		ndao.updateNoteRead(read,noteNum);
	}
	
	@PostMapping("/deleteSendMessage")
	@ResponseBody
	public void delSeMg(HttpServletRequest req) {
		
		String noteid = req.getParameter("noteid");
		
		String[] noteids = noteid.split(",");
		
		for(int i =0; i<noteids.length; i++) {
			
			int note_id=Integer.parseInt(noteids[i]);
			
			ndao.delSeMg(note_id);
			//둘다 delete인걸 찾아서 맞으면 삭제
		}
	}
	
	@PostMapping("/deleteReceiveMessage")
	@ResponseBody
	public void delReMg(HttpServletRequest req) {
	    String noteid = req.getParameter("noteid");
	    System.out.println(noteid);
	    
	    String[] noteids = noteid.split(",");
	    System.out.println(noteids.length);
	    for (int i = 0; i<noteids.length; i++) {
	        int note_id = Integer.parseInt(noteids[i]);
//	        System.out.println(note_id);
	        ndao.delReMg(note_id);
	        //둘 다 delete인 걸 찾아서 맞으면 삭제
	    }
	}
	
	//--------------------------------상세내용 페이지관련 매핑-------------------------------------------//
	
	@GetMapping("/detailMg")
	public String detailMg() {
		return "Mg/DetailMg";
	}
	
	@GetMapping("/detailMg/{senderID}/{receiverID}/{NoteNumber}/{value}")
	public String detailMg2(@PathVariable("senderID")int senderID,
							@PathVariable("receiverID")int receiverID,
							@PathVariable("NoteNumber")int NoteNumber,
							@PathVariable("value")int value,
							Model model) {
		String human ;
		System.out.println("들어오긴함");
		if(value==1){ // 들어온 밸류값이 1이면 받은 메시지 상세 내용 출력 
					
			UserDTO dto = ndao.select_User(senderID);
			
			human = dto.getEmp_name();
			
			model.addAttribute("senderName",human);
			
			ArrayList<carringReMgDTO> info = ndao.carringReMg(receiverID, NoteNumber);
			
			
			model.addAttribute("info",info);
		}else {     
			
			if(value==2 || value==3) {
				
				UserDTO dto = ndao.select_User(receiverID);
				
				human = dto.getEmp_name();
				
				model.addAttribute("receiverName",human);
				
				ArrayList<carringSeMgDTO> info = ndao.carringSeMg(senderID,NoteNumber);
				
				model.addAttribute("info",info);
				
			}else if(value==4) {
				
				UserDTO dto = ndao.select_User(senderID);
				
				human = dto.getEmp_name();
				
				model.addAttribute("senderName",human);
				
				ArrayList<carringReMgDTO> info = ndao.carringReMg(receiverID, NoteNumber);
				
				model.addAttribute("info",info);
			}		
		}
		model.addAttribute("value",value);
		
		return "Mg/DetailMg";
		
	}
	
	@GetMapping("/New/{senderID}")
	public String senderId(@PathVariable("senderID")int senderID,Model model) {
		
		UserDTO  dto = ndao.select_User(senderID);
		
		String senderName = dto.getEmp_name(); 
		
		model.addAttribute("senderName",senderName);
		
		model.addAttribute("senderID",senderID);
		
		return "Mg/NewMg";
	}
	
	@GetMapping("/returnReceiver")
	public String returns() {
		return "redirect:/receive";
	}
	
	@GetMapping("/returnSend")
	public String returns2() {
		return "redirect:/send";
	}
	@GetMapping("/tom")
	public String tom() {
		return "Mg/tom";
	}

	@PostMapping("/getSedel")
	@ResponseBody 
	public String getSedel(HttpServletRequest req) { 
		
		int userId=Integer.parseInt(req.getParameter("userId"));
		int total = ndao.countSedel(userId);
		System.out.println("유저번호"+userId);
		jh_pagination pg = new jh_pagination();
		pg.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		pg.setAmount(Integer.parseInt(req.getParameter("amount")));

		int pageNum=pg.getPageNum();
		int amount=pg.getAmount();
		
		int totalPage = (int)Math.ceil(total*1.0/amount);
		
		System.out.println(totalPage+","+amount+","+pageNum+","+total);
		ArrayList<getSedelDTO> dto = ndao.getSedel(userId,pageNum,amount); 
		
		JSONArray ja = new JSONArray(); 
		for(int i=0; i<dto.size(); i++) {
			JSONObject jo = new JSONObject();
			
			jo.put("noteId",dto.get(i).getNote_id());
			System.out.println(dto.get(i).getNote_id());
			jo.put("receiverID",dto.get(i).getNote_recipient());
			jo.put("receiver",dto.get(i).getReceiver());
			jo.put("content",dto.get(i).getNote_content());
			jo.put("senddate",dto.get(i).getNote_senddate());
			
			jo.put("amount",amount);
			jo.put("total", total);
			jo.put("totalPage",totalPage);
			
			ja.put(jo);
		}
		return ja.toString(); 
	  }
	  
	 @PostMapping("/getRedel")
	 @ResponseBody 
	 public String getRedel(HttpServletRequest req) {
		  int userId=Integer.parseInt(req.getParameter("userId"));		  
		  int total = ndao.countRedel(userId);
		  
		  jh_pagination pg = new jh_pagination();
		  
		  pg.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		  pg.setAmount(Integer.parseInt(req.getParameter("amount")));
		  
		  int pageNum = pg.getPageNum();
		  int amount = pg.getAmount();
		  
		  int totalPage = (int)Math.ceil(total*1.0/amount);
		  
		  ArrayList<getRedelDTO> dto = ndao.getRedel(userId,pageNum,amount);
		  
		  JSONArray ja = new JSONArray(); 
			for(int i=0; i<dto.size(); i++){
				
				JSONObject jo = new JSONObject();
				
				jo.put("noteId",dto.get(i).getNote_id());
				jo.put("senderID", dto.get(i).getNote_writer());
				jo.put("sender",dto.get(i).getSender());
				jo.put("content",dto.get(i).getNote_content());
				jo.put("receivedate",dto.get(i).getNote_senddate());
				
				jo.put("amount",amount);
				jo.put("total", total);
				jo.put("totalPage", totalPage);
				
				ja.put(jo);
			}
		 return ja.toString(); 
	  }
	  @PostMapping("/update_sedel")
	  @ResponseBody
	  public String update_sedel(HttpServletRequest req) {
		  String  noteid = req.getParameter("noteNum");
		  String[] noteids = noteid.split(",");
		  for(int i=0; i<noteids.length; i++) {
			  System.out.println(noteids[i]);
			  int number=Integer.parseInt(noteids[i]);
				ndao.updateSeDel(number);
				int checkNote= ndao.selectDeleteNote(number);
				
				  System.out.println("둘다 delete인지 체크한 숫자 : "+checkNote);
				  
				
				if(checkNote==1) {
					System.out.println("삭제할 떄 들어오는 노트 번호 "+number);
					ndao.deleteNote(number);
					
				}
		  }
		  return "ok";
	  }
	  @PostMapping("/update_redel")
	  @ResponseBody
	  public String update_redel(HttpServletRequest req) {
		  String noteid =req.getParameter("noteNum");
		  
		  String [] noteids = noteid.split(",");
		  for(int i=0; i<noteids.length; i++) {
			  int number = Integer.parseInt(noteids[i]);
			  ndao.updateReDel(number);
			  int checkNote = ndao.selectDeleteNote(number);
			  
			  System.out.println("둘다 delete인지 체크한 숫자 : "+checkNote);
			  
			  if(checkNote==1) {
				  System.out.println("삭제할 떄 들어오는 노트 번호 "+number);
				  ndao.deleteNote(number);
			  }
		  }
		  return "ok";
	  }
	  @PostMapping("/recover_sedel")
	  @ResponseBody
	  public String recover_sedel(HttpServletRequest req) {
		  String noteid = req.getParameter("noteNum");
		  String []noteids = noteid.split(",");
		  
		  for(int i=0; i<noteids.length; i++) {
			  int number = Integer.parseInt(noteids[i]);
			  ndao.recoverSedel(number);
		  }
		  return "ok";
	  }
	  @PostMapping("/recover_redel")
	  @ResponseBody
	  public String recover_redel(HttpServletRequest req) {
		  String noteid = req.getParameter("noteNum");
		  String [] noteids = noteid.split(",");
		  
		  for(int i=0; i<noteids.length; i++) {
			  int number = Integer.parseInt(noteids[i]);
			  ndao.recoverRedel(number);
		  }
		  return "ok";
	  }

}	


