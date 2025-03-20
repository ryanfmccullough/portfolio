CREATE TABLE patient_records (
  record_id INT PRIMARY KEY,
  patient_id INT,
  diagnosis VARCHAR(255),
  treatment VARCHAR(255),
  record_date DATE
);

-- Additional table (optional): compliance_audit_log to track audit outcomes
CREATE TABLE compliance_audit_log (
  audit_id INT PRIMARY KEY,
  record_id INT,
  audit_timestamp TIMESTAMP,
  issue_found VARCHAR(255),
  resolution_status VARCHAR(50)  -- e.g., 'open', 'resolved'
);
