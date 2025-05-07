
-- 1. Total Number of Movies vs. TV Shows
SELECT 
    type,
    COUNT(*) AS total_count
FROM 
    netflix_titles
GROUP BY 
    type;

-- 2. Top 10 Countries with Most Content
SELECT 
    country,
    COUNT(*) AS total_titles
FROM 
    netflix_titles
WHERE 
    country IS NOT NULL
GROUP BY 
    country
ORDER BY 
    total_titles DESC
LIMIT 10;

-- 3. Content Added Over the Years (Yearly Trend)
SELECT 
    YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
    COUNT(*) AS titles_added
FROM 
    netflix_titles
WHERE 
    date_added IS NOT NULL
GROUP BY 
    year_added
ORDER BY 
    year_added;

-- 4. Top 5 Genres (Across Movies and TV Shows)
SELECT 
    genre,
    COUNT(*) AS genre_count
FROM (
    SELECT 
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre
    FROM 
        netflix_titles
    JOIN (
        SELECT a.N + b.N * 10 + 1 AS n
        FROM 
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 
             UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 
             UNION SELECT 8 UNION SELECT 9) a,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 
             UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 
             UNION SELECT 8 UNION SELECT 9) b
        ORDER BY n
    ) n
    WHERE n.n <= 1 + LENGTH(listed_in) - LENGTH(REPLACE(listed_in, ',', ''))
) AS genre_list
GROUP BY genre
ORDER BY genre_count DESC
LIMIT 5;

-- 5. Most Frequent Directors (Top 10)
SELECT 
    director,
    COUNT(*) AS directed_titles
FROM 
    netflix_titles
WHERE 
    director IS NOT NULL
GROUP BY 
    director
ORDER BY 
    directed_titles DESC
LIMIT 10;

-- 6. Recent Content (Added After 2020)
SELECT 
    title, type, country, release_year, date_added
FROM 
    netflix_titles
WHERE 
    STR_TO_DATE(date_added, '%M %d, %Y') > '2020-12-31'
ORDER BY 
    STR_TO_DATE(date_added, '%M %d, %Y') DESC;

-- 7. Longest Duration Movie or Show (Based on Duration)
SELECT 
    title, duration, type
FROM 
    netflix_titles
WHERE 
    duration REGEXP '^[0-9]+ min'
ORDER BY 
    CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;
