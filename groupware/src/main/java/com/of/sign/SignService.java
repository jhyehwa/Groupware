package com.of.sign;

import java.util.List;
import java.util.Map;

public interface SignService {
	public void insertSign(Sign dto) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Sign> listSign(Map<String, Object> map, String keyword);
	public Sign readSign(int sNum);
	public List<Sign> empList();
	
	public void updateSign(Sign dto) throws Exception;
	public void deleteBoard(int sNum, String empNoId) throws Exception;
}