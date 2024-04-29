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

IF OBJECT_ID('dbo.date_dim') IS NOT NULL
	BEGIN
		DROP EXTERNAL TABLE [dbo].[date_dim];
	END

CREATE EXTERNAL TABLE dbo.date_dim
WITH (
    LOCATION     = 'date_dim',
    DATA_SOURCE = [udacitydivvyproject_udacitydivvyproject_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY date) as date_id,
	p.date,
	DATEPART(weekday, convert(date,p.date)) as day_of_week,
	DATEPART(quarter, convert(date,p.date)) as quarter,
	DATEPART(MONTH, convert(date,p.date)) as month,
	DATEPART(year, convert(date,p.date)) as year
	FROM
	dbo.Payment_stagingtable p
);

GO

SELECT TOP 10 * FROM dbo.date_dim;