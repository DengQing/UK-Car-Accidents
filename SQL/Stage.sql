use master
GO

if DB_ID ('Stage_DATH') is not null
	drop database Stage_DATH
GO

create database Stage_DATH
GO


ALTER DATABASE Stage_DATH SET SINGLE_USER
ALTER DATABASE Stage_DATH SET COMPATIBILITY_LEVEL = 130
ALTER DATABASE Stage_DATH SET MULTI_USER 
GO

use Stage_DATH

CREATE TABLE [Vehicles] (
    [Accident_Index] varchar(50),
    [Vehicle_Type] varchar(50),
    [Towing_and_Articulation] varchar(50),
    [Vehicle_Manoeuvre] varchar(50),
    [Vehicle_Location-Restricted_Lane] varchar(50),
    [Junction_Location] varchar(50),
    [Skidding_and_Overturning] varchar(50),
    [Hit_Object_in_Carriageway] varchar(50),
    [Vehicle_Leaving_Carriageway] varchar(50),
    [Hit_Object_off_Carriageway] varchar(50),
    [1st_Point_of_Impact] varchar(50),
    [Was_Vehicle_Left_Hand_Drive?] varchar(50),
    [Journey_Purpose_of_Driver] varchar(50),
    [Sex_of_Driver] varchar(50),
    [Age_of_Driver] varchar(50),
    [Age_Band_of_Driver] varchar(50),
    [Engine_Capacity_(CC)] varchar(50),
    [Propulsion_Code] varchar(50),
    [Age_of_Vehicle] varchar(50),
    [Driver_IMD_Decile] varchar(50),
    [Driver_Home_Area_Type] varchar(50)
)


CREATE TABLE [Accidents] (
    [Accident_Index] varchar(50),
    [Location_Easting_OSGR] varchar(50),
    [Location_Northing_OSGR] varchar(50),
    [Longitude] varchar(50),
    [Latitude] varchar(50),
    [Police_Force] varchar(50),
    [Accident_Severity] varchar(50),
    [Number_of_Vehicles] varchar(50),
    [Number_of_Casualties] varchar(50),
    [Date] varchar(50),
    [Day_of_Week] varchar(50),
    [Time] varchar(50),
    [Local_Authority_(District)] varchar(50),
    [Local_Authority_(Highway)] varchar(50),
    [1st_Road_Class] varchar(50),
    [1st_Road_Number] varchar(50),
    [Road_Type] varchar(50),
    [Speed_limit] varchar(50),
    [Junction_Detail] varchar(50),
    [Junction_Control] varchar(50),
    [2nd_Road_Class] varchar(50),
    [2nd_Road_Number] varchar(50),
    [Pedestrian_Crossing-Human_Control] varchar(50),
    [Pedestrian_Crossing-Physical_Facilities] varchar(50),
    [Light_Conditions] varchar(50),
    [Weather_Conditions] varchar(50),
    [Road_Surface_Conditions] varchar(50),
    [Special_Conditions_at_Site] varchar(50),
    [Carriageway_Hazards] varchar(50),
    [Urban_or_Rural_Area] varchar(50),
    [Did_Police_Officer_Attend_Scene_of_Accident] varchar(50),
    [LSOA_of_Accident_Location] varchar(50)
)

CREATE TABLE [Casualties] (
    [Accident_Index] varchar(50),
    [Vehicle_Reference] varchar(50),
    [Casualty_Reference] varchar(50),
    [Casualty_Class] varchar(50),
    [Sex_of_Casualty] varchar(50),
    [Age_of_Casualty] varchar(50),
    [Age_Band_of_Casualty] varchar(50),
    [Casualty_Severity] varchar(50),
    [Pedestrian_Location] varchar(50),
    [Pedestrian_Movement] varchar(50),
    [Car_Passenger] varchar(50),
    [Bus_or_Coach_Passenger] varchar(50),
    [Pedestrian_Road_Maintenance_Worker] varchar(50),
    [Casualty_Type] varchar(50),
    [Casualty_Home_Area_Type] varchar(50)
)

CREATE TABLE [PostCodes] (
    [postcode] varchar(50),
    [easting] varchar(50),
    [northing] varchar(50),
    [latitude] varchar(50),
    [longitude] varchar(50),
    [city] varchar(50),
    [county] varchar(50),
    [country_code] varchar(50),
    [country_name] varchar(50),
    [iso3166-2] varchar(50),
    [region_code] varchar(50),
    [region_name] varchar(50)
)

CREATE TABLE [PCD_LSOA] (
    [pcds] varchar(50),
    [lsoa11cd] varchar(50),
)
------
DROP TABLE Wiki_Postcodes

CREATE TABLE [Wiki_Postcodes] (
    [Postcode districts] varchar(255),
    [County] varchar(50)
)
GO

CREATE TABLE [Postcode_district] (
    [Postcode] varchar(50),
    [Town] varchar(50),
	[Region] varchar(50)
)
GO

use Stage_DATH
GO

CREATE PROC Wiki_Split_SingleRow
AS
DECLARE 
 @pcd VARCHAR(255),
 @split_pcd VARCHAR(50),
 @pcounty VARCHAR(50)
BEGIN
	DECLARE Raw_pcd CURSOR FOR 
	SELECT * FROM dbo.Wiki_Postcodes
	WHERE [Postcode districts] LIKE '%,%'

	OPEN Raw_pcd
	FETCH NEXT FROM Raw_pcd INTO @pcd, @pcounty
	WHILE @@FETCH_STATUS = 0
		BEGIN

			SELECT @pcounty = TRIM('()' FROM @pcounty) --Remove () from string

			DECLARE S_CURSOR CURSOR FOR
			SELECT * FROM STRING_SPLIT(@pcd,',')

			OPEN S_CURSOR
			FETCH NEXT FROM S_CURSOR INTO @split_pcd
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					SELECT @split_pcd = TRIM(' ' FROM @split_pcd) --Remove space at begin of char

					INSERT INTO dbo.Wiki_Postcodes
					VALUES (@split_pcd,@pcounty)
					FETCH NEXT FROM S_CURSOR INTO @split_pcd
				END
			CLOSE S_CURSOR
			DEALLOCATE S_CURSOR

			DELETE FROM dbo.Wiki_Postcodes
			WHERE [Postcode districts] = @pcd

			FETCH NEXT FROM Raw_pcd INTO @pcd, @pcounty
		END

	CLOSE Raw_pcd
	DEALLOCATE Raw_pcd
END
GO

