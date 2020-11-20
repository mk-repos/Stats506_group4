/*import the sas data*/
proc import datafile = "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\covid_fix_date\20201111-all-states-history.csv" out = UScovidRawData;
run;

/*select the columns we want and filter the data*/
proc SQL;
create table df_covid as 
select date, state,positiveIncrease
from UScovidRawData
where state not in ("AS","GU","MP","PR","VI");

/*modified the data, create quarter variable*/
DATA df_state_q;
set work.df_covid;
if input(date,YYMMDD10.) >= input("2020/10/01",YYMMDD10.) then q = "4";
else if input(date,YYMMDD10.)>= input("2020/07/01",YYMMDD10.) then q = "3";
else if input(date,YYMMDD10.) >=  input("2020/04/01",YYMMDD10.) then q = "2";
else if input(date,YYMMDD10.) >=  input("2020/01/01",YYMMDD10.) then q = "1";
state = state;
positiveIncrease = positiveIncrease;

/*calculate the positive cases for each quarter*/
Proc sql;
create table case_data_byq as 
select q,state as STUSPS,sum(positiveIncrease) as total_pos
from df_state_q
group by q,state
order by state,q;

/*get wider dataset*/
proc transpose data=work.case_data_byq out=wide_case_data_byq prefix=quarter;
    by STUSPS;
    id q;
    var total_pos;
run;

options printerpath=(png out);
filename out 'c:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\wide_case_data.png';
ods listing close;
ods printer;
title "Value Data";
proc print data = work.wide_case_data_byq;
run;
ods printer close;
ods listing close;


/*import the shape file*/
PROC MAPIMPORT datafile = "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\maps\cb_2018_us_state_500k.shp"
out = USmap;
run;

FILENAME plots "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\";
goptions reset=all DEVICE=png ftitle="Arial/bo" GSFNAME=plots GSFMODE=REPLACE NOFILEONLY;
ods _all_ close;
ods listing;
title "Covid - 19 Positive Number by State: Quarter 4";
proc gmap
	map = Usmap
	data = wide_case_data_byq;
	id STUSPS;
	choro quarter4 / name = "Q4";
run;
quit;


goptions reset=all DEVICE=png ftitle="Arial/bo" GSFNAME=plots GSFMODE=REPLACE NOFILEONLY;
ods _all_ close;
ods listing;
title "Covid - 19 Positive Number by State: Quarter 3";
proc gmap
	map = Usmap
	data = wide_case_data_byq;
	id STUSPS;
	choro quarter3 / name = "Q3";
run;
quit;

goptions reset=all DEVICE=png ftitle="Arial/bo" GSFNAME=plots GSFMODE=REPLACE NOFILEONLY;
ods _all_ close;
ods listing;
title "Covid - 19 Positive Number by State: Quarter 2";
proc gmap
	map = Usmap
	data = wide_case_data_byq;
	id STUSPS;
	choro quarter2 / name = "Q2";
run;
quit;

goptions reset=all DEVICE=png ftitle="Arial/bo" GSFNAME=plots GSFMODE=REPLACE NOFILEONLY;
ods _all_ close;
ods listing;
title "Covid - 19 Positive Number by State: Quarter 1";
proc gmap
	map = Usmap
	data = wide_case_data_byq;
	id STUSPS;
	choro quarter1 / name = "Q1";
run;
quit;
