/* 
the REFFILE contains address of the data
*/
FILENAME REFFILE '/folders/myshortcuts/Stats506_group4/covid_fix_date/20201111-all-states-history.csv';

/*
import the data
*/
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;