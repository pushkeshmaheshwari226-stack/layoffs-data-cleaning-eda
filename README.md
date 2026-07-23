# Layoffs Data Cleaning & Exploratory Data Analysis

End-to-end SQL project on a dataset of global tech layoffs — from raw messy data to
structured EDA surfacing trends across companies, industries, and time.

## Tools
- MySQL Workbench

## Project Breakdown

### Part 1 — Data Cleaning
- Removed duplicate rows using `ROW_NUMBER()` with a staging table approach
- Standardised inconsistent values across company, industry, and country columns
- Converted date strings to proper `DATE` format using `STR_TO_DATE()`
- Handled NULL and blank values

### Part 2 — Exploratory Data Analysis
- Identified companies, industries, and countries with the highest layoff totals
- Tracked layoff trends over time using date-based aggregations
- Ranked companies by total layoffs per year with `DENSE_RANK()` and CTEs
- Identified companies that went from 100% workforce to zero

## Key SQL Concepts
`ROW_NUMBER()` · `DENSE_RANK()` · CTEs · `SUM() OVER()` · `GROUP BY` ·
String functions · `STR_TO_DATE()` · `UPDATE` / `DELETE` · Staging tables

## Dataset
World Layoffs dataset — sourced from [Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
