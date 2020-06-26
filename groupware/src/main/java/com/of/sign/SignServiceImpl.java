package com.of.sign;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.of.common.dao.CommonDAO;

@Service("sign.signService")
public class SignServiceImpl implements SignService {

	@Autowired
	private CommonDAO dao;

	@Override
	public void insertSign(Sign dto) throws Exception {
		try {
			dao.insertData("insertSign", dto);
			dao.insertData("insertSignPermission", dto);
//			dao.insertData("insertSign", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map, String val) {
		int result=0;
		try {
			if(! val.equals("fini")) {
				map.put("val", "wait");
				result = dao.selectOne("sign.dataCount", map);
			}else {
				map.put("val", "fini");
				result = dao.selectOne("sign.dataCount", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Sign> listSign(Map<String, Object> map, String keyword) {
		List<Sign> list = null;
		try {
			map.put("val", keyword);
			list = dao.selectList("sign.listSign", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Sign> empList() {
		List<Sign> list=null;
		try {
			list = dao.selectList("sign.emplist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public Sign readSign(int valueSnum) {
		Sign dto = null;
		
		try {
			dto = dao.selectOne("sign.readSign", valueSnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Sign readEmp(int empNo) {
		Sign dto = null;
			try {
				dto = dao.selectOne("sign.readEmp", empNo);
			}catch (NullPointerException e) {
				dto = null;
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		return dto;
	}
	

	@Override
	public Sign readWriter(int empNo) {
		Sign dto = null;
		try {
			dto = dao.selectOne("sign.readWriter", empNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public List<Sign> stepList(Map<String, Object> map, String keyword){
		List<Sign> list = null;
		try {
			list = dao.selectList("sign.stepList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public void updateScurrStep(int sNum) throws Exception {
		dao.updateData("sign.updateScurrStep", sNum);
	}
	
	@Override
	public int stepCount(Map<String, Object> map) {
		int result=0;
		try {
			result =dao.selectOne("sign.stepCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Sign> finishList(Map<String, Object> map, String keyword) {
		List<Sign> list = null;
		try {
			list = dao.selectList("sign.finishSignList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Sign> seatchList(Map<String, Object> map, String keyword) {
		List<Sign> list = null;
		try {
			System.out.println(keyword);
			list = dao.selectList("sign.searchlist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
