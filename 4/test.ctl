LOAD DATA
INFILE *
TRUNCATE
INTO TABLE books_admin.test
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
id,
x,
y,
process_state, 
creation_date DATE "dd-mm-yyyy",
update_date DATE "yyyy-mm-dd"
)
BEGINDATA
1;2;33,14;not started;30-01-2014;2015-01-10
2;2;24,71;finished;30-01-2014;2016-02-01
3;4;15,41;in progress;11-05-2013;2017-03-01
4;4;56,23;developing;11-05-2013;2016-04-01
5;3;57,23;developing;11-05-2013;2016-04-01
6;147,23;not started;11-05-2013;2016-04-01
7;14;54,723;developing;11-05-2013;2016-04-01
8;344;53,523;finished;11-05-2013;2016-04-01
9;456;52,243;canceled;11-05-2013;2016-04-01
10;54;52,23;resumed;11-05-2013;2016-04-01
