create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int
);
INSERT INTO employee (emp_id, emp_name, dept_id, salary)
VALUES (1, 'Ankit', 100, 10000),
       (2, 'Mohit', 100, 15000),
       (3, 'Vikas', 100, 10000),
       (4, 'Rohit', 100, 5000),
       (5, 'Mudit', 200, 12000),
       (6, 'Agam', 200, 12000),
       (7, 'Sanjay', 200, 9000),
       (8, 'Ashish', 200, 5000);


select * from employee;

select emp_id, emp_name, dept_id, salary, 
RANK() OVER(order by salary desc) as rnk,
DENSE_RANK() OVER(order by salary desc) as dense_rnk,
ROW_NUMBER() OVER(order by salary desc) as row_num
from employee;


select emp_id, emp_name, dept_id, salary,
RANK() OVER(partition by dept_id order by salary desc) as rnk,
DENSE_RANK() OVER(partition by dept_id order by salary desc) as dense_rnk,
ROW_NUMBER() OVER(partition by dept_id order by salary desc) as row_num
from employee;

-- q:top salary by dept

select * from 
(select emp_id, emp_name, dept_id, salary,
RANK() OVER(partition by dept_id order by salary desc) as rnk
from employee) as r
where rnk = 1;



