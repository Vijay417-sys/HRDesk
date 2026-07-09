<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User, com.hrdesk.dto.EmployeeDTO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
    }
    List<EmployeeDTO> employees = (List<EmployeeDTO>) request.getAttribute("employees");
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='View Employees';document.getElementById('page-breadcrumb').textContent='HRDesk / Admin / Employees';</script>

<!-- Toolbar -->
<div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-6">
    <div class="flex items-center gap-3">
        <div class="relative">
            <svg class="w-4 h-4 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
            <input type="text" id="search-input" placeholder="Search employees..." class="input-field pl-9" style="width:220px;" oninput="filterTable(this.value)">
        </div>
        <select class="input-field" style="width:140px;" onchange="filterDept(this.value)">
            <option value="">All Departments</option>
            <option value="Engineering">Engineering</option>
            <option value="HR">Human Resources</option>
            <option value="Finance">Finance</option>
            <option value="Marketing">Marketing</option>
        </select>
    </div>
    <a href="add-employee.jsp" class="btn-primary no-underline">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 4v16m8-8H4"/></svg>
        Add Employee
    </a>
</div>

<div class="card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
    <div class="overflow-x-auto">
        <table class="data-table" id="emp-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Employee</th>
                    <th>Designation</th>
                    <th>Department</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (employees != null && !employees.isEmpty()) {
                    int sn = 1;
                    for (EmployeeDTO emp : employees) {
                        String name = (emp.getFirstName() != null ? emp.getFirstName() : "") + " " + (emp.getLastName() != null ? emp.getLastName() : "");
                        name = name.trim(); if (name.isEmpty()) name = "Unknown";
                        String initial = String.valueOf(name.charAt(0)).toUpperCase();
                        boolean active = "ACTIVE".equals(emp.getStatus()) || emp.getStatus() == null;
                %>
                <tr>
                    <td class="text-gray-400 text-xs"><%= sn++ %></td>
                    <td>
                        <div class="flex items-center gap-3">
                            <div class="w-8 h-8 bg-indigo-100 rounded-full flex items-center justify-center text-indigo-700 text-xs font-bold flex-shrink-0"><%= initial %></div>
                            <div>
                                <p class="text-sm font-medium text-gray-900"><%= name %></p>
                                <p class="text-xs text-gray-400"><%= emp.getEmail() != null ? emp.getEmail() : "" %></p>
                            </div>
                        </div>
                    </td>
                    <td class="text-gray-500 text-sm"><%= emp.getDesignation() != null ? emp.getDesignation() : "—" %></td>
                    <td class="text-gray-500 text-sm"><%= emp.getDepartmentId() %></td>
                    <td class="text-gray-500 text-sm"><%= emp.getPhone() != null ? emp.getPhone() : "—" %></td>
                    <td><span class="badge <%= active ? "badge-green" : "badge-gray" %>"><%= emp.getStatus() != null ? emp.getStatus() : "Active" %></span></td>
                    <td>
                        <div class="flex items-center gap-2">
                            <button onclick="editEmployee(<%= emp.getEmployeeId() %>)" class="text-xs text-indigo-600 hover:text-indigo-800 font-medium">Edit</button>
                            <span class="text-gray-200">|</span>
                            <button onclick="deleteEmployee(<%= emp.getEmployeeId() %>)" class="text-xs text-red-500 hover:text-red-700 font-medium">Delete</button>
                        </div>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="7" class="py-16 text-center">
                        <div class="flex flex-col items-center gap-2">
                            <svg class="w-12 h-12 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                            <p class="text-sm text-gray-400 font-medium">No employees found</p>
                            <a href="add-employee.jsp" class="text-sm text-indigo-600 font-medium hover:underline">Add your first employee →</a>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
function filterTable(q) {
    const rows = document.querySelectorAll('#emp-table tbody tr');
    rows.forEach(r => {
        r.style.display = r.textContent.toLowerCase().includes(q.toLowerCase()) ? '' : 'none';
    });
}
function filterDept(dept) {
    const rows = document.querySelectorAll('#emp-table tbody tr');
    rows.forEach(r => {
        r.style.display = (!dept || r.textContent.includes(dept)) ? '' : 'none';
    });
}
function editEmployee(id) { alert('Edit employee #' + id + ' — connect to servlet.'); }
function deleteEmployee(id) {
    if (confirm('Delete employee #' + id + '? This cannot be undone.')) {
        window.location.href = '<%= request.getContextPath() %>/employee?action=delete&id=' + id;
    }
}
</script>

<%@ include file="../includes/footer.jsp" %>