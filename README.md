# online-retail-customer-analysis-sql
Customer analytics on Online Retail II dataset using SQL: revenue insights, top customers, and churn risk assessment.
# Online Retail Customer Analysis (SQL)

## ⭐ Project Overview 

### Situation
An online retail company had ~500K transactions in the **Online Retail II dataset**, but lacked insights about customer behavior, revenue contribution, and churn risk.

### Task
Analyze the dataset to:
- Clean and structure transaction data
- Calculate revenue per transaction and per customer
- Identify high-value customers
- Assess customer churn risk

### Action
- **Data Cleaning:** Removed invalid transactions with missing `customerid`, negative `quantity`, or `unitprice`.
- **Data Enrichment:** Created `transactions_enriched` view to calculate revenue per transaction.
- **Customer Summary:** Created `customer_summary` view to calculate total revenue, total orders, and last purchase date per customer.
- **Analysis:**  
  - Calculated recency of customers for churn risk  
  - Segmented customers into revenue buckets and identified top 10% revenue contributors  
  - Classified churn risk as High / Medium / Low based on recency  
- **SQL Techniques Used:** `CTE`, `WINDOW FUNCTIONS` (`NTILE`, `CUME_DIST`), `VIEWS`, `CASE` statements

### Result
- Identified top 10% of customers who generate most revenue
- Determined high-risk churn customers (inactive > 180 days)
- Provided actionable insights for retention and loyalty strategies
- Created a professional, fully SQL-based workflow suitable for dashboards or further BI analysis

---

               

      

