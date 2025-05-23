# <p align="center">Netflix Shows and Movies Project</p>
# <p align="center">![Pic](https://i.ibb.co/Q81WwRN/92399716.jpg)</p>

**Tools Used:** 
* Excel
* PostgreSQL 
* ONLINE CSV to SQL converter tool- [converter](https://www.convertcsv.com/csv-to-sql.htm)

[Datasets Used](https://www.kaggle.com/datasets/victorsoeiro/netflix-tv-shows-and-movies?select=titles.csv)
[Netflix Dashboard - Tableau](https://public.tableau.com/app/profile/sharif.athar/viz/NetflixShowsMoviesDashboard/Dashboard1)

- **🧩 Business Problem:** Netflix aims to extract meaningful insights from their vast collection of data on shows and movies to better serve their subscribers. However, the challenge lies in the sheer volume of data—with over 82,000 rows across multiple datasets, they are struggling to efficiently analyze and draw useful conclusions. As such, Netflix needs a robust, scalable analytics solution to handle large data volumes and reveal valuable trends, patterns, and viewer behavior insights.
- **🛠️ Solution Approach** To address this, I used PostgreSQL to analyze and extract meaningful insights from Netflix’s dataset. The analysis involved writing SQL queries to answer specific business questions across content performance, genres, cast involvement, and production trends.

## ✅ Key Questions Solved
# 📈 Content Ratings and Performance
- Top 10 / Bottom 10 movies and shows by IMDb score
- Average IMDb and TMDB scores by:
  - Content type (movies/shows)
  - Production country
  - Age certification
- Count of movies and shows by decade
- Most common age certifications
- Top actors and directors by number of appearances
- Average runtime of movies vs. shows
- Shows with the most seasons
- Most common genres
- Highly rated and popular movies (IMDb > 7.5, TMDB popularity > 80)
- Titles released after 2010 with directors
- Actors playing the same character across multiple titles
