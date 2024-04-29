IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacitydivvyproject_udacitydivvyproject_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacitydivvyproject_udacitydivvyproject_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacitydivvyproject@udacitydivvyproject.dfs.core.windows.net' 
	)
GO

IF OBJECT_ID('dbo.payment_fact') IS NOT NULL
	BEGIN
		DROP EXTERNAL TABLE [dbo].[payment_fact];
	END

CREATE EXTERNAL TABLE dbo.payment_fact
WITH (
    LOCATION     = 'payment_fact',
    DATA_SOURCE = [udacitydivvyproject_udacitydivvyproject_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS (
	SELECT 
	p.payment_id,
	p.date,
	p.amount,
	p.rider_id
	FROM
	dbo.Payment_stagingtable p
	JOIN dbo.Rider_stagingtable r on r.rider_id = p.rider_id
);

GO

SELECT TOP 10 * FROM dbo.payment_fact;