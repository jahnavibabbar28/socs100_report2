# socs100_report2

SOCS100 Computational Social Science Report 2

Project: Health Insurance Coverage in the United States

Overview
This repository contains a US Health Insurance Data Analysis report and Web Shiny App, which aims to examine the variation in health insurance across the US, using US Census Data from 2019. It aims to drive data-driven research on the underlying socioeconomic factors in these regions influencing the varying health insurance outcomes in different regions, and support research for data-driven policymaking and targetted intervention. 


Report Details
Title: Health Insurance Coverage in the United States
Word Count: 1521 words
Purpose: The purpose of this project is to explore variations in health insurance coverage across U.S. states and demographic groups. It aims to understand how factors like age, income, and geographical location influence insurance outcomes and inform targeted health policy interventions.

Dataset Information
Source: U.S. Census Bureau, 2019 American Community Survey (ACS)
Dataset Structure: The data is structured in three separate CSV files containing detailed information on health insurance coverage across states, age groups, and over time.
Variables: state, uninsured, privately_insured, publicly_insured, uninsured_rate, privately_insured_rate, publicly_insured_rate, age_group, year

Files Included
socs100_report2.qmd -Quarto File of Report
socs100_report2.html -HTML Final Report
socs100_code2.R -R Script
app.R -ShinyWeb App
state_insurance.csv -Data from US Census for Vis 1
age_insurance.csv -Data from US Census for Vis 2
insurance_data_over_time.csv -Data from US Census for Vis 3
Visualisation1.png -Image of Visualisation 1 from App
Visualisation2.png -Image of Visualisation 2 from App
Visualisation3.png -Image of Visualisation 3 from App

Requirements
R version: 4.0 or higher.
Libraries: tidyverse, shinydashboard, shiny, ggplot2, dplyr, readr, plotly, leaflet

Usage
1. Clone the repository.
2. Request an API key from US Census at https://api.census.gov/data/key_signup.html 
3. Load socs100_code2.R in RStudio.
4. Load app.R 
5. Run the script to reproduce the analysis and dashboard visualisations.
6. Navigate to the Shiny App in your local browser to interact with the visualizations and explore the data.

Report Conclusions
This project provides insights into the variation in health insurance coverage across the U.S. States and demographic groups. By identifying key socio-economic factors that influence coverage, such as income level and age, the analysis informs policymakers on potential interventions to reduce disparities in health insurance coverage. The Shiny App visualizations provide an accessible interface for users to explore state, age, and temporal variations, supporting further research and policy development.

Contact
For any queries or further information, please reach out to candidate QBSJ5 from UCL SOCS100. 
