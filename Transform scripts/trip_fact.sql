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

IF OBJECT_ID('dbo.trip_fact') IS NOT NULL
	BEGIN
		DROP EXTERNAL TABLE [dbo].[trip_fact];
	END

CREATE EXTERNAL TABLE dbo.trip_fact
WITH (
    LOCATION     = 'trip_fact',
    DATA_SOURCE = [udacitydivvyproject_udacitydivvyproject_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS (
	SELECT 
	t.trip_id,
	t.rider_id,
	t.rideable_type,
	t.start_at,
	t.ended_at,
	DATEDIFF(MINUTE, t.start_at, t.ended_at) as duration,
	t.start_station_id,
	t.end_station_id,
	DATEDIFF(YEAR, r.birthday, t.start_at) as rider_age
	FROM
	dbo.Trip_stagingtable t
	JOIN dbo.Rider_stagingtable r on r.rider_id = t.rider_id
);

GO

SELECT TOP 10 * FROM dbo.trip_fact;