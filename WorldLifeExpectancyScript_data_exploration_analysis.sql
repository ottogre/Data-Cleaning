SELECT * 
FROM world_life_expectancy
;


SELECT Country,
	   min(`Life expectancy`) as `Minimum Life Expectancy`,
       max(`Life expectancy`) as `Max Life Expectancy`,
	   round(max(`Life expectancy`) - min(`Life expectancy`),1) as `Life Increase over 15 Years`
FROM world_life_expectancy
group by Country
having min(`Life expectancy`) <> '0'
	and max(`Life expectancy`) <> '0'
order by `Life Increase over 15 Years` desc
;


SELECT
       Year,
       round(avg(`Life expectancy`),2) as `Average Per Year` 
FROM world_life_expectancy
where `Life expectancy` <> '0'
	and `Life expectancy` <> '0'
group by Year
order by Year
;



SELECT Country,
       round(avg(`Life expectancy`),1) as `Average Life Expectancy`,
       round(avg(GDP),1) as `Average GDP`
FROM world_life_expectancy
group by Country
having `Average GDP` > 0
	and `Average Life Expectancy` > 0
order by `Average GDP` desc
;




SELECT 
sum(case when GDP >= 1500 then 1 else 0 end) `High GDP Count`,
round(avg(case when GDP >= 1500 then `Life expectancy` else null end),2) `High GDP Count Life Expectancy`,
sum(case when GDP <= 1500 then 1 else 0 end) `High GDP Count`,
round(avg(case when GDP <= 1500 then `Life expectancy` else null end),2) `Low GDP Count Life Expectancy`
FROM world_life_expectancy
;


SELECT Status,
	   round(avg(`Life expectancy`),1) 
FROM world_life_expectancy
group by Status
;



SELECT Status,
       count(distinct Country) as `Country Count`,
	   round(avg(`Life expectancy`),1) as `Average Life Expectancy`
FROM world_life_expectancy
group by Status
;

SELECT Country,
       round(avg(`Life expectancy`),1) as `Average Life Expectancy`,
       round(avg(BMI),1) as `Average BMI`
FROM world_life_expectancy
group by Country
having `Average BMI` > 0
	and `Average Life Expectancy` > 0
order by `Average BMI` asc
;


SELECT Country,
       Year,
       `Life expectancy`,
       `Adult Mortality`,
       sum(`Adult Mortality`) over(partition by Country order by Year) as `Rolling Total`
FROM world_life_expectancy
where Country like '%United%'