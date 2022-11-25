



use SQL_Project

/*
2. Sales cross Brands
*/

SELECT top 1 count(model_ID) over()  h from hyndai
SELECT top 1 count(model_ID) over() a  from audi
SELECT top 1 count(model_ID) over() b from bmw
SELECT top 1 count(model_ID) over() c from cclass
SELECT top 1 count(model_ID) over() m from merc


/*
3. Total Sales price b/w year
*/

SELECT  M.model_name , sum(H.price) Hyndai_price , count(H.model_ID) Sold_unit 
FROM models M
inner join hyndai H  on M.model_ID = H.model_ID
group by M.model_name



select T.transmission ,  F.fueltype,avg(mpg) from hyndai h inner join transmission T on H.transmission_ID = T.ID 
inner join fueltype F on F.fuel_ID = H.fuel_ID
 group by T.transmission ,  F.fueltype

 select * from hyndai

/*
4. Total Sales price b/w Type of Transmission
*/

SELECT  M.model_name , sum(H.price) Hyndai_price , count(H.model_ID) Sold_unit 
FROM models M
inner join hyndai H  on M.model_ID = H.model_ID
group by M.model_name




/*
5. No of units sold in each fuel type
*/


select fueltype , count(H.model_ID) Type_of_car_sold from fueltype F left join hyndai H 
on H.fuel_ID = F.fuel_ID where year = 2019
group by fueltype

select * from(
select fueltype , model_ID , year
from fueltype F inner join hyndai H 
on H.fuel_ID = F.fuel_ID)q
pivot 
(
count(model_id)
for fueltype in ([Diesel] , [Petrol] , [Hybrid],[Other],[Electric])
) pef
order by year



/*
6. WHich Transmission and fueltype are opt by customers 
*/

select T.transmission , F.fueltype ,  count (H.model_ID) from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID

group by T.transmission , F.fueltype

select T.transmission , F.fueltype ,  count (H.model_ID) from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
where year = 2017
group by T.transmission , F.fueltype



/*
7. Avg mpg for each Fueltype across year
*/
select * from(
select fueltype , mpg , year
from fueltype F inner join hyndai H 
on H.fuel_ID = F.fuel_ID)q
pivot 
(
avg(mpg)
for fueltype in ([Diesel] , [Petrol] , [Hybrid],[Other],[Electric])
) pef
order by year

/*
8.
*/

select * from(
select fueltype , mpg , transmission
from fueltype F inner join hyndai H 
on H.fuel_ID = F.fuel_ID
inner join transmission T on T.ID = H.transmission_ID)q
pivot 
(
avg(mpg)
for fueltype in ([Diesel] , [Petrol] , [Hybrid],[Other],[Electric])
) pef



select * from(
select fueltype , mpg , engineSize
from fueltype F inner join audi H 
on H.fuel_ID = F.fuel_ID
inner join transmission T on T.ID = H.transmission_ID)q
pivot 
(
avg(mpg)
for fueltype in ([Diesel] , [Petrol] , [Hybrid],[Other],[Electric])
) pef
order by engineSize

/*
9. Units Sold across each year
*/


select count(*) Count_sold from hyndai 



select Year , Sum(price) Count_sold from hyndai 
group by year order by year


select * from
(
select *,max(Count_sold) over () count_max from 
(
select Year , count(Model_id) Count_sold from hyndai 
group by year 
)q
)w


where Count_sold = count_max



/*
11. Avg Price difference B/w price and fuel type
*/
use SQL_Project


select * from (
SELECT  M.model_name , H.price , F.fueltype 
FROM models M
inner join hyndai H  on M.model_ID = H.model_ID
inner join fueltype F on F.fuel_ID = h.fuel_ID)q
pivot
(avg(price)
for Fueltype in ([diesel] , [Petrol] , [Hybrid])
)poup
order by model_name









/*
10 . Sales across each year
*/

select Year , Price , M.model_name from hyndai H inner join models M on M.model_ID = H.model_ID

select * from
(
select *,max(sales_price) over () max_price from 
(
select Year , sum(Price) Sales_price from hyndai 
group by year
)q
)w
where Sales_price = max_price

Select * from
(
select Year , Price , M.model_name from hyndai H inner join models M on M.model_ID = H.model_ID)q
pivot
(
sum(price)
for Year in ([2007],[2008],[2009],[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019])
)pivotyh




select * from (
select T.transmission , F.fueltype ,  H.model_ID from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
where year  = 2017)q
pivot
(
count(model_id)
for Fueltype in ([Diesel] , [Petrol] , [Hybrid],[Electric] ,[Other])
)poi

/*
12. Model sold the max in manual and petrol
*/

select m.model_name, count(H.model_ID) count_unit from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
inner join models M on M.model_ID = H.model_ID
where T.transmission = 'manual' and F.fueltype = 'Petrol' and year in (2016 , 2017 , 2018 , 2019 , 2020)
group by m.model_name


select m.model_name, count(H.model_ID) count_unit from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
inner join models M on M.model_ID = H.model_ID
where year in (2016 ,2017,2018, 2019,2020)
group by m.model_name
order by m.model_name


/*
13.Avg Mileage of the this type cars are 
*/

select m.model_name, Cast(avg(mpg) as int) avg_mpg  from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
inner join models M on M.model_ID = H.model_ID
where T.transmission = 'manual' and F.fueltype = 'Petrol' 
group by m.model_name


/*
14
*/

select model_name , avg_mileage_Run,finacial_expeniture , avg_price_car ,  (finacial_expeniture/avg_price_car) N_times_diff from 
(
select model_name , avg_mileage_Run,(avg_mileage_Run * 7.3) finacial_expeniture , avg_price_car from 
(
select m.model_name, avg(mileage) avg_mileage_Run, avg(mpg) avg_mpg , avg(price) avg_price_car from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
inner join models M on M.model_ID = H.model_ID
where T.transmission = 'manual' and F.fueltype = 'Petrol' and year = 2019
group by m.model_name
)q
)w


