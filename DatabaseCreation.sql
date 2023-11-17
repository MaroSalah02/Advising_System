CREATE DATABASE Advising_Team_109
-------------------
go
CREATE PROCEDURE CreateALLTABLE
AS  
BEGIN
    CREATE TABLE Advisor(
        advisor_id INT PRIMARY KEY IDENTITY,
        name VARCHAR(40),
        email VARCHAR(40),
        office VARCHAR(40),
        password VARCHAR(40)
    )

    
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
        advisor_id INT FOREIGN KEY REFERENCES Advisor(advisor_id), 
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
        grade VARCHAR(40) ,-- QUESTION 4 (Answered)
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


    CREATE TABLE Course_Semester(
        course_id INT FOREIGN KEY REFERENCES Course(course_id),
        semester_code VARCHAR(40) FOREIGN KEY REFERENCES Semester(semester_code),
        CONSTRAINT pk_Course_Semester PRIMARY KEY(
            course_id,
            semester_code
        )
    )


    CREATE TABLE Slot(
        slot_id INT PRIMARY KEY IDENTITY,
        day VARCHAR(40), -- Question 5
        time INT CONSTRAINT check_time CHECK (time BETWEEN 1 AND 5), -- Question 6
        location VARCHAR(40),
        course_id INT FOREIGN KEY REFERENCES Course(course_id),
        instructor_id INT FOREIGN KEY REFERENCES Instructor(instructor_id) 
    )


    create table Graduation_Plan(
        plan_id int identity,
        semster_code varchar(40),
        semster_credit_hours int,
        expected_grad_semster int,
        advisor_id int FOREIGN KEY REFERENCES Advisor(advisor_id),
        student_id int FOREIGN KEY REFERENCES Student(student_id),
        constraint pk_Graduation_Plan PRIMARY KEY(
            plan_id,
            semster_code
        )
    )


    CREATE TABLE GradPlan_Course(
        plan_id int ,
        semster_code varchar(40),
        course_id int foreign key references Course,
        Constraint fk_plan_semester FOREIGN KEY (plan_id,semster_code) REFERENCES Graduation_Plan(plan_id,semster_code),
        constraint pk_GradPlan_Course primary key(
            plan_id,
            semster_code,
            course_id
        )
    )

    CREATE TABLE Payment(
        payment_id INT PRIMARY KEY IDENTITY,
        amount DECIMAL, -- Question 9
        deadline DATE,
        n_installments INT,
        status VARCHAR(40) default 'notPaid', -- Question 7
        fund_percentage DECIMAL,
        student_id INT FOREIGN KEY REFERENCES Student(student_id),
        semester_code VARCHAR(40),
    )

    CREATE TABLE Installment(
        payment_id INT FOREIGN KEY REFERENCES Payment(payment_id),
        deadline DATE,
        CONSTRAINT pk_Installment PRIMARY KEY (payment_id, deadline),
        amount DECIMAL, -- Question 9
        status VARCHAR(40) default 'notPaid',
        start_date DATE
    )


    create table Request(
        request_id INT primary key identity,
        type varchar(40),
        comment varchar(40),
        status varchar(40) default 'pending',
        credit_hours INT, -- Question 8
        student_id INT FOREIGN KEY REFERENCES Student(student_id),
        advisor_id INT FOREIGN KEY REFERENCES Advisor(advisor_id),
        course_id INT
    )

    create table MakeUp_Exam(
        exam_id INT primary key IDENTITY,
        date DATE,
        type VARCHAR(40),
        course_id INT FOREIGN KEY REFERENCES Course(course_id)
    )

    create table Exam_Student(
        exam_id INT FOREIGN KEY REFERENCES MakeUp_Exam(exam_id),
        student_id INT FOREIGN KEY REFERENCES Student(student_id),
        course_id INT,
        primary key(exam_id, student_id) 
    )

END;