import pandas as pd
from google.cloud import bigquery
import os

# Set Google Cloud authentication dynamically & check if the file exists
credential_path = "C:\\Users\\spcha\\Downloads\\dw-midterm-project-94ccd5c877df.json"
if not os.path.exists(credential_path):
    raise FileNotFoundError(f"Service account file not found: {credential_path}")

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path

# Initialize BigQuery Client
client = bigquery.Client()
project_id = "dw-midterm-project"  
dataset_name = "gaming_sessions"  
dataset_id = "dw-midterm-project.gaming_sessions"  # Corrected this line


# Define file paths using a dictionary for better organization
file_paths = {
    "players_file": "C:/Users/spcha/Desktop/gaming_dw_project/datasets/players.csv",
    "sessions_file": "C:/Users/spcha/Desktop/gaming_dw_project/datasets/csv.csv",
    "purchases_file": "C:/Users/spcha/Desktop/gaming_dw_project/datasets/purchases.csv"
}

# Check if CSV files exist before reading and raise an error if not found
missing_files = [file for file, path in file_paths.items() if not os.path.exists(path)]
if missing_files:
    raise FileNotFoundError(f"CSV files not found: {', '.join(missing_files)}")

# ✅ Load the CSV files into DataFrames
players_df = pd.read_csv(file_paths["players_file"])
sessions_df = pd.read_csv(file_paths["sessions_file"])
purchases_df = pd.read_csv(file_paths["purchases_file"])


# ✅ Validate that required columns exist
required_players_cols = {"player_id", "username", "level", "experience_points", "region"}
required_sessions_cols = {"session_id", "player_id", "game_id", "session_date", "duration"}
required_purchases_cols = {"player_id", "item_price", "purchase_date"}

for df, required_cols, name in [
    (players_df, required_players_cols, "players.csv"),
    (sessions_df, required_sessions_cols, "sessions.csv"),
    (purchases_df, required_purchases_cols, "purchases.csv"),
]:
    missing_cols = required_cols - set(df.columns)
    if missing_cols:
        raise ValueError(f"Missing columns in {name}: {missing_cols}")

# Transform: Convert date columns to proper format
sessions_df["session_date"] = pd.to_datetime(sessions_df["session_date"]).dt.date
purchases_df["purchase_date"] = pd.to_datetime(purchases_df["purchase_date"]).dt.date

# Aggregate total purchases per player
purchases_agg = purchases_df.groupby("player_id")["item_price"].sum().reset_index()
purchases_agg.rename(columns={"item_price": "total_spent"}, inplace=True)

# Merge sessions with aggregated purchases
fact_game_sessions = sessions_df.merge(purchases_agg, on="player_id", how="left")
fact_game_sessions = fact_game_sessions.assign(total_spent=fact_game_sessions["total_spent"].fillna(0))


# Define BigQuery schemas
players_schema = [
    bigquery.SchemaField("player_id", "INTEGER"),
    bigquery.SchemaField("username", "STRING"),
    bigquery.SchemaField("level", "INTEGER"),
    bigquery.SchemaField("experience_points", "INTEGER"),
    bigquery.SchemaField("region", "STRING"),
]

fact_game_sessions_schema = [
    bigquery.SchemaField("session_id", "INTEGER"),
    bigquery.SchemaField("player_id", "INTEGER"),
    bigquery.SchemaField("game_id", "INTEGER"),
    bigquery.SchemaField("session_date", "DATE"),
    bigquery.SchemaField("duration", "INTEGER"),
    bigquery.SchemaField("total_spent", "FLOAT"),
]

# Function to check if a table exists & create it if needed
def check_and_create_table(table_name, schema):
    table_ref = f"{dataset_id}.{table_name}"
    
    try:
        client.get_table(table_ref)  # Check if table exists
    except:
        print(f"⚠️ Table {table_name} does not exist. Creating it...")
        table = bigquery.Table(table_ref, schema=schema)
        client.create_table(table)

# Function to load data into BigQuery
def load_to_bigquery(df, table_name, schema):
    check_and_create_table(table_name, schema)  # Ensure table exists

    table_ref = f"{dataset_id}.{table_name}"
    job_config = bigquery.LoadJobConfig(
        schema=schema,
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,  # Overwrites existing table
    )
    
    job = client.load_table_from_dataframe(df, table_ref, job_config=job_config)
    job.result()  # Wait for the upload to complete
    print(f" Uploaded {table_name} successfully!")

#  Load tables into BigQuery
load_to_bigquery(players_df, "dim_players", players_schema)
load_to_bigquery(fact_game_sessions, "fact_game_sessions", fact_game_sessions_schema)

print("🚀 ETL Automation Complete!")
