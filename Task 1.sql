create database student_scores;
use student_scores;

create table student_details(id int primary key,
first_name varchar(355),
last_name varchar(355),
email varchar(355),
gender char(30),
part_time_job char(30),
absence_days int,
extracurricular_activities char(30),
weekly_self_study_hours int,
career_aspiration char(40),
math_score int,
history_score int,
physics_score int,
chemistry_score int,
biology_score int,
english_score int,
geography_score int);


/*Task-1 Calculate the average math_score for each career_aspiration. Order the results by the average score in descending order */
Select career_aspiration,avg(math_score) as MATH_SCORE from student_details
group by career_aspiration
order by math_score desc;

/*Task-2 Find the career_aspirations that have an average english_score greater than 75. Display the career aspiration and the average score */
select career_aspiration,avg(english_score) as eng_score from student_details
where english_score > 75
group by career_aspiration;

/*Task-3 Identify students who have a math_score higher than the school's average math score. List their first_name, last_name, and math_score */
select first_name,last_name,math_score from student_details
where math_score > (select avg(math_score) from student_details);

/*Task-4 Rank students within each career_aspiration category by their physics_score in descending order. Display the first_name, last_name, career_aspiration, physics_score, and the rank*/
select first_name, last_name, career_aspiration, physics_score,
rank() over (order by physics_score desc) as rank_no from student_details;

/*Task-5  For each student, create a new column full_name by concatenating first_name and last_name with a space in between. Show the full_name and email columns where the email contains the string "academy" */
select email,concat(first_name," ",last_name) as full_name
from student_details;

/*Task-6 Calculate the lowest (FLOOR), highest (CEIL), and average (ROUND to two decimal places) chemistry_score for each career aspirant. Display the career aspirants
, lowest score, highest score, and average score */
select career_aspiration,chemistry_score, count(*) from student_details
group by career_aspiration,chemistry_score;

/*Task-7 Find career aspirations where the average history_score is above 85 and at least 5 students aspire to that career. List the career_aspiration and the average score */
select career_aspiration,avg(history_score) as hist_score from student_details
group by career_aspiration
having avg(history_score) > 85;

/*Task-8 Identify students who score above average in both biology and chemistry, compared to the school's average for those subjects. Display their id, first_name, last_name, biology_score, and chemistry_score */
select id, first_name, last_name, biology_score, chemistry_score,avg(biology_score) as bio_score,avg(chemistry_score) as chem_score from student_details
where biology_score > (select avg(biology_score) from student_details)
group by biology_score;

/*Task-9 Calculate the percentage of absence days for each student relative to the total absence days recorded for all students. Display the id, first_name, last_name, and the calculated percentage, rounded to two decimal places. Order the results by the percentage in descending order */
select id, first_name, last_name, count(absence_days),
count(absence_days)/(select count(absence_days) from student_details) * 100 as "calculated percentage" from student_details
group by id;

/*Task-10 Identify students who have scores above 80 in at least three out of the six subjects: math, history, physics, chemistry, biology, and English. Display their id, first_name, last_name, and the count of subjects where they scored above 80.*/
select  id, first_name, last_name,math_score,history_score,physics_score,chemistry_score,biology_score,english_score from student_details
where math_score > 80 and history_score> 80 and physics_score> 80 and chemistry_score> 80 and biology_score> 80 and english_score> 80
group by id;

