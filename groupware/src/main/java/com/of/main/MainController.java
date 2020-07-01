package com.of.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.of.employee.SessionInfo;

@Controller("mainController")
public class MainController {
	@Autowired
	MainService service;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(
			HttpSession session,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("employee");
		String empNo = info.getEmpNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		
		List<Main> list=service.listTodo(map);
		
		model.addAttribute("list", list);
				
		return ".mainLayout";		
	}
	
	
	@RequestMapping(value="/main/created", method=RequestMethod.POST)
	public String createdSubmit(
			Main dto,
			HttpSession session
			) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("employee");
		
		try {			
			dto.setEmpNo(info.getEmpNo());
			service.insertTodo(dto);
		} catch (Exception e) {
		}
		return "redirect:/main";
	}
	
	@RequestMapping(value="/main/delete")
	public String delete(
			@RequestParam int todoNum
			) throws Exception{
	
		try {
			service.deleteTodo(todoNum);
		} catch (Exception e) {
		}
		
		return "redirect:/main";
	}
	
	@RequestMapping(value="/main/update")
	public String update(
			@RequestParam int todoNum
			) throws Exception {
		
		try {
			service.updateTodo(todoNum);
		} catch (Exception e) {
		}
		
		return "redirect:/main";
	}
	
}
