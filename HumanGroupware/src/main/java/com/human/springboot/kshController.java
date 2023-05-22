package com.human.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class kshController {
	
	@GetMapping("/main")
	public String doMain() {
		return "main";
	}
}
