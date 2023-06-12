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

import com.human.springboot.dao.NoteDAO;
import com.human.springboot.dto.note.UserDTO;
import com.human.springboot.dto.note.carringReMgDTO;
import com.human.springboot.dto.note.carringSeMgDTO;
import com.human.springboot.dto.note.getRedelDTO;
import com.human.springboot.dto.note.getSedelDTO;
import com.human.springboot.dto.note.jh_pagination;
import com.human.springboot.dto.note.selectReceiveMgDTO;
import com.human.springboot.dto.note.selectSeMgDTO;
import com.human.springboot.dto.note.serchDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller

public class NoteController {
	
	@Autowired
	
	private NoteDAO ndao;
	
//-------------------------------- ���ο� �޽����ۼ�  ���������� ����---------------------------------------//	
	
	@GetMapping("/New")
	public String asdd() {		
		return "note/NewMg";
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
			
			jo.put("no", dto.get(i).getEmp_no());
			jo.put("name", dto.get(i).getEmp_name());
			jo.put("depart", dto.get(i).getEmp_name());
			
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
//--------------------------------�����޽�����, �����޽�����  ���������� ����-----------------------------------//
	
	@GetMapping("/receive")
	public String receiveMg() {
		return "note/ReceiveMgList";
	}
	
	@GetMapping("/send")
	public String sendMg() {
		return "note/SendMgList";
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
		int total = ndao.selectReTotal(id); //�α��ε� ������ ���� �޽����� �� ���� ������ 
		
		jh_pagination pg = new jh_pagination();
	
		pg.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		pg.setAmount(Integer.parseInt(req.getParameter("amount")));

		int pagenum = pg.getPageNum();
		int amount = pg.getAmount();
		
		int totalPage = (int)Math.ceil(total*1.0/amount); //�� ������ ���� 
		
		
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

	        ndao.delReMg(note_id);
	       
	    }
	}
	
	//--------------------------------�󼼳��� ���������� ����-------------------------------------------//
	
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
		System.out.println("��������");
		if(value==1){ 
					
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
		
		return "note/DetailMg";
		
	}
	
	@GetMapping("/New/{senderID}")
	public String senderId(@PathVariable("senderID")int senderID,Model model) {
		
		UserDTO  dto = ndao.select_User(senderID);
		
		String senderName = dto.getEmp_name(); 
		
		model.addAttribute("senderName",senderName);
		
		model.addAttribute("senderID",senderID);
		
		return "note/NewMg";
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
		return "note/tom";
	}

	@PostMapping("/getSedel")
	@ResponseBody 
	public String getSedel(HttpServletRequest req) { 
		
		int userId=Integer.parseInt(req.getParameter("userId"));
		int total = ndao.countSedel(userId);
		
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
				
				if(checkNote==1) {
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
			  
			  if(checkNote==1) {
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


