<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='Raise Ticket';document.getElementById('page-breadcrumb').textContent='HRDesk / Employee / Support';</script>

<div class="max-w-xl">
    <div class="card p-6 mb-6" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
        <h3 class="text-sm font-semibold text-gray-900 mb-5">Submit a Support Ticket</h3>
        <% if (request.getAttribute("success") != null) { %>
        <div class="flex items-center gap-2 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-5 text-sm">
            <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
            <%= request.getAttribute("success") %>
        </div>
        <% } %>
        <form action="<%= request.getContextPath() %>/support" method="post" class="space-y-5">
            <input type="hidden" name="action" value="raise">
            <div>
                <label class="input-label" for="category">Category *</label>
                <select id="category" name="category" class="input-field" required>
                    <option value="">Select category</option>
                    <option value="PAYROLL">Payroll Issue</option>
                    <option value="ATTENDANCE">Attendance Correction</option>
                    <option value="LEAVE">Leave Issue</option>
                    <option value="IT">IT Support</option>
                    <option value="HR">HR Policy</option>
                    <option value="OTHER">Other</option>
                </select>
            </div>
            <div>
                <label class="input-label" for="subject">Subject *</label>
                <input type="text" id="subject" name="subject" class="input-field" placeholder="Brief description of your issue" required>
            </div>
            <div>
                <label class="input-label" for="priority">Priority</label>
                <select id="priority" name="priority" class="input-field">
                    <option value="LOW">Low</option>
                    <option value="MEDIUM" selected>Medium</option>
                    <option value="HIGH">High</option>
                    <option value="URGENT">Urgent</option>
                </select>
            </div>
            <div>
                <label class="input-label" for="description">Description *</label>
                <textarea id="description" name="description" rows="4" class="input-field" placeholder="Describe your issue in detail..." required style="resize:vertical;"></textarea>
            </div>
            <div class="flex gap-3">
                <button type="submit" class="btn-primary">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/></svg>
                    Submit Ticket
                </button>
                <a href="my-tickets.jsp" class="btn-secondary no-underline">View My Tickets</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>