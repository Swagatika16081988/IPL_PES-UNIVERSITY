CREATE SCHEMA IF NOT EXISTS sports;
USE sports;
SET SQL_SAFE_UPDATES = 0;

 CREATE TABLE team (
  Team_Id int NOT NULL PRIMARY KEY,
  Team_Name VARCHAR(50),
  Team_Short_Code VARCHAR(5)
);

LOAD DATA INFILE 'C:\\PESMtech\\Presentation\\CSVfile\\team.csv' INTO TABLE team 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

CREATE TABLE players (
  Player_Id int NOT NULL PRIMARY KEY,
  Player_Name VARCHAR(50) NOT NULL,
  DOB int NOT NULL,
  Batting_Hand VARCHAR(25) NOT NULL,
  Bowling_Skill VARCHAR(25) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  Is_Umpire int NOT NULL,
  Column1 int DEFAULT NULL
);

LOAD DATA INFILE 'C:\\PESMtech\\Presentation\\CSVfile\\players.csv' INTO TABLE players 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Player_Id, Player_Name, DOB, Batting_Hand, Bowling_Skill, Country, Is_Umpire, @Column1 )
SET Column1 = NULLIF(TRIM(@Column1),'');

 CREATE TABLE season (
  Season_Id int NOT NULL PRIMARY KEY,
  Season_Year int NOT NULL,
  Orange_Cap_Id int NOT NULL,
  Purple_Cap_Id int NOT NULL,
  Man_of_the_Series_Id int NOT NULL
);

LOAD DATA INFILE 'C:\\PESMtech\\Presentation\\CSVfile\\season.csv' INTO TABLE season 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;  


 CREATE TABLE matches (
  Match_Id int NOT NULL PRIMARY KEY,
  Match_Date int NOT NULL,
  Team_Name_Id int NOT NULL,
  CONSTRAINT fk_team_1 FOREIGN KEY (Team_Name_Id)  REFERENCES team(Team_Id),
  Opponent_Team_Id int NOT NULL,
  CONSTRAINT fk_team_2 FOREIGN KEY (Opponent_Team_Id)  REFERENCES team(Team_Id),
  Season_Id int NOT NULL,
  Venue_Name VARCHAR(200),
  Toss_Winner_Id int NOT NULL,
  Toss_Decision VARCHAR(20),
  IS_Superover int NOT NULL,
  IS_Result int NOT NULL,
  Is_DuckWorthLewis int NOT NULL,
  Win_Type VARCHAR(50),
  Won_By int NOT NULL,
  Match_Winner_Id int NOT NULL,
  Man_Of_The_Match_Id int NOT NULL,
  First_Umpire_Id int NOT NULL,
  Second_Umpire_Id int NOT NULL,
  City_Name VARCHAR(50),
  Host_Country VARCHAR(50)
);

LOAD DATA INFILE 'C:\\PESMtech\\Presentation\\CSVfile\\match.csv' INTO TABLE matches 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

CREATE TABLE ball_by_ball (
  Match_Id int NOT NULL,
  CONSTRAINT fk_match_1 FOREIGN KEY (Match_Id)  REFERENCES matches(Match_Id),
  Season_Id int NOT NULL,
  CONSTRAINT fk_season_1 FOREIGN KEY (Season_Id)  REFERENCES season(Season_Id),
  Innings_Id int NOT NULL,
  Over_Id int NOT NULL,
  Ball_Id int NOT NULL,
  Team_Batting_Id int NOT NULL,
  Team_Bowling_Id int NOT NULL,
  Striker_Id int NOT NULL,
  Striker_Batting_Position int NOT NULL,
  Non_Striker_Id int NOT NULL,
  Bowler_Id int NOT NULL,
  Batsman_Scored int NOT NULL,
  Extra_Type VARCHAR(50) DEFAULT NULL,
  Extra_Runs INT DEFAULT NULL,
  Player_dissimal_Id INT DEFAULT NULL,
  Dissimal_Type VARCHAR(50) DEFAULT NULL,
  Fielder_Id INT DEFAULT NULL
); 

LOAD DATA INFILE 'C:\\PESMtech\\Presentation\\CSVfile\\ball_by_ball.csv' INTO TABLE ball_by_ball 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(Match_Id, Season_Id, Innings_Id, Over_Id, Ball_Id, Team_Batting_Id, Team_Bowling_Id, Striker_Id, Striker_Batting_Position, Non_Striker_Id, Bowler_Id, Batsman_Scored, @Extra_Type, @Extra_Runs, @Player_dissimal_Id, @Dissimal_Type, @Fielder_Id )
SET Extra_Type = NULLIF(TRIM(@Extra_Type),''),
 Extra_Runs = NULLIF(TRIM(@Extra_Runs),''),
 Player_dissimal_Id = NULLIF(TRIM(@Player_dissimal_Id),''),
 Dissimal_Type = NULLIF(TRIM(@Dissimal_Type),''),
 Fielder_Id = NULLIF(TRIM(@Fielder_Id),'');
 
 
CREATE TABLE player_match (
  Match_Id int NOT NULL,
  CONSTRAINT fk_matches_1 FOREIGN KEY (Match_Id)  REFERENCES matches(Match_Id),
  Player_Id int NOT NULL,
  CONSTRAINT fk_player_1 FOREIGN KEY (Player_Id)  REFERENCES players(Player_Id),
  Team_Id int NOT NULL,
  CONSTRAINT fk_team_3 FOREIGN KEY (Team_Id)  REFERENCES team(Team_Id),
  Is_Keeper int NOT NULL,
  Is_Captain int NOT NULL
);

LOAD DATA INFILE 'C:\\PESMtech\\Presentation\\CSVfile\\player_match.csv' INTO TABLE player_match 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;


 
 

 
 

