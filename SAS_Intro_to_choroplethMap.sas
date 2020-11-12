
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
	map = maps.us
	data = maps.us(obs = 1)
	all;
	id state;
	choro state/ nolegend;
run;
quit;

/*
first few rows of shape file
*/
options printerpath=(png out);
filename out 'c:\Users\zhaoleo\GitHub_Folder\Stats506_group4\SAS_document\out.png';
ods listing close;
ods printer;
proc print data = maps.us (OBS = 12);
run;
ods printer close;
ods listing;
