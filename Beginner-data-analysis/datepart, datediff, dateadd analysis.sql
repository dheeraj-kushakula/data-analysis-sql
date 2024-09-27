-- datepart, dateadd, datediff

-- select datepart(weekday,'2024-07-27'); 

-- select dateadd(week,2,'2024-07-27');

-- select datediff(week,'2024-07-01','2024-07-27');

create table customer_order (
order_id integer,
customer_id integer,
order_date date,
ship_date date);

insert into customer_order values(1000,1,cast('2022-01-05' as date),cast('2022-01-11' as date))
,(1001,2,cast('2022-02-04' as date),cast('2022-02-16' as date))
,(1002,3,cast('2022-01-01' as date),cast('2022-01-19' as date))
,(1003,4,cast('2022-01-06' as date),cast('2022-01-30' as date))
,(1004,1,cast('2022-02-07' as date),cast('2022-02-13' as date))
,(1005,4,cast('2022-01-07' as date),cast('2022-01-31' as date))
,(1006,3,cast('2022-02-08' as date),cast('2022-02-26' as date))
,(1007,2,cast('2022-02-09' as date),cast('2022-02-21' as date))
,(1008,4,cast('2022-02-10' as date),cast('2022-03-06' as date))
;

select *  from customer_order;
-- in days
select *, abs(datediff(order_date,ship_date)) as no_of_shipping_days from customer_order;
-- in weeks
SELECT *, FLOOR(ABS(DATEDIFF(ship_date, order_date)) / 7) AS no_of_shipping_weeks
FROM customer_order;

-- how many business days to ship excluding weekends

SELECT *,FLOOR(ABS(DATEDIFF(ship_date, order_date)) / 7) AS no_of_shipping_weeks  ,
DATEDIFF(ship_date, order_date) 
- (FLOOR((DATEDIFF(ship_date, order_date) + WEEKDAY(order_date)) / 7) * 2) 
- (CASE WHEN WEEKDAY(ship_date) = 6 THEN 1 ELSE 0 END)
- (CASE WHEN WEEKDAY(order_date) = 6 THEN 1 ELSE 0 END)  AS days_to_ship
FROM customer_order;


create table customer (
customer_id integer,
customer_name VARCHAR(10),
gender VARCHAR(1),
dob date);

insert into customer values
(1,'Rahul','M',cast('2000-01-05' as date))
,(2,'Shilpa','F',cast('2004-04-05' as date))
,(3,'Ramesh','M',cast('2003-07-07' as date))
,(4,'Katrina','F',cast('2005-02-05' as date))
,(5,'Alia','F',cast('1992-01-01' as date))
;

select * from customer;

select curdate();
 
SELECT *, TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM customer;


-- add business days
SELECT 
    CASE 
        WHEN DATEDIFF(DATE_ADD(order_date, INTERVAL business_days DAY), order_date) / 7 > 0 
        THEN DATE_ADD(order_date, INTERVAL business_days + 2 * FLOOR(DATEDIFF(DATE_ADD(order_date, INTERVAL business_days DAY), order_date) / 7) DAY)
        ELSE DATE_ADD(order_date, INTERVAL business_days DAY)
    END AS ship_date
FROM customer_order;

