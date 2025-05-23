/*
----------------------------QUESTIONS-----------------------------

-- What were the top 10 MOVIES according to IMDB score?
-- What were the top 10 SHOWS according to IMDB score? 
-- What were the bottom 10 MOVIES according to IMDB score? 
-- What were the bottom 10 SHOWS according to IMDB score? 
-- What were the average IMDB and TMDB scores for shows and movies? 

-- Count of movies and shows in each decade
-- What were the average IMDB and TMDB scores for each production country?
-- What were the average IMDB and TMDB scores for each age certification for shows and movies?
-- What were the 5 most common age certifications for movies?
-- Who were the top 20 actors that appeared the most in movies/shows? 

-- Who were the top 20 directors that directed the most movies/shows? 
-- Calculating the average runtime of movies and TV shows separately
-- Finding the titles and  directors of movies released on or after 2010
-- Which shows on Netflix have the most seasons?
-- Which genres had the most movies? 
-- Which genres had the most shows? 

-- Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80) 
-- What were the total number of titles for each year? 
-- Actors who have starred in the most highly rated movies or shows
-- Which actors/actresses played the same character in multiple movies or TV shows? 
-- What were the top 3 most common genres?
-- Average IMDB score for leading actors/actresses in movies or shows 

--Which directors have the highest average IMDb score across all their movies/shows?
--Which movies or shows have both high IMDb score and a long runtime (>120 minutes)?
--Which age certifications tend to have the highest average IMDb scores?
--What is the distribution of movie/show runtimes in 30-minute intervals?

*/

-------------------------------ANSWERS--------------------------------
-- What were the top 10 MOVIES according to IMDB score?
SELECT title,type,imdb_score
FROM titles
WHERE imdb_score >= 8 AND type = 'MOVIE'
ORDER BY imdb_score DESC, title ASC
LIMIT 10

-- What were the top 10 SHOWS according to IMDB score? 
SELECT title,type,imdb_score
FROM titles
WHERE imdb_score >= 8 AND type = 'SHOW'
ORDER BY imdb_score DESC, title ASC
LIMIT 10

-- What were the bottom 10 MOVIES according to IMDB score? 
SELECT title,type,imdb_score
FROM titles
WHERE type = 'MOVIE'
ORDER BY imdb_score ASC
LIMIT 10

-- What were the bottom 10 SHOWS according to IMDB score? 
SELECT title,type,imdb_score
FROM titles
WHERE type = 'SHOW'
ORDER BY imdb_score ASC
LIMIT 10

-- What were the average IMDB and TMDB scores for shows and movies? 
SELECT DISTINCT type, AVG(imdb_score) AS avd_imdb, AVG(tmdb_score) AS avd_tmdb
FROM titles
GROUP BY type

-- Count of movies and shows in each decade
SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
	COUNT(*) AS movies_shows_count
FROM titles
WHERE release_year >= 1940
GROUP BY CONCAT(FLOOR(release_year / 10) * 10, 's')
ORDER BY decade;

-- What were the average IMDB and TMDB scores for each production country?
SELECT DISTINCT production_countries, AVG(imdb_score) AS avd_imdb, AVG(tmdb_score) AS avd_tmdb
FROM titles
GROUP BY production_countries

-- What were the average IMDB and TMDB scores for each age certification for shows and movies?

SELECT age_certification, ROUND(AVG(imdb_score),2) AS avg_imdb_score, ROUND(AVG(tmdb_score),2) AS avg_tmdb_score
FROM titles
GROUP BY age_certification
ORDER BY avg_imdb_score DESC


-- What were the 5 most common age certifications for movies?
SELECT age_certification, COUNT(*) AS count_age_certification
FROM titles
WHERE type = 'MOVIE' AND age_certification IS NOT NULL
GROUP BY age_certification
ORDER BY count_age_certification DESC
LIMIT 5;


-- Who were the top 20 actors that appeared the most in movies/shows? 

SELECT DISTINCT name as actor, 
COUNT(*) AS number_of_appearences 
FROM credits
WHERE role = 'ACTOR'
GROUP BY name
ORDER BY number_of_appearences DESC
LIMIT 20

-- Who were the top 20 directors that directed the most movies/shows?
SELECT DISTINCT name as director, 
COUNT(*) AS number_of_appearences 
FROM credits
WHERE role = 'DIRECTOR'
GROUP BY name
ORDER BY number_of_appearences DESC
LIMIT 20


-- Calculating the average runtime of movies and TV shows separately
SELECT DISTINCT type, AVG(runtime)
FROM titles
GROUP BY type

-- Finding the titles and  directors of movies released on or after 2010
SELECT DISTINCT t.title, c.name AS director, release_year
FROM titles AS t
LEFT JOIN credits AS c
ON t.id = c.id
WHERE t.type = 'MOVIE' AND c.role = 'DIRECTOR' AND release_year >= '2010'
ORDER BY release_year DESC

-- Which shows on Netflix have the most seasons?
SELECT title, SUM(seasons) as total_seasons
FROM titles
WHERE type = 'SHOW'
GROUP BY title
ORDER BY total_seasons DESC

-- Which genres had the most movies? 
SELECT DISTINCT genres, COUNT(*) AS most_genres
FROM titles
WHERE type = 'MOVIE'
GROUP BY genres
ORDER BY most_genres DESC



-- Which genres had the most shows?
SELECT DISTINCT genres, COUNT(*) AS most_genres
FROM titles
WHERE type = 'SHOW'
GROUP BY genres
ORDER BY most_genres DESC


-- Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80) 
SELECT t.title, c.name AS director
FROM titles AS t
LEFT JOIN credits AS c
ON t.id = c.id
WHERE c.role = 'DIRECTOR' 
AND t.imdb_score > '7.5' 
AND t.tmdb_popularity > '80.0' 
AND t.type = 'MOVIE' 	


--What were the total number of titles for each year? 
SELECT DISTINCT release_year, COUNT(*) AS total_title
FROM titles
GROUP BY release_year
ORDER BY release_year DESC
LIMIT 10;

-- Actors who have starred in the most highly rated movies or shows

SELECT c.name, COUNT(*) AS num_highly_rated_titles
FROM credits AS c
LEFT JOIN titles AS t
ON c.id = t.id
WHERE c.role = 'ACTOR'
AND (t.type = 'MOVIE' OR t.type = 'SHOW')
AND t.imdb_score > '8.0'
AND t.tmdb_score > '8.0'
GROUP BY c.name
ORDER BY num_highly_rated_titles DESC;

-- Which actors/actresses played the same character in multiple movies or TV shows? 
SELECT c.name AS actor_actress, COUNT(DISTINCT t.title) AS total
FROM credits AS c
LEFT JOIN titles AS t
ON c.id = t.id
WHERE c.role = 'ACTOR' OR c.role = 'ACTRESS'
AND (t.type = 'MOVIE' OR t.type = 'SHOW')
GROUP BY c.character, c.name
ORDER BY total DESC;


-- What were the top 3 most common genres?
SELECT t.genres, COUNT(*) AS num_genre
FROM titles AS t
GROUP BY t.genres
ORDER BY num_genre DESC
LIMIT 3


-- Which directors have the highest average IMDb score across all their movies/shows?
SELECT c.name AS director, 
       ROUND(AVG(t.imdb_score), 2) AS avg_imdb_score,
       COUNT(*) AS total_titles
FROM credits c
JOIN titles t ON c.id = t.id
WHERE c.role = 'DIRECTOR'
GROUP BY c.name
HAVING COUNT(*) >= 3
ORDER BY avg_imdb_score DESC
LIMIT 10;

-- Which movies or shows have both high IMDb score and a long runtime (>120 minutes)?
SELECT title, type, imdb_score, runtime
FROM titles
WHERE imdb_score > 8 AND runtime > 120
ORDER BY imdb_score DESC;

-- Which age certifications tend to have the highest average IMDb scores?
SELECT age_certification, 
       ROUND(AVG(imdb_score), 2) AS avg_imdb_score,
       COUNT(*) AS total_titles
FROM titles
WHERE imdb_score IS NOT NULL
GROUP BY age_certification
ORDER BY avg_imdb_score DESC;

-- What is the distribution of movie/show runtimes in 30-minute intervals?
SELECT CONCAT(FLOOR(runtime / 30) * 30, '-', FLOOR(runtime / 30) * 30 + 29, ' mins') AS runtime_range,
       COUNT(*) AS title_count
FROM titles
GROUP BY runtime_range
ORDER BY runtime_range;






