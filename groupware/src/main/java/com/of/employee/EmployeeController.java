package com.of.employee;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("employee.employeeController")
@RequestMapping("/employee/*")
public class EmployeeController {

	@RequestMapping(value="employee", method=RequestMethod.GET)
	public String memberForm(Model model) {
		
		return ".employee.employee";
	}

	@RequestMapping(value="employee", method=RequestMethod.POST)
	public String memberSubmit() {

	
		return "redirect:/employee/employee";
	}
}
