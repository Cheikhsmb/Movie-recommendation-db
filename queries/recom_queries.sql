-- Top 5 Highest-Rated Movies

SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id, m.title
ORDER BY avg_rating DESC
LIMIT 5;

-- Movies Watched by a specific user 

SELECT m.title, w.watched_at
FROM WatchHistory w
JOIN Movies m ON w.movie_id = m.movie_id
WHERE w.user_id = 1
ORDER BY w.watched_at DESC;

-- Users Who Liked Movie A Also Liked Movie B 

SELECT DISTINCT m2.title
FROM Ratings r1
JOIN Ratings r2 ON r1.user_id = r2.user_id
JOIN Movies m2 ON r2.movie_id = m2.movie_id
WHERE r1.movie_id = 1
  AND r1.rating >= 4
  AND r2.rating >= 4
  AND r2.movie_id != 1;

--  Recommend Movies from a User’s Favorite Genre
-- Step 1: User's favorite genre based on average rating
WITH FavoriteGenre AS (
  SELECT m.genre_id
  FROM Ratings r
  JOIN Movies m ON r.movie_id = m.movie_id
  WHERE r.user_id = 1
  GROUP BY m.genre_id
  ORDER BY AVG(r.rating) DESC
  LIMIT 1
)

-- Step 2: Movies in that genre the user hasn't watched yet
SELECT m.title
FROM Movies m
WHERE m.genre_id = (SELECT genre_id FROM FavoriteGenre)
  AND m.movie_id NOT IN (
    SELECT movie_id FROM WatchHistory WHERE user_id = 1
  );

