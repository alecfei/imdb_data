-- View the original table
SELECT * FROM public.title_crew
LIMIT 100;

-- Create a new table that includes the directors of every title
CREATE TABLE title_directors (
    title_id text,
    director_id text
);

-- Insert the directors' name ids into the new table, i.e. title_directors
WITH split_directors AS (
    SELECT title_id, unnest(string_to_array(directors, ',')) AS director
    FROM public.title_crew
)
INSERT INTO title_directors (title_id, director_id)
SELECT title_id, director
FROM split_directors;

-- Check the new table, aka title_directors
SELECT COUNT(DISTINCT director_id)
FROM public.title_directors;

-- Create a new table that includes the writers of every title
CREATE TABLE title_writers (
    title_id text,
    writer_id text
);

-- Insert the writers' name ids into the new table, i.e. title_writers
WITH split_writers AS (
    SELECT title_id, unnest(string_to_array(writers, ',')) AS writer
    FROM public.title_crew
)
INSERT INTO title_writers (title_id, writer_id)
SELECT title_id, writer
FROM split_writers;

-- Check the new table
SELECT COUNT(DISTINCT writer_id)
FROM public.title_writers;