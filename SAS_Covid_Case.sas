/*import the sas data*/
proc import datafile = "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\covid_fix_date\20201111-all-states-history.csv" out = UScovidRawData;
run;

proc SQL;
create table df_covid as 
select date, state,positiveIncrease
from UScovidRawData
where state not in ("AS","GU","MP","PR","VI");

proc print data = work.df_covid;


DATA df_state_q;
set work.df_covid;
if input(date,YYMMDD10.) >= input("2020/10/01",YYMMDD10.) then q = "4";
else if input(date,YYMMDD10.)>= input("2020/07/01",YYMMDD10.) then q = "3";
else if input(date,YYMMDD10.) >=  input("2020/04/01",YYMMDD10.) then q = "2";
else if input(date,YYMMDD10.) >=  input("2020/01/01",YYMMDD10.) then q = "1";
state = state;
positiveIncrease = positiveIncrease;

Proc sql;
create table case_data_byq as 
select q,state,sum(positiveIncrease) as total_pos
from df_state_q
group by q,state
order by state,q;

proc transpose data=work.case_data_byq out=wide_case_data_byq prefix=quarter;
    by state;
    id q;
    var total_pos;
run;

