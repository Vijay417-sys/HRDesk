<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hrdesk.dto.User, com.hrdesk.dto.PayrollDTO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
    List<PayrollDTO> slips = (List<PayrollDTO>) request.getAttribute("payslips");
    PayrollDTO latest = (slips != null && !slips.isEmpty()) ? slips.get(0) : null;
%>
<%@ include file="../includes/header.jsp" %>
<script>document.getElementById('page-title').textContent='My Payslip';document.getElementById('page-breadcrumb').textContent='HRDesk / Employee / Payslip';</script>

<div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
    <!-- Payslip Card -->
    <div class="lg:col-span-2">
        <div class="card p-8" id="payslip-card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
            <!-- Header -->
            <div class="flex items-center justify-between pb-6 border-b border-gray-100 mb-6">
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                    </div>
                    <div>
                        <p class="text-base font-bold text-gray-900">HRDesk</p>
                        <p class="text-xs text-gray-400">Salary Slip</p>
                    </div>
                </div>
                <div class="text-right">
                    <p class="text-sm font-semibold text-gray-700"><%= latest != null ? latest.getPayMonth() : "—" %></p>
                    <span class="badge <%= latest != null && "PAID".equals(latest.getStatus()) ? "badge-green" : "badge-yellow" %>">
                        <%= latest != null ? (latest.getStatus() != null ? latest.getStatus() : "PENDING") : "—" %>
                    </span>
                </div>
            </div>

            <!-- Employee Info -->
            <div class="flex items-center gap-4 mb-6 pb-6 border-b border-gray-100">
                <div class="w-12 h-12 bg-indigo-100 rounded-full flex items-center justify-center text-indigo-700 font-bold text-lg">
                    <%= user.getUsername().charAt(0) %>
                </div>
                <div>
                    <p class="font-semibold text-gray-900"><%= user.getUsername() %></p>
                    <p class="text-sm text-gray-400">Employee</p>
                </div>
            </div>

            <!-- Salary Breakdown -->
            <div class="space-y-3 mb-6">
                <div class="flex justify-between py-2 border-b border-gray-50">
                    <span class="text-sm text-gray-600">Basic Salary</span>
                    <span class="text-sm font-medium text-gray-900">₹<%= latest != null ? String.format("%,.0f", latest.getBaseSalary()) : "—" %></span>
                </div>
                <div class="flex justify-between py-2 border-b border-gray-50">
                    <span class="text-sm text-gray-600">HRA</span>
                    <span class="text-sm font-medium text-gray-900">₹<%= latest != null ? String.format("%,.0f", latest.getBaseSalary() * 0.2) : "—" %></span>
                </div>
                <div class="flex justify-between py-2 border-b border-gray-50">
                    <span class="text-sm text-green-600">Bonus</span>
                    <span class="text-sm font-medium text-green-600">+₹<%= latest != null ? String.format("%,.0f", latest.getBonus()) : "—" %></span>
                </div>
                <div class="flex justify-between py-2 border-b border-gray-50">
                    <span class="text-sm text-red-500">Deductions</span>
                    <span class="text-sm font-medium text-red-500">-₹<%= latest != null ? String.format("%,.0f", latest.getDeductions()) : "—" %></span>
                </div>
                <div class="flex justify-between py-3 bg-indigo-50 rounded-lg px-4 mt-2">
                    <span class="text-sm font-bold text-gray-900">Net Pay</span>
                    <span class="text-lg font-black text-indigo-600">₹<%= latest != null ? String.format("%,.0f", latest.getNetPay()) : "—" %></span>
                </div>
            </div>

            <button onclick="window.print()" class="btn-secondary w-full" style="justify-content:center;">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/></svg>
                Print / Download
            </button>
        </div>
    </div>

    <!-- Past Slips -->
    <div class="lg:col-span-1">
        <div class="card" style="box-shadow:0 1px 4px rgba(0,0,0,.06);">
            <div class="px-5 py-4 border-b border-gray-100">
                <h3 class="text-sm font-semibold text-gray-900">Past Payslips</h3>
            </div>
            <div class="divide-y divide-gray-50">
                <% if (slips != null && !slips.isEmpty()) {
                    for (PayrollDTO s : slips) { %>
                <div class="px-5 py-4 flex items-center justify-between hover:bg-gray-50 transition-colors cursor-pointer">
                    <div>
                        <p class="text-sm font-medium text-gray-900"><%= s.getPayMonth() != null ? s.getPayMonth() : "—" %></p>
                        <p class="text-xs text-gray-400">₹<%= String.format("%,.0f", s.getNetPay()) %></p>
                    </div>
                    <span class="badge <%= "PAID".equals(s.getStatus()) ? "badge-green" : "badge-yellow" %>"><%= s.getStatus() != null ? s.getStatus() : "PENDING" %></span>
                </div>
                <% } } else { %>
                <div class="px-5 py-10 text-center text-sm text-gray-400">No payslips found.</div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>