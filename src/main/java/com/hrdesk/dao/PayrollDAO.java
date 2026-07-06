package com.hrdesk.dao;

import java.util.List;

import com.hrdesk.dto.Payroll;

public interface PayrollDAO {
	 boolean addPayroll(Payroll payroll);

	    boolean updatePayroll(Payroll payroll);

	    boolean deletePayroll(int payrollId);

	    Payroll getPayrollById(int payrollId);

	    List<Payroll> getPayrollByEmployee(int employeeId);

	    List<Payroll> getAllPayroll();

}
