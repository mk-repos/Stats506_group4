PROC MAPIMPORT datafile = "/home/u50241292/cb_2018_us_state_500k.shp"
out = USmap;
run;
/*
empty cholopleth map without data
*/
FILENAME plots "/home/u50241292/";
goptions reset=all DEVICE=png ftitle="Arial/bo" GSFNAME=plots GSFMODE=REPLACE NOFILEONLY  Replace;
ods _all_ close;
ods listing;
pattern v = e; /*pattern v = e means draw cholopleath map without the data input*/
title "US Cholopleth map";
proc gmap
	map = USmap
	data = USmap all;
	id stusps;
	choro stusps/ name = "USCholoplethMap" nolengend;
run;
ods listing close;
quit;

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

proc sgplot data=Usmap noautolegend;
	title 'US Cholopleth using original shape file';
	polygon x=X y=Y id=polyid/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black)  dataSkin=matte fill name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;


/*
first few rows of shape file
*/
options printerpath=(png out);
filename out '/home/u50241292/shapefile_firstfewrow.png';
ods listing close;
ods printer;
proc print data = USmap (OBS = 1);
run;
ods printer close;
ods listing;


/*Michigan Example*/
Proc SQL;
create table USmap_Michigan as 
select *
from USmap
where stusps = "MI";

FILENAME plots "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\";
goptions reset=all DEVICE=png ftitle="Arial/bo" GSFNAME=plots GSFMODE=REPLACE NOFILEONLY  Replace;
ods _all_ close;
ods listing;
pattern v = e; /*pattern v = e means draw cholopleath map without the data input*/
title "US - Michigan Map";
proc gmap
	map = Work.USmap_Michigan
	data = Work.USmap_Michigan;
	id stusps;
	choro stusps/ nolegend name = "Michigan";
run;
ods listing close;



proc sgplot data=Usmap(Where = (STUSPS = "MI")) noautolegend;
	title 'US - Michigan Map';
	polygon x=X y=Y id=polyid/ fill fillattrs=(transparency=0.75) outline 
		lineattrs=(color=black)  dataSkin=matte fill name='map';
	gradlegend 'map';
	xaxis display=none;
	yaxis display=none;
run;
