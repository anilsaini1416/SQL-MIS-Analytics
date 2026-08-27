# E-Commerce Sales & Profitability MIS Analysis

## 📌 Project Overview
This project is an end-to-end Management Information System (MIS) analysis report designed to evaluate e-commerce retail performance using Advanced SQL. The core objective is to process transactional records, track vital business metrics, identify profit leaks across regions and product lines, and deliver actionable insights for senior management decision-making.

---

## 🎯 Business Problem & Objectives
In retail and e-commerce operations, generating high revenue does not always guarantee profitability. This project addresses key business questions to assist management:
* What is the overall financial health of the business in terms of total orders, revenue, net profit, and profit margins?
* Which geographic regions (states) are driving maximum sales, and which ones are incurring operational losses (profit leakage)?
* Which product categories and sub-categories are the most and least profitable?
* Who are the high-value customers contributing significantly to repeat orders?
* What are the month-on-month business trends and growth patterns?

---

## 🗄️ Database Architecture & Structure
The project utilizes a relational database structure where two datasets are linked together via a common foreign key (`Order ID`):
1. **List of Orders:** Contains order-level metadata including Order ID, Order Date, Customer Name, State, and City.
2. **Order Details:** Contains product-level financial metrics including Order ID, Amount (Sales), Profit, Quantity, Category, and Sub-Category.

---

## 🔍 Key Analysis Modules
1. **Executive Summary & High-Level KPIs:** Aggregates total orders, units sold, gross revenue, net profit, and overall profit margin to provide a high-level snapshot of business scale.
2. **Regional & Geographic Performance:** Evaluates top-performing states by revenue while isolating loss-making territories through negative profit filtering for targeted cost control.
3. **Product & Sub-Category Profitability:** Analyzes category-wise contribution to sales and uses advanced ranking logic (`DENSE_RANK()`) to evaluate profit margins and product-level performance.
4. **Customer Segmentation:** Focuses on identifying top-tier high-value customers based on lifetime spend and order frequency to assist in customer retention strategies.
5. **Time-Series Trend & Ranking Analysis:** Tracks month-on-month revenue and order trajectories alongside window functions to understand seasonal demand shifts.

---

## 📈 Strategic Insights & Findings
* **Revenue vs. Profit Mismatch:** Certain top-performing regions generate substantial gross revenue but suffer from negative net margins, pointing towards issues with heavy discounting or operational overheads.
* **Product-Level Leakages:** Specific sub-categories drive sales volume yet result in net losses, indicating an urgent need for pricing strategy revisions or discontinuation of non-profitable items.
* **Customer Concentration:** A core group of repeat buyers drives a significant share of total customer spending, highlighting the importance of targeted loyalty and engagement programs.

---

## 💡 Skills & Concepts Demonstrated
- Relational Database Management & Multi-table Joins (`INNER JOIN`)
- Data Aggregations & Conditional Filtering (`GROUP BY`, `HAVING`)
- Advanced SQL Analytics (Common Table Expressions & Window Functions)
- MIS Reporting & Business-driven Data Analysis
