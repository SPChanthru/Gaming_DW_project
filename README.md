# 🎮 Gaming Data Warehouse Project - README

## 📚 Project Overview

This project implements a **Gaming Data Warehouse** to analyze player engagement, game sessions, and in-game purchases. The ETL pipeline automates data extraction, transformation, and loading into **Google BigQuery** using **Windows Task Scheduler**.

## 📑 Table of Contents

1. [📁 Project Structure](#project-structure)
2. [⚙️ Setup Instructions](#setup-instructions)
3. [⏰ ETL Automation with Task Scheduler](#etl-automation-with-task-scheduler)
4. [🚀 Running the ETL Pipeline](#running-the-etl-pipeline)
7. [📸 Screenshots](#screenshots)

---

## 1. 📁 Project Structure

Gaming_DW_Project/
│-- raw-data/
│ ├── players.csv
│ ├── sessions.csv
│ ├── purchases.csv
│-- scripts/
│ ├── etl.py
│ ├── run_etl.bat
│ ├── dim_date.sql
│ ├── dim_player.sql
│ ├── dim_game.sql
│ ├── stg_sessions.sql
│ ├── stg_purchases.sql
│ ├── stg_players.sql
│-- documentation/
│ ├── project_report.pdf
│ ├── data_dictionary.md
│-- snapshots/
│-- ER_diagram/
│-- README.md

## 2. ⚙️ Setup Instructions

### Prerequisites

- **Google Cloud SDK** installed and authenticated
- **BigQuery enabled** in Google Cloud
- **Python 3.x** installed
- **Required Python libraries** 

### Setting Up Google Cloud Authentication

1. Download the JSON key for your Google Cloud service account.
2. Set the environment variable:
   ```sh
   set GOOGLE_APPLICATION_CREDENTIALS=C:\path\to\your\key.json
   
3. ⏰ ETL Automation with Task Scheduler
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
Run the ETL script manually
python etl.py

ETL Pipeline Steps
Extract: Load raw data from CSV files.
Transform: Clean data, handle missing values, and aggregate purchases.
Load: Insert data into BigQuery tables.
