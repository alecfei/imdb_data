/**
In this section, we focus on analyse the people that have worked in
the movie/TV industires and their roles
**/

-- 1. The top 10 professions in the industry and its ratio among the whole population
SELECT 
    profession, 
    COUNT(profession) AS count, 
    ROUND((COUNT(profession) * 1.0 / (SELECT COUNT(DISTINCT name_id) FROM public.name_professions)) * 100, 3)::TEXT || '%' AS percentage
FROM public.name_professions
GROUP BY profession
ORDER BY count DESC
LIMIT 10;

-- 2. The age distribution of people who worked in the industry, excluding people who are still alive
SELECT full_name, (death_year - birth_year) as age
FROM public.name_basics
WHERE (death_year - birth_year) IS NOT NULL
ORDER BY age DESC


-- 3. Top 10 most localisation productions in history
WITH top_titles AS (
    SELECT ta.title_id, COUNT(DISTINCT ta.region) AS localisation_count
    FROM public.title_akas ta
    GROUP BY ta.title_id
    ORDER BY COUNT(DISTINCT ta.region) DESC
    LIMIT 10
)
SELECT 
    tb.primary_title, 
    tt.localisation_count
FROM public.title_basics tb
JOIN top_titles tt
	ON tb.title_id = tt.title_id
ORDER BY tt.localisation_count DESC
;

/*
SELECT * FROM public.title_basics tb
WHERE tb.title_id IN (
    SELECT ta.title_id
    FROM public.title_akas ta
    GROUP BY ta.title_id
    ORDER BY COUNT(DISTINCT ta.region) DESC
    LIMIT 10
)
*/

-- Analyse series programs
SELECT
    t.episode_title_id,
    t.series_title_id,
    t.season_number,
    t.episode_number,
    tb1.primary_title AS episode_title,
    tb2.primary_title AS series_title
FROM
    title_episode AS t
LEFT JOIN
    title_basics AS tb1 ON t.episode_title_id = tb1.title_id
LEFT JOIN
    title_basics AS tb2 ON t.series_title_id = tb2.title_id
WHERE t.series_title_id = 'tt0046576'
;

-- The most voted program
SELECT tr.*, tb.type, tb.original_title, tb.start_year, tb.runtime_minutes, tb.genres
FROM public.title_ratings tr
JOIN public.title_basics tb ON tr.title_id = tb.title_id
WHERE num_votes = (SELECT MAX(num_votes) FROM public.title_ratings)
;

SELECT tr.*, tb.type, tb.original_title, tb.start_year, tb.runtime_minutes, tb.genres
FROM public.title_ratings tr
JOIN public.title_basics tb ON tr.title_id = tb.title_id
ORDER BY num_votes DESC
LIMIT 10
;