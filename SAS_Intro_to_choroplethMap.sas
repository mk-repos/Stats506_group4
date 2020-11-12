PROC MAPIMPORT datafile = "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\maps\cb_2018_us_state_500k.shp"
out = USmap;
run;
/*
empty cholopleth map without data
*/
FILENAME plots "C:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\";
goptions reset=all DEVICE=png ftitle="Arial/bo" GSFNAME=plots GSFMODE=REPLACE NOFILEONLY;
ods _all_ close;
ods listing;
pattern v = e; /*pattern v = e means draw cholopleath map without the data input*/
title "Cholopleth map example";
proc gmap
	map = USmap
	data = USmap;
	id stusps;
	choro awater/ nolegend;
run;
quit;

/*
first few rows of shape file
*/
options printerpath=(png out);
filename out 'c:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\shapefile_firstfewrow.png';
ods listing close;
ods printer;
proc print data = USmap (OBS = 12);
run;
ods printer close;
ods listing;

Proc SQL;
create table USmap_withoutAlaska as 
select *
from USmap
where Name ~= "Alaska" and Name ~= "American Samoa" and Name ~= "Commonwealth of the Northem Mariana Islands";


proc gmap
	map = Work.USmap_withoutAlaska
	data = Work.USmap_withoutAlaska;
	id stusps;
	choro awater/ nolegend;
run;
