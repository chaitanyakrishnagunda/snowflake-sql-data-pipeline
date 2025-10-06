# snowflake-sql-data-pipeline
Snowflake SQL project using the Tasty Bytes dataset — includes database setup, data ingestion from AWS S3, and analytical queries for real-world data insights.

# 🍴 Snowflake Tasty Bytes SQL Demo

This repository demonstrates a **hands-on Snowflake SQL project** using the **Tasty Bytes dataset** provided by Snowflake.  
It covers database setup, schema creation, data ingestion from an S3 stage, and analytical SQL queries for real-world insights.

---

## 🧠 Project Overview

This mini-project simulates a **Point-of-Sale (POS) analytics workflow** for a food truck chain called *Tasty Bytes*.  
It includes:
- Creating databases and schemas in Snowflake
- Loading data from a public AWS S3 bucket
- Running analytical SQL queries to explore menu data

---

## ⚙️ Technologies Used
- **Snowflake** (Cloud Data Warehouse)
- **SQL**
- **AWS S3** (Data Staging)
- **Snowflake Web UI / Snowsight**

---

## 📁 Files Included

| File | Description |
|------|--------------|
| `tasty_bytes_snowflake_setup.sql` | Complete SQL setup script including table creation, data loading, and queries |
| `README.md` | Documentation for setup and explanation of the project |
| `screenshots/` | Screenshots of results |

---

## 🧰 How to Run

### 1. Log in to Snowflake Console
Go to [Snowflake Snowsight](https://app.snowflake.com/) and open a **new worksheet**.

### 2. Copy and Paste SQL Script
Run the SQL commands step-by-step from  
`tasty_bytes_snowflake_setup.sql`.

### 3. Verify Data Load
Run:
```sql
SELECT COUNT(*) FROM tasty_bytes_sample_data.raw_pos.menu;

