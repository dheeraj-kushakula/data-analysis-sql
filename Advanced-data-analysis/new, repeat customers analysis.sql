create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders;

with first_order as 
(select customer_id, min(order_date) as first_visit_date 
from customer_orders
group by customer_id),
visit_flag as 
(select cu.customer_id, cu.order_date, fi.first_visit_date,
CASE WHEN cu.order_date=fi.first_visit_date then 1 else 0 end as first_visit_flag,
CASE WHEN cu.order_date!=fi.first_visit_date then 1 else 0 end as repeat_visit_flag
from customer_orders cu
inner join 
first_order fi on cu.customer_id = fi.customer_id)
select order_date, sum(first_visit_flag) as no_of_first_visits, sum(repeat_visit_flag) as no_of_repeat_visits
from visit_flag
group by order_date;

-- or to simplify

select * from customer_orders;

with first_orders as 
(select customer_id, min(order_date) as first_visit_date
from customer_orders 
group by customer_id)
select cu.order_date,
sum(case when cu.order_date=fi.first_visit_date then 1 else 0 end) as no_of_first_visits,
sum(case when cu.order_date!=fi.first_visit_date then 1 else 0 end) as no_of_repeat_visits
from customer_orders cu
inner join
first_orders fi on cu.customer_id = fi.customer_id
group by cu.order_date;

-- q: find Amount of first and repeat visit customers

with first_orders as 
(select customer_id, min(order_date) as first_visit_date
from customer_orders 
group by customer_id)
select cu.order_date,
sum(case when cu.order_date=fi.first_visit_date then 1 else 0 end) as no_of_first_visits,
sum(case when cu.order_date!=fi.first_visit_date then 1 else 0 end) as no_of_repeat_visits,
sum(case when cu.order_date=fi.first_visit_date then order_amount else 0 end) as first_visit_order_amount,
sum(case when cu.order_date!=fi.first_visit_date then order_amount else 0 end) as repeat_visit_order_amount
from customer_orders cu
inner join
first_orders fi on cu.customer_id = fi.customer_id
group by cu.order_date;





