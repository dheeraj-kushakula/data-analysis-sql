create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;


with 
total_visit as 
(select name, count(1) as total_visits, GROUP_CONCAT(DISTINCT resources SEPARATOR ',') as resources_used from entries group by name),
floor_visit as 
(select name,floor,count(1) as no_of_visits,
rank() over(partition by name order by count(1) desc) as rnk
from entries
group by name,floor)
select fv.name, fv.floor as most_visited_floor, tv.total_visits, tv.resources_used
from floor_visit fv 
inner join 
total_visit tv on fv.name=tv.name
where rnk=1;



