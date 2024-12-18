-- View the basic struture in the original data related to names
SELECT * FROM public.name_basics
LIMIT 100;

-- Create a new table that includes the profession information of every person
CREATE TABLE name_professions (
    name_id text,
    profession text
);

-- Insert the profession information into the new table, i.e. name_professions
WITH split_professions AS (
    SELECT name_id, unnest(string_to_array(professions, ',')) AS profession
    FROM public.name_basics
)
INSERT INTO name_professions (name_id, profession)
SELECT name_id, profession
FROM split_professions;

-- Create a new table that includes the titles every person was famous for
CREATE TABLE name_knownfor (
    name_id text,
    title_id text
);

-- Insert the information into the new table, i.e. name_knownfor
WITH split_titles AS (
    SELECT name_id, unnest(string_to_array(known_for_titles, ',')) AS title
    FROM public.name_basics
)
INSERT INTO name_knownfor (name_id, title_id)
SELECT name_id, title
FROM split_titles;

-- View what Anne Hathaway is famous for and what's her professions in these movies
SELECT nb.full_name, np.profession, tb.original_title
FROM public.name_knownfor nk
JOIN public.name_basics nb ON nb.name_id = nk.name_id
JOIN public.title_basics tb ON tb.title_id = nk.title_id
JOIN public.name_professions np ON np.name_id = nk.name_id
WHERE nb.full_name LIKE 'Anne Hathaway';
