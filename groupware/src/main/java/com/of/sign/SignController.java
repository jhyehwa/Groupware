package com.of.sign;

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

import com.of.common.MyUtil;

@Controller("sign.signController")
@RequestMapping("/sign/*")
public class SignController {

	@Autowired
	private SignService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "mainList")
	public String list(
			HttpServletRequest req,
			Model model) throws Exception {

		int rows = 3;
		int offset = 0;

		/*
		 * if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우 keyword =
		 * URLDecoder.decode(keyword, "utf-8"); }
		 */

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("offset", offset);
		map.put("rows", rows);

		List<Sign> list = service.listSign(map, "wait");

		model.addAttribute("list", list);

		return ".sign.mainList";
	}

	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String craeteForm(HttpSession session, Model model) throws Exception {
		model.addAttribute("mode", "created");
		return ".sign.created";
	}

	@RequestMapping(value = "created", method = RequestMethod.POST)
	public String craeteSubmit(Sign dto, @RequestParam int option
	/* HttpSession session */
	) throws Exception {
		try {
			dto.setStnum(option);
			dto.setSdept("사원"); // 로그인 세션에서 가져와야함
			// 세션에서 가져온 값을 돌려서 내 직급을 가져와 입력

			service.insertSign(dto);
		} catch (Exception e) {
		}
		return "redirect:/sign/mainList";
	}

	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String search(@RequestParam String option, Model model) throws Exception {
		try {
			List<Sign> list = service.empList();
			model.addAttribute("list",list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "sign/" + option;
	}

	@RequestMapping(value = "empList")
	public String empList(Model model) {
		List<Sign> list = service.empList();

		model.addAttribute("list", list);

		return "sign/empList";
	}
	
	
	
	
}
