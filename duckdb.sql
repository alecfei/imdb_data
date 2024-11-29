/*

DROP TABLE IF EXISTS title_basics;
DROP TABLE IF EXISTS test;

CREATE TABLE title_basics AS
  SELECT * FROM read_csv('/home/hduser/movies/title.basics.tsv', delim='\t', null_padding = true, nullstr = '\N', sample_size = -1);
  
 */

SELECT titleType, COUNT(*) AS counts
FROM test
GROUP BY titleType;
