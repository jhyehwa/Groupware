package com.of.buddy;

import java.util.List;
import java.util.Map;

public interface BuddyService {
	public void sendBuddy(Buddy dto, String pathname) throws Exception;
	
	public int buddyCount(Map<String, Object> map);
	public int rbuddyCount(Map<String, Object> map);	// 받은 편지함 개수 
	public int sbuddyCount(Map<String, Object> map); 	// 보낸 편지함 개수 
	public int keepCount(Map<String, Object> map); 		// 보관함 개수
	
	public List<Buddy> listRbuddy(Map<String, Object> map);	// 받은 쪽지함
	public List<Buddy> listSbuddy(Map<String, Object> map);		// 보낸 쪽지함
	public List<Buddy> listKeep(Map<String, Object> map);		// 보관함 
	public List<Buddy> listAddr(Map<String, Object> map);		// 받는 사람 리스트 

	public Buddy readBuddy(int buddynum);
	public Buddy readSendBuddy(Map<String, Object> map);
	public Buddy preReadBuddy(Map<String, Object> map);
	public Buddy nextReadBuddy(Map<String, Object> map);
	
	public void updateCheck(int buddyNum) throws Exception;	// 읽음 상태 
	public void updateState(int buddyNum) throws Exception;	// 중요도 (보관)
	public void updateState2(int buddyNum) throws Exception;	// 중요도2 (해제)
	
	public void deleteBuddy(int buddyNum, String pathname) throws Exception;
	public int deleteListBuddy(List<String> buddyNums) throws Exception;
	
	public void insertFile(Buddy dto) throws Exception;
	public List<Buddy> listFile(int num);
	public Buddy readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
}
