import pandas as pd
import sqlalchemy
import smtplib
from email.mime.text import MIMEText

# Adjust connection string for your DB (SQLite example)
engine = sqlalchemy.create_engine('sqlite:///healthcare.db')

def run_completeness_check():
    query = """
    SELECT 100.0 * (
        COUNT(*) 
        - SUM(
            CASE WHEN (diagnosis IS NULL OR diagnosis = '' 
                      OR treatment IS NULL OR treatment = '')
            THEN 1 
            ELSE 0 
            END
        )
    ) / COUNT(*) AS completeness_score
    FROM patient_records;
    """
    df = pd.read_sql(query, engine)
    return df['completeness_score'][0]

def run_missing_fields_query():
    query = """
    SELECT record_id, patient_id, diagnosis, treatment, record_date
    FROM patient_records
    WHERE diagnosis IS NULL OR diagnosis = ''
          OR treatment IS NULL OR treatment = '';
    """
    df = pd.read_sql(query, engine)
    return df

if __name__ == "__main__":
    # Run checks
    completeness = run_completeness_check()
    missing_fields_df = run_missing_fields_query()

    print(f"Data Completeness Score: {completeness:.2f}%")

    if not missing_fields_df.empty:
        print("\nRecords with missing diagnosis or treatment:")
        print(missing_fields_df.to_string(index=False))

    # (Optional) If you want to send an email alert:
    """
    if completeness < 90:  # example threshold
        msg = MIMEText(f"Data completeness is below 90%. Current score: {completeness:.2f}%")
        msg['Subject'] = 'Compliance Alert: Low Data Completeness'
        msg['From'] = 'your_email@example.com'
        msg['To'] = 'compliance_officer@example.com'

        with smtplib.SMTP('smtp.example.com') as server:
            server.login('your_username', 'your_password')
            server.send_message(msg)
    """
