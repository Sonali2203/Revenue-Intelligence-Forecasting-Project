# Revenue-Intelligence-Forecasting-Project
This project demonstrates an end-to-end analytics workflow — from raw transactional data to executive dashboards and machine learning–based revenue forecasting.
The goal was to:

Analyze historical business performance

Identify revenue, profit, and margin drivers

Forecast future revenue to support budgeting and planning decisions

🧩 Business Problem

Stakeholders needed answers to:

How is revenue and profitability trending over time?

Which products and regions drive performance?

Are discounts impacting margins?

What revenue can be expected in the next 3–6 months?

🛠️ Tech Stack

SQL (MySQL) – Data modeling & business KPIs

Power BI – Executive dashboards & visualization

Python (pandas, scikit-learn) – Revenue forecasting (ML)

🗄️ 1. SQL: Data Modeling & KPI Layer
🔹 Data Source

Retail / Superstore transactional dataset (orders, products, customers).

🔹 Data Modeling

I followed a star schema design:

Fact Table

sales_transactions

order_date

product_id

customer_id

region

revenue

cost

discount

quantity

Dimension Tables

products

customers

regions

calendar

Raw data was first loaded into a staging table (raw_superstore) and then transformed into clean analytics tables.

🔹 Financial Logic

Cost calculated as:
cost = revenue − profit

Ensured financial consistency across SQL, Power BI, and ML.

🔹 Key SQL KPIs

Monthly Revenue & Profit

Gross Margin %

Month-over-Month Growth

Revenue Contribution by Category

Region-wise Profitability

Discount vs Margin Impact

📌 SQL served as the single source of truth.

📊 2. Power BI: Business Intelligence Dashboard
🔹 Data Connection

Direct connection to SQL analytics tables

No CSVs used for reporting

🔹 Data Model

Star schema with proper relationships

Dedicated calendar table for time intelligence

Single-direction filtering (best practice)

🔹 Key DAX Measures

Total Revenue

Total Profit

Gross Margin %

MoM Revenue Growth %

🔹 Dashboard Pages

1️⃣ Executive Overview

Revenue, Profit, Margin, MoM Growth

Revenue trend over time

Revenue by region

2️⃣ Product & Pricing Insights

Revenue by category

Product-level profitability

Discount impact on margins

3️⃣ Finance View

Revenue vs Cost trend

Profitability by region

Margin efficiency analysis

📌 Designed for leadership decision-making, not just reporting.

🤖 3. Python (ML): Revenue Forecasting
🔹 Objective

Forecast next 6 months of revenue to support budgeting and planning.

🔹 Data Preparation

Monthly revenue aggregated in SQL

Loaded into Python using pandas

Time converted into a numeric feature (time_index)

🔹 Model Selection

Linear Regression

Why Linear Regression?

Revenue shows a clear trend over time

Model is explainable to business stakeholders

Suitable for short-term forecasting

Avoids overfitting with limited data

🔹 Model Training

Independent variable: time_index

Dependent variable: monthly revenue

🔹 Evaluation Metric

Mean Absolute Error (MAE)

Why MAE?

Interpretable in business terms (currency)

Shows average forecast error

More suitable than RMSE/R² for time series

🔹 Validation Approach

MAE within acceptable business range

Visual comparison: actual vs predicted revenue

Business plausibility check (no unrealistic spikes)

🔹 Output

6-month revenue forecast

Actual vs forecast trend visualization

📌 Forecast used as a planning tool, not a trading model.

📈 Key Insights

Revenue shows long-term growth with seasonal variability

High discounts significantly reduce margins

Some regions generate high revenue but low profitability

Forecast indicates steady revenue growth over the next 6 months

🎯 Business Impact

Enables leadership to track performance at a glance

Supports pricing and discount strategy decisions

Provides data-driven input for revenue planning

Demonstrates how analytics and ML complement BI

🧠 What This Project Demonstrates

End-to-end analytics thinking

Strong SQL fundamentals & data modeling

Business-focused Power BI dashboards

Practical, explainable use of ML

Ability to translate data into decisions

🚀 Next Enhancements (Optional)

Add seasonality-aware forecasting

Include confidence intervals

Extend forecasting to region/category level

Automate data refresh pipeline
