# Revenue Leakage Detection & Recovery System

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)

## 📊 Project Overview

A comprehensive data analytics project identifying **₹2.87 Crores** in revenue leakage for a telecom company through systematic analysis of 280,000+ transaction records.

## 🎯 Business Problem

The telecom company was experiencing unexplained revenue shortfalls. This project aimed to:
- Identify sources of revenue leakage
- Quantify the financial impact
- Prioritize recovery actions
- Enable data-driven decision making

## 💡 Solution Approach

### 1. Data Architecture
- Designed 6-table relational database with proper normalization
- Tables: Customers, Billing Transactions, Service Usage, Pricing Rules, Discounts Applied, Recovery Actions
- Implemented proper relationships and foreign key constraints

### 2. SQL Analysis
Wrote 5 comprehensive SQL queries using:
- Complex JOINs (INNER, LEFT, multiple tables)
- Window Functions (ROW_NUMBER, RANK, LAG)
- Common Table Expressions (CTEs)
- Aggregate functions with GROUP BY and HAVING
- Date/time calculations

### 3. Power BI Visualization
Created 3-page interactive dashboard with 26 visuals:
- **Executive Overview:** High-level KPIs and trends
- **Detailed Analysis:** Deep-dive into each leakage category
- **Recovery Pipeline:** Actionable recovery tracking

## 📈 Key Findings

| Leakage Category  | Amount        | Customers Affected | Key Insight                               |
| ----------------- | ------------- | ------------------ | ----------------------------------------- |
| Failed Payments   | ₹1.33 Cr      | 7,886              | Avg 990 days unpaid - collections gap     |
| Expired Discounts | ₹1.17 Cr/year | 5,298              | Avg 1,215 days expired - no auto-expiry   |
| Billing Mismatch  | ₹29.1 L       | 7,239              | Usage vs billing system integration issue |
| Data Overage      | ₹7.9 L        | 5,857              | 134 TB unbilled data                      |
| **TOTAL**         | **₹2.87 Cr**  | **26,280**         | Multiple system and process gaps          |


## 🚀 Business Impact

1. **Prioritized Recovery:** Top 10 customers = ₹20L potential recovery
2. **Process Improvements:** Identified 4 system gaps for IT team
3. **Automated Reporting:** Dashboard reduced manual reporting from 4 hours to 10 minutes
4. **Data-Driven Decisions:** Finance team can track recovery by category, status, and time period

## 🛠️ Technologies Used

- **Database:** SQL Server
- **Querying:** SQL (complex joins, window functions, CTEs)
- **Visualization:** Power BI (DAX, relationships, slicers)
- **Data Generation:** Python (pandas, numpy)

## 📁 Repository Structure
```
Revenue-Leakage-Analysis/
├── SQL_Scripts/
│   ├── 01_Create_Database.sql
│   ├── 02_Create_Tables.sql
│   ├── 03_Import_Data.sql
│   ├── 04_Analysis_Queries.sql
│   └── 05_Create_Views.sql
├── Screenshots/
│   ├── Page1_Executive_Overview.png
│   ├── Page2_Detailed_Analysis.png
│   └── Page3_Recovery_Pipeline.png
└── README.md
```

## 📸 Dashboard Screenshots

### Executive Overview
![Executive Overview](Screenshots/Page1_Executive_Overview.png)

### Detailed Analysis
![Detailed Analysis](Screenshots/Page2_Detailed_Analysis.png)

### Recovery Pipeline
![Recovery Pipeline](Screenshots/Page3_Recovery_Pipeline.png)

## 🎓 Key SQL Techniques Demonstrated

- Multi-table JOINs (6 tables joined)
- Window Functions: `ROW_NUMBER()`, `RANK()`, `LAG()`
- Common Table Expressions (CTEs) for complex logic
- Date arithmetic and DATEDIFF calculations
- Aggregate functions with GROUP BY
- TRY_CAST for data type handling
- Creating permanent views for reusability

## 📊 Sample SQL Query
```sql
-- Identify failed payments not followed up
WITH Failed_Payments AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        SUM(bt.BilledAmount) as TotalBilled,
        bt.PaymentStatus,
        DATEDIFF(day, bt.BillingDate, GETDATE()) as DaysSinceBilling,
        ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY bt.BillingDate DESC) as rn
    FROM Customers c
    JOIN Billing_Transactions bt ON c.CustomerID = bt.CustomerID
    WHERE bt.PaymentStatus = 'Failed'
        AND DATEDIFF(day, bt.BillingDate, GETDATE()) > 90
    GROUP BY c.CustomerID, c.CustomerName, bt.PaymentStatus, bt.BillingDate
)
SELECT * FROM Failed_Payments WHERE rn = 1
ORDER BY TotalBilled DESC;
```

## 💼 Author

**Jasmine D**  
Data Analyst | SQL | Power BI | Python  
[LinkedIn](https://linkedin.com/in/djasmine1610) | [Email](mailto:djasmine1610@gmail.com)

## 📝 License

This project is for portfolio demonstration purposes.

---

⭐ If you found this project interesting, please consider giving it a star!
