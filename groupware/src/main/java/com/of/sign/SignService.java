package com.of.sign;

import java.util.List;
import java.util.Map;

public interface SignService {
	public void insertSign(Sign dto) throws Exception;
	public int dataCount(Map<String, Object> map, String val);
	public int stepCount(Map<String, Object> map);
	
	public List<Sign> listSign(Map<String, Object> map, String keyword);
	public List<Sign> stepList(Map<String, Object> map, String keyword);
	public List<Sign> finishList(Map<String, Object> map, String keyword);
	public List<Sign> seatchList(Map<String, Object> map, String keyword);
	
	public Sign readSign(int valueSnum);
	public Sign readEmp(int empNo);
	public Sign readWriter(int empNo);
	public List<Sign> empList();
	
	public void updateScurrStep(int sNum) throws Exception;
}
