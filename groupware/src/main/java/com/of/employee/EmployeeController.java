package com.of.employee;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.of.common.MyUtil;

@Controller("employeeController")
public class EmployeeController {

	@Autowired
	private EmployeeService service;

	@Autowired
	private MyUtil myUtil;

	// ---------------------------------------------------------------------------------------------
	// 사원 리스트
	@RequestMapping("/employee/list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, Model model) throws Exception {

		String cp = req.getContextPath();

		int rows = 10;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Employee> list = service.listEmployee(map);

		String query = "";

		String listUrl;
		String articleUrl;

		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		listUrl = cp + "/employee/list";
		articleUrl = cp + "/employee/article?page=" + current_page;
		if (query.length() != 0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".employee.list";
	}

	// ---------------------------------------------------------------------------------------------
	// 사원 등록
	@RequestMapping(value = "/employee/employee", method = RequestMethod.GET)
	public String employeeForm(Model model) {

		model.addAttribute("mode", "employee");

		return ".employee.employee";
	}

	@RequestMapping(value = "/employee/employee", method = RequestMethod.POST)
	public String employeeSubmit(Employee dto, final RedirectAttributes reAttr, Model model) {

		try {
			dto.setTel(dto.getTel().replaceAll("-", ""));

			String tel1 = dto.getTel().substring(0, 3);
			String tel2 = dto.getTel().substring(3, 7);
			String tel3 = dto.getTel().substring(7);

			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);

			service.insertEmployee(dto);

		} catch (Exception e) {
			model.addAttribute("mode", "employee");

			return ".employee.employee";
		}

		StringBuilder sb = new StringBuilder();
		sb.append(dto.getName() + "님의 사원 정보가 정상적으로 등록되었습니다.");

		reAttr.addFlashAttribute("message", sb.toString());
		reAttr.addFlashAttribute("title", "사원 등록");

		return "redirect:/employee/complete";
	}

	// ---------------------------------------------------------------------------------------------
	// 사원번호 중복 체크
	@RequestMapping(value = "/employee/empNoCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> empNoCheck(@RequestParam String empNo) throws Exception {

		String p = "true";
		Employee dto = service.readEmployee(empNo);
		if (dto != null) {
			p = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("passed", p);

		return model;
	}

	// ---------------------------------------------------------------------------------------------
	// 메시지 출력
	@RequestMapping(value = "/employee/complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {

		if (message == null || message.length() == 0) {
			return "redirect:/";
		}

		return ".employee.complete";
	}

	// ---------------------------------------------------------------------------------------------
	// 로그인
	@RequestMapping(value = "/login/login", method = RequestMethod.GET)
	public String loginForm() {
		return ".login.login";
	}

	@RequestMapping(value = "/login/login", method = RequestMethod.POST)
	public String loginSubmit(@RequestParam String empNo, @RequestParam String pwd, HttpSession session, Model model) {

		Employee dto = service.loginEmployee(empNo);

		if (dto == null || !pwd.equals(dto.getPwd())) {
			model.addAttribute("message", "사번 또는 비밀번호가 일치하지 않습니다.");
			return "/login/login";
		}

		SessionInfo info = new SessionInfo();
		info.setEmpNo(dto.getEmpNo());
		info.setName(dto.getName());
		info.setrCode(dto.getrCode());
		info.setrType(dto.getrType());
		info.setdCode(dto.getdCode());
		info.setdType(dto.getdType());
		info.setpCode(dto.getpCode());
		info.setpType(dto.getpType());

		session.setMaxInactiveInterval(30 * 60); // 세션유지시간 30분, 기본:30분

		session.setAttribute("employee", info);

		return ".main.main";
	}

	// ---------------------------------------------------------------------------------------------
	// 로그아웃
	@RequestMapping(value = "/employee/logout")
	public String logout(HttpSession session) {

		session.removeAttribute("employee");
		session.invalidate();

		return "redirect:/";
	}

	// ---------------------------------------------------------------------------------------------
	// 사원 정보 보기
	@RequestMapping(value = "/employee/article")
	public String article(@RequestParam int employeeNum, @RequestParam String page,
			@RequestParam(defaultValue = "title") String condition, @RequestParam(defaultValue = "") String keyword,
			Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "UTF-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		Employee dto = service.readEmployee(employeeNum);
		if (dto == null) {
			return "redirect:/employee/list?" + query;
		}

		model.addAttribute("employeeNum", employeeNum);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return ".employee.article";
	}

	// ---------------------------------------------------------------------------------------------
	// 사원 정보 수정
	@RequestMapping(value = "/employee/update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int employeeNum, @RequestParam String page, Model model) throws Exception {

		Employee dto = service.readEmployee(employeeNum);

		if (dto == null) {
			return "redirect:/employee/list?page=" + page;
		}

		model.addAttribute("employeeNum", employeeNum);
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);

		return ".employee.employee";
	}

	@RequestMapping(value = "/employee/update", method = RequestMethod.POST)
	public String updateSubmit(Employee dto, @RequestParam String page, Model model) {

		try {
			dto.setTel(dto.getTel().replaceAll("-", ""));

			String tel1 = dto.getTel().substring(0, 3);
			String tel2 = dto.getTel().substring(3, 7);
			String tel3 = dto.getTel().substring(7);

			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);

			service.updateEmployee(dto);

		} catch (Exception e) {
		}

		StringBuilder sb = new StringBuilder();
		sb.append(dto.getName() + "님의 회원정보가 정상적으로 변경되었습니다.<br>");

		model.addAttribute("title", "회원 정보 수정");
		model.addAttribute("message", sb.toString());

		return "redirect:/employee/list?page=" + page;
	}
}
