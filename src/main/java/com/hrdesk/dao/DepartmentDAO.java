package com.hrdesk.dao;

import java.util.List;

import com.hrdesk.dto.Department;

public interface DepartmentDAO {
	boolean addDepartment(Department department);

    boolean updateDepartment(Department department);

    boolean deleteDepartment(int departmentId);

    Department getDepartmentById(int departmentId);

    List<Department> getAllDepartments();

}
