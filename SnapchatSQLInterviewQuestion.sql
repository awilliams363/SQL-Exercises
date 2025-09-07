/*
-----------------------------------------------------------------------------------------
Angel Williams 
-----------------------------------------------------------------------------------------
Exercise Info:
-----------------------------------------------------------------------------------------

DataLemur SQL Exercise 2: Snapchat SQL Interview Question - Sending vs Opening Snaps 
Completion Date: September 6, 2025
Completion Time: 54 minutes 15 seconds
Exercise Link: https://datalemur.com/questions/time-spent-snaps

-----------------------------------------------------------------------------------------
Problem:
-----------------------------------------------------------------------------------------

Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:

Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.

-----------------------------------------------------------------------------------------
*/

CREATE DATABASE dataLemurExercises_db;
USE DATABASE dataLemurExercises_db;

DROP TABLE IF EXISTS activities; 
CREATE TABLE activities (
    activity_id INT, 
    user_id INT, 
    activity_type VARCHAR(400),
    time_spent FLOAT,
    activity_date DATETIME
);
INSERT INTO activities (activity_id, user_id, activity_type, time_spent, activity_date)
VALUES (7274, 123, 'open', 4.50, '2022-06-22'),
        (2425, 123, 'send', 3.50, '2022-06-22'),
        (1413, 456, 'send', 5.67, '2022-06-23'),
        (2536, 456, 'open', 3.00, '2022-06-25'),
        (8564, 456, 'send', 8.24, '2022-06-26'),
        (5235, 789, 'send', 6.24, '2022-06-28'),
        (4251, 123, 'open', 1.25, '2022-07-01'),
        (1414, 789, 'open', 11.00, '2022-06-25'),
        (1314, 123, 'chat', 3.15, '2022-06-26'),
        (1435, 789, 'open', 5.25, '2022-07-02');

DROP TABLE IF EXISTS age_breakdown;
CREATE TABLE age_breakdown(
    user_id INT,
    age_bucket VARCHAR(500)
);
INSERT INTO age_breakdown (user_id, age_bucket)
VALUES (123, '31-35'),
        (456, '26-30'),
        (789, '21-25');

/*
PostgreSQL Solution:
-----------------------------------------------------------------------------------------
SELECT ab.age_bucket,
  ROUND((((SUM(a.time_spent) FILTER (WHERE a.activity_type LIKE 'open')) / (SUM(a.time_spent) FILTER (WHERE a.activity_type LIKE 'open' OR a.activity_type LIKE 'send'))) * 100.0), 2) AS open_perc,
  ROUND((((SUM(a.time_spent) FILTER (WHERE a.activity_type LIKE 'send')) / (SUM(a.time_spent) FILTER (WHERE a.activity_type LIKE 'open' OR a.activity_type LIKE 'send'))) *100.0), 2) AS send_perc
FROM activities as a 
JOIN age_breakdown as ab 
ON a.user_id = ab.user_id
WHERE a.activity_type LIKE 'send' 
OR a.activity_type LIKE 'open'
GROUP BY ab.age_bucket
ORDER BY ab.age_bucket; 
-----------------------------------------------------------------------------------------
*/
/* 
-----------------------------------------------------------------------------------------
My initial solution was performed on DataLemur using PostgreSQL.
Below is a modified solution for SQL and MySQL that elimates the use of the FILTER clause. 

SQL and MySQL Solution: 
-----------------------------------------------------------------------------------------
*/
/*
-----------------------------------------------------------------------------------------
I joined the activities and age_breakdown table based on their common element (user_id).
I grouped and ordered the results by age_bucket. 
I performed the following calculations in the SELECT statement using the CASE WHEN Statements:
  *sending percetage = [time spend sending/ (time spent sending + time spent opening)] * 100 
  *opening percentage = [time spend opening/ (time spent sending + time spent opening)] * 100 
  *rounded results to the second decimal place
-----------------------------------------------------------------------------------------
*/
SELECT ab.age_bucket,
  ROUND((SUM(CASE WHEN a.activity_type = 'open' THEN time_spent END) / (SUM(CASE WHEN (a.activity_type = 'open') OR (a.activity_type = 'send') THEN time_spent END)) * 100.0), 2) AS open_perc,
  ROUND((SUM(CASE WHEN a.activity_type = 'send' THEN time_spent END) / (SUM(CASE WHEN (a.activity_type = 'open') OR (a.activity_type = 'send') THEN time_spent END)) * 100.0), 2) AS send_perc
FROM activities as a 
JOIN age_breakdown as ab 
ON a.user_id = ab.user_id
WHERE a.activity_type LIKE 'send' 
OR a.activity_type LIKE 'open'
GROUP BY ab.age_bucket
ORDER BY ab.age_bucket; 