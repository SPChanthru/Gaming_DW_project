# 🎮 Gaming Data Warehouse Project

## 📚 Project Overview

This project implements a **Gaming Data Warehouse** to analyze player engagement, game sessions, and in-game purchases. The ETL pipeline automates data extraction, transformation, and loading into **Google BigQuery** using **Windows Task Scheduler**.

## 📑 Table of Contents

1. [📁 Project Structure]
2. [⚙️ Setup Instructions]
3. [⏰ ETL Automation with Task Scheduler]
4. [🚀 Running the ETL Pipeline]

---

# Project Structure

1. **GAMING_DW_PROJECT/**
   - **datasets/**
     - `csv.csv`               - Contains session data
     - `players.csv`           - Contains player data
     - `purchases.csv`         - Contains purchase data
   - **documentation/**
     - `data_dictionary.md`     - Documentation for data fields and definitions
     - `final_document.pdf`     - Final documentation for the project
   - **ER_diagram/**
     - `dimensional_model_schema.png`  - Diagram of the dimensional model
     - `normalized_schema.png`         - Diagram of the normalized schema
   - **etl/**
     - `etl.py`                - Main ETL script
     - `run_etl.bat`           - Batch file to run the ETL process
   - **raw-data/**
     - `game_sessions.csv`      - Raw session data
     - `players.json`           - Raw player data in JSON format
     - `purchases.xml`          - Raw purchase data in XML format
   - **scripts/**
     - `dimensional_model.sql`   - SQL script for creating the dimensional model
     - `staging_tables.sql`      - SQL script for creating staging tables
   - `LICENSE`                  - License file for the project
   - `README.md`                - This README file

> **Note:** The final documentation includes all the deliverables and screenshots.

## 2. ⚙️ Setup Instructions

### Prerequisites

- **Google Cloud SDK** installed and authenticated.
- **BigQuery enabled** in Google Cloud.
- **Python 3.x** installed.
- **Required Python libraries** (install via pip):
  ```sh
  pip install pandas google-cloud-bigquery

Setting Up Google Cloud Authentication
Create a Service Account:

Go to the Google Cloud Console.
Navigate to IAM & Admin > Service Accounts.
Click Create Service Account.
Provide a name and description for the service account.
Click Create and then Continue.

Assign Roles:

Assign the BigQuery Admin role to the service account to allow it to manage BigQuery resources.
Create a Key:
Click on the service account you just created.
Go to the Keys tab.
![bq](path/to/diagram.png)

Click Add Key > Create New Key.
Select JSON and click Create. This will download a JSON key file to your computer.

Set the Environment Variable:

Set the GOOGLE_APPLICATION_CREDENTIALS environment variable to the path of the JSON key file. 

This allows your application to authenticate with Google Cloud using the service account.

   use this command
   set GOOGLE_APPLICATION_CREDENTIALS=C:\path\to\your\key.json

Configuring BigQuery

Create a Dataset:
In the Google Cloud Console, navigate to BigQuery.
Click on your project name in the left-hand panel.
Click Create Dataset.
Provide a name for your dataset and configure any additional settings as needed.

upload the raw datasets as csv files (purchases.csv, players.csv, csv.csv(sessions))

Click Create Dataset.

Create Tables:
Use the SQL scripts provided in the scripts/ directory to create the necessary tables in your BigQuery dataset.
You can execute these scripts directly in the BigQuery console or using the bq command-line tool.

## 3. ⏰ ETL Automation with Task Scheduler

To automate the ETL pipeline, you can schedule it using Windows Task Scheduler. This ensures that your data is regularly updated without manual intervention.

### Schedule the Task

1. **Open Task Scheduler**:
   - Press `Win + R`, type `taskschd.msc`, and press `Enter` to open Task Scheduler.

2. **Create a Basic Task**:
   - Click on **Create Basic Task** in the Actions pane.
   - Provide a name for the task, such as **Gaming_ETL_Job**, and click **Next**.

3. **Set the Trigger**:
   - Choose when you want the task to start (e.g., **Daily** or **Hourly**) and click **Next**.
   - Configure the specific time and frequency settings as needed, then click **Next**.

4. **Select the Action**:
   - Choose **Start a Program** and click **Next**.

5. **Specify the Program**:
   - Click **Browse** and select the `run_etl.bat` file from your project directory.
   - Click **Next** to proceed.

6. **Finish the Task Setup**:
   - Review the settings and click **Finish** to create the task.
   - Ensure the task is enabled and will run as scheduled.

## 4. 🚀 Running the ETL Pipeline

You can run the ETL pipeline manually or rely on the scheduled task for automation.

### Manual Execution

To manually execute the ETL script, follow these steps:

1. **Open a Command Prompt**:
   - Press `Win + R`, type `cmd`, and press `Enter`.

2. **Navigate to the ETL Directory**:
   - Use the `cd` command to navigate to the directory containing your ETL script.
   ```sh
   cd path\to\your\project\etl

Run the ETL Script:
Execute the ETL script using Python.

use the command :  python etl.py

Note: Regularly monitor the Task Scheduler and ETL logs to ensure that the pipeline runs smoothly and any issues are addressed promptly.

Final Steps
Ensure that your Python environment is set up correctly and that all dependencies are installed.
Verify that the Google Cloud SDK is authenticated and configured to use the correct project.
Test the ETL script manually to ensure that it runs without errors before setting up automation.

Note: Make sure to keep your JSON key file secure and do not share it publicly, as it contains sensitive information that can be used to access your Google Cloud resources.


