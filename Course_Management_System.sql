create schema Course_Management;
create table Course_Management.Students(student_id(int,primary key),first_name varchar (20),last_name varchar(20),email varchar,date_of_birth date);
alter table Course_Management.Students
add constraint students_pkey Primary key (student_id);
select *from Course_Management.Students;
insert into Course_Management.Students
values (001,'Myra','Makeba','myramakeba@gmail.com','2006-04-28'),
(002,'Mark','Kinuthia','MarkKinuthia@gmail.com','2005-06-27'),
(003,'Elsie','Ella','ElsieElla@gmail.com','2004-07-06'),
(004,'Vanessa','Noni','VanessaNoni@gmail.com','2006-07-15'),
(005,'Lavender','Mutiso','LavenderMutiso@gmail.com','2005-08-24'),
(006,'Victor','Wangai','Wangai@gmail.com','2005-07-09'),
(007,'Alex','Mwenda','Alexmwenda@gmail.com','2007-04-27'),
(008,'Jenelle','Wawira','jennellewawira@gmail.com','2004-07-27'),
(009,'Nancy','Mbeere','Nancymbeere@gmail.com','2004-05-16'),
(010,'Eric','Kamau','Ericamau@gmail.com','2007-01-14');


create table (instructor_id INT PRIMARY key,
first_name VARCHAR,
last_name VARCHAR,
email VARCHAR);
select*from Course_Management.Instructors;
insert into Course_Management.Instructors
values (100,'John','Maina','Johnmaina@gmail.com'),
(200,'Alice','Kibet','Alicekibet@gmail.com'),
(300,'Damaris','Muthoni','Damarismuthoni@gmail.com');

create table Course_Management.Courses (course_id INT PRIMARY key,
course_name VARCHAR,
course_description TEXT,
instructor_id INT, 
FOREIGN key (instructor_id)references Course_Management.Instructors(Instructor_id));
select*from Course_Management.Courses;
insert into Course_Management.Courses
values (101,'Linear_Algebra','Linear algebra is the study of vectors, matrices, and linear equations, used to solve problems in math, science, and engineering.
',100),
(102,'Discrete_Mathematics','Discrete mathematics studies mathematical structures that are distinct and countable, like logic, sets, graphs, and algorithms—essential for computer science.',
200),
(103,'Fundamentals_of_Computer_Systems','This field explores how computers work, covering hardware, software, data representation, and how systems process and store information.'
,300),
insert into Course_Management.Courses
values(104,'Exploratory_Data_Analysis', 'Introduction to analyzing data patterns using visual and statistical tools.',100),
(105,'Communication_Skills','Basics of effective verbal and written communication.',200);


create table Course_Management.Enrollments (enrollment_id INT PRIMARY key,
student_id INT,
course_id INT,
enrollment_date DATE,
grade CHAR(1),
Foreign key (student_id) references Course_Management.Students(student_id),
foreign key (course_id) references Course_Management.Courses(course_id));
select*from Course_Management.Enrollments;


insert into Course_Management.Enrollments
values(111,001,101,'2025/01/12','A'),
(112,002,102,'2025/01/12','B'),
(113,003,103,'2025/01/12','C'),
(114,004,104,'2025/01/12','D'),
(115,005,105,'2025/01/12','E'),
(116,006,101,'2025/01/12','F'),
(117,007,102,'2025/01/12','A'),
(118,008,103,'2025/01/12','B'),
(119,009,104,'2025/01/12','C'),
(120,010,105,'2025/01/12','D'),
(121,001,105,'2025/01/12','E'),
(122,002,104,'2025/01/12','F'),
(123,003,104,'2025/01/12','A'),
(124,004,103,'2025/01/12','B'),
(125,005,101,'2025/01/12','C');

--1.Students who enrolled in atleast one course.
select distinct Students.student_id,Students.first_name,Students.last_name
from Course_Management.Students
join Course_Management.Enrollments on Students.student_id = Enrollments.student_id;

--2.Students enrolled in more than two courses.
select Students.student_id,Students.first_name,Students.last_name,count (Enrollments.course_id) as course_count
from Course_Management.Students
join Course_Management.Enrollments on Students.student_id = Enrollments.student_id
group by Students.student_id,Students.first_name,Students.last_name
having count (Enrollments.course_id)>2;

--3.Courses with total enrolled students.
select Courses.course_id,Courses.course_name,count(Enrollments.student_id)as total_students
from Course_Management.Courses
join Course_Management.Enrollments on Courses.course_id = Enrollments.course_id
group by Courses.course_id,Courses.course_name;

--4.Average Grade per course(A=4,...F=0)
select  Courses.course_id,Courses.course_name,
round(AVG(
case Enrollments.grade
When'A' then 4
when 'B' then 3
when 'C'then 2
when 'D'then 1
when 'E'then 0.5
when 'F'then 0
end 
),2) as average_grade
from Course_Management.Courses
join Course_Management.Enrollments on Courses.course_id = Enrollments.course_id
group by Courses.course_id,Courses.course_name;

-- 5.Students who havent enrolled in any course
select  Students.student_id,Students.first_name,Students.last_name
from Course_Management.Students
left join Course_Management.Enrollments on Students.student_id =Enrollments.student_id
where Course_Management.Enrollments.course_id is null ; 

--6.Courses not taught by any Instructor.
select  Courses.course_id,Courses.course_name
from Course_Management.Courses
left join Course_Management.Instructors on courses.instructor_id=Instructors.instructor_id
where Courses.instructor_id is null;

--7.Instructors teaching more than one course
SELECT 
    Students.student_id,
    Students.first_name,
    Students.last_name,
    ROUND(AVG(
        CASE Enrollments.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'E' THEN 0.5
            WHEN 'F' THEN 0
        END
    ), 2) AS average_gpa
FROM Course_Management.Students
JOIN Course_Management.Enrollments ON Students.student_id = Enrollments.student_id
GROUP BY Students.student_id, Students.first_name, Students.last_name
ORDER BY average_gpa DESC
LIMIT 3;
--Students failing('F')in more than one course.
SELECT 
    Students.student_id,
    Students.first_name,
    Students.last_name,
    COUNT(*) AS num_failures
FROM Course_Management.Students
JOIN Course_Management.Enrollments ON Students.student_id = Enrollments.student_id
WHERE Enrollments.grade = 'F'
GROUP BY Students.student_id, Students.first_name, Students.last_name
HAVING COUNT(*) > 1;


create view Student_Average_GPA as
select
Students.student_id,
    Students.first_name,
    Students.last_name,
    ROUND(AVG(
        CASE Enrollments.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'E' THEN 0.5
            WHEN 'F' THEN 0
        END
    ), 2) AS average_gpa
FROM Course_Management.Students
JOIN Course_Management.Enrollments ON Students.student_id = Enrollments.student_id
GROUP BY Students.student_id, Students.first_name, Students.last_name;
select*from Student_Average_GPA;

CREATE INDEX idx_students_last_name
ON Course_Management.Students(last_name);

EXPLAIN SELECT * FROM Course_Management.Students WHERE last_name = 'Makeba';

































select Instructors.instructor_id,Instructors.first_name,Instructors.last_name
from Course_Management.Instructors
join  Course_Management.Courses on Instructors.instructor_id= Courses.instructor_id
group by  Instructors.instructor_id,Instructors.first_name,Instructors.last_name
having count (Courses.course_id)>1;
--8.Students enrolled in a course taught by "John Maina"
SELECT Students.student_id, Students.first_name, Students.last_name
FROM Course_Management.Students
JOIN Course_Management.Enrollments ON Students.student_id = Enrollments.student_id
JOIN Course_Management.Courses ON Enrollments.course_id = Courses.course_id
JOIN  Course_Management.Instructors ON Courses.instructor_id = Instructors.instructor_id
WHERE Instructors.first_name = 'John' AND Instructors.last_name = 'Maina';
--9.Top 3 students by average grade
















