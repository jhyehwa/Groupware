package com.of.address;

import java.util.List;
import java.util.Map;

public interface AddressService {
	public List<Address> listAddress(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public void insertAddress(Address dto) throws Exception;
	
	public void updateAddress(Address dto) throws Exception;
	
	public Address readAddress(int addrNum);

}