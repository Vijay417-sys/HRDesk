<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User, com.hrdesk.dto.AttendanceDTO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
    List<AttendanceDTO> records = (List<AttendanceDTO>) request.getAttribute("myAttendance");
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='My Attendance';document.getElementById('page-breadcrumb').textContent='HRDesk / Employee / Attendance';</script>

<!-- Summary Stats -->
<div class="grid grid-cols-4 gap-5 mb-7">
    <div class="card p-5 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-2xl font-bold text-green-600"><%= request.getAttribute("presentCount") != null ? request.getAttribute("presentCount") : "—" %></p>
        <p class="text-xs text-gray-400 mt-1">Present</p>
    </div>
    <div class="card p-5 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-2xl font-bold text-red-500"><%= request.getAttribute("absentCount") != null ? request.getAttribute("absentCount") : "—" %></p>
        <p class="text-xs text-gray-400 mt-1">Absent</p>
    </div>
    <div class="card p-5 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-2xl font-bold text-amber-500"><%= request.getAttribute("lateCount") != null ? request.getAttribute("lateCount") : "—" %></p>
        <p class="text-xs text-gray-400 mt-1">Late</p>
    </div>
    <div class="card p-5 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-2xl font-bold text-indigo-600"><%= request.getAttribute("attendancePct") != null ? request.getAttribute("attendancePct") + "%" : "—" %></p>
        <p class="text-xs text-gray-400 mt-1">This Month</p>
    </div>
</div>

<!-- Filter -->
<div class="flex gap-3 mb-5">
    <input type="month" id="month-filter" class="input-field" style="width:160px;" value="<%= new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date()) %>">
    <button class="btn-primary" onclick="window.location.href='<%= request.getContextPath() %>/attendance?month='+document.getElementById('month-filter').value">Filter</button>
</div>

<!-- Table -->
<div class="card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
    <div class="overflow-x-auto">
        <table class="data-table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Day</th>
                    <th>Check In</th>
                    <th>Check Out</th>
                    <th>Working Hours</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% if (records != null && !records.isEmpty()) {
                    for (AttendanceDTO r : records) { %>
                <tr>
                    <td class="font-medium text-gray-900"><%= r.getAttendanceDate() != null ? r.getAttendanceDate() : "—" %></td>
                    <td class="text-gray-500">
                        <% if (r.getAttendanceDate() != null) {
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            cal.setTime(r.getAttendanceDate());
                            String[] days = {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
                            out.print(days[cal.get(java.util.Calendar.DAY_OF_WEEK)-1]);
                        } else { out.print("—"); } %>
                    </td>
                    <td class="text-gray-500"><%= r.getCheckInTime() != null ? r.getCheckInTime() : "—" %></td>
                    <td class="text-gray-500"><%= r.getCheckOutTime() != null ? r.getCheckOutTime() : "—" %></td>
                    <td class="text-gray-500"><%= r.getWorkingHours() > 0 ? String.format("%.1f h", r.getWorkingHours()) : "—" %></td>
                    <td>
                        <span class="badge
                            <% if ("PRESENT".equals(r.getStatus())) { %>badge-green<% }
                               else if ("ABSENT".equals(r.getStatus())) { %>badge-red<% }
                               else if ("LATE".equals(r.getStatus())) { %>badge-yellow<% }
                               else if ("HALF_DAY".equals(r.getStatus())) { %>badge-blue<% }
                               else { %>badge-gray<% } %>">
                            <%= r.getStatus() != null ? r.getStatus() : "—" %>
                        </span>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="6" class="py-16 text-center">
                        <div class="flex flex-col items-center gap-2">
                            <svg class="w-10 h-10 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/></svg>
                            <p class="text-sm text-gray-400">No attendance records found for this period.</p>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>