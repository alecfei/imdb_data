<div align="center">
  <img src="images/Flowchart.png">
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
  <img src="images/barplot.png">
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
  <img src="images/lineplot.png">
</p>

## Data migration from DuckDB to PostgreSQL
excute

## Data analysis

## Visualisation using Gnuplot





#### References
[IMDb Non-Commercial Datasets](https://developer.imdb.com/non-commercial-datasets/) \
[Youplot](https://github.com/red-data-tools/YouPlot) \
[DuckDB](https://duckdb.org/docs/api/overview) \
[PostgreSQL](https://www.postgresql.org/) \
[Gnuplot](http://www.gnuplot.info/)