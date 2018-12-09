LOAD DATA
INFILE *
TRUNCATE
INTO TABLE books_admin.EXPERIMENTS
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
id,
x FLOAT,
y FLOAT, 
z FLOAT, 
str terminated by "$"
)
BEGINDATA
1,113.6,127.7,14.1,not_completed$
2,118.1,133.2,15.1,in_process$
3,119.9,135.3,15.4,in_process$
4,126.2,143.3,17.1,unknown$
5,126.7,139.3,12.6,updated$
6,127.3,140.2,12.9,finished$
7,128.2,143.8,15.6,in_process$
8,129.5,144.6,15.1,started$
9,130.5,147.6,17.1,updated$
