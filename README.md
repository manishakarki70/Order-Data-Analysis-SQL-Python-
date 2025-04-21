# 🧾 Order Data Analysis | SQL + Python Project

## 🔍 Project Overview
This project explores and analyzes a retail order dataset using a combination of **SQL** and **Python (Pandas)**. The objective is to derive business insights such as product performance, regional trends, and profit analysis by using structured queries and data wrangling.

---

## 🛠️ Tools & Technologies
- **SQL**: Data modeling, aggregation, filtering, window functions (ROW_NUMBER)
- **Python (Pandas)**: Data cleaning and preparation
- **Kaggle API**: Automated dataset download

---

## 📊 Key Features & Insights

### 📥 Data Preparation (Python)
- Downloaded retail dataset from Kaggle using the API.
- Cleaned the data: handled missing values, renamed columns, and created new columns for discount, sale price, and profit.

### 🗃️ SQL Table Creation
- Created an `ORDERS` table to hold the processed data with appropriate column types and constraints.
- Loaded the data from the cleaned CSV file into the SQL environment.

### 📈 SQL Analysis
- Identified **Top 10 highest revenue-generating products**.
- Extracted **Top 5 products in each region** using **CTEs** and **ROW_NUMBER()**.
- Analyzed **average discount and profit** across product categories and sub-categories.
- Evaluated **monthly sales trends** and regional performance.

---

## 📈 Outcome
- Extracted valuable insights to identify best-selling products and high-performing regions.
- Built a strong foundation for extending the analysis to dashboards or machine learning applications.
- Showcased end-to-end data handling: from ingestion and transformation to insight generation.

---

## 📁 Project Files
- `order_data_analysis.ipynb`: Python notebook with dataset loading, cleaning, and preparation steps.
- `order_data_analysis.sql`: SQL script for table creation and business insights queries.

---

## 🔗 Dataset
- [Retail Orders Dataset on Kaggle](https://www.kaggle.com/datasets/ankitbansal06/retail-orders)
