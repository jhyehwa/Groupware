package com.of.privateaddr;

import java.util.List;
import java.util.Map;

public interface PrivateAddrService {
	public List<PrivateAddr> listPrivateAddr(Map<String, Object> map);
	public List<PrivateAddr> listAllPrivateAddr();

	public int dataCount(Map<String, Object> map);

	public void insertPrivateAddrSpeed (PrivateAddr dto) throws Exception;
	public void insertPrivateAddr(PrivateAddr dto) throws Exception;
	
	public void modalInsert(PrivateAddr dto) throws Exception;

	public void updatePrivateAddr(PrivateAddr dto) throws Exception;

	public PrivateAddr readAddress(int addrNum);
	
	public List<PrivateAddr> modalList();
}