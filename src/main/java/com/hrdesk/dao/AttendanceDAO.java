package com.hrdesk.dao;

import java.util.Date;
import java.util.List;

import com.hrdesk.dto.AttendanceDTO;

public interface AttendanceDAO {
	boolean markAttendance(AttendanceDTO attendance);

    boolean updateAttendance(AttendanceDTO attendance);

    boolean deleteAttendance(int attendanceId);

    AttendanceDTO getAttendanceById(int attendanceId);

    List<AttendanceDTO> getAttendanceByEmployee(int employeeId);

    List<AttendanceDTO> getAttendanceByDate(Date attendanceDate);

<<<<<<< HEAD
    List<AttendanceDTO> getAllAttendance();
=======
    List<Attendance> getAllAttendance();
    
>>>>>>> 6bf9c4f2ad53ee8c0277f502c94b9039b86a32ca
}
