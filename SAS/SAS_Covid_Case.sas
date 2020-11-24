/*--------------------------------------------------------------------------*/
/*import the sas data*/
proc import datafile="/home/u50241292/20201111-all-states-history.csv" 
		out=UScovidRawData;
run;

/*select the columns we want and filter the data*/
proc SQL;
	create table df_covid as select date, state, positiveIncrease from 
		UScovidRawData where state not in ("AS", "GU", "MP", "PR", "VI");

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
proc transpose data=work.case_data_byq out=wide_case_data_byq 
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

/*import the shape file*/

PROC MAPIMPORT datafile="/home/u50241292/us_shifted.shp" out=USmaps;
run;

/*create the poly Segment with the data*/ 

data US_map;
	set Usmaps;
	seqno=_n_;
run;

proc sql;
	create table polyID as 
	select distinct STUSPS, segment 
	from USmaps 
	group by STUSPS, segment;

data polyID;
	set polyID;
	polyid=_n_;
run;

proc sql;
create table USmap as 
select a.STUSPS, polyid, X, Y, Quarter1,Quarter2,Quarter3,Quarter4
from polyID as a right join US_map as b 
   on a.Segment=b.Segment and a.STUSPS=b.STUSPS 
   right join wide_case_data_byq as c 
   on a.STUSPS = c.STUSPS
order by a.STUSPS, seqno;

proc sql;
create table maxmap as 
select '' as STUSPS,0 as polyid, minX as X, minY as Y,
	q4 as Quarter1,q4 as Quarter2,q4 as Quarter3,q4 as Quarter4
from (
	select '', '',min(X) as minX,min(Y) as minY,
		max(Quarter4) as q4
	from polyID as a right join US_map as b 
	   on a.Segment=b.Segment and a.STUSPS=b.STUSPS 
	   right join wide_case_data_byq as c 
	   on a.STUSPS = c.STUSPS
);

Data US_map_Data;
proc append base=USmap data=maxmap;
run;

proc sgplot data=Usmap noautolegend;
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




	

