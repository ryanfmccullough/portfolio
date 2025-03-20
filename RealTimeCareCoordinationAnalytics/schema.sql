-- Table for tracking patient events (admissions, discharges, etc.)
CREATE TABLE patient_events (
  event_id INT PRIMARY KEY,
  patient_id INT,
  event_type VARCHAR(50),       -- e.g., 'admission', 'discharge', 'transfer'
  event_timestamp TIMESTAMP,    -- date/time of the event
  details VARCHAR(255)          -- optional notes or metadata
);

-- Table for storing lab results (e.g., test_name, result_value)
CREATE TABLE lab_results (
  result_id INT PRIMARY KEY,
  patient_id INT,
  test_name VARCHAR(100),
  result_value DECIMAL(10, 2),
  result_timestamp TIMESTAMP
);
