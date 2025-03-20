-- Sample patient events
INSERT INTO patient_events VALUES (1, 1, 'admission', '2025-03-20 08:30:00', 'ER admission');
INSERT INTO patient_events VALUES (2, 2, 'discharge', '2025-03-20 09:45:00', 'Routine discharge');
INSERT INTO patient_events VALUES (3, 3, 'transfer', '2025-03-20 10:15:00', 'Transferred to ICU');
INSERT INTO patient_events VALUES (4, 1, 'discharge', '2025-03-21 11:00:00', 'Patient discharged to rehab');

-- Sample lab results
INSERT INTO lab_results VALUES (1, 1, 'Troponin', 0.75, '2025-03-20 08:45:00');
INSERT INTO lab_results VALUES (2, 2, 'Troponin', 0.10, '2025-03-20 09:00:00');
INSERT INTO lab_results VALUES (3, 3, 'Creatinine', 1.90, '2025-03-20 10:30:00');
INSERT INTO lab_results VALUES (4, 1, 'Hemoglobin', 8.5, '2025-03-21 09:15:00');
