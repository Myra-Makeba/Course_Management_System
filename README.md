# 📚 SQL Final Project: Student Course Management System

## 🧾 About the Project

This project simulates a course enrollment system for an EdTech company. It includes the design and implementation of a relational database, population with sample data, and execution of meaningful SQL queries for insights and analysis.



## 🗃️ Database Design

### 📌 Schema Overview

Students

 `student_id` (PK), `first_name`, `last_name`, `email`, `date_of_birth`

Instructors

 `instructor_id` (PK), `first_name`, `last_name`, `email`

Courses

 `course_id` (PK), `course_name`, `course_description`, `instructor_id` (FK)

Enrollments

 `enrollment_id` (PK), `student_id` (FK), `course_id` (FK), `enrollment_date`, `grade`



## 🏁 Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/sql-course-management.git
   ```

2. Open your SQL client and run:

    `create_tables.sql`
    `insert_data.sql`
    `queries.sql` for reports and analysis

3. (Optional) Run `advanced_features.sql` for view, index, and triggers.



## 📈 Key SQL Queries

 Enrolled students
 Students in more than 2 courses
 Total students per course
 Course GPA averages
 Unenrolled students
 Student GPA summary
 Courses per instructor
 Students taught by “John Smith”
 Top 3 students
 Students failing multiple courses



## ⚙️ Advanced Features

VIEW: `student_course_summary`
INDEX: on `Enrollments.student_id`




## 🧪 Sample Data

 10 students
 3 instructors
 5 courses
 15 enrollments (varied grades)


## 🎯 Highlights & Takeaways

 Learned how to design normalized schemas
 Gained hands-on SQL experience with real-world scenarios
 Used advanced SQL constructs for performance and clarity
 Practiced clean, modular SQL file organization





## 🔗 Repository Link

Paste your public GitHub repository link here after uploading.


