# Stats506_group4

This repository contains the scripts created for [Group Project, Statistics 506, Fall 2020](https://jbhender.github.io/Stats506/F20/GroupProject.html)

# Group Members
 - [Enhao Li](https://github.com/Lehao25/Stats506_public) (Primary role - Python)
 - [Moeki Kurita](https://github.com/mk-repos/Stats506_public) (Primary role - R)
 - [Dongyang Zhao](https://github.com/zhaodyleo/STATS506_F20) (Primary role - SAS)

# Tutorial

[`./main.html`](https://github.com/mk-repos/Stats506_group4/blob/main/main.html) is the latest version of our tutorial. 

In this tutorial, we explained how to handle shapefiles (geographic data format) in R, Python, and SAS and how to create choropleth maps that show the total number of COVID-19 positives in the U.S. per month/quarter.

Because the file size of `main.html` is too large to preview on Github, **we recommend reviewers to clone this entire repository**.

# To-Do List

The following lists show unfinished tasks.

## Introductions (Sections 1-2) and Conclusion (Section 7)

 - completed
 - waiting for peer reviews

## R
 - completed
 - waiting for peer reviews

## Python

 - completed 
 - waiting for peer reviews

## SAS

 - Procedure to make the shifted map in SAS 
 - extended example: owner defined color choropleth map
 - Waiting for peer reviews

# Collaboration History

 - Code reviews are mostly done through `Issue` on Github.
 - After each member finalize codes in separate files, all the codes and descriptions are integrated into `main.Rmd`.
 - We sometimes overwrite and supplement each other's codes/descriptions in separate files or in `main.Rmd`. Thus there are multiple commits by all members.

# Folder/File Structure

The current structure is shown below. It will likely be reorganized before final submission.

 - Main Document
	 - `proposal.md` is the original proposal for this project
	 - `main.Rmd` will include all codes and descriptions for R, Python, and SAS examples
	 - `main.html` is the rendered version of `main.Rmd`
 - Dataset Directory
	 - `./maps` directory stores shapefiles downloaded from the Census Bureau
	 - `./maps_comp` directory stores compiled shapefiles( modified by [website](https://mapshaper.org/)). Pyhton example use this instead of original shapefiles
	 - `./maps_shifted` directory stores shapefiles modified by our R example. SAS example may use this instead of original shapefiles
	 - `./covid_fix_date` stores covid data as of 2020-11-11
 - R
	 - all codes are stored inside `main.Rmd`
	 - all figures are stored in `./main_files/figure-html`
 - Python

	 - all python code are stored in `./python_code` directory
	 	- `python_base.ipynb` stores codes for the core example
	 	- `python_extend.ipynb` stores codes for the extended example
	 - all figures are stored in `./python_files`
 - SAS
 	 - all SAS code are stored in `./SAS_code` directory
	 	- `SAS_Intro_to_choroplethMap.sas` stores codes for Section 3
	 	- `SAS_Covid_Case.sas` stores codes for Section 4
	 - all figures are stored in `./SAS_document`
