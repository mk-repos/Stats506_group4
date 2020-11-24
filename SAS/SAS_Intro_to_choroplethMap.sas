PROC MAPIMPORT datafile = "/home/u50241292/cb_2018_us_state_500k.shp"
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
select a.STUSPS, polyid, X, Y
from polyID as a right join US_map as b 
   on a.Segment=b.Segment and a.STUSPS=b.STUSPS 
order by a.STUSPS, seqno;

/*Unorder case*/
proc sgplot data=Usmap noautolegend;
	title 'US Cholopleth(Unordered)';
	polygon x=X y=Y id=STUSPS/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black)  dataSkin=matte fill name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;

/*USmap*/

proc sgplot data=Usmap noautolegend;
	title 'US Cholopleth';
	polygon x=X y=Y id=polyid/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black)  dataSkin=matte fill name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;


/*Remove unwanted state*/
Data Usmap;
modify USmap;
if STUSPS = "AS" then remove;
if STUSPS = "GU" then remove;
if STUSPS = "MP" then remove;
if STUSPS = "PR" then remove;
if STUSPS = "VI" then remove;














/*shifted shape file*/

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
select a.STUSPS, polyid, X, Y
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


proc sgplot data=Usmap noautolegend;
	title 'US Cholopleth using shifted shape file';
	polygon x=X y=Y id=polyid/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black)  dataSkin=matte fill name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;



























