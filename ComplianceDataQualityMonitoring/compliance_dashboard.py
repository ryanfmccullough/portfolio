import dash
from dash import dcc, html
import plotly.express as px
import pandas as pd
import sqlalchemy

engine = sqlalchemy.create_engine('sqlite:///healthcare.db')
app = dash.Dash(__name__)

def get_completeness_data():
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

def get_missing_records():
    query = """
    SELECT record_id, patient_id, diagnosis, treatment, record_date
    FROM patient_records
    WHERE diagnosis IS NULL OR diagnosis = ''
          OR treatment IS NULL OR treatment = '';
    """
    return pd.read_sql(query, engine)

app.layout = html.Div([
    html.H1("Compliance & Data Quality Monitoring Dashboard"),
    
    # Display completeness score
    html.Div(id='completeness-score'),
    
    # Display missing records table
    dcc.Graph(id='missing-records-graph')
])

@app.callback(
    dash.dependencies.Output('completeness-score', 'children'),
    dash.dependencies.Output('missing-records-graph', 'figure'),
    [dash.dependencies.Input('completeness-score', 'id')]
)
def update_dashboard(_):
    completeness = get_completeness_data()
    missing_df = get_missing_records()

    # Format completeness score as a text string
    completeness_text = f"Data Completeness Score: {completeness:.2f}%"

    # Convert missing records to a bar chart or table. For simplicity, let's do a bar chart by record_id:
    if missing_df.empty:
        fig = px.bar(title="No Missing Records")
    else:
        fig = px.bar(missing_df, x='record_id', y='patient_id',
                     title="Records with Missing Fields",
                     labels={'patient_id': 'Patient ID', 'record_id': 'Record ID'})

    return completeness_text, fig

if __name__ == '__main__':
    app.run_server(debug=True)
