/*
===========================================================
Bronze Layer Load Script: Import Data from CSV
===========================================================
Script Purpose:
	This script is to Load data into all 
	Bronze Layer tables from Source CSV. (CRM & ERP)
	This Script also Truncates the current table 
	to get a fresh load of data from each source
===========================================================
*/
CREATE or ALTER  PROCEDURE bronze.load_bronze AS
	BEGIN
	--TRUNCATE & LOAD CRM Source Table
	TRUNCATE TABLE bronze.crm_cust_info;
	BULK INSERT bronze.crm_cust_info
	FROM '<INSERT FILEPATH HERE>\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	--TRUNCATE & LOAD CRM Source Table
	TRUNCATE TABLE bronze.crm_prd_info;
	BULK INSERT bronze.crm_prd_info
	FROM '<INSERT FILEPATH HERE>\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	--TRUNCATE & LOAD CRM Source Table
	TRUNCATE TABLE bronze.crm_sales_details;
	BULK INSERT bronze.crm_sales_details
	FROM '<INSERT FILEPATH HERE>\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	--TRUNCATE & LOAD ERP Source Table
	TRUNCATE TABLE bronze.erp_cust_az12;
	BULK INSERT bronze.erp_cust_az12
	FROM '<INSERT FILEPATH HERE>\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	--TRUNCATE & LOAD ERP Source Table
	TRUNCATE TABLE bronze.erp_loc_a101;
	BULK INSERT bronze.erp_loc_a101
	FROM '<INSERT FILEPATH HERE>\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	--TRUNCATE & LOAD ERP Source Table
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM '<INSERT FILEPATH HERE>\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

END
