-- --------------------------------------------------------
# Datasets Used: cricket_1.csv, cricket_2.csv
-- cricket_1 is the table for cricket test match 1.
-- cricket_2 is the table for cricket test match 2.
-- --------------------------------------------------------
use day2;
# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.
select c1.Player_Name 
from cricket_1 c1
join cricket_2 c2
on c1.Player_Id=c2.Player_Id;

 
# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
#  scored runs more than 50
select Player_Id,Runs, Player_Name 
from cricket_1 
where Runs>50;

# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.
select * from cricket_1 
where Player_Name like 'y%v';

# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.
select * from cricket_1 
where Player_Name not like '%t';
 
-- --------------------------------------------------------
# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------

# Q5. Write a MySQL query to add a column PC_Ratio to the table that contains the divsion ratio 
# of popularity to charisma .(Hint :- Popularity divide by Charisma)
alter table cric_combined 
add PC_Ratio float after Charisma;

update cric_combined 
set PC_Ratio=Popularity/Charisma;

select * from cric_combined;

# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.
select * from cric_combined 
order by PC_Ratio desc 
limit 5;

# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.
select Player_Id, Player_Name 
from cric_combined 
where Player_Name like '%D%';

# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.
select Player_Id, PC_Ratio 
from cric_combined 
where PC_Ratio between 0.12 and 0.25;

-- --------------------------------------------------------
# Dataset Used: new_cricket.csv
-- --------------------------------------------------------
# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.
select Player_Id, Player_Name 
from new_cricket 
where Charisma is null;
 
# Q10. Write a MySQL query to display all the NULL values  in the column Charisma imputed with 0.
select ifnull(Charisma, 0)
from new_cricket;
 
# Q11. Separate all Player_Id into single numeric ids (example PL1 to be converted as 1, PL2 as 2 , ... PL12 as 12 ).
select substr(Player_Id,3,2), Player_Name as Player_id 
from new_cricket;
 
# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.
select Player_Id, Player_Name, Charisma 
from new_cricket 
where Charisma>25;

-- --------------------------------------------------------
# Dataset Used: churn1.csv 
-- --------------------------------------------------------

# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount 
# for those paymentmethod is through Electronic check mode.
select ceiling(monthlyservicecharges), floor(totalamount) 
from churn1 
where PaymentMethod='Electronic check';

# Q14. Rename the table churn1 to “Churn_Details”.
alter table churn1 rename to Churn_Details;

# Q15. Write a query to create a display a column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.
alter table Churn_Details 
add column New_Amount float after churn;

update Churn_Details 
set New_Amount = (TotalAmount + MonthlyServiceCharges);

# Q16. Rename column new_Amount to Amount.
alter table Churn_Details 
rename column New_Amount to Amount;

# Q17. Drop the column “Amount” from the table “Churn_Details”.
alter table Churn_Details 
drop column Amount;

# Q18. Write a query to extract the customerID, InternetConnection and gender 
# from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ 
# at the second position.
select customerID, InternetConnection, gender 
from Churn_Details 
where InternetConnection like '_i%';

# Q19. Find the records where the tenure is 6x, where x is any number.
select * from Churn_Details
 where tenure%6=0;

# Q20. Write a query to display the player names in capital letter and arrange in alphabatical order 
# along with the charisma, display 0 for whom the charisma value is NULL.
select ucase(Player_Name)P_Name, ifnull(Charisma, 0)
from new_cricket
order by P_Name;

