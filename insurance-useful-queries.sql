-- Useful queries

SELECT p.policy_id, p.policy_number, i.type_name, p.start_date, p.end_date, p.premium_amount, p.coverage_amount
FROM policy p
JOIN insurance_type i ON p.type_id = i.type_id
WHERE p.client_id = 1 AND p.status = 'active';

SELECT p.policy_id, p.policy_number, c.first_name, c.last_name, c.phone_number, 
       i.type_name, p.end_date, p.premium_amount
FROM policy p
JOIN client c ON p.client_id = c.client_id
JOIN insurance_type i ON p.type_id = i.type_id
WHERE p.end_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '30 days')
AND p.status = 'active'
ORDER BY p.end_date;

SELECT i.type_name, COUNT(cl.claim_id) AS total_claims, 
       SUM(cl.claim_amount) AS total_claim_amount,
       AVG(cl.claim_amount) AS average_claim_amount
FROM claim cl
JOIN policy p ON cl.policy_id = p.policy_id
JOIN insurance_type i ON p.type_id = i.type_id
GROUP BY i.type_name
ORDER BY total_claim_amount DESC;

SELECT p.payment_id, c.first_name, c.last_name, po.policy_number, 
       i.type_name, p.amount, p.due_date
FROM payment p
JOIN policy po ON p.policy_id = po.policy_id
JOIN client c ON po.client_id = c.client_id
JOIN insurance_type i ON po.type_id = i.type_id
WHERE p.status = 'pending'
ORDER BY p.due_date;

SELECT a.agent_id, a.first_name, a.last_name, 
       COUNT(p.policy_id) AS total_policies,
       SUM(p.premium_amount) AS total_premium,
       ROUND(SUM(p.premium_amount) * a.commission_rate / 100, 2) AS total_commission
FROM agent a
LEFT JOIN policy p ON a.agent_id = p.agent_id AND p.status = 'active'
GROUP BY a.agent_id, a.first_name, a.last_name
ORDER BY total_premium DESC;

SELECT p.policy_id, p.policy_number, c.first_name, c.last_name, 
       i.type_name, p.premium_amount, claims_total.total_claim_amount,
       ROUND((claims_total.total_claim_amount / p.coverage_amount) * 100, 2) AS claim_ratio
FROM policy p
JOIN client c ON p.client_id = c.client_id
JOIN insurance_type i ON p.type_id = i.type_id
JOIN (
    SELECT policy_id, SUM(claim_amount) AS total_claim_amount
    FROM claim
    WHERE status IN ('approved', 'paid')
    GROUP BY policy_id
) claims_total ON p.policy_id = claims_total.policy_id
WHERE (claims_total.total_claim_amount / p.coverage_amount) > 0.5
ORDER BY claim_ratio DESC;

SELECT c.city, COUNT(p.policy_id) AS total_policies,
       COUNT(cl.claim_id) AS total_claims,
       ROUND(COUNT(cl.claim_id)::numeric / COUNT(p.policy_id)::numeric, 4) AS claim_frequency,
       AVG(p.risk_factor) AS average_risk_factor
FROM client c
JOIN policy p ON c.client_id = p.client_id
LEFT JOIN claim cl ON p.policy_id = cl.policy_id
GROUP BY c.city
ORDER BY claim_frequency DESC;

SELECT p.policy_id, p.policy_number, p.status,
       c.first_name || ' ' || c.last_name AS client_name,
       c.phone_number AS client_phone,
       i.type_name AS insurance_type,
       a.first_name || ' ' || a.last_name AS agent_name,
       p.start_date, p.end_date,
       p.premium_amount, p.coverage_amount,
       (SELECT COUNT(*) FROM claim WHERE policy_id = p.policy_id) AS claims_count,
       (SELECT COALESCE(SUM(amount), 0) FROM payment WHERE policy_id = p.policy_id AND status = 'completed') AS total_paid
FROM policy p
JOIN client c ON p.client_id = c.client_id
JOIN insurance_type i ON p.type_id = i.type_id
JOIN agent a ON p.agent_id = a.agent_id
WHERE p.policy_id = 1; 

SELECT p.payment_id, c.first_name, c.last_name, po.policy_number,
       p.amount, p.due_date,
       CURRENT_DATE - p.due_date AS days_overdue
FROM payment p
JOIN policy po ON p.policy_id = po.policy_id
JOIN client c ON po.client_id = c.client_id
WHERE p.status = 'pending' AND p.due_date < CURRENT_DATE
ORDER BY days_overdue DESC;

SELECT p.policy_id, p.policy_number, c.first_name, c.last_name,
       i.type_name, p.start_date, p.premium_amount
FROM policy p
JOIN client c ON p.client_id = c.client_id
JOIN insurance_type i ON p.type_id = i.type_id
LEFT JOIN claim cl ON p.policy_id = cl.policy_id
WHERE cl.claim_id IS NULL AND p.status = 'active';
