<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
    }
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='Add Employee';document.getElementById('page-breadcrumb').textContent='HRDesk / Admin / Add Employee';</script>

<div class="max-w-2xl">
    <% if (request.getAttribute("error") != null) { %>
    <div class="flex items-center gap-2 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 text-sm">
        <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
    <div class="flex items-center gap-2 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6 text-sm">
        <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        <%= request.getAttribute("success") %>
    </div>
    <% } %>

    <div class="card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <div class="px-6 py-5 border-b border-gray-100">
            <h3 class="text-sm font-semibold text-gray-900">Employee Information</h3>
            <p class="text-xs text-gray-400 mt-0.5">Fill in the details to add a new employee to the system.</p>
        </div>
        <form action="<%= request.getContextPath() %>/employee" method="post" class="p-6 space-y-5">
            <input type="hidden" name="action" value="add">
            <div class="form-grid">
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="firstName">First Name *</label>
                    <input type="text" id="firstName" name="firstName" class="input-field" placeholder="John" required>
                </div>
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="lastName">Last Name *</label>
                    <input type="text" id="lastName" name="lastName" class="input-field" placeholder="Doe" required>
                </div>
            </div>
            <div class="form-grid">
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="email">Email Address *</label>
                    <input type="email" id="email" name="email" class="input-field" placeholder="john@company.com" required>
                </div>
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" class="input-field" placeholder="+91 98765 43210">
                </div>
            </div>
            <div class="form-grid">
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="designation">Designation *</label>
                    <input type="text" id="designation" name="designation" class="input-field" placeholder="Software Engineer" required>
                </div>
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="departmentId">Department *</label>
                    <select id="departmentId" name="departmentId" class="input-field" required>
                        <option value="">Select Department</option>
                        <option value="1">Engineering</option>
                        <option value="2">Human Resources</option>
                        <option value="3">Finance</option>
                        <option value="4">Marketing</option>
                        <option value="5">Operations</option>
                    </select>
                </div>
            </div>
            <div class="form-grid">
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="salary">Monthly Salary (₹) *</label>
                    <input type="number" id="salary" name="salary" class="input-field" placeholder="50000" min="0" step="500" required>
                </div>
                <div class="form-group" style="margin-bottom:0;">
                    <label class="input-label" for="hireDate">Hire Date *</label>
                    <input type="date" id="hireDate" name="hireDate" class="input-field" required>
                </div>
            </div>
            <div class="form-group" style="margin-bottom:0;">
                <label class="input-label" for="status">Status</label>
                <select id="status" name="status" class="input-field">
                    <option value="ACTIVE">Active</option>
                    <option value="INACTIVE">Inactive</option>
                    <option value="ON_LEAVE">On Leave</option>
                </select>
            </div>
            <div class="flex gap-3 pt-2">
                <button type="submit" class="btn-primary">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 4v16m8-8H4"/></svg>
                    Add Employee
                </button>
                <a href="view-employees.jsp" class="btn-secondary no-underline">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>