import dash
from dash import dcc, html
import plotly.express as px
import pandas as pd
import sqlalchemy

# Create the Dash app
app = dash.Dash(__name__)

# Connect to your local database (SQLite example).
# If you’re using a different DB, update the connection string accordingly.
engine = sqlalchemy.create_engine('sqlite:///healthcare.db')

# Example query: admissions in the past year by patient
query = """
SELECT p.patient_id, p.name, COUNT(a.admission_id) AS admission_count
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.admission_date >= date('now','-1 year')
GROUP BY p.patient_id, p.name
"""

# Read query results into a pandas DataFrame
df = pd.read_sql(query, engine)

# Create a bar chart using Plotly
fig = px.bar(
    df, 
    x='name', 
    y='admission_count', 
    title='Admissions in Past Year'
)

# Define the layout of the Dash app
app.layout = html.Div(children=[
    html.H1('Patient Risk Stratification Dashboard'),
    dcc.Graph(id='admissions-bar', figure=fig)
])

# Run the app
if __name__ == '__main__':
    app.run_server(debug=True)
