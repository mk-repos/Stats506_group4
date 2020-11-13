# Stats506_group4

This repository contains the scripts created for [Group Project, Statistics 506, Fall 2020](https://jbhender.github.io/Stats506/F20/GroupProject.html)

# Group Members
 - [Enhao Li](https://github.com/Lehao25/Stats506_public)
 - [Moeki Kurita](https://github.com/mk-repos/Stats506_public)
 - [Dongyang Zhao](https://github.com/zhaodyleo/STATS506_F20)

# To-Do List

## Introductions (Sections 1-2)

 - waiting for peer reviews

## R

 - waiting for peer reviews

## Python

 - task here 

## SAS

 - Write detail instruction about the steps 
 - extended example: owner defined color choropleth map
 - Waiting for peer reviews

# Collaboration History
 - Code reviews are mostly done through `Issue` on Github.
 - After each member finalize codes in separate files, all the codes and descriptions are integrated into `main.Rmd`.
 - We overwrite and supplement each other's descriptions in `main.Rmd`. Thus there are multiple commits by all members.

# Folder/File Structure

The current structure is shown below. It will likely be reorganized before final submission.

 - Main Document
	 - `proposal.md` is the original proposal for this project
	 - `main.Rmd` will include all codes and descriptions for R, Python, and SAS examples
	 - `main.html` is the rendered version of `main.Rmd`
	 - `./maps` directory stores shapefiles downloaded from the Census Bureau
	 - `./maps_shifted` directory stores shapefiles shifted by our R example. SAS example may use this instead of original shapefiles
	 - `./covid_fix_date` stores covid data as of 2020-11-11
 - R
	 - all codes are stored inside `main.Rmd`
	 - all figures are stored in `./main_files/figure-html`
 - Python codes
	 - `python_base.ipynb` stores codes for the core example
	 - `python_extend.ipynb` stores codes for the extended example
	 - all figures are stored in `./python_files`
 - SAS
	 - `SAS_Intro_to_choroplethMap.sas` stores codes for Section 3
	 - `SAS_Covid_Case.sas` stores codes for Section 4
	 - all figures are stored in `./sas_files`
