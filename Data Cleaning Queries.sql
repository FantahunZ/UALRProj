USE GlobalFood;
GO
-- Get number of countries in each data set
SELECT COUNT(DISTINCT Country)
FROM [dbo].[CO2_Data]

SELECT COUNT(DISTINCT Country)
FROM [dbo].[Maize_Production]

SELECT COUNT(DISTINCT Country)
FROM [dbo].[Maize_Yields]

SELECT COUNT(DISTINCT Country)
FROM [dbo].[Rice_Production]

SELECT COUNT(DISTINCT Country)
FROM [dbo].[Rice_Yields]

SELECT COUNT(DISTINCT Country)
FROM [dbo].[Surface_Temperature_Anomaly]

SELECT COUNT(DISTINCT Country)
FROM [dbo].[Wheat_Production]

SELECT COUNT(DISTINCT Country)
FROM [dbo].[Wheat_Yields]




-- Get countries which exist in all data sets - and also their counts (We got 113 countries)

SELECT COUNT(DISTINCT Country)
FROM
(
SELECT DISTINCT Country
FROM [dbo].[CO2_Data]
INTERSECT
SELECT DISTINCT Country
FROM [dbo].[Maize_Production]
INTERSECT
SELECT DISTINCT Country
FROM [dbo].[Maize_Yields]
INTERSECT
SELECT DISTINCT Country
FROM [dbo].[Rice_Production]
INTERSECT
SELECT DISTINCT Country
FROM [dbo].[Rice_Yields]
INTERSECT
SELECT DISTINCT Country
FROM [dbo].[Surface_Temperature_Anomaly]
INTERSECT
SELECT DISTINCT Country
FROM [dbo].[Wheat_Production]
INTERSECT
SELECT DISTINCT Country
FROM [dbo].[Wheat_Yields]
)X
GO
-- To make our subsequest queries simple to read, we created a view from the above INTERSECTs
CREATE VIEW vw_Countries
AS
	SELECT DISTINCT Country
	FROM [dbo].[CO2_Data]
	INTERSECT
	SELECT DISTINCT Country
	FROM [dbo].[Maize_Production]
	INTERSECT
	SELECT DISTINCT Country
	FROM [dbo].[Maize_Yields]
	INTERSECT
	SELECT DISTINCT Country
	FROM [dbo].[Rice_Production]
	INTERSECT
	SELECT DISTINCT Country
	FROM [dbo].[Rice_Yields]
	INTERSECT
	SELECT DISTINCT Country
	FROM [dbo].[Surface_Temperature_Anomaly]
	INTERSECT
	SELECT DISTINCT Country
	FROM [dbo].[Wheat_Production]
	INTERSECT
	SELECT DISTINCT Country
	FROM [dbo].[Wheat_Yields]

GO
-- To make appropriate comparisons, we opted to take countries that existed in all data sets
-- Thus remove countries not in all data sets as follows - Use the vw_Countries created above

DELETE FROM [dbo].[CO2_Data]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 11759 rows

DELETE FROM [dbo].[Maize_Production]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 5292 rows

DELETE FROM [dbo].[Maize_Yields]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 5289 rows

DELETE FROM [dbo].[Rice_Production]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 6176 rows

DELETE FROM [dbo].[Rice_Yields]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 6142 rows

DELETE FROM [dbo].[Surface_Temperature_Anomaly]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 13134 rows

DELETE FROM [dbo].[Wheat_Production]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 2598 rows

DELETE FROM [dbo].[Wheat_Yields]
WHERE Country NOT IN (SELECT Country FROM vw_Countries) -- Deleted 2586 rows



-- Check the data again
SELECT *
FROM [dbo].[CO2_Data]

SELECT *
FROM [dbo].[Maize_Production]

SELECT *
FROM [dbo].[Maize_Yields]

SELECT *
FROM [dbo].[Rice_Production]

SELECT *
FROM [dbo].[Rice_Yields]

SELECT *
FROM [dbo].[Surface_Temperature_Anomaly]

SELECT *
FROM [dbo].[Wheat_Production]

SELECT *
FROM [dbo].[Wheat_Yields]

-- The data should be cleaned further - so that the Year range will be consistent for all data sets and countries
-- For this we will start with the range of years for which data is available for each country in all the data sets

SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[CO2_Data]
	GROUP BY Country
	--ORDER BY Country
)X


SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Maize_Production]
	GROUP BY Country
	--ORDER BY Country
)X

SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Maize_Yields]
	GROUP BY Country
	--ORDER BY Country
)X

SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Rice_Production]
	GROUP BY Country
	--ORDER BY Country
)X

SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Rice_Yields]
	GROUP BY Country
	--ORDER BY Country
)X

SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year)[Year]
	FROM [dbo].[Surface_Temperature_Anomaly]
	GROUP BY Country
	--ORDER BY Country
)X

SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year)[Year]
	FROM [dbo].[Wheat_Production]
	GROUP BY Country
	--ORDER BY Country
)X
SELECT MAX([Year])
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Wheat_Yields]
	GROUP BY Country
	--ORDER BY Country
)X

---- Five countries - don't have data starting 1993 - all the rest (106 countries do)
-- 
SELECT *
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Wheat_Yields]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993
----------------------------------------------------

SELECT *
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Maize_Production]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993


SELECT *
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Maize_Yields]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993

SELECT *
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Rice_Production]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993


SELECT *
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Rice_Yields]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993


SELECT *
FROM
(
	SELECT Country, MIN(Year)[Year]
	FROM [dbo].[Surface_Temperature_Anomaly]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993

SELECT *
FROM
(
	SELECT Country, MIN(Year)[Year]
	FROM [dbo].[Wheat_Production]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993


SELECT *
FROM
(
	SELECT Country, MIN(Year) [Year]
	FROM [dbo].[Wheat_Yields]
	GROUP BY Country
	--ORDER BY Country
)X
WHERE [Year] > 1993

/*
	Final: Cleaned data
	1 - Taking Crop production between years 1993 and 2017 as most countries have data in that year range
	2 - We're eliminating countries which don't have crop yield and production information between 1993 and 2017
	3 - As such from the above identified 113 countries, five of them, viz. Montenegro, Serbia, Sudan, Luxembourg, Belgium and Denmark don't have 
	crop production and yield info between 1993 and 2017 - they only have in the below range
	Country			Year range
	Montenegro		2006-2018
	Serbia			2006-2018
	Sudan			2012-2018
	Luxembourg		2000-2018
	Belgium			2000-2018
	Denmark			2010-2018

As such removing them from the list

	Also, while we have CO2 and Surface temprature anomaly well before 1993, that will not help us in our analysis and thus will be removed from
	our range
	The below deletes will remove the out of bound data and those not satisfiying the date range requirements
*/

DELETE FROM [dbo].[CO2_Data]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

DELETE FROM [dbo].[Maize_Production]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

DELETE FROM [dbo].[Maize_Yields]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

DELETE FROM [dbo].[Rice_Production]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

DELETE FROM [dbo].[Rice_Yields]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

DELETE FROM [dbo].[Surface_Temperature_Anomaly]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

DELETE FROM [dbo].[Wheat_Production]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

DELETE FROM [dbo].[Wheat_Yields]
WHERE [Year] < 1993 OR Country IN ('Montenegro', 'Serbia', 'Sudan', 'Luxembourg', 'Belgium', 'Denmark')

-- The remaining data contains - Maize, Rice and Wheat yield and production data from 1993 to 2018
-- And CO2 and Surface temprature data of 106 countries from 1993 t0 2017
-- Now data is ready for analysis and visualization