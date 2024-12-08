<div align="center">
  <img alt="flowchart" src="images/Flowchart.png">
  <hr>

Information courtesy of
IMDb
(https://www.imdb.com).
Used with permission.
</div>

## Import data into DuckDB
```
./duckdb your_database.duckdb
```

```
CREATE TABLE your_tables AS
  SELECT * FROM read_csv('/your_directory/*.*.tsv',
    delim='\t',
    null_padding=true,
    sample_size=-1);
```

```
.tables
```

```
SELECT * FROM your_tables;
```

## Quick visualisation using Youplot
### title type counts
```
./duckdb your_database.duckdb -s \
"COPY (SELECT titleType, count(titleType) AS total_counts \
FROM your_table GROUP BY 1 ORDER BY 2 DESC) \
TO '/dev/stdout' WITH (format 'csv', header)"  \
| uplot bar -d, -H -c blue -t "Counts of the Title Types"
```
<p align="center">
  <img alt="barplot" src="images/barplot.png">
</p>

### movie production trend
```
./duckdb your_database.duckdb -s \
"COPY (SELECT startYear AS year, COUNT(titleType) AS 'numbers of productions' \
FROM your_table WHERE titleType = 'tvMovie' AND startYear IS NOT NULL \
GROUP BY startYear) TO '/dev/stdout' WITH (format 'csv', header)" \
| uplot line -d, -w 55 -h 15 -t "Movie Production Changes Over the Years" \
--xlim 1920,2026 --ylim 0,4000 -c blue
```
<p align="center">
  <img alt="lineplot" src="images/lineplot.png">
</p>

### average rating distribution
```
./duckdb your_database.duckdb -s \
"COPY (SELECT averageRating FROM your_table) \
TO '/dev/stdout' WITH (format 'csv', header)" \
| uplot hist --nbins 20 -c blue --title "Distribution of the Averageratings"
```
<p align="center">
  <img alt="lineplot" src="images/histgram.png">
</p>

### running time distribution
- ***overall***

```
./duckdb your_database.duckdb -s "
COPY (
    SELECT 
        runtimeMinutes
    FROM your_table 
    WHERE runtimeMinutes IS NOT NULL) TO '/dev/stdout' WITH (format 'csv', header)
" | uplot boxplot -H -d, -t 'Overall Running Time Distribution' 
-c blue --xlabel 'minutes' --xlim 0,150
```
**V.S.**

- ***movie***
```
./duckdb your_database.duckdb -s "
COPY (
    SELECT 
        CASE WHEN titleType = 'movie' THEN runtimeMinutes ELSE NULL END AS movie,
    FROM your_table 
    WHERE runtimeMinutes IS NOT NULL
) TO '/dev/stdout' WITH (format 'csv', header)
" | cut -f1 -d, | uplot boxplot -H -d, -t 'Movie Running Time Distribution' 
-c blue --xlabel 'minutes' --xlim 0,150
```

<p align="center">
  <img alt="lineplot" src="images/overall_runningtime_dist.png">
  <img alt="lineplot" src="images/movie_runningtime_dist.png">
</p>

## Data migration from DuckDB to PostgreSQL


## Data analysis

## Visualisation using Gnuplot





#### References
[IMDb Non-Commercial Datasets](https://developer.imdb.com/non-commercial-datasets/) \
[Youplot](https://github.com/red-data-tools/YouPlot) \
[DuckDB](https://duckdb.org/docs/api/overview) \
[PostgreSQL](https://www.postgresql.org/) \
[Gnuplot](http://www.gnuplot.info/)