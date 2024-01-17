# Team Performance :  Team ID, Team, match played, Match win, Match lost, % win
# Bowler performance : Bowler name, team, match played, ball placed, wicket taken, wicket per match, best performance in one match
# Batsman performance : Batsman, team, match played, strike count, total ball faced, average run, total run, best performance in any match
# Bowler VS Batsman :  Batsman, team, match played, Batsman out by bowler, average ball played, bowler name


# Team Performance
 
 select MT.Team_ID, T.Team_Name, Count(MT.Match_Id) AS Match_Played, 
		Sum(CASE WHEN M.Match_Winner_ID IS NOT NULL THEN 1 ELSE 0 END) AS Match_Win,
        Sum(CASE WHEN M.Match_Winner_ID IS NULL THEN 1 ELSE 0 END) AS Match_Lost,
        (Sum(CASE WHEN M.Match_Winner_ID IS NOT NULL THEN 1 ELSE 0 END) / Count(MT.Match_Id))*100 AS Percentage_Win
 from  
 (
	 select Match_ID, Team_Name_ID AS Team_ID from matches
	 UNION 
	 select Match_ID, Opponent_Team_ID AS Team_ID from matches
) AS MT
INNER JOIN Team AS T
	ON T.Team_ID = MT.Team_ID
LEFT OUTER JOIN matches AS M	
	ON M.Match_ID = MT.Match_ID
    AND M.Match_Winner_ID = MT.Team_ID
Group by MT.Team_ID, T.Team_Name;

#Bowler Performance 

select 	P.player_id,
		p.Player_name AS Bowler_Name, 
		Count(DISTINCT b.Match_ID) AS Match_Played,
		count(*) AS Total_Ball, 
		Sum(Case When Player_Dissimal_Id IS NOT NULL THEN 1 ELSE 0 END) AS Wicket_Taken,
        Sum(Case When Player_Dissimal_Id IS NOT NULL THEN 1 ELSE 0 END) / Count(DISTINCT b.Match_ID) AS Wicket_Per_Match,
        Max(Wicket_Taken) AS Best_Performance,
        BP.Match_Id AS Best_Match
from ball_by_ball as b
INNER JOIN players as p
	on P.player_id = b.Bowler_Id
INNER JOIN 
(	select Match_Id, Bowler_ID, Sum(Case When Player_Dissimal_Id IS NOT NULL THEN 1 ELSE 0 END) AS Wicket_Taken 
	FROM ball_by_ball
	Group BY Match_Id, Bowler_ID
) AS BP
	ON BP.Match_Id = b.Match_Id
    AND BP.Bowler_ID = b.Bowler_ID
Group By Bowler_Name;


# Batsman Performance
SELECT 
	p.player_id,p.player_Name,
	Sum(b.batsman_scored)as total_score, 
	Sum(CASE WHEN Batsman_scored = 6 then 1 else 0 END) AS no_of_sixes,
    Sum(CASE WHEN Batsman_scored = 4 then 1 else 0 END) AS no_of_fours,
    count( Distinct b.Match_Id) As Match_Played,
    Sum(b.batsman_scored)/count(Distinct b.Match_Id) AS Avg_score
 from players p
 join ball_by_ball b
 on p.player_Id = b.striker_Id
 group by p.player_id, player_Name
 order by total_score desc;
 
 #Batsman VS Bowler Performance
 
 select 	BM.Player_Name AS Batsman,
		BW.Player_Name AS Bowler, 
		Count(DISTINCT B.Match_Id) AS Match_Played,
        SUM(CASE WHEN Player_Dissimal_Id IS NOT NULL THEN 1 ELSE 0 END) AS Batsman_Out,
        Sum(Batsman_scored) AS Total_Run,
        Sum(Batsman_scored) / Count(DISTINCT B.Match_Id) AS Avg_Run_Per_Match, 
        Count(*) AS Total_Ball_Faced,
        Count(*) / Count(DISTINCT B.Match_Id) AS Avg_Ball_Played_Per_Match
from ball_by_ball AS B
INNER JOIN Players AS BM
	ON BM.Player_Id = B.Striker_Id
INNER JOIN Players AS BW
	ON BW.Player_Id = B.Bowler_Id
Group By Batsman, Bowler
 
 



 

 