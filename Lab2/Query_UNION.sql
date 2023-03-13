--->> QUERIES **
use [Handball_CH];
-- one query using the UNION operation
--a) two queries with the union operation; use UNION [ALL] and OR


-- In a Russian special organized fan meeting all russian players and the best players of the world are coming (status given by golden_glove_votes > 90).
-- The list of allowed attendants also includes russian fans
select * from Player 
select * from Fan 
--used distinct
select DISTINCT name from Player where country = 'Russia' or golden_globe_votes > 90
UNION ALL
select name from Fan where country = 'Russia'

---- All players from Russia or Romania (set UNION with OR)
--select name from Player where country = 'Russia' or country = 'Romania' -- OR IN WHERE
select * from Player 

select name
from Player
where Country='Russia' OR country='Romania'