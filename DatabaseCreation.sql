CREATE DATABASE Advising_Team_109
-------------------

CREATE TABLE Student(
    student_id INT PRIMARY KEY IDENTITY,
    f_name VARCHAR(40) NOT NULL,
    l_name VARCHAR(40) NOT NULL,
    gpa DECIMAL(3,2), -- Question 1
    faculty VARCHAR(40),
    email VARCHAR(40),
    major VARCHAR(40),
    password VARCHAR(40),
    financial_status BIT, -- Question 2 =D
    semester INT,
    acquired_hours INT,
    assigned_hours INT,
    --advisor_id INT FOREIGN KEY REFERENCES Advisor(advisor_id), 
    CONSTRAINT check_gpa CHECK (gpa BETWEEN 0.7 AND 5)
)


CREATE TABLE Student_Phone(
    student_id INT FOREIGN KEY REFERENCES Student(student_id),
    phone_number VARCHAR(40),
    CONSTRAINT pk_Student_phone PRIMARY KEY (
        student_id,
        phone_number
    )
)

CREATE TABLE Course(
    course_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(40),
    major VARCHAR(40),
    is_offered BIT,
    credit_hours INT,
    semester INT
)

CREATE TABLE PreqCourse_course(
    prerequisite_course_id INT FOREIGN KEY REFERENCES Course(course_id),
    course_id INT FOREIGN KEY REFERENCES Course(course_id),
    CONSTRAINT pk_PreqCourse_course PRIMARY KEY (
        prerequisite_course_id,
        course_id
    )
)

CREATE TABLE Instructor(
    instructor_id INT PRIMARY KEY IDENTITY, -- Question 3 
    name VARCHAR(40),
    email VARCHAR(40),
    faculty VARCHAR(40),
    office VARCHAR(40)
)


CREATE TABLE Instructor_Course (
    course_id INT FOREIGN KEY REFERENCES Course(course_id),
    instructor_id INT FOREIGN KEY REFERENCES Instructor(instructor_id),
    CONSTRAINT pk_Instructor_Course PRIMARY KEY (
        course_id,
        instructor_id
    )
)


CREATE TABLE Student_Instructor_Course_Take(
    student_id INT FOREIGN KEY REFERENCES Student(student_id),
    course_id INT FOREIGN KEY REFERENCES Course(course_id),
    instructor_id INT FOREIGN KEY REFERENCES Instructor(instructor_id),
    semester_code VARCHAR(40),
    exam_type VARCHAR(40),
    grade INT ,-- QUESTION 4
    CONSTRAINT pk_Student_Instructor_Course_Take PRIMARY KEY(
        student_id,
        course_id,
        instructor_id
    )

)


CREATE TABLE Semester(
    semester_code VARCHAR(40) PRIMARY KEY,
    start_date DATETIME,
    end_date DATETIME
)