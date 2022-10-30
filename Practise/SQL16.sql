##################################################################################
create database SQL2TakeHome4;
use SQL2TakeHome4;
# Datset Used: admission_predict.csv
-- ----------------------------------------------------
# Q.1 A university is looking for candidates with GRE score between 330 and 340. 
# Also they should be proficient in english i.e. their Toefl score should not be less than 115. Create a view for this university.
#Solution:
create view candidate_GRE as 
select * from admission_predict
where (`GRE Score` between 330 and 340) and (`TOEFL Score`>=115);


# Q.2 Create a view of the candidates with the CGPA greater than the average CGPA.
#Solution:	
create view candidate_CGPA as 
select * from admission_predict
where CGPA>(select avg(CGPA) from admission_predict);


 # Datsets Used: world_cup_2015.csv and world_cup_2016.csv 
-- -------------------------------------------------------------------------------------
# Q.3 Create a view "team_1516" of the players who played in world cup 2015 as well as in world cup 2016.
#Solution:	
create view team_1516 as
select a.Player_Id, a.Player_Name, a.Runs, a.Popularity, b.Charisma
from world_cup_2015 a
join world_cup_2016 b
using(Player_Name);


# Q.4 Create a view "All_From_15" that contains all the players who played in world cup 2015 but not in the year 2016
# Along with those players who played in both the world cup matches.
#Solution:
create view All_From_15 as
select a.Player_Id, a.Player_Name,  a.Runs, a.Popularity, b.Charisma
from world_cup_2015 a left join world_cup_2016 b
on a.Player_Id=b.Player_Id;


# Q.5 Create a view "All_From_16" that contains all the players who played in world cup 2016 but not in the year 2015 
# Along with those players who played in both the world cup matches.
#Solution:
create view All_From_16 as
select a.Player_Id, a.Player_Name,  a.Runs, b.Popularity, a.Charisma
from world_cup_2016 a left join world_cup_2015 b
on a.Player_Id=b.Player_Id;


# Q.6 Drop multiple views "all_from_16", "all_from_15", "players_ranked"
#Solution:
drop view all_from_16, all_from_15;

