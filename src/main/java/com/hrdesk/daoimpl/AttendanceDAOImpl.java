package com.hrdesk.daoimpl;

import java.util.Date;
import java.util.List;

import com.hrdesk.dao.AttendanceDAO;
import com.hrdesk.dto.Attendance;

public class AttendanceDAOImpl implements AttendanceDAO {

	@Override
	public boolean markAttendance(Attendance attendance) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateAttendance(Attendance attendance) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteAttendance(int attendanceId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Attendance getAttendanceById(int attendanceId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Attendance> getAttendanceByEmployee(int employeeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Attendance> getAttendanceByDate(Date attendanceDate) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Attendance> getAllAttendance() {
		// TODO Auto-generated method stub
		return null;
	}

}
