package com.of.employee;

import java.util.List;
import java.util.Map;

public interface EmployeeService {	
	public List<Employee> listEmployee(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public Employee loginEmployee(String empNo);
	
	public void insertEmployee(Employee dto) throws Exception;
	
	public void updateEmployee(Employee dto) throws Exception;
	public void updateLastLogin(String empNo) throws Exception;
	
	public Employee readEmployee(int employeeNum);
	public Employee readEmployee(String empNo);
}
