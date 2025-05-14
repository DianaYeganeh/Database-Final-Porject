-- PostgreSQL Database Schema for Insurance Management System

CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    national_id VARCHAR(20) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    registration_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE insurance_type (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    base_premium DECIMAL(10, 2) NOT NULL,
    coverage_details TEXT,
    terms_conditions TEXT
);

CREATE TABLE agent (
    agent_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    employee_id VARCHAR(20) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    position VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    commission_rate DECIMAL(5, 2) DEFAULT 0.00
);

CREATE TABLE policy (
    policy_id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL,
    type_id INTEGER NOT NULL,
    agent_id INTEGER NOT NULL,
    policy_number VARCHAR(20) UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    premium_amount DECIMAL(12, 2) NOT NULL,
    coverage_amount DECIMAL(15, 2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('active', 'expired', 'cancelled', 'pending')),
    risk_factor DECIMAL(5, 2),
    notes TEXT,
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE RESTRICT,
    FOREIGN KEY (type_id) REFERENCES insurance_type(type_id) ON DELETE RESTRICT,
    FOREIGN KEY (agent_id) REFERENCES agent(agent_id) ON DELETE RESTRICT,
    CHECK (end_date > start_date)
);

CREATE TABLE claim (
    claim_id SERIAL PRIMARY KEY,
    policy_id INTEGER NOT NULL,
    date_filed DATE NOT NULL DEFAULT CURRENT_DATE,
    incident_date DATE NOT NULL,
    claim_amount DECIMAL(15, 2) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('filed', 'under_review', 'approved', 'rejected', 'paid')),
    resolution_date DATE,
    documents_reference TEXT,
    FOREIGN KEY (policy_id) REFERENCES policy(policy_id) ON DELETE RESTRICT,
    CHECK (date_filed >= incident_date)
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    policy_id INTEGER NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    payment_date DATE,
    due_date DATE NOT NULL,
    payment_method VARCHAR(50),
    transaction_id VARCHAR(100) UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    FOREIGN KEY (policy_id) REFERENCES policy(policy_id) ON DELETE RESTRICT
);

CREATE INDEX idx_client_name ON client(last_name, first_name);
CREATE INDEX idx_policy_dates ON policy(start_date, end_date);
CREATE INDEX idx_policy_status ON policy(status);
CREATE INDEX idx_claim_status ON claim(status);
CREATE INDEX idx_payment_status ON payment(status);
