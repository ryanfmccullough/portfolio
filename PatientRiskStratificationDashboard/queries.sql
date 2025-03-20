-- Query 1: Identify patients with more than 3 admissions in the past year
SELECT 
    p.patient_id,
    p.name,
    COUNT(a.admission_id) AS admission_count
FROM 
    patients p
JOIN 
    admissions a ON p.patient_id = a.patient_id
WHERE 
    a.admission_date >= DATE('now', '-1 year')  -- Adjust for your SQL dialect if needed
GROUP BY 
    p.patient_id, p.name
HAVING 
    COUNT(a.admission_id) > 3;


-- Query 2: Identify patients with Diabetes
SELECT 
    p.patient_id,
    p.name,
    c.condition_name,
    c.diagnosis_date
FROM 
    patients p
JOIN 
    conditions c ON p.patient_id = c.patient_id
WHERE 
    c.condition_name = 'Diabetes';


-- Query 3: Combine Chronic Conditions and Recent Admissions
-- This can help see all chronic conditions for each patient alongside admissions in the last year
SELECT 
    p.patient_id,
    p.name,
    COUNT(a.admission_id) AS recent_admissions,
    GROUP_CONCAT(c.condition_name) AS chronic_conditions  -- Works in MySQL/PostgreSQL; for others, use a different concat approach
FROM 
    patients p
LEFT JOIN 
    admissions a ON p.patient_id = a.patient_id
LEFT JOIN 
    conditions c ON p.patient_id = c.patient_id
WHERE 
    a.admission_date >= DATE('now', '-1 year')  -- Adjust for your SQL dialect if needed
GROUP BY 
    p.patient_id, p.name;
