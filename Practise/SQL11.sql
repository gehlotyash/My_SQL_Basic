Create database Sql2Inclass2;
use SQL2Inclass2;
-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------
# Q1. Give a dense rank to the wine varities on the basis of the price.
select variety, Price, 
dense_rank()over(partition by variety order by price desc)Rnk 
from wine;
 
# Q2. Use aggregate window functions to find the average of points for each row within
# its partition (country) and also arrange the final result in the descending order by country.
# print country,province,winery,variety
select 
Country, Province, Winery, Variety,
avg(Points) over(partition by Country)Avg_Point
from wine
order by country desc;


# Dataset Used: students.csv
-- --------------------------------------------------------------
# Q3. Provide the new roll numbers to the students on the basis of their names alphabetically.
select * from
(select row_number()over(order by name asc)`Roll No.`,
name, subject, marks from students)r;


-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
# Q4. Display the difference in ad_clicks between the current day and the next day for 
# the website 'Olympus'
select *, (ad_clicks-Next_click) as Diff_clicks
from
(select day, ad_clicks, lead(ad_clicks)
over(partition by website_id order by day) as Next_click
from website_stats
where website_id=(select id from web where name like 'Olympus'))t;



# Q5. Write a query that displays the statistics for website_id = 3 such that for each row,
# show the day, the number of users and the smallest number of users ever.
select * from
(select  *, first_value(no_users)over(order by no_users )Min_Usr from website_stats)t
where website_id = 3;


# Dataset Used: play_store.csv and sale.csv
-- ---------------------------------------------------------------
# Q6. Write a query thats orders games in the play store into three buckets as 
#per editor ratings received  from higher to lowest
select *, ntile(3)over(order by editor_rating desc)
from play_store;


# Q7. Write a query that displays the name of the game, the price, the sale date and 
#the 4th column should display # the sales consecutive number i.e. ranking of game as 
#per the sale took place, so that the latest game sold gets number 1. 
#Order the result by editor's rating of the game
select p.Name, s.Price, str_to_date(Date, '%d-%m-%y') as date,
row_number()over(order by str_to_date(Date, '%d-%m-%y' )desc)Rnk
from play_store p 
join sale s
on p.id=s.id
order by editor_rating;


-----------------------------------------------------------------
# Dataset Used: movies.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
# Q8. Write a query that displays basic movie informations as well as the previous rating 
#provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.
select m.id, m.title, m.genre, r.rating,
lag(r.rating)over(partition by m.id)Previous_Rating
from movies m
join ratings r
on m.id=r.movie_id
order by r.id;


# Q9. For each movie, show the following information: title, genre, average user rating for 
#that movie  and its rank in the respective genre based on that average rating in descending 
#order (so that the best movies will be shown first).
select *,
dense_rank()over(partition by Genre order by Avg_Rating)Rnk
from
(select m.title, m.genre, 
avg(r.rating)Avg_Rating
from movies m
join ratings r
on m.id=r.movie_id
group by title)t;

# Q10. For each rental date, show the rental_date, the sum of payment amounts 
#(column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between 
#these two values.
select *,
lag(Payment_Amounts)over(order by date)Previous_Day,
(lag(Payment_Amounts)over(order by date)-Payment_Amounts)Diff_Amount
from
(select str_to_date(rental_Date, '%d-%m-%y') as date, sum(Payment_Amount)Payment_Amounts
from rent
group by str_to_date(rental_Date, '%d-%m-%y')
order by str_to_date(rental_Date, '%d-%m-%y'))t;

