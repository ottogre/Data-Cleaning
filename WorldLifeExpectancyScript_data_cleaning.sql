select *
from world_life_expectancy
;

        
select country,
       Year,
       concat(country, year),
       count(concat(country, year)) as duplicates
from world_life_expectancy
group by country,
		 Year,
         concat(country, year)
having duplicates > 1
;

        
        
select *
from(
	select Row_ID,
		   concat(country, year),
		   row_number() over(partition by concat(country, year) order by concat(country, year)) as Row_Num
	from world_life_expectancy
    ) as Row_table
where Row_num > 1
;
        
        
        
        
        
delete from world_life_expectancy
where Row_ID in (
                 select Row_ID
                 from(
	                   select Row_ID,
		                      concat(country, year),
		                      row_number() over(partition by concat(country, year) order by concat(country, year)) as Row_Num
					   from world_life_expectancy
							) as Row_table
					   where Row_num > 1
                       )
;



select *
from world_life_expectancy
;

select *
from world_life_expectancy
where status = ''
;


select distinct(status)
from world_life_expectancy
where status <> ''
;


select distinct(country)
from world_life_expectancy
where status = 'Developing'
;


update world_life_expectancy
set status = 'Developing'
where Country in (select distinct(country)
                  from world_life_expectancy
                  where status = 'Developing')
;



update world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
set t1.status = 'Developing'
where t1.status = ''
and t2.status <> ''
and t2.status = 'Developing'
;


update world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
set t1.status = 'Developed'
where t1.status = ''
and t2.status <> ''
and t2.status = 'Developed'
;



select *
from world_life_expectancy
where `Life expectancy` = ''
;



select Country,
       Year,
	   `Life expectancy`
from world_life_expectancy
#where `Life expectancy` = ''
;


select t1.Country, t1.Year, t1.`Life expectancy`, 
	   t2.Country, t2.Year, t2.`Life expectancy`,
       t3.Country, t3.Year, t3.`Life expectancy`,
       round((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1)
from world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
    and t1.Year = t2.Year -1
join world_life_expectancy t3
	on t1.Country = t3.Country
    and t1.Year = t3.Year +1
where t1.`Life expectancy` = ''
;


update world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
    and t1.Year = t2.Year -1
join world_life_expectancy_stagingworld_life_expectancy t3
	on t1.Country = t3.Country
    and t1.Year = t3.Year +1
set t1.`Life expectancy` =  round((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1)
where t1.`Life expectancy` =''


