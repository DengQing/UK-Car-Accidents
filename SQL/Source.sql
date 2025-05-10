use master
if DB_ID ('Source_DATH') is not null
	drop database Source_DATH

create database Source_DATH
go
use Source_DATH

CREATE TABLE [Accidents1114] (
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
    [LSOA_of_Accident_Location] varchar(50),
	[Create_time] datetime,
	[Update_time] datetime
)
GO

CREATE TABLE [PCD_OA_LSOA_MSOA_LAD_AUG21_UK_LU] (
    [pcd7] varchar(50),
    [pcd8] varchar(50),
    [pcds] varchar(50),
    [dointr] varchar(50),
    [doterm] varchar(50),
    [usertype] varchar(50),
    [oa11cd] varchar(50),
    [lsoa11cd] varchar(50),
    [msoa11cd] varchar(50),
    [ladcd] varchar(50),
    [lsoa11nm] varchar(50),
    [msoa11nm] varchar(50),
    [ladnm] varchar(50),
    --[ladnmw] varchar(100),
	[Create_time] datetime,
	[Update_time] datetime
)

CREATE TABLE [Casualties1114] (
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
    [Casualty_Home_Area_Type] varchar(50),
	[Create_time] datetime,
	[Update_time] datetime
)

CREATE TABLE [Vehicles1114] (
    [Accident_Index] varchar(50),
    [Vehicle_Reference] varchar(50),
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
    [Driver_Home_Area_Type] varchar(50),
	[Create_time] datetime,
	[Update_time] datetime
)

CREATE TABLE [postcodes] (
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
    [region_name] varchar(50),
	[Create_time] datetime,
	[Update_time] datetime
)

CREATE TABLE [Wiki_Postcodes] (
    [Postcode area] varchar(255),
    [Postcode districts] varchar(255),
    [Post town] varchar(255),
    [Former postal county] varchar(255),
    [create_time] datetime,
    [update_time] datetime
)
DROP TABLE dbo.Postcode_district
CREATE TABLE [Postcode_district] (
    [Postcode] varchar(255),
    [Latitude] varchar(50),
    [Longitude] varchar(50),
    [Easting] varchar(50),
    [Northing] varchar(50),
    [Grid Reference] varchar(255),
    [Town Area] varchar(255),
    [Region] varchar(255),
    [Postcodes] varchar(255),
    [Active postcodes] varchar(50),
    [Population] varchar(50),
    [Households] varchar(50),
    [Nearby districts] varchar(255),
    [UK region] varchar(255),
    [Create_time] datetime,
    [Update_time] datetime
)