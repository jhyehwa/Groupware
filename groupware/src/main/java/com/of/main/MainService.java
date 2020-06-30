package com.of.main;

import java.util.List;
import java.util.Map;

public interface MainService {
	public void insertTodo(Main dto) throws Exception;
	public List<Main> listTodo(Map<String, Object> map);
	public void deleteTodo(int todoNum) throws Exception;
}
