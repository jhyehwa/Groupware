package com.of.address;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.of.common.dao.CommonDAO;

@Service("address.addressService")
public class AddressServiceImpl implements AddressService {

	@Autowired
	private CommonDAO dao;
	
	// ---------------------------------------------------------------------------------------------
	// 주소록 리스트
	@Override
	public List<Address> listAddress(Map<String, Object> map) {
		
		List<Address> list = null;
		
		try {
			list = dao.selectList("address.list", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	// ---------------------------------------------------------------------------------------------
	// 데이터 개수
	@Override
	public int dataCount(Map<String, Object> map) {
		
		int result = 0;

		try {
			result = dao.selectOne("address.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 등록
	@Override
	public void insertAddress(Address dto) throws Exception {
		
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 수정
	@Override
	public void updateAddress(Address dto) throws Exception {
		
	}

	// ---------------------------------------------------------------------------------------------
	@Override
	public Address readAddress(int addrNum) {
		
		return null;
	}

}
