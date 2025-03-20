-- Query 1: Flag critical Troponin lab results (assume threshold > 0.4)
SELECT 
    e.patient_id,
    e.event_timestamp,
    l.test_name,
    l.result_value
FROM 
    patient_events e
JOIN 
    lab_results l ON e.patient_id = l.patient_id
WHERE 
    l.test_name = 'Troponin'
    AND l.result_value > 0.4
ORDER BY 
    e.event_timestamp DESC;

-- Query 2: Identify recent admissions (in the last 24 hours)
-- Adjust the time frame as needed for your use case.
SELECT 
    patient_id,
    event_type,
    event_timestamp,
    details
FROM 
    patient_events
WHERE 
    event_type = 'admission'
    AND event_timestamp >= datetime('now', '-1 day')  -- SQLite syntax; adjust for other SQL dialects
ORDER BY 
    event_timestamp DESC;

-- Query 3: Combine lab results with event details to see if abnormal results occurred around admissions
SELECT 
    p.event_id,
    p.patient_id,
    p.event_type,
    p.event_timestamp,
    l.test_name,
    l.result_value
FROM 
    patient_events p
JOIN 
    lab_results l ON p.patient_id = l.patient_id
WHERE 
    p.event_timestamp BETWEEN datetime('now', '-2 days') AND datetime('now')
    OR l.result_timestamp BETWEEN datetime('now', '-2 days') AND datetime('now')
ORDER BY 
    p.event_timestamp DESC;
