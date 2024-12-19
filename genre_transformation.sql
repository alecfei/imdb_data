-- Check table title_basics
SELECT * FROM public.title_basics
LIMIT 100;

-- Create a new table that includes the genre information of every title
CREATE TABLE title_genres (
    title_id text,
    genre text
);

-- Insert the genres into the new table, i.e. title_genres
WITH split_genres AS (
    SELECT title_id, unnest(string_to_array(genres, ',')) AS genre
    FROM public.title_basics
)
INSERT INTO title_genres (title_id, genre)
SELECT title_id, genre
FROM split_genres;

-- Check the genres
SELECT DISTINCT genre
FROM public.title_genres
;