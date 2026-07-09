<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User, com.hrdesk.dto.AttendanceDTO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
    }
    List<AttendanceDTO> records = (List<AttendanceDTO>) request.getAttribute("attendanceList");
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='Attendance Report';document.getElementById('page-breadcrumb').textContent='HRDesk / Admin / Attendance';</script>

<!-- Filters -->
<div class="card p-4 mb-6 flex flex-wrap gap-3 items-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
    <div>
        <label class="input-label" for="filter-date" style="margin-bottom:.25rem;">Date</label>
        <input type="date" id="filter-date" class="input-field" style="width:160px;" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
    </div>
    <div>
        <label class="input-label" for="filter-dept" style="margin-bottom:.25rem;">Department</label>
        <select id="filter-dept" class="input-field" style="width:160px;">
            <option value="">All Departments</option>
            <option>Engineering</option>
            <option>HR</option>
            <option>Finance</option>
        </select>
    </div>
    <div>
        <label class="input-label" for="filter-status" style="margin-bottom:.25rem;">Status</label>
        <select id="filter-status" class="input-field" style="width:140px;">
            <option value="">All Status</option>
            <option>Present</option>
            <option>Absent</option>
            <option>Late</option>
            <option>Half-Day</option>
        </select>
    </div>
    <div class="flex items-end gap-2 mt-4">
        <button class="btn-primary" onclick="loadAttendance()">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L13 13.414V19a1 1 0 01-.553.894l-4 2A1 1 0 017 21v-7.586L3.293 6.707A1 1 0 013 6V4z"/></svg>
            Filter
        </button>
        <button class="btn-secondary" onclick="exportCSV()">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/></svg>
            Export
        </button>
    </div>
</div>

<!-- Summary badges -->
<div class="grid grid-cols-4 gap-4 mb-6">
    <div class="card p-4 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-xl font-bold text-green-600">—</p>
        <p class="text-xs text-gray-400 mt-1">Present</p>
    </div>
    <div class="card p-4 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-xl font-bold text-red-500">—</p>
        <p class="text-xs text-gray-400 mt-1">Absent</p>
    </div>
    <div class="card p-4 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-xl font-bold text-amber-500">—</p>
        <p class="text-xs text-gray-400 mt-1">Late</p>
    </div>
    <div class="card p-4 text-center" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <p class="text-xl font-bold text-indigo-600">—</p>
        <p class="text-xs text-gray-400 mt-1">Half-Day</p>
    </div>
</div>

<!-- Table -->
<div class="card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
    <div class="overflow-x-auto">
        <table class="data-table" id="att-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Employee</th>
                    <th>Date</th>
                    <th>Check In</th>
                    <th>Check Out</th>
                    <th>Hours</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% if (records != null && !records.isEmpty()) {
                    int sn = 1;
                    for (AttendanceDTO r : records) { %>
                <tr>
                    <td class="text-gray-400 text-xs"><%= sn++ %></td>
                    <td class="font-medium text-gray-900">Emp #<%= r.getEmployeeId() %></td>
                    <td class="text-gray-500"><%= r.getAttendanceDate() != null ? r.getAttendanceDate() : "—" %></td>
                    <td class="text-gray-500"><%= r.getCheckInTime() != null ? r.getCheckInTime() : "—" %></td>
                    <td class="text-gray-500"><%= r.getCheckOutTime() != null ? r.getCheckOutTime() : "—" %></td>
                    <td class="text-gray-500"><%= r.getWorkingHours() > 0 ? String.format("%.1f h", r.getWorkingHours()) : "—" %></td>
                    <td>
                        <span class="badge
                            <% if ("PRESENT".equals(r.getStatus())) { %>badge-green<% }
                               else if ("ABSENT".equals(r.getStatus())) { %>badge-red<% }
                               else if ("LATE".equals(r.getStatus())) { %>badge-yellow<% }
                               else { %>badge-gray<% } %>">
                            <%= r.getStatus() != null ? r.getStatus() : "—" %>
                        </span>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="7" class="py-16 text-center">
                        <div class="flex flex-col items-center gap-2">
                            <svg class="w-10 h-10 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/></svg>
                            <p class="text-sm text-gray-400">No attendance records for this date.</p>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
function loadAttendance() {
    const date = document.getElementById('filter-date').value;
    window.location.href = '<%= request.getContextPath() %>/attendance?date=' + date;
}
function exportCSV() { alert('CSV export — connect to servlet.'); }
</script>

<%@ include file="../includes/footer.jsp" %>