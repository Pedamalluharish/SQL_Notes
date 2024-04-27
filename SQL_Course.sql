USE moviesdb;
##WHERE CLAUSE
SELECT * FROM movies WHERE industry="hollywood";
SELECT * FROM movies WHERE studio="";
SELECT * FROM movies WHERE imdb_rating>=9;  ## Will get the movies which has rating greaterthan and equal to 9

## AND Operator
SELECT * FROM movies WHERE imdb_rating>=6 AND imdb_rating<=8;
SELECT * FROM movies WHERE imdb_rating BETWEEN 6 AND 8;   ## BETWEEN Operator

## OR Operator
SELECT * FROM movies WHERE release_year=2019 OR release_year=2022;
SELECT * FROM movies WHERE release_year IN (2019,2022,2018);  ## IN Operator

## LIKE 
SELECT * FROM movies WHERE title LIKE "%THOR%";

## ORDER BY
SELECT * FROM movies WHERE industry="bollywood" ORDER BY imdb_rating DESC;  ## will show rating from high to low because of DESC
SELECT * FROM movies WHERE industry="bollywood" ORDER BY imdb_rating DESC LIMIT 5; ### Limit will give limited rows.

## OFFSET
SELECT * FROM movies WHERE industry="hollywood" ORDER BY imdb_rating DESC LIMIT 5 OFFSET 1;

## DISTINCT
SELECT DISTINCT industry FROM movies;

## MAX Function
SELECT MAX(imdb_rating) FROM movies WHERE industry="bollywood";
SELECT MIN(imdb_rating) FROM movies WHERE industry="bollywood";   ## MIN function
SELECT ROUND(AVG(imdb_rating),2) AS Average_rating FROM movies WHERE studio ="Marvel Studios"; ## AVG function

## If i want to get the MIN, MAX and AVG rating for the "Marvel Studios" 
SELECT MIN(imdb_rating) AS Min_Rating,
	   MAX(imdb_rating) AS Max_Rating,
       ROUND(AVG(imdb_rating),2) AS Avg_Rating 
FROM movies WHERE studio="Marvel Studios";

## GroupBy Class
## if i want to group the industry colomn and need to get the movies count for that industry
SELECT industry, COUNT(*) AS No_of_movies  FROM movies GROUP BY industry;
SELECT studio, COUNT(*) AS No_of_movies  FROM movies GROUP BY studio ORDER BY No_of_movies DESC;
SELECT industry, COUNT(*) AS No_of_movies, AVG(imdb_rating) as Avg_rating FROM movies GROUP BY industry;

SELECT studio,
	   COUNT(studio) AS cnt,
	   ROUND(AVG(imdb_rating),1) AS Avg_rating
FROM movies 
WHERE studio!=""
GROUP BY studio
ORDER BY Avg_rating DESC;

## Print all the years where morethan 2 movies were released
SELECT release_year, COUNT(*) AS No_of_movies 
FROM movies
GROUP BY release_year 
HAVING No_of_movies>2
ORDER BY No_of_movies DESC;

###SQL Query Execution Order
### FROM --> WHERE --> GROUP BY --> HAVING --> ORDER BY
### HAVING is mostly used when GROUP BY is used.

#### Working on Actors Table
## I have an actors table having birthyear and now i want to get the age of thta actor.
SELECT * FROM actors;
SELECT *, YEAR(curdate())-birth_year AS Age FROM actors;

### Using Financials Table
SELECT * FROM financials;
SELECT *, (revenue-budget) AS Profit FROM financials;
## Convert currency all colomns from USD to INR
SELECT DISTINCT unit FROM financials;

SELECT *,
	CASE
		WHEN unit="thousands" THEN revenue/1000
        WHEN unit="billions" THEN revenue*1000
        ELSE revenue
	END AS revenue_mln
FROM financials;

############################## JOINS ########################################
## Joining 2 tables movies & Financials, BY Default JOIN in SQL is INNER JOIN
SELECT m.movie_id, title, budget, revenue, currency, unit
FROM movies m
LEFT JOIN financials f
ON m.movie_id=f.movie_id;

SELECT f.movie_id, title, budget, revenue, currency, unit
FROM movies m
RIGHT JOIN financials f
ON m.movie_id=f.movie_id;


