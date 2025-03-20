-- Sample patient records (some have missing or empty fields to demonstrate data quality issues)
INSERT INTO patient_records VALUES (1, 101, 'Hypertension', 'Medication A', '2025-03-15');
INSERT INTO patient_records VALUES (2, 102, NULL, 'Medication B', '2025-03-16');  -- Missing diagnosis
INSERT INTO patient_records VALUES (3, 103, 'Diabetes', '', '2025-03-17');        -- Missing treatment
INSERT INTO patient_records VALUES (4, 104, 'Asthma', 'Inhaler Therapy', '2025-03-18');

-- Optional sample rows for compliance_audit_log
-- (In a real workflow, you'd insert rows here only after running an audit script)
INSERT INTO compliance_audit_log VALUES (1, 2, '2025-03-19 09:00:00', 'Missing diagnosis field', 'open');
INSERT INTO compliance_audit_log VALUES (2, 3, '2025-03-19 09:15:00', 'Empty treatment field', 'open');
