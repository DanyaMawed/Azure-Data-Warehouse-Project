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

IF OBJECT_ID('dbo.station_dim') IS NOT NULL
	BEGIN
		DROP EXTERNAL TABLE [dbo].[station_dim];
	END

CREATE EXTERNAL TABLE dbo.station_dim
WITH (
    LOCATION     = 'station_dim',
    DATA_SOURCE = [udacitydivvyproject_udacitydivvyproject_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS (
	SELECT 
	s.station_id,
	s.name,
	s.latitude,
	s.longitude
	FROM
	dbo.Station_stagingtable s
);

GO

SELECT TOP 10 * FROM dbo.station_dim;