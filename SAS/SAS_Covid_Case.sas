/*--------------------------------------------------------------------------*/
/*prepare shape file*/
PROC MAPIMPORT datafile = "/home/u50241292/us_shifted.shp"
out = USmap;
run;


data US_map;
	set Usmap;
	seqno=_n_;
run;

proc sql;
	create table polyID as 
	select distinct STUSPS, segment 
	from USmap
	group by STUSPS, segment;

data polyID;
	set polyID;
	polyid=_n_;
run;

proc sql;
create table USmap as 
select a.STUSPS, polyid, X, Y, seqno
from polyID as a right join US_map as b 
   on a.Segment=b.Segment and a.STUSPS=b.STUSPS 
order by a.STUSPS, seqno;

Data Usmap;
modify USmap;
if STUSPS = "AS" then remove;
if STUSPS = "GU" then remove;
if STUSPS = "MP" then remove;
if STUSPS = "PR" then remove;
if STUSPS = "VI" then remove;


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

options printerpath=(png out);
filename out '/home/u50241292/wide_case_data.png';
ods listing close;
ods printer;
title "Value Data";

proc print data=work.wide_case_data_byq;
run;

ods printer close;
ods listing close;


proc sql;
create table USmap as 
select a.STUSPS, polyid, X, Y, Quarter1,Quarter2,Quarter3,Quarter4
from USmap as a 
   right join wide_case_data_byq as b
   on a.STUSPS = b.STUSPS
order by a.STUSPS, seqno;

proc sql;
create table maxmap as 
select '' as STUSPS,0 as polyid, minX as X, minY as Y,
	q1 as Quarter1,q2 as Quarter2,q3 as Quarter3,q4 as Quarter4
from (
	select '', '',min(X) as minX,min(Y) as minY,
		max(Quarter4) as q4, max(Quarter3) as q3,
		max(Quarter2) as q2, max(Quarter1) as q1
	from polyID as a right join US_map as b 
	   on a.Segment=b.Segment and a.STUSPS=b.STUSPS 
	   right join wide_case_data_byq as c 
	   on a.STUSPS = c.STUSPS
);

Data maxmap; 
set maxmap;
max = quarter1;
if quarter2 > max then max = quarter2;
if quarter3 > max then max = quarter3;
if quarter4 > max then max = quarter4;
quarter1 = max;
quarter2 = max;
quarter3 = max;
quarter4 = max;
drop max;

proc append base=USmap data=maxmap;
run;

options printerpath=(png out);
filename out '/home/u50241292/USmap_last10.png';
ods listing close;
ods printer;
proc print data=USmap(firstobs=285583);
run;
ods printer close;
ods listing;

proc sgplot data=USmap  noautolegend;
	title 'Covid - 19 Positive Number by State: Quarter 1';
	polygon x=X y=Y id=polyID/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black) 
	    colorresponse=Quarter1 dataSkin=matte fill colormodel=(white greenyellow green blue purple
		 red black) name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;

proc sgplot data=Usmap noautolegend;
	title 'Covid - 19 Positive Number by State: Quarter 2';
	polygon x=X y=Y id=polyID/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black) 
	    colorresponse=Quarter2 dataSkin=matte fill colormodel=(white greenyellow green blue purple
		 red black) name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;

proc sgplot data=Usmap noautolegend;
	title 'Covid - 19 Positive Number by State: Quarter 3';
	polygon x=X y=Y id=polyID/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black) 
	    colorresponse=Quarter3 dataSkin=matte fill colormodel=(white greenyellow green blue purple
		 red black) name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;

proc sgplot data=Usmap noautolegend;
	title 'Covid - 19 Positive Number by State: Quarter 4';
	polygon x=X y=Y id=polyID/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black) 
	    colorresponse=Quarter4 dataSkin=matte fill colormodel=(white greenyellow green blue purple
		 red black) name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;






	

