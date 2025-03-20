CREATE TABLE patients (
  patient_id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  gender VARCHAR(10)
);

CREATE TABLE admissions (
  admission_id INT PRIMARY KEY,
  patient_id INT,
  admission_date DATE,
  discharge_date DATE,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE conditions (
  condition_id INT PRIMARY KEY,
  patient_id INT,
  condition_name VARCHAR(100),
  diagnosis_date DATE,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
