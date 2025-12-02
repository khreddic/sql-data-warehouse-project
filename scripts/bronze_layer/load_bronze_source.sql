/*
===========================================================
Stored Procedure: Load Bronze Layer Script
===========================================================
Script Purpose:
	This script is to Load data into all 
	Bronze Layer tables from Source CSV. (CRM & ERP)
	- Truncates Bronze Tables
	- Uses 'BULK INSERT' command to load date for bronze 
		tables from source

Parameters:
	None.
	This SP does not accept nor return any values

Usage Example:
	EXEC bronze.load_bronze;
===========================================================
*/
CREATE or ALTER  PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	Set @batch_start_time = GETDATE()
	BEGIN TRY
		PRINT '=============================='
		PRINT '	Loading Bronze layer'
		PRINT '=============================='

		PRINT '__________________________________'
		PRINT 'Loading CRM Tables'
		PRINT '__________________________________'
	
		SET @start_time = GETDATE()
		PRINT '>> Truncate Table: bronze.crm_cust_info'
		--TRUNCATE & LOAD CRM Source Table
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Insert Data: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Kevin.Reddic\OneDrive - Solera Holdings, Inc\Data Projects\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------------- '

		SET @start_time = GETDATE()
		PRINT '>> Truncate Table: bronze.crm_prd_info'
		--TRUNCATE & LOAD CRM Source Table
		TRUNCATE TABLE bronze.crm_prd_info;
	
		PRINT '>> Insert Data: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Kevin.Reddic\OneDrive - Solera Holdings, Inc\Data Projects\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------------- '

		SET @start_time = GETDATE()
		PRINT '>> Truncate Table: bronze.crm_sales_details'
		--TRUNCATE & LOAD CRM Source Table
		TRUNCATE TABLE bronze.crm_sales_details;
	
		PRINT '>> Insert Data: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Kevin.Reddic\OneDrive - Solera Holdings, Inc\Data Projects\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------------- '


		PRINT '__________________________________'
		PRINT 'Loading ERP Tables'
		PRINT '__________________________________'
		
		SET @start_time = GETDATE()
		PRINT '>> Truncate Table: bronze.erp_cust_az12'
		--TRUNCATE & LOAD ERP Source Table
		TRUNCATE TABLE bronze.erp_cust_az12;
	
		PRINT '>> Insert Data: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Kevin.Reddic\OneDrive - Solera Holdings, Inc\Data Projects\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------------- '

		SET @start_time = GETDATE()
		PRINT '>> Truncate Table: bronze.erp_loc_a101'
		--TRUNCATE & LOAD ERP Source Table
		TRUNCATE TABLE bronze.erp_loc_a101;
	
		PRINT '>> Insert Data: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Kevin.Reddic\OneDrive - Solera Holdings, Inc\Data Projects\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------------- '

		SET @start_time = GETDATE()
		PRINT '>> Truncate Table: bronze.erp_px_cat_g1v2'
		--TRUNCATE & LOAD ERP Source Table
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	
		PRINT '>> Insert Data: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Kevin.Reddic\OneDrive - Solera Holdings, Inc\Data Projects\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------------- '

		SET @batch_end_time = GETDATE()
		PRINT '=============================='
		PRINT 'Loading Bronze layer Completed'
		PRINT 'TOTAL LOAD DURATION: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=============================='

		
	END TRY

	
	
	BEGIN CATCH
		PRINT '=============================='
		PRINT 'Error Loading Bronze layer'
		PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=============================='
	END CATCH
	SET @batch_end_time = GETDATE()

END
