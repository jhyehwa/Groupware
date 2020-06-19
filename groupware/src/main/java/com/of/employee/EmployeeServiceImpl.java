package com.of.employee;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.of.common.dao.CommonDAO;

@Service("employee.employeeService")
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private CommonDAO dao;

	// ---------------------------------------------------------------------------------------------
	// 로그인
	@Override
	public Employee loginEmployee(String empNo) {

		Employee dto = null;

		try {
			dto = dao.selectOne("employee.loginEmployee", empNo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	// ---------------------------------------------------------------------------------------------
	// 사원 리스트
	@Override
	public List<Employee> listEmployee(Map<String, Object> map) {

		List<Employee> list = null;

		try {
			list = dao.selectList("employee.listEmployee", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// ---------------------------------------------------------------------------------------------
	// 
	@Override
	public int dataCount(Map<String, Object> map) {

		int result = 0;

		try {
			result = dao.selectOne("employee.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void insertEmployee(Employee dto) throws Exception {

		try {
			dao.insertData("employee.insertEmployee1", dto);
			dao.insertData("employee.insertEmployee2", dto);
			dao.insertData("employee.insertEmployee3", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public void updateEmployee(Employee dto) throws Exception {

		try {
			dao.updateData("employee.updateEmployee1", dto);
			dao.updateData("employee.updateEmployee2", dto);
			dao.updateData("employee.updateEmployee3", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateLastLogin(String empNo) throws Exception {

		/*
		 * try { dao.updateData("employee.updateLastLogin", empNo); } catch (Exception
		 * e) { e.printStackTrace(); }
		 */
	}

	@Override
	public Employee readEmployee(int employeeNum) {

		Employee dto = null;

		try {
			dto = dao.selectOne("employee.readEmployee", employeeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;

	}


	@Override
	public Employee readEmployee(String empNo) {

		Employee dto = null;

		try {
			dto = dao.selectOne("employee.readEmployee", empNo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

}
