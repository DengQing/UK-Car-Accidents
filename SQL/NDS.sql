use master
if DB_ID ('NDS_DATH') is not null
	drop database NDS_DATH
GO

CREATE DATABASE NDS_DATH 
GO

ALTER DATABASE NDS_DATH SET SINGLE_USER
ALTER DATABASE NDS_DATH SET COMPATIBILITY_LEVEL = 130
ALTER DATABASE NDS_DATH SET MULTI_USER 
GO

USE NDS_DATH
GO


CREATE TABLE Source_NDS
(
	Source_ID INT IDENTITY(1,1) PRIMARY KEY,
	Source_Name VARCHAR(50)
)

INSERT INTO dbo.Source_NDS
VALUES ('Codebook'), ('Accidents'), ('Casualties'), ('Vehicles'), ('Postcodes'), ('WikiPostcodes'), ('PostcodeDistrict'), ('LSOA')

CREATE TABLE Area
(
	Area_ID INT IDENTITY(1,1) PRIMARY KEY,
	CODE_NK  VARCHAR(50),
	LABEL VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS, 
	[Create_time] datetime,
	[Update_time] DATETIME
)

CREATE TABLE Severity
(
	Severity_ID INT IDENTITY(1,1) PRIMARY KEY,
	CODE_NK  VARCHAR(50),
	LABEL VARCHAR(50),
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS, 
	[Create_time] datetime,
	[Update_time] DATETIME
)

CREATE TABLE Local_Authority_Highway
(
	Local_Authority_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE RoadType
(
	RoadType_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE CasualtiesClass
(
	CasualtiesClass_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE AgeBand
(
	AgeBand_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS 
)

CREATE TABLE VehicleType
(
	VehicleType_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE CasualtyType
(
	CasualtyType INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(100),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE JourneyPurpose
(
	JourneyPurpose_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK VARCHAR(50),
	Label VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE PoliceForce
( 
	PoliceForce_ID INT IDENTITY(1,1) PRIMARY KEY,
	Code_NK NVARCHAR(50),
	Label NVARCHAR(150),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Region
(
	Region_ID INT IDENTITY(1,1) PRIMARY KEY,
	Region_NK VARCHAR(50),
	RegionName VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Country
(
	Country_ID INT IDENTITY(1,1) PRIMARY KEY,
	Country_NK VARCHAR(50),
	CountryName VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE County
(
	County_ID INT IDENTITY(1,1) PRIMARY KEY,
	County_NK VARCHAR(50),
	CountyName VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Town
(
	Town_ID INT IDENTITY(1,1) PRIMARY KEY,
	Town_NK VARCHAR(50),
	TownName VARCHAR(50),
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Postcode
(
	Postcode_ID INT IDENTITY (1,1) PRIMARY KEY,
	Postcode VARCHAR(50),
	Latitude VARCHAR(50),
	Longtitude VARCHAR(50),
	Easting VARCHAR(50),
	Northing VARCHAR(50),
	TownID INT FOREIGN KEY REFERENCES dbo.Town,
	CountyID INT FOREIGN KEY REFERENCES dbo.County,
	CountryID INT FOREIGN KEY REFERENCES dbo.Country,
	RegionID INT FOREIGN KEY REFERENCES dbo.Region,
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE LSOA_Mapping
(
	LSOA VARCHAR(50) UNIQUE,
	Postcode_ID INT FOREIGN KEY REFERENCES dbo.Postcode,
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)


CREATE TABLE Accidents
(
	Accident_ID INT IDENTITY (1,1) PRIMARY KEY,
	Accident_NK VARCHAR(50),
	Accident_Easting VARCHAR(50),
	Accident_Northing VARCHAR(50),
	Accident_Longtitude VARCHAR(50),
	Accident_Latitude VARCHAR(50),
	Accident_Severity INT FOREIGN KEY REFERENCES dbo.Severity,
	Date DATE,
	Time TIME,
	Local_Authority INT FOREIGN KEY REFERENCES dbo.Local_Authority_Highway,
	RoadType INT FOREIGN KEY REFERENCES dbo.RoadType,
	SpeedLimit INT,
	Build_Up_Road VARCHAR(50),
	Postcode_ID INT FOREIGN KEY REFERENCES dbo.Postcode,
	Police_ID INT FOREIGN KEY REFERENCES dbo.PoliceForce,
	[Create_time] datetime,
	[Update_time] DATETIME,
	NumberOfCasualties INT,
	AreaID INT FOREIGN KEY REFERENCES dbo.Area,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Casualties
(
	Casualties_ID INT IDENTITY(1,1) PRIMARY KEY,
	Accident_ID INT FOREIGN KEY REFERENCES dbo.Accidents,
	Casualty_Class INT FOREIGN KEY REFERENCES dbo.CasualtiesClass,
	Sex VARCHAR(10),
	Age INT,
	AgeBand INT FOREIGN KEY REFERENCES dbo.AgeBand,
	CasualtyType INT FOREIGN KEY REFERENCES dbo.CasualtyType,
	CasualtySeverity INT FOREIGN KEY REFERENCES dbo.Severity
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)

CREATE TABLE Vehicle
(
	Vehicle_ID INT IDENTITY(1,1) PRIMARY KEY,
	Accident_ID INT FOREIGN KEY REFERENCES dbo.Accidents,
	VehicleType INT FOREIGN KEY REFERENCES dbo.VehicleType,
	JourneyPurpose INT FOREIGN KEY REFERENCES dbo.JourneyPurpose,
	Driver_sex VARCHAR(10),
	Driver_Age INT,
	AgeBand INT FOREIGN KEY REFERENCES dbo.AgeBand,
	EngineCapacity VARCHAR(50),
	VehicleAge INT,
	[Create_time] datetime,
	[Update_time] DATETIME,
	Source_ID INT FOREIGN KEY REFERENCES dbo.Source_NDS
)
