package com.hrdesk.dao;

import java.util.List;

import com.hrdesk.dto.Employee;

public interface EmployeeDAO {
	boolean addEmployee(Employee employee);

    boolean updateEmployee(Employee employee);

    boolean deleteEmployee(int employeeId);

    Employee getEmployeeById(int employeeId);

    List<Employee> getAllEmployees();

}
