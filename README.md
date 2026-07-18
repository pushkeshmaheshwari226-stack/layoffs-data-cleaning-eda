# Layoffs Data Cleaning & EDA

## Overview
End-to-end SQL project on global tech layoffs data (2020–2023).
Performed a full data cleaning pipeline followed by exploratory data analysis using MySQL.

## Project Files
- `PROJECT_P1.sql` — Data Cleaning
- `PROJECT_P2_EXPLORATORY_DATA_ANALYSIS.sql` — Exploratory Data Analysis
- `layoffs.csv` — Raw dataset

## Data Cleaning (Part 1)
1. Removed duplicate rows using ROW_NUMBER() window function + CTE
2. Standardized company names (TRIM), industry labels (Crypto variants → Crypto), and country names
3. Converted `date` column from TEXT to DATE using STR_TO_DATE()
4. Replaced blank strings with NULL, then populated missing industry values using a self-JOIN
5. Deleted rows with no layoff data; dropped the helper row_num column

## Exploratory Data Analysis (Part 2)
- Rolling monthly layoff totals using CTEs + SUM() OVER()
- Top 5 companies by layoffs per year using DENSE_RANK()
- Breakdowns by industry, country, funding stage, and date range

## Tools
MySQL
