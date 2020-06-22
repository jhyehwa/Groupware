package com.of.sign;

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

import com.of.common.MyUtil;
import com.of.employee.SessionInfo;

import oracle.net.aso.a;
import oracle.net.aso.p;

@Controller("sign.signController")
@RequestMapping("/sign/*")
public class SignController {

	@Autowired
	private SignService service;

	@Autowired
	private MyUtil myUtil;
	
	// main리스트 출력
	@RequestMapping(value = "mainList")
	public String list(
			HttpServletRequest req,
			Model model) throws Exception {

		int rows = 3;
		int offset = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("offset", offset);
		map.put("rows", rows);

		List<Sign> list = service.listSign(map, "wait");

		model.addAttribute("list", list);

		return ".sign.mainList";
	}
	
	// 희망 문서함 페이징처리 후 리스트 출력
	@RequestMapping(value="list")
	public String showList(
			HttpServletRequest req,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam String mode,
			Model model
			) throws Exception{
		
		
		String cp = req.getContextPath();
		
		
		int rows=10; // 10 줄씩 출력
		int total_page = 0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword= URLDecoder.decode(keyword,"utf-8");
		}
		
		// 페이지 수 출력
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		
		System.out.println(dataCount);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		
		// 페이지 변화 시 설정
		if(total_page < current_page) {
			current_page=total_page;
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Sign> list = service.listSign(map, keyword);
		
		int listNum, n = 0;
		for(Sign dto : list) {
			listNum = dataCount-(offset + n);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp+"/sign/list?mode="+mode;
		String articleUrl = cp+"/sign/article?page=" + current_page;
		
		if(keyword.length() != 0) {
			query = "condition=" + condition + 
					"&keyword=" + URLEncoder.encode(keyword,"utf-8") +
					"&mode="+ mode;
		}
		
		if(query.length() != 0) {
			listUrl = cp+"/sign/list?mode="+ mode + query;
			articleUrl = cp+"sign/article?page="+current_page+"&"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		switch (mode) {
		case "1":
			mode = "결재대기함";
			break;
		case "2":
			mode = "수신대기함";
			break;
		case "3":
			mode = "결재완료함";
			break;
		case "4":
			mode = "아직안정함";
			break;
		case "5":
			mode = "이것도안정함";
			break;
		}
		
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("mode",mode);
		
		return ".sign.list";
	}
	
	
	
	// create jsp 호출
	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String craeteForm(HttpSession session, Model model) throws Exception {
		model.addAttribute("mode", "created");
		return ".sign.created";
	}

	// insert
	@RequestMapping(value = "created", method = RequestMethod.POST)
	public String craeteSubmit(Sign dto, @RequestParam int option,
			@RequestParam String lineEmp2,
			@RequestParam String lineEmp3,
			@RequestParam String lineEmp4,
	HttpSession session
	) throws Exception {
		try {
			dto.setStnum(option);
			
			SessionInfo info = (SessionInfo)session.getAttribute("employee");
			
			dto.setEmpNo(Integer.parseInt(info.getEmpNo()));
			dto.setName(info.getName());
			dto.setSdept(info.getdType());
			int count = 1;
			
			System.out.println(dto.getStartDay());
			
			if(! lineEmp2.equals("0")) {
				count++;
			}
			dto.setpEmpNo2(lineEmp2);
			
			if(! lineEmp3.equals("0")) {
				count++;
			}
			dto.setpEmpNo3(lineEmp3);
			
			if(! lineEmp4.equals("0")) {
				count++;
			}
			dto.setpEmpNo4(lineEmp4);
			
			dto.setSendStep(count);
						
			
			service.insertSign(dto);
			
			
		} catch (Exception e) {
		}
		return "redirect:/sign/mainList";
	}
	
	// 문서 종류 호출
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String search(
			@RequestParam String option,
			@RequestParam(defaultValue="") String mode,
			@RequestParam(defaultValue="") String valueSnum,
			Model model) throws Exception {
		
		String returnAddr =  "sign/" + option;
		Sign dto = null;
		Sign writer = null;
		Sign pempNo2 = null; 
		Sign pempNo3 = null;
		Sign pempNo4 = null;
		
		try {
			if(mode.equalsIgnoreCase("article")) {
				
				writer = service.readWriter(Integer.parseInt(valueSnum));
				
				dto = service.readSign(Integer.parseInt(valueSnum));
				
				System.out.println(dto.getpEmpNo2());
				System.out.println(dto.getpEmpNo3());
				System.out.println(dto.getpEmpNo4());
				
				if(dto.getpEmpNo2() != null) {
					pempNo2 = service.readEmp(Integer.parseInt(dto.getpEmpNo2()));
					model.addAttribute("pempNo2", pempNo2);
				}
				
				if(dto.getpEmpNo3() != null) {
					pempNo3 = service.readEmp(Integer.parseInt(dto.getpEmpNo3()));
					model.addAttribute("pempNo3", pempNo3);
				}
				
				if(dto.getpEmpNo4() != null) {
					pempNo4 = service.readEmp(Integer.parseInt(dto.getpEmpNo4()));
					model.addAttribute("pempNo4", pempNo4);
				}
				
			}
			
			
			List<Sign> list = service.empList();
			model.addAttribute("list",list);
			model.addAttribute("dto",dto);
			model.addAttribute("mode", mode);
			model.addAttribute("writer", writer);

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnAddr;
	}
	
	
	
}
