<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='My Tickets';document.getElementById('page-breadcrumb').textContent='HRDesk / Employee / My Tickets';</script>

<div class="flex items-center justify-between mb-6">
    <div></div>
    <a href="raise-ticket.jsp" class="btn-primary no-underline">+ New Ticket</a>
</div>

<div class="card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
    <div class="overflow-x-auto">
        <table class="data-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Subject</th>
                    <th>Category</th>
                    <th>Priority</th>
                    <th>Raised On</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="6" class="py-16 text-center">
                        <div class="flex flex-col items-center gap-2">
                            <svg class="w-10 h-10 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"/></svg>
                            <p class="text-sm text-gray-400">No tickets raised yet.</p>
                            <a href="raise-ticket.jsp" class="text-sm text-indigo-600 font-medium hover:underline">Raise your first ticket →</a>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>