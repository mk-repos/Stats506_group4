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
select q,state,sum(positiveIncrease) as total_pos
from df_state_q
group by q,state
order by state,q;

/*get wider dataset*/
proc transpose data=work.case_data_byq out=wide_case_data_byq prefix=quarter;
    by state;
    id q;
    var total_pos;
run;

/*import the shape file*/
PROC MAPIMPORT datafile = "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\maps_shifted\us_shifted.shp"
out = USmap;
run;
/*make the shape file*/
Proc SQL;
create table shapefile_Covid as 
select State,X,Y,quarter1,quarter2,quarter3,quarter4
from work.USmap as a inner join work.Wide_case_data_byq as b on b.state = a.STUSPS;
