<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User, com.hrdesk.dto.DeptDTO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
    }
    List<DeptDTO> depts = (List<DeptDTO>) request.getAttribute("departments");
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='Departments';document.getElementById('page-breadcrumb').textContent='HRDesk / Admin / Departments';</script>

<div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
    <!-- Add Department Form -->
    <div class="lg:col-span-1">
        <div class="card p-6" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
            <h3 class="text-sm font-semibold text-gray-900 mb-4">Add Department</h3>
            <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-50 border border-red-200 text-red-700 px-3 py-2.5 rounded-lg mb-4 text-xs"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
            <div class="bg-green-50 border border-green-200 text-green-700 px-3 py-2.5 rounded-lg mb-4 text-xs"><%= request.getAttribute("success") %></div>
            <% } %>
            <form action="<%= request.getContextPath() %>/department" method="post" class="space-y-4">
                <input type="hidden" name="action" value="add">
                <div>
                    <label class="input-label" for="deptName">Department Name *</label>
                    <input type="text" id="deptName" name="deptName" class="input-field" placeholder="e.g. Engineering" required>
                </div>
                <div>
                    <label class="input-label" for="deptCode">Department Code</label>
                    <input type="text" id="deptCode" name="deptCode" class="input-field" placeholder="e.g. ENG">
                </div>
                <div>
                    <label class="input-label" for="managerId">Manager ID</label>
                    <input type="number" id="managerId" name="managerId" class="input-field" placeholder="Employee ID">
                </div>
                <div>
                    <label class="input-label" for="location">Location</label>
                    <input type="text" id="location" name="location" class="input-field" placeholder="e.g. Bangalore">
                </div>
                <button type="submit" class="btn-primary w-full" style="justify-content:center;">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 4v16m8-8H4"/></svg>
                    Add Department
                </button>
            </form>
        </div>
    </div>

    <!-- Departments List -->
    <div class="lg:col-span-2">
        <div class="card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
            <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                <h3 class="text-sm font-semibold text-gray-900">All Departments</h3>
                <span class="badge badge-blue"><%= depts != null ? depts.size() : 0 %> total</span>
            </div>
            <div class="overflow-x-auto">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Department</th>
                            <th>Code</th>
                            <th>Manager</th>
                            <th>Employees</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (depts != null && !depts.isEmpty()) {
                            int sn = 1;
                            for (DeptDTO dept : depts) { %>
                        <tr>
                            <td class="text-gray-400 text-xs"><%= sn++ %></td>
                            <td>
                                <div class="flex items-center gap-2.5">
                                    <div class="w-7 h-7 bg-indigo-100 rounded-lg flex items-center justify-center text-indigo-700 text-xs font-bold">
                                        <%= dept.getDeptName() != null && dept.getDeptName().length() > 0 ? dept.getDeptName().charAt(0) : "?" %>
                                    </div>
                                    <span class="text-sm font-medium text-gray-900"><%= dept.getDeptName() != null ? dept.getDeptName() : "—" %></span>
                                </div>
                            </td>
                            <td><span class="badge badge-gray"><%= dept.getDeptCode() != null ? dept.getDeptCode() : "—" %></span></td>
                            <td class="text-gray-500 text-sm"><%= dept.getManagerId() > 0 ? "Emp #" + dept.getManagerId() : "—" %></td>
                            <td><span class="badge badge-blue"><%= dept.getHeadcount() %></span></td>
                            <td>
                                <div class="flex items-center gap-2">
                                    <button class="text-xs text-indigo-600 font-medium hover:underline">Edit</button>
                                    <span class="text-gray-200">|</span>
                                    <button onclick="if(confirm('Delete this department?')) location.href='<%= request.getContextPath() %>/department?action=delete&id=<%= dept.getDeptId() %>'" class="text-xs text-red-500 font-medium hover:underline">Delete</button>
                                </div>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="6" class="py-12 text-center text-sm text-gray-400">No departments found. Add your first department.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>