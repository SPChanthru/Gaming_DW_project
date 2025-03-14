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
