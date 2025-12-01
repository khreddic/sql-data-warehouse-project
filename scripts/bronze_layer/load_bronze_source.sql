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

--TRUNCATE & LOAD CRM Source Table
TRUNCATE TABLE bronze.crm_cust_info;
go

BULK INSERT bronze.crm_cust_info
FROM '<Insert Filepath here>'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
go

--TRUNCATE & LOAD CRM Source Table
TRUNCATE TABLE bronze.crm_prd_info;
go

BULK INSERT bronze.crm_prd_info
FROM '<Insert Filepath here>'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
go

--TRUNCATE & LOAD CRM Source Table
TRUNCATE TABLE bronze.crm_sales_details;
go

BULK INSERT bronze.crm_sales_details
FROM '<Insert Filepath here>'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
go

--TRUNCATE & LOAD ERP Source Table
TRUNCATE TABLE bronze.erp_cust_az12;
go

BULK INSERT bronze.erp_cust_az12
FROM '<Insert Filepath here>'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
go

--TRUNCATE & LOAD ERP Source Table
TRUNCATE TABLE bronze.erp_loc_a101;
go

BULK INSERT bronze.erp_loc_a101
FROM '<Insert Filepath here>'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
go

--TRUNCATE & LOAD ERP Source Table
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
go

BULK INSERT bronze.erp_px_cat_g1v2
FROM '<Insert Filepath here>'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
go


