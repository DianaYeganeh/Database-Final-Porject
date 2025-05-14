-- Sample data for project

INSERT INTO client (first_name, last_name, national_id, date_of_birth, address, city, postal_code, phone_number, email)
VALUES 
('Ali', 'Ahmadi', '0012345678', '1980-05-15', 'Valiasr St. 123', 'Tehran', '12345', '09121234567', 'ali.ahmadi@email.com'),
('Maryam', 'Hosseini', '0023456789', '1992-09-23', 'Shariati St. 456', 'Tehran', '23456', '09132345678', 'maryam.hosseini@email.com'),
('Reza', 'Karimi', '0034567890', '1975-03-10', 'Taleghani St. 789', 'Isfahan', '34567', '09143456789', 'reza.karimi@email.com'),
('Zahra', 'Mohammadi', '0045678901', '1988-11-05', 'Imam St. 101', 'Shiraz', '45678', '09154567890', 'zahra.mohammadi@email.com'),
('Hassan', 'Sadeghi', '0056789012', '1965-07-20', 'Azadi St. 202', 'Mashhad', '56789', '09165678901', 'hassan.sadeghi@email.com');

INSERT INTO insurance_type (type_name, description, base_premium, coverage_details, terms_conditions)
VALUES 
('Health Insurance', 'Coverage for medical expenses and treatments', 5000000, 'Covers hospitalization, surgeries, and medical treatments', 'Waiting period of 3 months for pre-existing conditions'),
('Car Insurance', 'Coverage for vehicle damages and third-party liabilities', 3000000, 'Covers accident damages, theft, and third-party injuries', 'Valid for vehicles under 15 years old'),
('Home Insurance', 'Coverage for property damages and content loss', 2500000, 'Covers fire, theft, natural disasters, and structural damages', 'Excludes damages from war or intentional acts'),
('Life Insurance', 'Coverage providing financial security in case of death', 10000000, 'Provides financial support to beneficiaries in case of policyholder death', 'Suicide exclusion for first 2 years of policy'),
('Travel Insurance', 'Coverage for travel-related risks', 1000000, 'Covers medical emergencies, trip cancellations, and lost luggage', 'Valid only for trips less than 90 days');

INSERT INTO agent (first_name, last_name, employee_id, hire_date, phone_number, email, position, department, commission_rate)
VALUES 
('Hamid', 'Rezaei', 'EMP001', '2018-03-15', '09171234567', 'hamid.rezaei@insurance.com', 'Senior Agent', 'Sales', 5.50),
('Fatemeh', 'Akbari', 'EMP002', '2019-07-10', '09182345678', 'fatemeh.akbari@insurance.com', 'Agent', 'Sales', 4.25),
('Mohammad', 'Ghasemi', 'EMP003', '2017-01-20', '09193456789', 'mohammad.ghasemi@insurance.com', 'Senior Agent', 'Corporate', 6.00),
('Sara', 'Javadi', 'EMP004', '2020-11-05', '09204567890', 'sara.javadi@insurance.com', 'Agent', 'Personal', 4.00),
('Amir', 'Ebrahimi', 'EMP005', '2016-05-18', '09215678901', 'amir.ebrahimi@insurance.com', 'Team Lead', 'Sales', 7.50);

INSERT INTO policy (client_id, type_id, agent_id, policy_number, start_date, end_date, premium_amount, coverage_amount, status, risk_factor)
VALUES 
(1, 1, 1, 'POL-H-001', '2023-01-15', '2024-01-14', 6000000, 500000000, 'active', 1.20),
(2, 3, 2, 'POL-HO-002', '2023-02-20', '2024-02-19', 3000000, 350000000, 'active', 1.15),
(3, 2, 3, 'POL-C-003', '2023-03-10', '2024-03-09', 3500000, 200000000, 'active', 1.25),
(4, 4, 4, 'POL-L-004', '2023-04-05', '2033-04-04', 12000000, 1000000000, 'active', 1.10),
(5, 5, 5, 'POL-T-005', '2023-05-15', '2024-05-14', 1200000, 100000000, 'active', 1.05),
(1, 2, 1, 'POL-C-006', '2023-06-01', '2024-05-31', 3200000, 180000000, 'active', 1.15),
(2, 1, 2, 'POL-H-007', '2022-12-10', '2023-12-09', 5500000, 450000000, 'active', 1.25);

INSERT INTO claim (policy_id, incident_date, claim_amount, description, status)
VALUES 
(1, '2023-05-20', 15000000, 'Hospitalization due to appendicitis surgery', 'paid'),
(3, '2023-06-15', 8000000, 'Car accident with front bumper damage', 'approved'),
(5, '2023-07-10', 5000000, 'Lost luggage during international flight', 'under_review'),
(4, '2023-08-05', 0, 'Inquiry about coverage for specific medical procedure', 'rejected'),
(2, '2023-09-01', 20000000, 'Water damage from burst pipe', 'filed');

INSERT INTO payment (policy_id, amount, payment_date, due_date, payment_method, transaction_id, status)
VALUES 
(1, 6000000, '2023-01-10', '2023-01-15', 'Credit Card', 'TRX-001-2023', 'completed'),
(2, 3000000, '2023-02-18', '2023-02-20', 'Bank Transfer', 'TRX-002-2023', 'completed'),
(3, 3500000, '2023-03-09', '2023-03-10', 'Online Payment', 'TRX-003-2023', 'completed'),
(4, 12000000, '2023-04-03', '2023-04-05', 'Credit Card', 'TRX-004-2023', 'completed'),
(5, 1200000, '2023-05-14', '2023-05-15', 'Bank Transfer', 'TRX-005-2023', 'completed'),
(6, 3200000, '2023-05-30', '2023-06-01', 'Online Payment', 'TRX-006-2023', 'completed'),
(7, 5500000, '2022-12-09', '2022-12-10', 'Credit Card', 'TRX-007-2022', 'completed'),
(1, 6000000, null, '2024-01-15', null, null, 'pending');
