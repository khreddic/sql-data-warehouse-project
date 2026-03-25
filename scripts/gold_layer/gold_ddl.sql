/*
===============================================================================
DDL Script: Create Gold Veiws
===============================================================================
Script Purpose:
    This script creates views in the 'gold' schema, dropping existing tables 
    if they already exist.
	Data Checks commented out 
	  Run this script to re-define the DDL structure of 'gold' Tables
===============================================================================
*/

IF OBJECT_ID('gold.dim_customers','U') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

--Create Gold Layer View: Dimension table - dim_customer
CREATE VIEW gold.dim_customers AS (
SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	CI.cst_id AS customer_id,
	CI.cst_key AS customer_number,
	CI.cst_firstname AS first_name,
	CI.cst_lastname AS last_name,
	la.cntry AS country,
	CI.cst_marital_status AS marital_status,
	CASE WHEN ci.cst_gndr != 'unknown' then ci.cst_gndr --CRM is the master data
		ELSE COALESCE(ca.gen, 'N/A')
	END AS gender,
	ca.bdate AS birthdate,
	CI.cst_create_date as create_date
FROM silver.crm_cust_info CI
Left Join silver.erp_cust_az12 CA
ON		ci.cst_key = ca.cid
Left Join silver.erp_loc_a101 la
on		ci.cst_key = la.cid
)


----------------------------------------------------------------------------------------------------
--	--Quality checks
	
--	-- Check for duplicate data
--Select cst_id, count(*) FROM
--	(SELECT
--	CI.cst_id,
--	CI.cst_key,
--	CI.cst_firstname,
--	CI.cst_lastname,
--	CI.cst_marital_status,
--	CASE WHEN ci.cst_gndr != 'unknown' then ci.cst_gndr --CRM is the master data
--		ELSE COALESCE(ca.gen, 'N/A')
--	END AS new_gen,
--	CI.cst_create_date,
--	ca.bdate,
--	la.cntry
--	FROM silver.crm_cust_info CI
--	Left Join silver.erp_cust_az12 CA
--	ON		ci.cst_key = ca.cid
--	Left Join silver.erp_loc_a101 la
--	on		ci.cst_key = la.cid) AS t 
--GROUP BY cst_id
--HAVING count(*) > 1


----CHeck most accurate information for multiple columns with same information
--SELECT DISTINCT
--	CI.cst_gndr,
--	ca.gen,
--	CASE WHEN ci.cst_gndr != 'unknown' then ci.cst_gndr --CRM is the master data
--		ELSE COALESCE(ca.gen, 'N/A')
--	END AS new_gen
--	FROM silver.crm_cust_info CI
--	Left Join silver.erp_cust_az12 CA
--	ON		ci.cst_key = ca.cid
--	Left Join silver.erp_loc_a101 la
--	on		ci.cst_key = la.cid
--	ORDER BY 1, 2
---------------------------------------------------------------------------------------------
IF OBJECT_ID('gold.dim_products','U') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
	
CREATE VIEW gold.dim_products AS (
SELECT
ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
pn.prd_id AS product_id,
pn.prd_key AS product_number,
pn.prd_nm AS product_name,
pn.cat_id AS category_id,
pc.cat AS category,
pc.subcat AS subcatagory,
pc.maintenance AS maintenance,
pn.prd_cost AS cost,
pn.prd_line AS product_line,
pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
Where pn.prd_end_dt IS NULL -- Filter out all historical data
)

SELECT * FROM gold.dim_products

-------------------------------------------------------
----Quality Checks
--SELECT prd_key, count(*) FROM (
--SELECT
--pn.prd_id AS product_id,
--pn.prd_key AS product_number,
--pn.prd_nm AS product_name,
--pn.cat_id AS category_id,
--pc.cat AS category,
--pc.subcat AS subcatagory,
--pc.maintenance AS maintenance,
--pn.prd_cost AS cost,
--pn.prd_line AS product_line,
--pn.prd_start_dt AS start_date
--FROM silver.crm_prd_info pn
--LEFT JOIN silver.erp_px_cat_g1v2 pc
--ON pn.cat_id = pc.id
--Where pn.prd_end_dt IS NULL) t -- Filter out all historical data
--GROUP BY prd_key
--HAVING count(*) > 1



----------------------------------------------------------------------
IF OBJECT_ID('gold.fact_sales','U') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
	
--Create View gold.fact_sales
CREATE VIEW gold.fact_sales AS 
SELECT
sd.sls_ord_num AS order_number,
pr.product_key AS product_key,
cu.customer_key AS customer_key,
sd.sls_order_dt AS order_date,
sd.sls_ship_dt AS ship_date,
sd.sls_due_dt AS due_date,
sd.sls_sales AS sales,
sd.sls_quantity AS quantity,
sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key= pr.product_number
LEFT JOIN gold.dim_customers cu
on sd.sls_cust_id = cu.customer_id



--Select * from gold.fact_sales f
--LEFT JOIN gold.dim_customers c
--on c.customer_key = f.customer_key
--LEFT JOIN gold.dim_products p
--ON p.product_key = f.product_key
--where p.product_key IS NULL

