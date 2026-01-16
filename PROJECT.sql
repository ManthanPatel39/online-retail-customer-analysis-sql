LOAD DATA LOCAL INFILE 'C:/Users/Asus/Downloads/archive/online_retail_II.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT customerid) AS total_customers,
  COUNT(DISTINCT invoiceno) AS total_orders
FROM transactions;

DELETE FROM transactions
WHERE customerid IS NULL
   OR quantity <= 0
   OR unitprice <= 0;

CREATE VIEW transactions_enriched AS
SELECT *,
       quantity * unitprice AS revenue
FROM transactions;

CREATE VIEW customer_summary AS
SELECT
  customerid,
  COUNT(DISTINCT invoiceno) AS total_orders,
  SUM(revenue) AS total_revenue,
  MAX(invoicedate) AS last_purchase_date
FROM transactions_enriched
GROUP BY customerid;

SELECT
  customerid,
  total_revenue,
  total_orders,
  CURRENT_DATE - last_purchase_date AS recency_days
FROM customer_summary;

SELECT *
FROM (
  SELECT
    customerid,
    total_revenue,
    NTILE(10) OVER (ORDER BY total_revenue DESC) AS revenue_bucket
  FROM customer_summary
) t
WHERE revenue_bucket = 1;

WITH ranked AS (
  SELECT
    customerid,
    total_revenue,
    CUME_DIST() OVER (ORDER BY total_revenue DESC) AS revenue_rank
  FROM customer_summary
)
SELECT
  SUM(CASE WHEN revenue_rank <= 0.10 THEN total_revenue END) * 100.0
  / SUM(total_revenue) AS top_10_revenue_pct
FROM ranked;

SELECT
  customerid,
  recency_days,
  CASE
    WHEN recency_days > 180 THEN 'High Risk'
    WHEN recency_days BETWEEN 90 AND 180 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END AS churn_risk
FROM (
  SELECT
    customerid,
    CURRENT_DATE - last_purchase_date AS recency_days
  FROM customer_summary
) t;

