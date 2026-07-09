package com.hrdesk.daoimp;

import java.util.Date;
import java.util.List;

import com.hrdesk.dao.AttendanceDAO;
import com.hrdesk.dto.AttendanceDTO;

public class AttendanceDAOImp implements AttendanceDAO {

	@Override
	public boolean markAttendance(AttendanceDTO attendance) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateAttendance(AttendanceDTO attendance) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteAttendance(int attendanceId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public AttendanceDTO getAttendanceById(int attendanceId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AttendanceDTO> getAttendanceByEmployee(int employeeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AttendanceDTO> getAttendanceByDate(Date attendanceDate) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AttendanceDTO> getAllAttendance() {
		// TODO Auto-generated method stub
		return null;
	}

}
