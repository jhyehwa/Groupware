package com.of.privateaddr;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.of.common.dao.CommonDAO;

@Service("privateAddr.privateAddrService")
public class PrivateAddrServiceImpl implements PrivateAddrService {

	@Autowired
	private CommonDAO dao;
	
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;
	
	// ---------------------------------------------------------------------------------------------
	// 주소록 리스트
	@Override
	public List<PrivateAddr> listPrivateAddr(Map<String, Object> map) {
		
		List<PrivateAddr> list = null;
		
		try {
			list = dao.selectList("privateAddr.listPrivateAddr", map);
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
			result = dao.selectOne("privateAddr.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 빠른등록
	@Override
	public void insertPrivateAddrSpeed(PrivateAddr dto) throws Exception {
		try {
			dao.insertData("privateAddr.insertPrivateAddrSpeed", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
		
	// ---------------------------------------------------------------------------------------------
	// 주소록 등록
	@Override
	public void insertPrivateAddr(PrivateAddr dto) throws Exception {
		try {
			dao.insertData("privateAddr.insertPrivateAddr", dto);
			//dao.insertData("privateAddr.insertPrivateAddr3", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// ---------------------------------------------------------------------------------------------
	// 모달 추가
	@Override
	public void modalInsert(PrivateAddr dto) throws Exception {
		
		try {
			dao.insertData("privateAddr.modalInsert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// ---------------------------------------------------------------------------------------------
	// 모달 리스트
	@Override
	public List<PrivateAddr> modalList() {
		
		List<PrivateAddr> list = null;
		
		try {
			list = dao.selectList("privateAddr.listModal");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 수정
	@Override
	public void updatePrivateAddr(PrivateAddr dto) throws Exception {
		
		try {
			dao.updateData("privateAddr.updatePrivateAddr2", dto);
			dao.updateData("privateAddr.updatePrivateAddr1", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// ---------------------------------------------------------------------------------------------
	@Override
	public PrivateAddr readAddress(int addrNum) {
		
		PrivateAddr dto = null;

		try {
			dto = dao.selectOne("privateAddr.readAddress", addrNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	// ---------------------------------------------------------------------------------------------
	// 주소록 내보내기
	@Override
	public List<PrivateAddr> listAllPrivateAddr() {
		
		List<PrivateAddr> list = null;

		try {
			list = sqlSession.selectList("privateAddr.listAllPrivateAddr");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}
