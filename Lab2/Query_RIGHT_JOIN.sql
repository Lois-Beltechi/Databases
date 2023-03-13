use [Handball_CH]

--RIGHT JOIN

select * from match 
select * from training 

-- Print matches that have trainings (by having same date in column)... Some matches can be postponed (NULL value in Matches side), but the trainings are still 
-- going on
select M.mid, M.opponents, M.date as Match_date, T.date as Training_date
from Match M
right join Training T ON M.date=T.date and M.mid=T.mid