
PROC MAPIMPORT datafile = "/home/u50241292/us_shifted.shp"
out = USmap;
run;

/*import the sas data*/
proc import datafile="/home/u50241292/20201111-all-states-history.csv" 
		out=UScovidRawData;
run;

/*select the columns we want and filter the data*/
proc SQL;
create table df_covid as 
select date, state, positiveIncrease 
from UScovidRawData 
where state not in ("AS", "GU", "MP", "PR", "VI");

	/*modified the data, create quarter variable*/
DATA df_state_q;
	set df_covid;

	if input(date, YYMMDD10.) >=input("2020/10/01", YYMMDD10.) then
		q="4";
	else if input(date, YYMMDD10.)>=input("2020/07/01", YYMMDD10.) then
		q="3";
	else if input(date, YYMMDD10.) >=input("2020/04/01", YYMMDD10.) then
		q="2";
	else if input(date, YYMMDD10.) >=input("2020/01/01", YYMMDD10.) then
		q="1";
	state=state;
	positiveIncrease=positiveIncrease;

	/*calculate the positive cases for each quarter*/
Proc sql;
	create table case_data_byq as 
	select q, state as STUSPS, 
		sum(positiveIncrease) as total_pos 
	from df_state_q group by q, state order by state, q;

	/*get wider dataset*/
proc transpose data=case_data_byq out=wide_case_data_byq 
prefix=quarter;
	by STUSPS;
	id q;
	var total_pos;
run;

title "US - Quarter1";
proc gmap
	map = USmap
	data = wide_case_data_byq ;
	id stusps;
	choro quarter1/levels = 10;
run;


title "US - Quarter2";
proc gmap
	map = USmap
	data = wide_case_data_byq ;
	id stusps;
	choro quarter2/levels = 10;
run;

title "US - Quarter3";
proc gmap
	map = USmap
	data = wide_case_data_byq ;
	id stusps;
	choro quarter3/levels = 10;
run;


title "US - Quarter4";
proc gmap
	map = USmap
	data = wide_case_data_byq ;
	id stusps;
	choro quarter4/levels = 10;
run;


