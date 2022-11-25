create database SQL_Project;

use SQL_Project


select * from audi
select * from bmw
select * from cclass
select * from hyndai
select * from merc
select * from fueltype
select * from models
select * from transmission

SELECT * FROM transmission T
inner join hyndai H  on H.transmission_ID = T.ID
inner join audi A  on A.transmission_ID = T.ID
inner join bmw B  on B.transmission_ID = T.ID
inner join cclass C  on C.transmission_ID = T.ID
inner join merc M  on M.transmission_ID = T.ID
group by transmission


create view T_1 as
select transmission , H.price Hyndai_price,A.price Audi_price,
B.price BMW_price,C.price C_Class_price,
M.price Merc_price 
FROM transmission T
inner join hyndai H  on H.transmission_ID = T.ID
inner join audi A  on A.transmission_ID = T.ID
inner join bmw B  on B.transmission_ID = T.ID
inner join cclass C  on C.transmission_ID = T.ID
inner join merc M  on M.transmission_ID = T.ID




SELECT transmission , Sum(H.price) Hyndai_price 
FROM transmission T
left join hyndai H  on H.transmission_ID = T.ID
group by transmission


SELECT top 1 count(model_ID) over()  h from hyndai
SELECT top 1 count(model_ID) over() a  from audi
SELECT top 1 count(model_ID) over() b from bmw
SELECT top 1 count(model_ID) over() c from cclass
SELECT top 1 count(model_ID) over() m from merc

  


SELECT transmission , Sum(C.price) cclass_price 
FROM transmission T
inner join cclass C  on C.transmission_ID = T.ID
group by transmission


SELECT transmission , Sum(M.price) Merc_price 
FROM transmission T
inner join merc M  on M.transmission_ID = T.ID
group by transmission


/*
-----------------------------------------------
2.
-----------------------------------------------
*/


select * from fueltype
select * from hyndai

select fueltype , count(H.model_ID) Type_of_car_sold from fueltype F left join hyndai H 
on H.fuel_ID = F.fuel_ID
group by fueltype

/*
---------------------------------------------------
3.
---------------------------------------------------
*/

select * from
(
select *,max(Count_sold) over () count_max from 
(
select Year , count(Model_id) Count_sold from hyndai 
group by year 
)q
)w
where Count_sold = count_max

select Year , count(Model_id) Count_sold from hyndai 
group by year order by year


select * from
(
select *,max(sales_price) over () max_price from 
(
select Year , sum(Price) Sales_price from hyndai 
group by year
)q
)w
where Sales_price = max_price


select M.model_name , count(H.model_ID) from hyndai H inner join models M on M.model_ID = H.model_ID where year = 2020 group by M.model_name

select count(model_id) from hyndai where Year = 2019

select T.transmission , F.fueltype ,  count (H.model_ID) from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
where year = 2019
group by T.transmission , F.fueltype

select T.transmission , F.fueltype ,  count (H.model_ID) from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
where year = 2017
group by T.transmission , F.fueltype


select m.model_name, count(H.model_ID) count_unit from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
inner join models M on M.model_ID = H.model_ID
where T.transmission = 'manual' and F.fueltype = 'Petrol' and year in (2016 ,2017 ,2018,2020, 2019)
group by m.model_name


select m.model_name, avg(mpg) avg_mpg , avg(price) avg_price from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
inner join models M on M.model_ID = H.model_ID
where T.transmission = 'manual' and F.fueltype = 'Petrol' 
group by m.model_name




select model_ID , (mileage * 6 ), price from hyndai where year = 2019 and id = 38797
select * from hyndai where year = 2019 and id = 38797

select model_name , avg_mileage_Run,finacial_expeniture , avg_price_car ,  (finacial_expeniture/avg_price_car) N_times_diff from 
(
select model_name , avg_mileage_Run,(avg_mileage_Run * 8) finacial_expeniture , avg_price_car from 
(
select m.model_name, avg(mileage) avg_mileage_Run, avg(mpg) avg_mpg , avg(price) avg_price_car from hyndai H
inner join transmission T on H.transmission_ID = T.ID
inner join Fueltype F on F.fuel_ID = H.fuel_ID
inner join models M on M.model_ID = H.model_ID
where T.transmission = 'manual' and F.fueltype = 'Petrol' and year = 2019
group by m.model_name
)q
)w

 
