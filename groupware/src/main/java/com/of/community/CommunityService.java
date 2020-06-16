package com.of.community;

import java.util.List;
import java.util.Map;

public interface CommunityService {
	public void insertCommu(Community dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Community> listCommu(Map<String, Object> map);
	
	public void updateHitCount(int num) throws Exception;
	public Community readCommu(int num);
	public Community preReadCommu(Map<String, Object> map);
	public Community nextReadCommu(Map<String, Object> map);
	
	public void updateCommu(Community dto, String pathname) throws Exception;
	public void deleteCommu(int num, String pathname) throws Exception;
	
	public void insertFile(Community dto) throws Exception;
	public List<Community> listFile(int num);
	public Community readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
}
