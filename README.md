# OTTs Content Analysis
![ott_logo](https://github.com/saicharannetha/OTTs-Content-Analysis-/blob/main/rating.jpg)

## Problem Statement: 

**OTT Content Analysis Across Netflix, Amazon Prime Video, and Hotstar**

The data analysis solution provides insights into the content available on major OTT platforms, including Netflix, Amazon Prime, and Hotstar. The analysis will focus on content ratings, genres, and the distinction between movies and TV shows. Additionally, it will examine release trends by year and country to identify patterns and trends in content distribution across these platforms.

**Key Components & Features:**

1. **Content Rating Analysis:**
   - Analyze the distribution of content ratings (e.g., G, PG, PG-13, R, etc.) across Netflix, Amazon Prime, and Hotstar.
   - Compare the content rating distributions between platforms to understand their target audience demographics.
   - Identify trends in content ratings over time and by country, and assess how these trends align with platform-specific strategies.

2. **Genre Analysis:**
   - Explore the genre distribution across each OTT platform, comparing the popularity of different genres (e.g., Drama, Comedy, Action, Thriller).
   - Identify which genres are more prominent on each platform and how this reflects the platform’s content strategy.
   - Analyze the evolution of genre popularity over time and across different regions or countries.

3. **Movies vs. TV Shows:**
   - Categorize content into movies and TV shows, and analyze the balance between these two categories on each platform.
   - Visualize the proportion of movies versus TV shows available on each platform.
   - Identify trends in the production and release of movies versus TV shows over time and by country.

4. **Releases by Year:**
   - Analyze the number of content releases (both movies and TV shows) by year across Netflix, Amazon Prime, and Hotstar.
   - Visualize trends in content production and releases over the years to understand how these platforms have grown or shifted focus.
   - Identify peak years for content releases and correlate them with platform expansions or major industry events.

5. **Country-Specific Analysis:**
   - Examine the geographical distribution of content on each platform, identifying the most prolific countries of origin.
   - Analyze how the country of origin influences content ratings, genres, and the type of content (movies vs. TV shows).
   - Compare the availability of local versus international content on each platform.

6. **Platform Comparison:**
   - Conduct a comparative analysis of the content strategies of Netflix, Amazon Prime, and Hotstar based on ratings, genres, and release patterns.
   - Identify unique strengths and niches of each platform in terms of content offerings.
   - Explore how each platform tailors its content library to different regions and demographics.

**Stakeholders:**
- **Content Creators and Producers:** To understand the competitive landscape and identify gaps or opportunities in content production.
- **OTT Platform Strategists:** To refine content acquisition and production strategies based on competitor analysis and audience preferences.
- **Marketers:** To design targeted marketing campaigns that align with content trends and audience preferences on each platform.
- **Data Analysts and Researchers:** To explore content trends, audience behavior, and regional preferences across OTT platforms.
## Business Problems and Solutions



#### 1. Content Type Comparison
**Problem:** Compare the percentage of Movies vs TV Shows across Netflix, Disney+, and Amazon Prime.
**Query:**
```sql
SELECT platform, type, COUNT(*) AS count
FROM (
    SELECT 'Netflix' AS platform, type FROM netflix_titles
    UNION ALL
    SELECT 'Disney+' AS platform, type FROM disney_plus_titles
    UNION ALL
    SELECT 'Amazon Prime' AS platform, type FROM amazon_prime_titles
) combined
GROUP BY platform, type;
```
**Insight:** Netflix has the highest percentage of TV Shows, while Disney+ focuses more on movies.

---

#### 2. Top-Producing Countries
**Problem:** Identify the top 3 content-producing countries for each platform.
**Query:**
```sql
SELECT platform, country, COUNT(*) AS count
FROM (
    SELECT 'Netflix' AS platform, country FROM netflix_titles
    UNION ALL
    SELECT 'Disney+' AS platform, country FROM disney_plus_titles
    UNION ALL
    SELECT 'Amazon Prime' AS platform, country FROM amazon_prime_titles
) combined
WHERE country IS NOT NULL
GROUP BY platform, country
ORDER BY platform, count DESC;
```
**Insight:** The United States dominates content production across all three platforms.

---

#### 3. Yearly Content Addition
**Problem:** Analyze how content has grown year by year across the three platforms.
**Query:**
```sql
SELECT platform, release_year, COUNT(*) AS count
FROM (
    SELECT 'Netflix' AS platform, release_year FROM netflix_titles
    UNION ALL
    SELECT 'Disney+' AS platform, release_year FROM disney_plus_titles
    UNION ALL
    SELECT 'Amazon Prime' AS platform, release_year FROM amazon_prime_titles
) combined
GROUP BY platform, release_year
ORDER BY platform, release_year;
```
**Insight:** Netflix has steadily increased its content output over the years, while Disney+ shows a sharp rise post-2019.

---

#### 4. Top Directors Across Platforms
**Problem:** Identify the top 5 directors with the most titles across all platforms.
**Query:**
```sql
SELECT director, COUNT(*) AS count
FROM (
    SELECT director FROM netflix_titles WHERE director IS NOT NULL
    UNION ALL
    SELECT director FROM disney_plus_titles WHERE director IS NOT NULL
    UNION ALL
    SELECT director FROM amazon_prime_titles WHERE director IS NOT NULL
) combined
GROUP BY director
ORDER BY count DESC
LIMIT 5;
```
**Insight:** Prominent directors have content across multiple platforms, showcasing their versatility.

---

#### 5. Diverse Genre Analysis
**Problem:** What are the top 3 genres on each platform?
**Query:**
```sql
SELECT platform, listed_in, COUNT(*) AS count
FROM (
    SELECT 'Netflix' AS platform, listed_in FROM netflix_titles
    UNION ALL
    SELECT 'Disney+' AS platform, listed_in FROM disney_plus_titles
    UNION ALL
    SELECT 'Amazon Prime' AS platform, listed_in FROM amazon_prime_titles
) combined
GROUP BY platform, listed_in
ORDER BY platform, count DESC;
```
**Insight:** Netflix has a strong focus on international content, Disney+ emphasizes family-friendly content, and Amazon Prime has a diverse mix.

---

#### 6. Exclusive Content Analysis
**Problem:** Identify content exclusive to each platform.
**Query:**
```sql
SELECT title, COUNT(DISTINCT platform) AS platform_count
FROM (
    SELECT 'Netflix' AS platform, title FROM netflix_titles
    UNION ALL
    SELECT 'Disney+' AS platform, title FROM disney_plus_titles
    UNION ALL
    SELECT 'Amazon Prime' AS platform, title FROM amazon_prime_titles
) combined
GROUP BY title
HAVING platform_count = 1;
```
**Insight:** Each platform has a large collection of exclusive content, highlighting unique selling points.

---

#### 7. Content Rating Trends
**Problem:** Compare content ratings across platforms.
**Query:**
```sql
SELECT platform, rating, COUNT(*) AS count
FROM (
    SELECT 'Netflix' AS platform, rating FROM netflix_titles
    UNION ALL
    SELECT 'Disney+' AS platform, rating FROM disney_plus_titles
    UNION ALL
    SELECT 'Amazon Prime' AS platform, rating FROM amazon_prime_titles
) combined
GROUP BY platform, rating
ORDER BY platform, count DESC;
```
**Insight:** Disney+ has a higher percentage of family-friendly content, while Netflix and Amazon Prime cater to more mature audiences.

---

#### 8. Actor Appearances
**Problem:** Identify actors who have appeared across multiple platforms.
**Query:**
```sql
SELECT cast, COUNT(DISTINCT platform) AS platform_count
FROM (
    SELECT 'Netflix' AS platform, cast FROM netflix_titles WHERE cast IS NOT NULL
    UNION ALL
    SELECT 'Disney+' AS platform, cast FROM disney_plus_titles WHERE cast IS NOT NULL
    UNION ALL
    SELECT 'Amazon Prime' AS platform, cast FROM amazon_prime_titles WHERE cast IS NOT NULL
) combined
GROUP BY cast
HAVING platform_count > 1;
```
**Insight:** Some actors have content spanning across multiple platforms, increasing their global reach.

---

#### 9. Content Duration Trends
**Problem:** Compare average movie duration and TV show seasons across platforms.
**Query:**
```sql
SELECT platform, AVG(CAST(duration AS UNSIGNED)) AS avg_duration
FROM (
    SELECT 'Netflix' AS platform, duration FROM netflix_titles WHERE duration LIKE '%min%'
    UNION ALL
    SELECT 'Disney+' AS platform, duration FROM disney_plus_titles WHERE duration LIKE '%min%'
    UNION ALL
    SELECT 'Amazon Prime' AS platform, duration FROM amazon_prime_titles WHERE duration LIKE '%min%'
) combined
GROUP BY platform;
```
**Insight:** Netflix tends to have slightly longer movies, while Disney+ focuses on shorter, family-friendly content.

