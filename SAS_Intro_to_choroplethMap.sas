PROC MAPIMPORT datafile = "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\maps\cb_2018_us_state_500k.shp"
out = USmap;
run;
/*
empty cholopleth map without data
*/
FILENAME plots "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\";
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


/*
first few rows of shape file
*/
options printerpath=(png out);
filename out 'c:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\shapefile_firstfewrow.png';
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
