create table emp_compensation (
emp_id int,
salary_component_type varchar(20),
val int
);
insert into emp_compensation
values (1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);
select * from emp_compensation;


select emp_id,
sum(case when salary_component_type="salary" then val else null end) as salary,
sum(case when salary_component_type="bonus" then val else null end) as bonus,
sum(case when salary_component_type="hike_percent" then val else null end) as hike_percent
into emp_pivot_compensation
from emp_compensation
group by emp_id;

-- In mysql

CREATE TABLE emp_pivot_compensation AS
SELECT emp_id,
       SUM(CASE WHEN salary_component_type = 'salary' THEN val ELSE NULL END) AS salary,
       SUM(CASE WHEN salary_component_type = 'bonus' THEN val ELSE NULL END) AS bonus,
       SUM(CASE WHEN salary_component_type = 'hike_percent' THEN val ELSE NULL END) AS hike_percent
FROM emp_compensation
GROUP BY emp_id;

select * from emp_pivot_compensation;

select * from (
select emp_id, 'salary' as salary_component, salary as val from emp_pivot_compensation
union all
select emp_id, 'bonus' as salary_component, bonus as val from emp_pivot_compensation
union all 
select emp_id, 'hike_percent' as salary_component, hike_percent as val from emp_pivot_compensation
) as q
order by emp_id;

