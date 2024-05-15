create database task;
use task;
select count(*) from data;

alter table coronadataset1 rename to data;
select * from data;

-- Q1. Write a code to check NULL values
SELECT * from data 
WHERE 'Province' IS NULL OR
'Country/Region' IS NULL OR
'Latitude' IS NULL OR
'Longitute' IS NULL OR
'Date' IS NULL OR
'Deaths' IS NULL OR
'Recovered' IS NULL;

-- Q2. If NULL values are present, update them with zeros for all columns. 
-- In this NULL values are not present but we can use the below query to update with zeros.
UPDATE data
SET Province = IFNULL(Province, 0),
    `Country/Region` = IFNULL(`Country/Region`, 0),
    Latitude = IFNULL(Latitude, 0),
    Longitude = IFNULL(Longitude, 0),
    Date = IFNULL(Date, 0),
    Deaths = IFNULL(Deaths, 0),
    Recovered = IFNULL(Recovered, 0);

-- Q3. check total number of rows
SELECT COUNT(*) FROM data;
    
-- Q4. Check what is start_date and end_date
-- Convert existing dates to the correct format
UPDATE data
SET Date = STR_TO_DATE(Date, '%d-%m-%Y');
-- Alter the table to change the data type of the Date column
ALTER TABLE data
MODIFY COLUMN Date DATE;

SELECT MIN(Date) as 'Start Date', MAX(Date) as 'End Date' FROM data;

-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT MONTH(Date)) AS num_months FROM data; -- Count is 12
SELECT Month(Date) as Month , COUNT(*) as NumberofMonths FROM data GROUP BY Month;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    AVG(Confirmed) AS Avg_Confirmed,
    AVG(Deaths) AS Avg_Deaths,
    AVG(Recovered) AS Avg_Recovered
FROM data
GROUP BY Year, Month;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    SUBSTRING_INDEX(GROUP_CONCAT(Confirmed ORDER BY confirmed DESC), ',', 1) AS most_frequent_confirmed,
    SUBSTRING_INDEX(GROUP_CONCAT(Deaths ORDER BY deaths DESC), ',', 1) AS most_frequent_deaths,
    SUBSTRING_INDEX(GROUP_CONCAT(Recovered ORDER BY recovered DESC), ',', 1) AS most_frequent_recovered
FROM data
GROUP BY year, month;

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT YEAR(Date) as Year, 
MIN(Confirmed), MIN(deaths), MIN(recovered) FROM data GROUP BY Year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT YEAR(Date) as Year, 
MAX(Confirmed) as ConfirmedMax, MAX(deaths) as DeathMax, MAX(recovered) as RecoveredMax
FROM data GROUP BY Year;

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT MONTH(Date) AS Month,
SUM(Confirmed) as TotalConfirmed, SUM(deaths) as TotalDeaths, SUM(recovered) as TotalRecovered
FROM data
GROUP BY Month;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    SUM(Confirmed) AS total_confirmed_cases,
    AVG(Confirmed) AS average_confirmed_cases,
    VARIANCE(Confirmed) AS variance_confirmed_cases,
    STDDEV(Confirmed) AS std_dev_confirmed_cases
FROM data;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
	MONTH(Date) AS Month,
    SUM(deaths) AS total_death_cases,
    AVG(deaths) AS average_death_cases,
    VARIANCE(deaths) AS variance_death_cases,
    STDDEV(deaths) AS std_dev_death_cases
FROM data GROUP BY Month;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    SUM(recovered) AS total_recovered_cases,
    AVG(recovered) AS average_recovered_cases,
    VARIANCE(recovered) AS variance_recovered_cases,
    STDDEV(recovered) AS std_dev_recovered_cases
FROM data;

-- Q14. Find Country having highest number of the Confirmed case
SELECT 
    `Country/Region` AS country,
    SUM(Confirmed) AS highest_confirmed_cases
FROM data
GROUP BY `Country/Region`
ORDER BY highest_confirmed_cases DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT 
    `Country/Region` AS country,
    SUM(deaths) AS lowest_death_cases
FROM data
GROUP BY `Country/Region`
ORDER BY lowest_death_cases
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT 
    `Country/Region` AS country,
    SUM(recovered) AS highest_cases
FROM data
GROUP BY `Country/Region`
ORDER BY highest_cases DESC
LIMIT 5;















































