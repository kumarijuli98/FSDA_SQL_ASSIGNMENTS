use projects;

SET GLOBAL local_infile=1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
select version();

drop table Accidents;

Create table Accidents(
Accident_Index	VARCHAR(20),
Location_Easting_OSGR	int,
Location_Northing_OSGR	int,
Longitude	Decimal,
Latitude	Decimal,
Police_Force	int,
Accident_Severity	int,
Number_of_Vehicles	int,
Number_of_Casualties	int,
Date	VARCHAR(20),
Day_of_Week	int,
Time	time,
Local_Authority_District	int,
Local_Authority_Highway	VARCHAR(200),
1st_Road_Class	int,
1st_Road_Number	int,
Road_Type	int,
Speed_limit	int,
Junction_Detail	int,
Junction_Control	int,
2nd_Road_Class	int,
2nd_Road_Number	int,
Pedestrian_Crossing_Human_Control	int,
Pedestrian_Crossing_Physical_Facilities	int,
Light_Conditions	int,
Weather_Conditions	int,
Road_Surface_Conditions	int,
Special_Conditions_at_Site	int,
Carriageway_Hazards	int,
Urban_or_Rural_Area	int,
Did_Police_Officer_Attend_Scene_of_Accident	int,
LSOA_of_Accident_Location	VARCHAR(50));

LOAD DATA INFILE 'D:/work/SQL/project/UK Road Safty/Accidents.csv'
INTO TABLE Accidents
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SHOW VARIABLES LIKE "secure_file_priv"; 





Create table Vehicles (
Accident_Index	VARCHAR(20),
Vehicle_Reference	int,
Vehicle_Type	int,
Towing_and_Articulation	int,
Vehicle_Manoeuvre	int,
Vehicle_Location_Restricted_Lane	int,
Junction_Location	int,
Skidding_and_Overturning	int,
Hit_Object_in_Carriageway	int,
Vehicle_Leaving_Carriageway	int,
Hit_Object_off_Carriageway	int,
1st_Point_of_Impact	int,
Was_Vehicle_Left_Hand_Drive	int,
Journey_Purpose_of_Driver	int,
Sex_of_Driver	int,
Age_of_Driver	int,
Age_Band_of_Driver	int,
Engine_Capacity_CC	int,
Propulsion_Code	int,
Age_of_Vehicle	int,
Driver_IMD_Decile	int,
Driver_Home_Area_Type	int,
Vehicle_IMD_Decile	int);

LOAD DATA INFILE 'D:/work/SQL/project/UK Road Safty/Vehicles.csv'
INTO TABLE Vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from Accidents;
describe Accidents_2015;
select * from Vehicles;
select * from vehicle_types;


/* Create index on accident_index as it is using in both vehicles and accident tables and join clauses using indexes will perform faster */
CREATE INDEX accident_index
ON Accidents(accident_index);

CREATE INDEX accident_index
ON Vehicles(accident_index);


select* from vehicle_types;

--- view for analyses the median severity value of accidents caused by various Motorcycles.

CREATE VIEW median_severity AS
SELECT  accidents.accident_severity,Vehicles.Vehicle_Type
FROM accidents INNER JOIN  Vehicles ON
Accidents.Accident_Index= Vehicles.Accident_Index;



###1. Evaluate the median severity value of accidents caused by various Motorcycles.
select * from median_severity;

select * from Accidents;
describe Accidents_2015;
select * from Vehicles;
select * from vehicle_types;

#### 2.get Accident Severity and Total Accidents per Vehicle Type 

SELECT  accidents.accident_severity as 'severity',Vehicles.Vehicle_Type,
count(Vehicles.Vehicle_Type) as 'Total Accidents'
FROM accidents 
JOIN  Vehicles ON
Accidents.Accident_Index= Vehicles.Accident_Index
join vehicle_types on
vehicle_types.code= Vehicles.Vehicle_Type
group by 1,2
ORDER BY 3;

## 3. Average Severity by vehicle type 

SELECT  (accidents.accident_severity) as 'Avg_severity',Vehicles.Vehicle_Type,
(Vehicles.Vehicle_Type) as 'Total Accidents'
from Accidents
JOIN  Vehicles ON
Accidents.Accident_Index= Vehicles.Accident_Index
join vehicle_types on
vehicle_types.code= Vehicles.Vehicle_Type
group by 1,2
having count(vehicle_type) and avg(accidents.accident_severity)
ORDER BY 3 desc;


## 4. Average Severity and Total Accidents by Motorcyle */

SELECT  (accidents.accident_severity) as 'Avg_severity',Vehicles.Vehicle_Type , vehicle_types.label as 'Motorcycles',
(Vehicles.Vehicle_Type) as 'Total Accidents'
from Accidents
JOIN  Vehicles ON
Accidents.Accident_Index= Vehicles.Accident_Index
join vehicle_types on
vehicle_types.code= Vehicles.Vehicle_Type
group by 1,2,3,4
having count(vehicle_type) and avg(accidents.accident_severity) 
ORDER BY 3 desc;

SELECT (accidents.accident_severity )as 'severity',
(Vehicles.Vehicle_Type) as 'Total Accidents',vehicle_types.label as 'Motorcycles'
FROM accidents 
JOIN  Vehicles ON
Accidents.Accident_Index= Vehicles.Accident_Index
join vehicle_types on
vehicle_types.code= Vehicles.Vehicle_Type
group by 1,2,3
ORDER BY 3 desc;