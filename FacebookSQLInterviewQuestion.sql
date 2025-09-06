/*
-----------------------------------------------------------------------------------------
Angel Williams 
-----------------------------------------------------------------------------------------
Exercise Info:
-----------------------------------------------------------------------------------------

DataLemur SQL Exercise 2: Facebook SQL Interview Question - Page With No Likes 
Completion Date: September 6, 2025
Completion Time: 10 minutes 23 seconds
Exercise Link: https://datalemur.com/questions/sql-page-with-no-likes

-----------------------------------------------------------------------------------------
Problem:
-----------------------------------------------------------------------------------------

Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").
Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

-----------------------------------------------------------------------------------------
*/

CREATE DATABASE dataLemurExercises_db;
USE dataLemurExercises_db;

/* 

I created the the pages and page_likes tables. 
Then, I entered the sample data into each table 

*/ 

DROP TABLE IF EXISTS pages;
CREATE TABLE pages (
    page_id INT,
    page_name VARCHAR(300)
);

INSERT INTO pages
VALUES (20001, 'SQL Solutions'),
        (20045, 'Brain Exercises'),
        (20701, 'Tips for Data Analysis'),
        (31111, 'Postgres Crash Course'), 
        (32728, 'Break the thread');

SELECT * FROM pages;
DROP TABLE IF EXISTS page_likes

CREATE TABLE page_likes (
    user_id INT, 
    page_id INT,
    liked_date DATETIME
);

INSERT INTO page_likes (user_id, page_id, liked_date)
VALUES (111, 20001, '2022-04-08'),
        (121, 20045, '2022-03-12'),
        (156, 20001, '2022-07-25'),
        (255, 20045, '2022-07-19'),
        (125, 20001, '2022-07-19'),
        (144, 31111, '2022-06-21'),
        (125, 31111, '2022-07-04');

SELECT * FROM page_likes;

/*

I joined the entire pages table with only their corresponding matches from the page_likes table 
based on the common attribute (page_id) by using a Left Join. 
I specificied selecting pages that exist in the page table, but were not present in the page_likes table in the Where clause 
Then, I ordered the page_ids results in ascending order. 

*/
SELECT p.page_id
FROM pages AS p
LEFT JOIN page_likes AS pLike 
ON p.page_id = pLike.page_id
WHERE pLike.page_id IS NULL
ORDER BY p.page_id; 
