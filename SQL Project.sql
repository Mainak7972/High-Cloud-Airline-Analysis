Use Project;

SELECT 
    CAST(CONCAT(year_, '-', month_, '-', day_) AS DATE) AS Date_,
    Year_ AS `Year`,
    Month_ AS Month_no,
    MONTHNAME(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_),
                    '%Y-%m-%d')) AS `Month Name`,
    QUARTER(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_),
                '%Y-%m-%d')) AS `Quarter`,
    CONCAT(year_,
            '-',
            MONTHNAME(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_),
                            '%Y-%m-%d'))) AS `Year-Month`,
    DAYOFWEEK(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_),
                    '%Y-%m-%d')) AS Weekday_no,
    DAYNAME(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_),
                    '%Y-%m-%d')) AS Day_name,
    CASE
        WHEN month_ >= 4 THEN month_ - 3
        ELSE month_ + 9
    END AS financial_month,
    CASE
        WHEN month_ BETWEEN 4 AND 6 THEN 'Q1'
        WHEN month_ BETWEEN 7 AND 9 THEN 'Q2'
        WHEN month_ BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS financial_quarter,
    CASE
        WHEN
            DAYOFWEEK(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_),
                            '%Y-%m-%d')) IN (1 , 7)
        THEN
            'weekend'
        ELSE 'Weekday'
    END AS Daytype
    
FROM
    Maindata
order by Date_;

SELECT 
    Year_,
    (SUM(Transported_Passengers) / SUM(Available_seats) * 100) AS 'Load Factor'
FROM
    maindata
GROUP BY Year_;

    Select  QUARTER(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_), '%Y-%m-%d')) AS `Quarter_`,
		(sum(Transported_Passengers)/sum(Available_seats)*100) as 'Load Factor'
        from maindata
	group by Quarter_
    order by Quarter_ asc;
    
SELECT 
    Month_,
    (SUM(Transported_Passengers) / SUM(Available_seats) * 100) AS 'Load factor'
FROM
    maindata
GROUP BY Month_
ORDER BY month_ ASC;
   
SELECT 
    Carrier_Name,
    (SUM(Transported_Passengers) / SUM(Available_seats) * 100) AS 'Load_factor'
FROM
    maindata
GROUP BY Carrier_Name
ORDER BY Load_Factor DESC
LIMIT 10;

Select from_To_City, sum(Transported_Passengers) as Total_Passengers
From Maindata
group by From_to_city
order by Total_Passengers desc
limit 10;

SELECT 
    CASE
        WHEN
            DAYOFWEEK(STR_TO_DATE(CONCAT(year_, '-', month_, '-', day_),
                            '%Y-%m-%d')) IN (1 , 7)
        THEN
            'weekend'
        ELSE 'Weekday'
    END AS Daytype,
    SUM(Transported_Passengers) / SUM(Available_seats) * 100 AS Load_Factor
FROM
    Maindata
GROUP BY Daytype
ORDER BY Load_Factor ASC;




















