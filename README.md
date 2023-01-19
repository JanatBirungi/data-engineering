## Introduction

The aim of this project was to practice data normalization. I used the titanic dataset from Kaggle that you can download [here](https://www.kaggle.com/datasets/brendan45774/test-file). I also downloaded the description of the different columns in the data [here](http://campus.lakeforest.edu/frank/FILES/MLFfiles/Bio150/Titanic/TitanicMETA.pdf) to get a deeper understanding of the data I was going to work with.

I was to create a data model from the titanic dataset, create a PostgresSQL database to upload the tables from the data model and create analyses in SQL and python. 

## Technical Implementation

### Data modelling

I created a data model prototype by hand(pen and paper) to get a good understanding of how the data would flow across the different tables. Using the data provided, I created 6 tables; 

1. Passenger - to store general passenger information
2. Payments - store general payment information on the passengers
3. Passenger_class - related to the class the passenger paid for
4. Survival - show whether the passenger died or survived
5. embarked - information on the port where the passenger boarded from
6. Cabin - the cabin details where the passenger was lodging

                            The normalized data model for the titanic data
<div>
<img src="attachment:WhatsApp%20Image%202022-11-03%20at%202.18.37%20PM.jpeg" width="400"/>
</div>
                             

### Data wrangling

I carried out data wrangling in my effort to create SQL files for uploading to the database. 
Four tables(passenger_class, survival, embarked and cabin) contained unique values, which I normalized to contain details that are referenced in other tables.  
I used excel to replicate the table columns from the data model and populate them with data. I used the `concatenate` function in excel to generate SQL statements using **_insert into table(column names) values (values to insert into table)_**. I applied this formula to the entire rows in the dataset to generate this for all observations. Find the implementation for this in the CSV file in the repository. 

### SQL implementation

I created a PostgresSQL database called titanic using this [course](https://www.youtube.com/watch?v=qw--VYLpxG4). I created tables and uploaded the SQL files created with excel.


### Analysis

I carried out an exploratory analysis in SQL using this data model to generate insights from the titanic data. View the SQL code for my analysis in the **analysis_on_the_titanic_dataset**

I created an exploratory data analysis in python using the flat file and documented my workings in the  **Python EDA on Titanic dataset** which also contains my takeaways. 

