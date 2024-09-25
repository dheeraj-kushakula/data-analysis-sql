create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

select Team_1 as Team_Name, case when Team_1=Winner then 1 else 0 end as win_flag
from icc_world_cup
union all 
select Team_2 as Team_Name, case when TEam_2=Winner then 1 else 0 end as win_flag
from icc_world_cup;


select Team_Name,count(1) as Matches_played, sum(win_flag) as no_of_matches_won, count(1) - sum(win_flag) as no_of_losses from
(select Team_1 as Team_Name, case when Team_1=Winner then 1 else 0 end as win_flag
from icc_world_cup
union all 
select Team_2 as Team_Name, case when TEam_2=Winner then 1 else 0 end as win_flag
from icc_world_cup) as a
group by Team_Name 
order by no_of_matches_won desc;

-- q: Draw match 
INSERT INTO icc_world_cup values('Eng','India','Draw');

select * from icc_world_cup;

select 
Team_1 as Team_Name, 
case when Team_1=Winner then 1 else 0 end as win_flag, 
case when Winner='Draw' then 1 else 0 end as draw_flag
from icc_world_cup
union all 
select 
Team_2 as Team_Name,
case when Team_2=Winner then 1 else 0 end as win_flag, 
case when Winner='Draw' then 1 else 0 end as draw_flag
from icc_world_cup;


with CTE as 
(select 
Team_1 as Team_Name, 
case when Team_1=Winner then 1 else 0 end as win_flag, 
case when Winner='Draw' then 1 else 0 end as draw_flag
from icc_world_cup
union all 
select 
Team_2 as Team_Name,
case when Team_2=Winner then 1 else 0 end as win_flag, 
case when Winner='Draw' then 1 else 0 end as draw_flag
from icc_world_cup)
select 
Team_Name, 
count(1) as Matches_played, 
sum(win_flag) as no_of_matches_won, 
sum(draw_flag) as no_of_draw_matches, 
count(1) - sum(win_flag) - sum(draw_flag) as no_of_losses
from CTE
group by Team_Name
order by no_of_matches_won desc;














