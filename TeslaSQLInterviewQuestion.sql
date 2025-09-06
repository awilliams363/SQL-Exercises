/*
-----------------------------------------------------------------------------------------
Angel Williams 
-----------------------------------------------------------------------------------------
Exercise Info:
-----------------------------------------------------------------------------------------

DataLemur SQL Exercise 2: Facebook SQL Interview Question - Page With No Likes 
Completion Date: September 6, 2025
Completion Time: 5 minutes 15 seconds
Exercise Link: https://datalemur.com/questions/tesla-unfinished-parts

-----------------------------------------------------------------------------------------
Problem:
-----------------------------------------------------------------------------------------

Tesla is investigating production bottlenecks and they need your help to extract the relevant data.
Write a query to determine which parts have begun the assembly process but are not yet finished.

Assumptions:

*Parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
*An unfinished part is one that lacks a finish_date.

This question is straightforward, so let's approach it with simplicity in both thinking and solution.

-----------------------------------------------------------------------------------------
*/

CREATE DATABASE dataLemurExercises_db; 
USE DATABASE dataLemurExercises_db;

DROP TABLE IF EXISTS parts_assembly;
CREATE TABLE parts_assembly (
    part VARCHAR(450),
    finish_date DATETIME,
    assembly_step INT
);
INSERT INTO parts_assembly (part, finish_date, assembly_step)
VALUES ('battery', '2022-01-22', 1),
        ('battery', '2022-02-22', 2),
        ('battery', '2022-03-22', 3),
        ('bumper', '2022-01-22', 1),
        ('bumper', '2022-02-22', 2),
        ('bumper', NULL, 3),
        ('bumper', NULL, 4),
        ('door', '2022-01-22', 1),
        ('door', '2022-02-22', 2),
        ('engine', '2022-01-22', 1),
        ('engine', '2022-01-25', 2),
        ('engine', '2022-02-28', 3),
        ('engine', '2022-04-01', 4),
        ('engine', NULL, 5);

SELECT * FROM parts_assembly;
/*

    I specified the a condition for a incompleted part in the where clause. 
    The result provides a list that represents all currently incomplete parts in prodcution. 

*/

SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;