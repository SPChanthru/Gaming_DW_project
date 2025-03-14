# 🎮 Gaming Data Warehouse Project

## 📚 Project Overview

This project implements a **Gaming Data Warehouse** to analyze player engagement, game sessions, and in-game purchases. The ETL pipeline automates data extraction, transformation, and loading into **Google BigQuery** using **Windows Task Scheduler**.

## 📑 Table of Contents

1. [📁 Project Structure]
2. [⚙️ Setup Instructions]
3. [⏰ ETL Automation with Task Scheduler]
4. [🚀 Running the ETL Pipeline]
5. [📊 Data Model]
6. [📸 Screenshots](#screenshots)

---

## 1. 📁 Project Structure
Gaming_DW_Project/ │-- raw-data/ │ ├── players.csv │ ├── sessions.csv │ ├── purchases.csv │-- scripts/ │ ├── etl.py │ ├── run_etl.bat │-- documentation/ │ ├── project_report.pdf │ ├── data_dictionary.md │-- ER_diagram/ │-- README.md


## 2. ⚙️ Setup Instructions

### Prerequisites

- **Google Cloud SDK** installed and authenticated.
- **BigQuery enabled** in Google Cloud.
- **Python 3.x** installed.
- **Required Python libraries** (install via pip):
  ```sh
  pip install pandas google-cloud-bigquery
  
Setting Up Google Cloud Authentication
Download the JSON key for your Google Cloud service account.
Set the environment variable:
set GOOGLE_APPLICATION_CREDENTIALS=C:\path\to\your\key.json

3. ⏰ ETL Automation with Task Scheduler
To automate the ETL pipeline, schedule it using Windows Task Scheduler.

Schedule the Task
Open Task Scheduler (taskschd.msc).
Click Create Basic Task.
Name it Gaming_ETL_Job.
Set the trigger (Daily or Hourly).
Select Start a Program as the action.
Browse and select run_etl.bat.
Finish and enable the task.

4. 🚀 Running the ETL Pipeline
Manual Execution
Run the ETL script manually:
python etl.py

ETL Pipeline Steps
Extract: Load raw data from CSV files.
Transform:
Clean data, handle missing values.
Aggregate purchases per player.
Convert date columns.
Assign surrogate keys.
Load: Insert transformed data into BigQuery tables.
