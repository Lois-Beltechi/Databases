use [Handball_CH]

SELECT * from Fan
SELECT * from FanOfPlayer
SELECT * from Player 
-- d) LEFT JOIN
--Print all Fan Names and the player_id they like along with its player Golden Globe Votes from this year to see if performance is influencing their choices
Select F.name,FOP.pid, P.golden_globe_votes  
from Fan F
left join FanOfPlayer FOP on F.fid=FOP.fid
left join Player P on P.pid=FOP.pid
