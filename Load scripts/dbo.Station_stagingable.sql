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

CREATE EXTERNAL TABLE dbo.Station_stagingable (
	[station_id] nvarchar(4000),
	[name] nvarchar(4000),
	[latitude] float,
	[longitude] float
	)
	WITH (
	LOCATION = 'publicstation.csv',
	DATA_SOURCE = [udacitydivvyproject_udacitydivvyproject_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.Station_stagingable
GO