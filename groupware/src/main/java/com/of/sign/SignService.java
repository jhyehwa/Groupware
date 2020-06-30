package com.of.sign;

import java.util.List;
import java.util.Map;

public interface SignService {
	public void insertSign(Sign dto, String pathname) throws Exception;
	public void insertFile(Sign dto) throws Exception;
	public int dataCount(Map<String, Object> map, String val);
	public int stepCount(Map<String, Object> map);
	
	public List<Sign> listSign(Map<String, Object> map, String keyword);
	public List<Sign> stepList(Map<String, Object> map, String keyword);
	public List<Sign> finishList(Map<String, Object> map, String keyword);
	public List<Sign> seatchList(Map<String, Object> map, String keyword);
	
	public Sign readSign(Map<String, Object> map);
	public Sign readEmp(int empNo);
	public Sign readWriter(int empNo);
	public List<Sign> empList();
	
	public void updateScurrStep(int sNum) throws Exception;
	public void insertReturnSign(Map<String, Object> map) throws Exception;
	public void updateScurrStepReturn(int sNum) throws Exception;
	
	public List<Sign> returnSignList(Map<String, Object> map);
	public int returnDataCount(int empNo);
	
	
	public Sign readReturnSign(Map<String, Object> map);
	
	public void insertStorage(Sign dto) throws Exception;
}
