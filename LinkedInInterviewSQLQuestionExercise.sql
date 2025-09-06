/*
-----------------------------------------------------------------------------------------
Angel Williams 
-----------------------------------------------------------------------------------------
Exercise Info:
-----------------------------------------------------------------------------------------

DataLemur SQL Exercise 1: LinkedIn Interview SQL Question 
Completion Date: September 6, 2025
Completion Time: 16 minutes 44 seconds
Exercise Link: https://datalemur.com/questions/matching-skills?referralCode=Basm0AN9

-----------------------------------------------------------------------------------------
Problem:
-----------------------------------------------------------------------------------------

Given a table of candidates and their skills,
you're tasked with finding the candidates best suited for an open Data Science job. 
You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
Write a query to list the candidates who possess all of the required skills for the job. 
Sort the output by candidate ID in ascending order.

-----------------------------------------------------------------------------------------
*/
CREATE DATABASE linkedInExercise_db;
USE linkedInExercise_db; 
DROP TABLE IF EXISTS candidates;
CREATE TABLE candidates(
    candidate_id INT, 
    skill VARCHAR(200)
);

INSERT INTO candidates (candidate_id, skill)
VALUES (123, 'Python'), 
            (123, 'Tableau'), 
            (123, 'PostgreSQL'), 
            (234, 'R'), 
            (234, 'PowerBI'),
            (234, 'SQL Server'), 
            (345, 'Python'), 
            (345, 'Tableau');

SELECT * FROM candidates;


/*

The three desired candidate skills (Python, Tableau, and PostgreSQL) are defined in the where clause.  
I selected candidates that have at least all three of the desired skills 
by using the Group By statement on candidate_id and the Having clause to define the conidition
Then, I ordered the candidates by candidate_id in ascending order. 

*/
SELECT candidate_id, COUNT(skill)
FROM candidates
WHERE 
  skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) >= 3
ORDER BY candidate_id; 

/* 

To improve testing on my query, I am adding to the table: 
    *2 more candidates that have all 3 skills
    
*/ 

SELECT * FROM candidates;
INSERT INTO candidates (candidate_id, skill)
VALUES (456, 'Python'),
        (456, 'PostgreSQL'),
        (456, 'Tableau'),
        (567, 'Python'),
        (567, 'PostgreSQL'),
        (567, 'Tableau');

/* 

Reattempting Query 

*/

SELECT * FROM candidates;

SELECT candidate_id, COUNT(skill)
FROM candidates
WHERE 
  skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) >= 3
ORDER BY candidate_id; 
