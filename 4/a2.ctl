LOAD DATA
INFILE *
TRUNCATE
INTO TABLE books_admin.XX_MYEXAMPLE2
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
id,
item terminated by "$",
color terminated by "^",
price,
weight FILLER,
creation_date DATE "dd-mm-yyyy"
)
BEGINDATA
1,table$black^12480,12,30-01-2014
2,table$green^12580,12,11-05-2013
3,chair$black^3800,3,11-08-2014
