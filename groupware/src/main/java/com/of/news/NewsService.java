package com.of.news;

import java.util.List;
import java.util.Map;

public interface NewsService{
	public void insertNews(News dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<News> listNews(Map<String, Object> map);
	
	public News readNews(int newsNum);
	public News preReadNews(Map<String, Object> map);
	public News nextReadNews(Map<String, Object> map);
	
	public void updateNews(News dto) throws Exception;
	public void deleteNews(int newsNum) throws Exception;
	
	
}
