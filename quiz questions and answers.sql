# WHO IS THE TOP BATSMAN BASED ON THE RUNS SCORED?
SELECT p.player_id,p.player_Name,sum(b.batsman_scored)as total_score
 from players p
 join ball_by_ball b
 on p.player_Id = b.striker_Id
 group by p.player_id
 order by total_score desc;
 select * from players;
 
 #WHO IS THE TOP BATSMAN BASED ON THE NUMBER OF SIXES?
 SELECT p.Player_id,p.Player_name,COUNT(b.Batsman_Scored) as no_of_sixes
 from players p
 join ball_by_ball b
 on p.Player_Id=b.Striker_Id
 where b.Batsman_scored = 6
 group by p.Player_Id
 order by no_of_sixes desc;
 
 #WHO IS THE TOP BATSMAN BASED ON THE NUMBER OF FOURS?
SELECT p.Player_id,p.Player_name,COUNT(b.Batsman_Scored) as no_of_fours
 from players p
 join ball_by_ball b
 on p.Player_Id=b.Striker_Id
 where b.Batsman_scored = 4
 group by p.Player_Id
 order by no_of_fours desc;
 
 select * from matches;
 #TEAM PERFORMANCE:TEAM_ID,TEAM MATCH PLAYED,MATCH WIN,MATCH LOST,PERCENTAGE WIN
 
 #1ST PART:NUMBER OF MATCHES PLAYED IN EACH SEASON
 select season_id,count(match_id)as no_of_matches_played
 from matches
 group by season_id;
  
 #2ND PART:COUNT OF MATCHES WON BY EACH TEAM, COUNT OF MATCHES THAT ARE DRAW 
 #AND WIN PERCENTAGE OF EACH TEAM
 select m.match_winner_Id,t.team_name, count(m.match_id)as match_won_count,
 concat(round((count(m.match_id)/577 * 100 ),2),'%')as percentage_win
 from matches m
 left join team t
 on m.match_winner_id = t.team_id
 group by match_winner_id
 order by count(m.match_id) desc;
 
 #BATSMAN PERFORMANCE:BATSMAN_ID,TEAM_ID,MATCH PLAYED,STRIKE COUNT,BALL FACED,AVERAGE RUN,TOTAL RUN,
 #BEST PERFORMANCE IN ANY MATCH
 SELECT * FROM BALL_BY_BALL;
 select b.striker_id,p.player_name,count(distinct b.match_id)as no_of_matches_played,
 sum(b.batsman_scored)as total_run, count(b.Player_dissimal_id)as no_of_outs,count(b.innings_id),
 dense_rank() over(order by sum(b.batsman_scored) desc)as batsman_rank
 from ball_by_ball b
 join players p
 on b.striker_id = p.player_id
 group by striker_id;
 
# BATTING AVERAGE 
Select b.striker_id,p.player_Name,(sum(b.batsman_scored))/(count(b.player_dissimal_id))AS batting_average
from ball_by_ball b
join players p
on b.striker_id = p.player_id
group by b.striker_id
order by batting_average desc;

select * from ball_by_ball;
#BOWLER PERFORMANCE:BOWLER NAME,TEAM,MATCH PLAYED,BALL PLACED,WICKET TAKEN,WICKET PER MATCH,
#BEST PERFORMANCE IN ANY MATCH
select b.bowler_id,p.player_name,count(distinct b.match_id)as no_of_matches_played,
count(ball_id)
from ball_by_ball b
join players p
on b.bowler_id = p.player_id
group by b.bowler_id;
