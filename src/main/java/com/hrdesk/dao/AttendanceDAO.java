package com.hrdesk.dao;

import java.util.Date;
import java.util.List;

import com.hrdesk.dto.Attendance;

public interface AttendanceDAO {
	boolean markAttendance(Attendance attendance);

    boolean updateAttendance(Attendance attendance);

    boolean deleteAttendance(int attendanceId);

    Attendance getAttendanceById(int attendanceId);

    List<Attendance> getAttendanceByEmployee(int employeeId);

    List<Attendance> getAttendanceByDate(Date attendanceDate);

    List<Attendance> getAllAttendance();
}
