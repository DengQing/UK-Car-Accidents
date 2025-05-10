USE master
IF DB_ID('DDS_DATH') IS NOT NULL
	DROP DATABASE DDS_DATH
GO 

CREATE DATABASE DDS_DATH
GO 

USE DDS_DATH

--Dim Date
DECLARE @startDate DATE ='20110101'
DECLARE @cutOffDate DATE = '20150101'
;WITH seq(n) AS
(
	SELECT 0 UNION ALL SELECT n + 1 FROM seq
	WHERE n < DATEDIFF(DAY, @startDate, @cutOffDate)
),
d(d) AS
(
	SELECT DATEADD(DAY, n, @startDate) FROM seq
),
src AS
(
	SELECT
	 DateKey 			= CONVERT(CHAR(8),d,112),
	 Date				= CONVERT(DATE,d),
	 Day				= DATEPART(DAY,d),
	 DayName			= DATENAME(WEEKDAY, d),
	 Week				= DATEPART(WEEK, d),
	 ISOWeek			= DATEPART(ISO_WEEk, d),
	 DayOfWeek			= DATEPART(WEEKDAY, d),
	 Month				= DATEPART(MONTH, d),
	 MonthName			= DATENAME(MONTH, d),
	 Quarter			= DATEPART(QUARTER, d),
	 Year				= DATEPART(YEAR, d),
	 FirstOfMonth		= DATEFROMPARTS(YEAR(d),MONTH(d),1),
	 LastOfYear			= DATEFROMPARTS(YEAR(d),12,31),
	 DayOfYear			= DATEPART(DAYOFYEAR, d)

	FROM d
)
SELECT *  INTO dbo.DimDate
FROM src
ORDER BY src.Date
OPTION (MAXRECURSION 0);
GO

ALTER TABLE dbo.DimDate
ALTER COLUMN DateKey INT NOT NULL  

GO 
ALTER TABLE dbo.DimDate
ADD PRIMARY KEY(DateKey)

--Dim Time
CREATE TABLE DimTime
(
     TimeKey VARCHAR(5) PRIMARY KEY,
	 Hour SMALLINT,
	 Minute SMALLINT,
	 PartOfDay VARCHAR(10)
)

--Add data to dim time
BEGIN 
	DECLARE
		@hour SMALLINT = 0,
		@minute SMALLINT = 0,
		@key varchar(5),
		@part VARCHAR(10)

	WHILE @hour < 24
		BEGIN
			IF(@hour >= 5 AND @hour < 12)
				SET @part = 'Morning'

			IF(@hour >= 12 AND @hour < 17)
				SET @part = 'Afternoon'

			IF(@hour >= 17 AND @hour < 21)
				SET @part = 'Evening'

			IF(@hour >= 21 OR @hour < 5)
				SET @part = 'Night'

			WHILE @minute <60
				BEGIN
					SET @key =  RIGHT('00'+CAST(@hour AS VARCHAR(2)),2) +  RIGHT('00'+CAST(@minute AS VARCHAR(2)),2)

					INSERT INTO dbo.DimTime
					VALUES
					(   @key, -- TimeKey - varchar(5)
						@hour,  -- Hour - smallint
						@minute,  -- Minute - smallint
						@part  -- PartOfDay - varchar(10)
					)
					SET @minute = @minute + 1
				END
			SET @minute = 0
			SET @hour = @hour + 1
		END	
END
GO

CREATE TABLE DimGeography 
(
	GeographyKey INT IDENTITY(1,1) PRIMARY KEY,
	Postcode VARCHAR(50),
	Latitude VARCHAR(50),
	Longtitude VARCHAR(50),
	Easting VARCHAR(50),
	Northing VARCHAR(50),
	CountryKey INT,
	CountryName VARCHAR(50),
	RegionKey INT,
	RegionName VARCHAR(50),
	CountyName VARCHAR(50),
	TownName VARCHAR(50)
)

CREATE TABLE DimVehicleType
(
  VehicleKey INT IDENTITY(1,1) PRIMARY KEY,
	VehicleNK INT,
	VehicleTypeName VARCHAR(50)
)

CREATE TABLE DimJourneyPurpose
(
	PurposeKey INT IDENTITY(1,1) PRIMARY KEY,
	PurposeNK INT,
	PurposeName VARCHAR(50)
)

CREATE TABLE DimRoadType
(
	RoadTypeKey INT IDENTITY(1,1) PRIMARY KEY,
	RoadTypeNK INT,
	AreaType VARCHAR(50),
	RoadType VARCHAR(50),
	SpeedLimit INT,
	BuiltUpRoad VARCHAR(50)
)

CREATE TABLE DimCasualties
(
	CasualtiesID INT IDENTITY(1,1) PRIMARY KEY,
	CasualtiesNK INT,
	CasualtiesClass VARCHAR(50),
	CasualtiesType VARCHAR(150),
	AgeBand VARCHAR(50)
)

CREATE TABLE FactAccidents
(
	DateKey INT FOREIGN KEY REFERENCES dbo.DimDate,
	TimeKey VARCHAR(5) FOREIGN KEY REFERENCES dbo.DimTime,
	GeographyKey INT FOREIGN KEY REFERENCES dbo.DimGeography,
	RoadTypeKey INT FOREIGN KEY REFERENCES dbo.DimRoadType,
	AccidentKey INT,

	Latitude VARCHAR(50),
	Longtitude VARCHAR(50),
	Easting VARCHAR(50),
	Northing VARCHAR(50),
	NumberOfCasualties INT,
	AccidentSeverity VARCHAR(10),
)

CREATE TABLE FactAccidentCasualties
(
	AccidentKey INT,
    CasualtiesKey INT FOREIGN KEY REFERENCES dbo.DimCasualties,
	DateKey INT FOREIGN KEY REFERENCES dbo.DimDate,
	TimeKey VARCHAR(5) FOREIGN KEY REFERENCES dbo.DimTime,


	SexOfCasualties VARCHAR(10),
	AgeOfCasualties INT,
	CasualtiesSeverity VARCHAR(10)
)

CREATE TABLE FactAccidentVehicle
(
	DateKey INT FOREIGN KEY REFERENCES dbo.DimDate,
	TimeKey VARCHAR(5) FOREIGN KEY REFERENCES dbo.DimTime,
	VehicleKey INT FOREIGN KEY REFERENCES dbo.DimVehicleType,
	PurposeKey INT FOREIGN KEY REFERENCES dbo.DimJourneyPurpose,
	AccidentKey INT,

	AccidentServerity VARCHAR(50),
	SexOfDriver VARCHAR(10),
	AgeOfDriver INT,
	AgeBand VARCHAR(50),
	VehicleAge INT,
	EngineCapacity INT
)

CREATE TABLE  Mining (
	[Accident_ID] int,
    [DateKey] INT FOREIGN KEY REFERENCES dbo.DimDate,
    [TimeKey] varchar(5) FOREIGN KEY REFERENCES dbo.DimTime,
    [GeographyKey] INT FOREIGN KEY REFERENCES dbo.DimGeography,
    [RoadTypeKey] INT FOREIGN KEY REFERENCES dbo.DimRoadType,
    [Accident_Severity] varchar(50),
    [Number_of_Vehicles] INT,
    [Number_of_Casualties] INT,

    [Light_Conditions] varchar(50),
    [Weather_Conditions] varchar(50),
    [Road_Surface_Conditions] varchar(50),
    [Special_Conditions_at_Site] varchar(50),
	[Carriageway_Hazards] varchar(50),
)

