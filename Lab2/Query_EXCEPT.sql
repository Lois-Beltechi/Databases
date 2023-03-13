use [Handball_CH]

--c) two queries with the difference operation; use EXCEPT and NOT IN

select * from Player 
select * from Team
-- Countries with players but not team clubs: eg Player X is from Sweden but that player does not have a Team Club in Sweden ()
select country from Player
except
select team_country from Team

---- Countries with players but not team clubs (alternative)
--select team_country from Team
select distinct country from Player  
where country not in ('Romania', 'Bulgary')
