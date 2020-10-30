# Generate Choropleth Maps of Covid-19 Cases in the United States

## Topics Covered

graphical concepts and provide a tutorial on how to carry them out
 - How to draw a geographic map using a geospatial vector data, `shapefile` (R/Python/SAS)
 - How to visualize the frequency of spatial events using a heat map, projected onto boundary information using `shapefile` (R/Python/SAS)
 - Extended examples of an HTML interactive map that allows users to specify the time frame for aggregation (not available in SAS)

## Keywords

Choropleth Map, GIS, shapefile, Interactive Report

## Summary

A choropleth map is a very useful tool in visualizing the differences between regions. Using daily count data from Covid-19 obtained from the [COVID Tracking Project](https://covidtracking.com/), we visualize the total number of new infections in the U.S. for each quarter in 2020 at the state level.

Furthermore, we show that choropleth maps are also powerful for visualizing spatio-temporal data that evolve with time. We create examples of an interactive map for the same dataset where users can change the aggregation period. Users can see which areas were hotspots of infection at which point in time.

Although we only use the U.S. data in this tutorial, we adopt a universal method using  `shapefile` instead of using a special package made exclusively for the U.S. (such as `usmap` package in R) to ensure a consistent presentation across software tools and to allow users to apply our tutorial for visualizations in different resolutions (international, state, county, zip code, etc.) and in different situations.

## Dataset

COVID Tracking Project - Data by State
 - can be downloaded [here](https://covidtracking.com/data/download)
 - daily data on the COVID-19 pandemic for the US and individual states
 - available since 2020/01/22
 - `positive` variable shows the number of positivity

## Software Tools (Primary Member)

 - R: ggplot, rgdal, plotly (Moeki Kurita)
 - Python: geopandas, matplotlib/bokeh (Enhao Li)
 - SAS: Proc Mapimport, Proc Gmap (Dongyang Zhao)
