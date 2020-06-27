package com.of.privateaddr;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.of.common.MyExcelView;
import com.of.common.MyUtil;
import com.of.employee.SessionInfo;

@Controller("privateAddrController")
public class PrivateAddrController {

	@Autowired
	private PrivateAddrService service;

	@Autowired
	private MyUtil myUtil;

	@Autowired
	private MyExcelView excelView;

	// ---------------------------------------------------------------------------------------------
	// 주소록 리스트
	@RequestMapping("/privateAddr/list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("employee");
		
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
		map.put("empNo", info.getEmpNo());
		
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

		List<PrivateAddr> list = service.listPrivateAddr(map);

		String query = "";

		String listUrl;
		String articleUrl;

		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		listUrl = cp + "/privateAddr/list";
		articleUrl = cp + "/privateAddr/article?page=" + current_page;
		if (query.length() != 0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}

		List<PrivateAddr> modalList = service.modalList();

		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("modalList", modalList);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".privateAddr.list";
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 등록
	@RequestMapping(value = "/privateAddr/privateAddr", method = RequestMethod.GET)
	public String privateAddrForm(Model model, HttpSession session) {

		SessionInfo info = (SessionInfo) session.getAttribute("employee");

		List<PrivateAddr> modalList = service.modalList();

		model.addAttribute("mode", "privateAddr");
		model.addAttribute("modalList", modalList);

		return ".privateAddr.privateAddr";
	}

	@RequestMapping(value = "/privateAddr/privateAddr", method = RequestMethod.POST)
	public String privateAddrSubmit(PrivateAddr dto, final RedirectAttributes reAttr, Model model, HttpSession session) {

		SessionInfo info = (SessionInfo) session.getAttribute("employee");

		try {
			dto.setTel(dto.getTel().replaceAll("-", ""));

			String tel1 = dto.getTel().substring(0, 3);
			String tel2 = dto.getTel().substring(3, 7);
			String tel3 = dto.getTel().substring(7);

			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);
			
			dto.setEmpNo(info.getEmpNo());

			service.insertPrivateAddr(dto);
		} catch (Exception e) {
			model.addAttribute("mode", "privateAddr");
			
			return ".privateAddr.privateAddr";
		}

		return "redirect:/privateAddr/list";
	}
	
	// ---------------------------------------------------------------------------------------------
	// 주소록 빠른 등록
	@RequestMapping(value = "/privateAddr/privateAddr2", method = RequestMethod.POST)
	public String privateAddrSubmit2(PrivateAddr dto, final RedirectAttributes reAttr, Model model, HttpSession session) {

		SessionInfo info = (SessionInfo) session.getAttribute("employee");

		try {
			dto.setTel(dto.getTel().replaceAll("-", ""));

			String tel1 = dto.getTel().substring(0, 3);
			String tel2 = dto.getTel().substring(3, 7);
			String tel3 = dto.getTel().substring(7);

			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);
			
			dto.setEmpNo(info.getEmpNo());

			service.insertPrivateAddrSpeed(dto);
		} catch (Exception e) {
			model.addAttribute("mode", "privateAddr");
			
			return ".privateAddr.list";
		}

		return "redirect:/privateAddr/list";
	}
	
	// ---------------------------------------------------------------------------------------------
	// 모달 그룹 추가
	@RequestMapping(value = "/privateAddr/modalInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> modalInsert(PrivateAddr dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("employee");

		String state = "false";
		
		try {

			dto.setEmpNo(info.getEmpNo());
		
			service.modalInsert(dto);
			
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);

		return model;
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 보기
	@RequestMapping(value = "/privateAddr/article")
	public String article(
			@RequestParam int addrNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "title") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "UTF-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		PrivateAddr dto = service.readAddress(addrNum);
		if (dto == null) {
			return "redirect:/privateAddr/list?" + query;
		}

		model.addAttribute("addrNum", addrNum);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return ".privateAddr.article";
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 수정
	@RequestMapping(value = "/privateAddr/update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int addrNum, @RequestParam String page, @RequestParam(defaultValue = "title") String condition, @RequestParam(defaultValue = "") String keyword, Model model, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("employee");
		
		keyword = URLDecoder.decode(keyword, "UTF-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		PrivateAddr dto = service.readAddress(addrNum);
		if (dto == null) {
			return "redirect:/privateAddr/list?" + query;
		}
		
		List<PrivateAddr> modalList = service.modalList();
		
		model.addAttribute("addrNum", addrNum);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("modalList", modalList);

		return ".privateAddr.privateAddr";
	}

	@RequestMapping(value = "/privateAddr/update", method = RequestMethod.POST)
	public String updateSubmit(@RequestParam int addrNum, PrivateAddr dto,  @RequestParam(defaultValue="1") String page, HttpSession session) {

		SessionInfo info = (SessionInfo) session.getAttribute("employee");
		
		try {
			System.out.println(dto.getName());
			dto.setTel(dto.getTel().replaceAll("-", ""));

			String tel1 = dto.getTel().substring(0, 3);
			String tel2 = dto.getTel().substring(3, 7);
			String tel3 = dto.getTel().substring(7);

			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);
			dto.setAddrNum(addrNum);
			dto.setEmpNo(info.getEmpNo());

			service.updatePrivateAddr(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/privateAddr/list?page=" + page;
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 내보내기
	@RequestMapping("/privateAddr/excel")
	public View excel(Map<String, Object> model) throws Exception {
		/*
		 * List<PrivateAddr> list = service.listAllPrivateAddr();
		 * 
		 * String sheetName = "개인 주소록"; List<String> columnLabels = new ArrayList<>();
		 * List<Object[]> columnValues = new ArrayList<>();
		 * 
		 * columnLabels.add("이름"); columnLabels.add("전화번호"); columnLabels.add("이메일");
		 * columnLabels.add("회사명"); columnLabels.add("그룹");
		 * 
		 * for (PrivateAddr dto : list) { columnValues.add(new Object[] { dto.getName(),
		 * dto.getTel(), dto.getEmail(), dto.getCompany(), dto.getGrouptype()}); }
		 * 
		 * model.put("filename", "address.xls"); model.put("sheetName", sheetName);
		 * model.put("columnLabels", columnLabels); model.put("columnValues",
		 * columnValues);
		 */

		return excelView;
	}

}
