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

	PRINT '=============================='
	PRINT '	Loading Bronze layer'
	PRINT '=============================='

	PRINT '__________________________________'
	PRINT 'Loading CRM Tables'
	PRINT '__________________________________'
	
	
	PRINT '>> Truncate Table: bronze.crm_cust_info'
	--TRUNCATE & LOAD CRM Source Table
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT '>> Insert Data: bronze.crm_cust_info'
	BULK INSERT bronze.crm_cust_info
	FROM '<INSERT FILEPATH HERE>\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	
	PRINT '>> Truncate Table: bronze.crm_prd_info'
	--TRUNCATE & LOAD CRM Source Table
	TRUNCATE TABLE bronze.crm_prd_info;
	
	PRINT '>> Insert Data: bronze.crm_prd_info'
	BULK INSERT bronze.crm_prd_info
	FROM '<INSERT FILEPATH HERE>\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	
	PRINT '>> Truncate Table: bronze.crm_sales_details'
	--TRUNCATE & LOAD CRM Source Table
	TRUNCATE TABLE bronze.crm_sales_details;
	
	PRINT '>> Insert Data: bronze.crm_sales_details'
	BULK INSERT bronze.crm_sales_details
	FROM '<INSERT FILEPATH HERE>\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);


	PRINT '__________________________________'
	PRINT 'Loading ERP Tables'
	PRINT '__________________________________'
	
	PRINT '>> Truncate Table: bronze.erp_cust_az12'
	--TRUNCATE & LOAD ERP Source Table
	TRUNCATE TABLE bronze.erp_cust_az12;
	
	PRINT '>> Insert Data: bronze.erp_cust_az12'
	BULK INSERT bronze.erp_cust_az12
	FROM '<INSERT FILEPATH HERE>\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	
	PRINT '>> Truncate Table: bronze.erp_loc_a101'
	--TRUNCATE & LOAD ERP Source Table
	TRUNCATE TABLE bronze.erp_loc_a101;
	
	PRINT '>> Insert Data: bronze.erp_loc_a101'
	BULK INSERT bronze.erp_loc_a101
	FROM '<INSERT FILEPATH HERE>\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	
	PRINT '>> Truncate Table: bronze.erp_px_cat_g1v2'
	--TRUNCATE & LOAD ERP Source Table
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	
	PRINT '>> Insert Data: bronze.erp_px_cat_g1v2'
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM '<INSERT FILEPATH HERE>\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

END
