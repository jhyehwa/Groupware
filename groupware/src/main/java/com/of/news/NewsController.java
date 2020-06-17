package com.of.news;

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

@Controller("newsController")
@RequestMapping("/news/*")
public class NewsController {
	@Autowired
	private NewsService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="title") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String nCode,
			HttpServletRequest req,
			Model model			
			) throws Exception{
		int rows = 15;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("nCode", nCode);
		
		
		dataCount = service.dataCount(map);
		if(dataCount!=0) {
			total_page=myUtil.pageCount(rows, dataCount);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(current_page>total_page) {
			current_page=total_page;
		}
		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page-1)*rows;
		if(offset < 0) offset=0;
			map.put("offset", offset);
			map.put("rows", rows);			


		
		// 글 리스트
		List<News> list=service.listNews(map);
		
		// 리스트의 번호
		int listNum, n=0;
		for(News dto : list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/news/list";
		String articleUrl=cp+"/news/article?page="+current_page;
		if(keyword.length()!=0) {
			query="condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		if(nCode!=null) {
			if(query.length()!=0) {
				query+="&"+"nCode="+nCode;
			} else {
				query="nCode="+nCode;
			}
		}
		
		
		if(query.length()!=0) {
			listUrl=cp+"/news/list?"+query;
			articleUrl=cp+"/news/article?page="+current_page+"&"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("nCode",nCode);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
				
		return ".news.list";		
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(HttpSession session, Model model) throws Exception{
		model.addAttribute("mode", "created");
		return ".news.created";
	}
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String createdSubmit(
			News dto,
			HttpSession session
			) throws Exception{
		try {			
			dto.setWriter("1001199");
			service.insertNews(dto);
		} catch (Exception e) {
		}
		return "redirect:/news/list";
	}
	
	@RequestMapping(value="article")
	public String article(
			@RequestParam int newsNum,
			@RequestParam String page,
			@RequestParam(defaultValue="title") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		News dto = service.readNews(newsNum);
		if(dto==null) {
			return "redirect:/notice/list?"+query;
		}
		//dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		// 이전글, 다음글
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("newsNum", newsNum);
		
		News preReadDto=service.preReadNews(map);
		News nextReadDto=service.nextReadNews(map);
	
		model.addAttribute("dto",dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("query",query);
		
		return ".news.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int newsNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception{
		
		News dto=service.readNews(newsNum);
		if(dto==null) {
			return "redirect:/news/list?page="+page;
		}
		
		// 파일
		
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		
		return ".news.created";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			News dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception{
		try {
			
			dto.setWriter("1001199");
			service.updateNews(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/news/list?page="+page;
	}
	
	
	@RequestMapping("delete")
	public String delete(
			@RequestParam int newsNum,
			@RequestParam String page,
			@RequestParam(defaultValue="title") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception{
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
/*		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/notice/list?"+query;
		}
		*/
		try {
			service.deleteNews(newsNum);
		} catch (Exception e) {
		}
		
		return "redirect:/news/list?"+query;
	}
	
	
}
