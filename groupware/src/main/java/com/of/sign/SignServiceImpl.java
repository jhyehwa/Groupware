package com.of.sign;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.of.common.FileManager;
import com.of.common.dao.CommonDAO;

@Service("sign.signService")
public class SignServiceImpl implements SignService {

	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager fileManager;

	@Override
	public void insertSign(Sign dto, String pathname) throws Exception {
		try {
			dao.insertData("insertSign", dto);
			dao.insertData("insertSignPermission", dto);
//			dao.insertData("insertSign", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename==null) continue;
					
					String originalFilename = mf.getOriginalFilename();
					
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					
					//insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertFile(Sign dto) throws Exception {
		// TODO Auto-generated method stub
		
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
	public Sign readSign(Map<String, Object> map) {
		Sign dto = null;
		try {
			dto = dao.selectOne("sign.readSign", map);
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

	@Override
	public void insertReturnSign(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("sign.insertReturnSign", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateScurrStepReturn(int sNum) throws Exception {
		try {
			dao.updateData("sign.updateScurrStepReturn", sNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Sign> returnSignList(Map<String, Object> map) {
		List<Sign> list = null;
		try {
			list = dao.selectList("sign.returnSignList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int returnDataCount(int empNo) {
		int result = 0;
		try {
			result = dao.selectOne("sign.returnDataCount", empNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Sign readReturnSign(Map<String, Object> map) {
		Sign dto = null;
		try {
			dto = dao.selectOne("sign.readReturnSign", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void insertStorage(Sign dto) throws Exception {
			try {
				dao.insertData("sign.insertStorage", dto);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}

}
