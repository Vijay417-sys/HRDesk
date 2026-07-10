CREATE DATABASE hrdesk_db;
USE hrdesk_db;

-- ============================================
-- 1. DEPARTMENTS
-- ============================================
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- ============================================
-- 2. EMPLOYEES
-- ============================================
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    gender ENUM('MALE','FEMALE','OTHER'),
    dob DATE,
    hire_date DATE,
    salary DECIMAL(10,2),
    dept_id INT,
    role ENUM('ADMIN','EMPLOYEE') DEFAULT 'EMPLOYEE',
    password_hash VARCHAR(255),
    status ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- ============================================
-- 3. ATTENDANCE
-- ============================================
CREATE TABLE attendance (
    att_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    date DATE,
    status ENUM('PRESENT','ABSENT','HALF_DAY','LEAVE') DEFAULT 'PRESENT',
    check_in TIME,
    check_out TIME,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- ============================================
-- 4. LEAVE REQUESTS
-- ============================================
CREATE TABLE leave_requests (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    leave_type ENUM('SICK','CASUAL','EARNED','OTHER'),
    start_date DATE,
    end_date DATE,
    reason TEXT,
    status ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- ============================================
-- 5. PAYROLL
-- ============================================
CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    month_year VARCHAR(10),
    basic_salary DECIMAL(10,2),
    leave_deductions DECIMAL(10,2) DEFAULT 0.00,
    bonus DECIMAL(10,2) DEFAULT 0.00,
    net_salary DECIMAL(10,2),
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- ============================================
-- 6. SUPPORT TOKENS (NEW - Employee Issue Tracker)
-- ============================================
CREATE TABLE support_tokens (
    token_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    category ENUM('HARDWARE','SOFTWARE','NETWORK','ACCESSORY','OTHER'),
    priority ENUM('LOW','MEDIUM','HIGH','URGENT') DEFAULT 'MEDIUM',
    status ENUM('OPEN','IN_PROGRESS','RESOLVED','CLOSED') DEFAULT 'OPEN',
    assigned_to INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (assigned_to) REFERENCES employees(emp_id)
);