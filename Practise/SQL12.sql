CREATE SCHEMA IF NOT EXISTS SQL2Takehome2;
USE SQL2Takehome2;
SELECT * FROM Video_Games_Sales;

# 1. Display the names of the Games, platform and total sales in North America for respective platforms.
select name,platform,sum(na_sales)over(partition by platform)
from video_games_sales;


# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding 
# Genre as Genre_Sales,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.
select name,platform,genre,
sum(na_sales)over(partition by genre) genre_sales ,
sum(na_sales)over(partition by platform) platform_sales,
sum(global_sales)over() as total_sales
from video_games_sales
order by global_sales desc;


# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.
select name,platform,Year_of_Release,genre,
row_number()over(partition by platform order by year_of_release desc)
from video_games_sales;


# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). 
# Also arrange the result in the descending order by year of release.
select name,platform,year_of_release,
avg(global_sales)over(partition by year_of_release order by year_of_release desc)
from video_games_sales;


# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 
select name,platform,publisher,critic_rank from
(select name,platform,publisher,
dense_rank()over(partition by publisher order by critic_score desc) as critic_rank
from video_games_sales)t
where critic_rank<6;


------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
------------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date
select *,
lead(str_to_date(launch_date, '%d-%m-%y'),2) over(order by str_to_date(launch_date, '%d-%m-%y'))Third_Website_Launch_Date_
from web;


# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.
select str_to_date(day, '%d-%m-%y')Day, income,
first_value(income)over(order by str_to_date(day, '%d-%m-%y'))Income_on_first_day
from website_stats
where website_id=1;

-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, 
#show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.
select Name, Genre, (released)Date_of_Release,
rank()over(order by released)Rnk,
dense_rank()over(order by released)Dns_Rnk,
row_number()over(order by released)R_Number
from play_store;



