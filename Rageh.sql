CREATE DATABASE Advising_Team_109
GO
use Advising_Team_109
-------------------
GO
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

GO
EXEC CreateALLTABLE

-- Answers Starts here --

-- 2.2 A
Go
CREATE VIEW view_Students
AS
SELECT S.* 
FROM Student S

-- Testing The View
GO
Select * FROM view_Students




-- 2.2 F
GO
CREATE VIEW Courses_MakeupExams(Course_Name , Course_Semster , Exam_ID , Exam_Date , Exam_Type , Course_ID)
AS
SELECT C.name , C.semester , M.* 
FROM Course C INNER JOIN MakeUp_Exam M ON C.course_id = M.course_id

-- Testing The View
GO
Select * FROM Courses_MakeupExams




-- 2.3 B
GO
CREATE PROCEDURE Procedures_AdvisorRegistration
@Advisor_name VARCHAR(40),
@Advisor_password VARCHAR(40),
@Advisor_email VARCHAR(40),
@Advisor_office VARCHAR(40), 
@Advisor_id INT OUTPUT
AS 
BEGIN
   SELECT @Advisor_id = A.advisor_id
   FROM Advisor A
   WHERE  @Advisor_name = A.name AND @Advisor_password = A.password AND @Advisor_email = A.email AND @Advisor_office = A.office 
END

-- Some Insertions
--INSERT INTO Advisor VALUES('ahmed' , 'ahmed@yahoo.com' , 'c4.101' , '1234')
--INSERT INTO Advisor VALUES('sara' , 'sara@yahoo.com' , 'c5.203' , '0000')
--INSERT INTO Advisor VALUES('ali' , 'ali@yahoo.com' , 'c6.203' , '1000')
-- Testing The PROCEDURE
-- Go
-- declare @Advisor_id INT
-- EXEC Procedures_AdvisorRegistration 'allaa' , '0000' , 'allaa@yahoo.com' , 'c5.203', @Advisor_id OUTPUT
-- print @Advisor_id




-- 2.3 G
GO
CREATE PROCEDURE Procedures_AdminAddingCourse
@Course_name VARCHAR(40),
@Course_major VARCHAR(40),
@Course_is_offered BIT,
@Course_credit_hours INT,
@Course_semester INT
AS
BEGIN
   INSERT INTO Course (name, major, is_offered, credit_hours, semester)
   VALUES (@Course_name, @Course_major, @Course_is_offered,       @Course_credit_hours, @Course_semester)
END

-- Testing The PROCEDURE
-- GO
-- EXEC Procedures_AdminAddingCourse 'Networks' , 'MET' , 1 , 2 , 5

-- SELECT * FROM Course




-- 2.3 Q
GO
CREATE FUNCTION FN_AdvisorLogin(@ID INT , @Password VARCHAR(40)) RETURNS BIT
AS
BEGIN
   DECLARE @Success BIT = 0
   IF EXISTS(SELECT A.advisor_id FROM Advisor A WHERE A.advisor_id = @ID AND A.password = @Password)
   BEGIN
      SET @Success = 1
   END
   RETURN @Success
END
   
GO
-- Testing The Function
--DECLARE @OUT BIT = 0
--SET @OUT = dbo.FN_AdvisorLogin(1,'1234')
--PRINT @OUT