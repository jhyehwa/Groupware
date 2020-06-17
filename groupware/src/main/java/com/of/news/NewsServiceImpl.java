package com.of.news;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.of.common.dao.CommonDAO;

@Service("news.newsService")
public class NewsServiceImpl implements NewsService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertNews(News dto) throws Exception {
		try {
			dao.insertData("news.insertNews", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("news.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<News> listNews(Map<String, Object> map) {
		List<News> list=null;
		try {
			list=dao.selectList("news.listNews", map);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return list;
	}

	@Override
	public News readNews(int newsNum) {
		News dto=null;
		try {
			dto=dao.selectOne("news.readNews", newsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public News preReadNews(Map<String, Object> map) {
		News dto=null;
		try {
			dto=dao.selectOne("news.preReadNews", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public News nextReadNews(Map<String, Object> map) {
		News dto=null;
		try {
			dto=dao.selectOne("news.nextReadNews", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateNews(News dto) throws Exception {
		try {
			dao.updateData("news.updateNews", dto);			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}

	@Override
	public void deleteNews(int newsNum) throws Exception {
		try {
			dao.deleteData("news.updateNews", newsNum);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
		
	}

}
