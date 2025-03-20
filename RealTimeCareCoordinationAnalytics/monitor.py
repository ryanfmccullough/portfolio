import time
import pandas as pd
import sqlalchemy

# Database connection (SQLite example). 
# If using PostgreSQL or MySQL, adjust your connection string accordingly.
engine = sqlalchemy.create_engine('sqlite:///healthcare.db')

def check_critical_troponin():
    query = """
    SELECT e.patient_id, e.event_timestamp, l.test_name, l.result_value
    FROM patient_events e
    JOIN lab_results l ON e.patient_id = l.patient_id
    WHERE l.test_name = 'Troponin' AND l.result_value > 0.4
    ORDER BY e.event_timestamp DESC;
    """
    df = pd.read_sql(query, engine)
    return df

def check_recent_admissions():
    query = """
    SELECT patient_id, event_type, event_timestamp, details
    FROM patient_events
    WHERE event_type = 'admission'
      AND event_timestamp >= datetime('now', '-1 day') 
    ORDER BY event_timestamp DESC;
    """
    df = pd.read_sql(query, engine)
    return df

if __name__ == "__main__":
    print("Starting real-time monitoring...\n")
    while True:
        # Check for critical troponin
        critical_troponin_df = check_critical_troponin()
        if not critical_troponin_df.empty:
            print("CRITICAL TROponin Detected:\n", critical_troponin_df, "\n")

        # Check for recent admissions in last 24 hours
        recent_admissions_df = check_recent_admissions()
        if not recent_admissions_df.empty:
            print("RECENT ADMISSIONS (past 24 hrs):\n", recent_admissions_df, "\n")

        # Sleep for 60 seconds before checking again
        time.sleep(60)
