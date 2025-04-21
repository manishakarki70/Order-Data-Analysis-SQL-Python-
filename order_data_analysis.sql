-----
----- 1. CREATE THE 'ORDERS' TABLE 

CREATE TABLE ORDERS (
	  [order_id] int primary key
	 ,[order_date] date
	 ,[ship_mode] varchar(20)
	 ,[segment] varchar(20)
	 ,[country] varchar(20)
	 ,[city] varchar(20)
	 ,[state] varchar(20)
	 ,[postal_code] varchar(20)
	 ,[region] varchar(20)
	 ,[category] varchar(20)
	 ,[sub_category] varchar(20)
	 ,[product_id] varchar(20)
	 ,[quantity] int
	 ,[discount] decimal(7,2)
	 ,[sale_price] decimal(7,2)
	 ,[profit] decimal(7,2)
)

----- 2. VERIFY THE LOADED DATFRAME FROM PANDAS
SELECT * FROM ORDERS

----- 3. DATA ANALYSIS USING SQL

------ FIND TOP 10 HIGHEST GENERATING PRODUCTS
SELECT TOP 10 product_id, sum(sale_price) as revenue
FROM ORDERS
GROUP BY product_id
ORDER BY revenue DESC

------ FIND TOP 5 HIGHEST SELLING PRODUCTS IN EACH REGION
WITH cte_products AS (
SELECT region, product_id, sum(sale_price) as revenue
FROM ORDERS
GROUP BY region, product_id
),

cte_ranking AS(
SELECT *, ROW_NUMBER() OVER(PARTITION BY region ORDER BY revenue DESC) AS row_num
FROM cte_products
)

SELECT * FROM cte_ranking
WHERE row_num<=5


------ FIND MONTH OVER MONTH GROWTH COMPARISION FOR YEARS 2022 AND 2023 SALES
WITH cte_yearly_sales AS (
SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month, SUM(sale_price) AS revenue
FROM ORDERS
GROUP BY YEAR(order_date), MONTH(order_date)
)

SELECT order_month,
SUM(CASE WHEN order_year=2023 THEN revenue ELSE 0 END) AS sales_2023,
SUM(CASE WHEN order_year=2022 THEN revenue ELSE 0 END) AS sales_2022
FROM cte_yearly_sales
GROUP BY order_month


------ FOR EACH CATEGORY WHICH MONTH HAS THE HIGHEST SALE
WITH cte_yearly_monthly_sales AS (
SELECT category, FORMAT(order_date, 'yyyyMM') AS order_year_month, SUM(sale_price) AS revenue
FROM ORDERS
GROUP BY category, FORMAT(order_date, 'yyyyMM')
),

cte_monthly_ranking AS (
SELECT *, ROW_NUMBER() OVER(PARTITION BY category ORDER BY revenue DESC) AS row_num
FROM cte_yearly_monthly_sales
)

SELECT * FROM cte_monthly_ranking
WHERE row_num=1


------ WHICH SUBCATEGORY HAD THE HIGHEST GROWTH BY PROFIT IN 2023 COMPARED TO 2022
WITH cte_sub_category AS (
SELECT sub_category, YEAR(order_date) AS order_year, SUM(sale_price) AS revenue
FROM ORDERS
GROUP BY sub_category, YEAR(order_date)
),

cte_yearly_sales AS (
SELECT sub_category,
SUM(CASE WHEN order_year=2023 THEN revenue ELSE 0 END) AS sales_2023,
SUM(CASE WHEN order_year=2022 THEN revenue ELSE 0 END) AS sales_2022
FROM cte_sub_category
GROUP BY sub_category
)

SELECT TOP 1 *, (sales_2023-sales_2022)*100/sales_2022 AS profit_percent
FROM cte_yearly_sales
ORDER BY (sales_2023-sales_2022)*100/sales_2022 DESC
