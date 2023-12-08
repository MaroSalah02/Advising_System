--2.1-1
--DROP DATABASE Advising_Team_109
--CREATE DATABASE Advising_Team_109
-------------------
--2.1-2
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
        advisor_id INT,
		CONSTRAINT fk_student_advisor FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id) ON DELETE SET NULL ON UPDATE CASCADE,
        CONSTRAINT check_gpa CHECK (gpa BETWEEN 0.7 AND 5)
    )


    CREATE TABLE Student_Phone(
        student_id INT,
        phone_number VARCHAR(40),
        CONSTRAINT pk_Student_phone PRIMARY KEY (
            student_id,
            phone_number
        ),
		CONSTRAINT fk_phone_student FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE ON UPDATE CASCADE
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
        prerequisite_course_id INT,
        course_id INT,
        CONSTRAINT pk_PreqCourse_course PRIMARY KEY (
            prerequisite_course_id,
            course_id
        ),
        CONSTRAINT fk_preqCourse_course FOREIGN KEY (course_id) REFERENCES Course(course_id),
        CONSTRAINT fk_preqCourse_prereq FOREIGN KEY (prerequisite_course_id) REFERENCES Course(course_id)
    )

    CREATE TABLE Instructor(
        instructor_id INT PRIMARY KEY IDENTITY, -- Question 3 
        name VARCHAR(40),
        email VARCHAR(40),
        faculty VARCHAR(40),
        office VARCHAR(40)
    )


    CREATE TABLE Instructor_Course (
        course_id INT,
        instructor_id INT,
        CONSTRAINT fk_instructorCourse_course FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_instructorCourse_instructor FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT pk_Instructor_Course PRIMARY KEY (
            course_id,
            instructor_id
        )
    )


    CREATE TABLE Student_Instructor_Course_Take(
        student_id INT,
        course_id INT,
        instructor_id INT,
        semester_code VARCHAR(40),
        exam_type VARCHAR(40),
        grade VARCHAR(40) ,-- QUESTION 4 (Answered)
        CONSTRAINT fk_take_student FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_take_course FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_take_instructor FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT pk_Student_Instructor_Course_Take PRIMARY KEY(
            student_id,
            course_id,
            semester_code
        )

    )


    CREATE TABLE Semester(
        semester_code VARCHAR(40) PRIMARY KEY,
        start_date DATE,
        end_date DATE
    )


    CREATE TABLE Course_Semester(
        course_id INT,
        semester_code VARCHAR(40),
        CONSTRAINT fk_courseSemester_course FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_courseSemester_semester FOREIGN KEY (semester_code) REFERENCES Semester(semester_code) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT pk_Course_Semester PRIMARY KEY(
            course_id,
            semester_code
        )
    )

    
    CREATE TABLE Slot(
        slot_id INT PRIMARY KEY IDENTITY,
        day VARCHAR(40), -- Question 5
        time VARCHAR(40) CONSTRAINT check_time CHECK (time IN ('1','2','3','4','5')), -- Question 6
        location VARCHAR(40),
        course_id INT FOREIGN KEY REFERENCES Course(course_id),
        instructor_id INT FOREIGN KEY REFERENCES Instructor(instructor_id) 
    )


    CREATE TABLE Graduation_Plan(
        plan_id INT IDENTITY,
        semester_code VARCHAR(40),
        semester_credit_hours INT,
        expected_grad_date DATE,
        advisor_id INT,
        student_id INT,
        CONSTRAINT fk_gradPLan_advisor FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id) ON DELETE SET NULL ON UPDATE CASCADE,
        CONSTRAINT fk_gradPLan_student FOREIGN KEY (student_id) REFERENCES Student(student_id),
        CONSTRAINT pk_Graduation_Plan PRIMARY KEY(
            plan_id,
            semester_code
        )
    )


    CREATE TABLE GradPlan_Course(
        plan_id INT,
        semester_code VARCHAR(40),
        course_id INT,
        CONSTRAINT fk_gradPlanCourse_gradPlan FOREIGN KEY (plan_id,semester_code) REFERENCES Graduation_Plan(plan_id,semester_code),
        CONSTRAINT pk_GradPlan_Course primary key(
            plan_id,
            semester_code,
            course_id
        )
    )

    CREATE TABLE Payment(
        payment_id INT PRIMARY KEY IDENTITY,
        amount INT, -- Question 9 "DONE?"
        deadline DATETIME,
        n_installments INT, --should we derive this?
        status VARCHAR(40) NOT NULL DEFAULT 'notPaid', -- Question 7
        fund_percentage DECIMAL(5,2),
		start_date DATETIME,
        student_id INT,
        semester_code VARCHAR(40),
        CONSTRAINT fk_payment_student FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_payment_semester FOREIGN KEY (semester_code) REFERENCES Semester(semester_code) ON DELETE SET NULL ON UPDATE CASCADE,
    )

    CREATE TABLE Installment(
        payment_id INT,
        deadline DATETIME,
        amount INT, -- Question 9 "DONE?"
        status VARCHAR(40) NOT NULL DEFAULT 'notPaid',
        start_date DATETIME,
        CONSTRAINT pk_Installment PRIMARY KEY (payment_id, deadline),
        CONSTRAINT fk_installment_payment FOREIGN KEY(payment_id) REFERENCES Payment(payment_id) ON DELETE CASCADE ON UPDATE CASCADE
    )


    CREATE TABLE Request(
        request_id INT PRIMARY KEY IDENTITY,
        type VARCHAR(40),
        comment VARCHAR(40),
        status VARCHAR(40) DEFAULT 'pending',
        credit_hours INT, -- Question 8
        student_id INT,
        advisor_id INT,
        course_id INT,
        CONSTRAINT fk_request_student FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_request_advisor FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
        CONSTRAINT fk_request_course FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    )

    CREATE TABLE MakeUp_Exam(
        exam_id INT PRIMARY KEY IDENTITY,
        date DATETIME,
        type VARCHAR(40),
        course_id INT,
        CONSTRAINT fk_makeUp_course FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Exam_Student(
        exam_id INT,
        student_id INT,
        course_id INT,
        CONSTRAINT pk_Exam_Student PRIMARY KEY(exam_id, student_id),
        CONSTRAINT fk_exam_makeUp FOREIGN KEY (exam_id) REFERENCES MakeUp_Exam(exam_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_exam_student FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    )

END;

EXEC CreateALLTABLE;
-----------------------------------
--2.2-B -- CHECKED 
GO
CREATE VIEW view_Course_prerequisites(Course_ID, Course_Name, Course_Major, C_is_offered, C_Credit_Hours, C_Semester, Prerequisiite_ID, Prerequisite_Name, Prerequisite_Major, P_is_offered, P_Credit_Hours, P_Semester)
AS
SELECT C.course_id, c.name, c.major, c.is_offered, c.credit_hours, c.semester, p.course_id, p.name, p.major, p.is_offered, p.credit_hours, p.semester FROM Course c
LEFT OUTER JOIN PreqCourse_course pc ON c.course_id = pc.course_id
LEFT OUTER JOIN Course p ON pc.prerequisite_course_id = p.course_id
GO
-----------------------------------
--2.2-G -- CHECKED
GO
CREATE VIEW Students_Courses_transcript(Student_ID, First_Name, Last_Name, Course_ID, Course_Name, Exam_Type, Course_Grade, Semester, Instructor_Name)
AS
SELECT s.student_id, S.f_name, S.l_name, T.course_id, c.name, T.exam_type, T.grade, T.semester_code, I.name 
FROM Student S, Student_Instructor_Course_Take T, Course C, Instructor I
WHERE S.student_id = T.student_id AND T.course_id = C.course_id AND I.instructor_id = T.instructor_id
GO
-----------------------------------
--2.3-C -- CHECKED
GO
CREATE PROCEDURE Procedures_AdminListStudents
AS
SELECT * FROM Student
GO
-----------------------------------
--2.3-H -- CHECKED
GO
CREATE PROCEDURE Procedures_AdminLinkInstructor
@InstructorId int,
@courseId int,
@slotID int
AS
UPDATE Slot
SET instructor_id = @InstructorId, course_id = @courseId
WHERE slot_id = @slotID
GO
-----------------------------------
--2.3-M -- CHECKED
GO
CREATE PROCEDURE Procedures_AdminDeleteCourse
@courseID int
AS
DELETE FROM PreqCourse_course
WHERE course_id = @courseID or prerequisite_course_id = @courseID

DELETE FROM Slot 
WHERE course_id = @courseID

DELETE FROM Course
WHERE course_id = @courseID
GO
-----------------------------------
--2.3-R -- CHECKED 
GO
CREATE PROCEDURE Procedures_AdvisorCreateGP
@sem_code VARCHAR(40),
@exp_grad_date DATE,
@sem_credit_hours int,
@advisor int,
@student int
AS
INSERT INTO Graduation_Plan(semester_code, semester_credit_hours, expected_grad_date, advisor_id, student_id) 
VALUES(@sem_code, @sem_credit_hours, @exp_grad_date, @advisor, @student)
GO
-----------------------------------
--2.3-W -- CHECKED
GO
CREATE PROCEDURE Procedures_AdvisorApproveRejectCHRequest
@requestID INT,
@current_sem_code VARCHAR(40)
AS
DECLARE @req_credit int
DECLARE @student_assigned_hours int
DECLARE @studen_id int
DECLARE @req_type VARCHAR(40)

IF NOT EXISTS(SELECT * FROM Request WHERE request_id = @requestID)
PRINT 'No such request exists'
ELSE
BEGIN
	SELECT @req_credit = R.credit_hours, @student_assigned_hours = S.assigned_hours, @req_type = R.type, @studen_id = S.student_id
	FROM Request R INNER JOIN Student S ON R.student_id = S.student_id
	WHERE R.request_id = @requestID

	IF NOT EXISTS(SELECT * FROM Semester WHERE semester_code = @current_sem_code)
	PRINT 'No such semester exists'
	ELSE
	BEGIN
		IF @req_type NOT LIKE '%credit_hours%'
		PRINT 'This request is a course request not a credit hour request'
		ELSE
		BEGIN
			IF @req_credit <= @student_assigned_hours
			BEGIN
				UPDATE Request 
				SET status = 'accepted'
				WHERE request_id = @requestID

				DECLARE @payment_id int

				SELECT @payment_id = payment_id FROM Payment P
				WHERE P.student_id = @studen_id AND P.semester_code = @current_sem_code

				UPDATE Payment
				SET amount = amount + @req_credit * 1000
				WHERE payment_id = @payment_id

				UPDATE Installment
				SET amount = amount + @req_credit * 1000
				WHERE payment_id = @payment_id AND deadline = (SELECT I.deadline FROM Installment I
																WHERE I.deadline > GETDATE() AND I.deadline <= ALL (SELECT I1.deadline FROM Installment I1
																													WHERE I1.deadline > GETDATE()
																													)
																)
				PRINT 'Request Accepted'
			END
			ELSE
			BEGIN
				UPDATE Request 
				SET status = 'rejected'
				WHERE request_id = @requestID

				PRINT 'Request Rejected'
			END
		END
	END
END
GO
-----------------------------------
--2.3-BB -- checked 
GO
CREATE PROCEDURE Procedures_StudentaddMobile
@StudentID INT,
@mobile_number VARCHAR(40)
AS
INSERT INTO Student_phone
VALUES(@StudentID,@mobile_number);
GO

-----------------------------------
--2.3-GG -- CHECKED

go
create function FN_StudentUpcoming_installment
(@StudentID int)
returns date
begin
    declare @UpcomingDeadline date;

    select top 1 @UpcomingDeadline = i.deadline
    from Payment p
    inner join Installment i on p.payment_id = i.payment_id
    where p.student_id = @StudentID
        and i.deadline > current_timestamp
		and i.status = 'notPaid'
	ORDER BY i.deadline ASC

    return @UpcomingDeadline
end
go
-----------------------------------
--2.3-LL -- Checked
GO
CREATE PROCEDURE Procedures_ViewRequiredCourses
@StudentID int,
@Current_semester_code VARCHAR(40)
AS
DECLARE @odd int

IF @Current_semester_code LIKE '%W__%' OR @Current_semester_code LIKE '%S__R1%'
	SET @odd = 1
ELSE
	SET @odd = 0


IF NOT EXISTS (SELECT * FROM Student WHERE student_id = @StudentID)
print 'No such student ID exists'
ELSE
BEGIN
	IF NOT EXISTS (SELECT * FROM Semester WHERE semester_code = @Current_semester_code)
	PRINT 'No such semester code exists'
	ELSE
	BEGIN
	DECLARE @s_semester int
	DECLARE @s_major VARCHAR(40)
		
		SELECT @s_semester = semester, @s_major = major FROM Student
		WHERE student_id = @StudentID
		
		-- SELECT C.course_id, C.name, C.major, C.is_offered, C.credit_hours, C.semester FROM Course C
		-- LEFT OUTER JOIN Student_Instructor_Course_Take SIC ON C.course_id = SIC.course_id
		-- WHERE SIC.student_id = @StudentID AND C.semester % 2 = @odd
		-- AND (
			-- (
			-- SIC.grade IN ('F', 'FF', 'FA') AND dbo.FN_StudentCheckSMEligiability(C.course_id, SIC.student_id)
			-- )
			-- OR
			-- (
			-- C.major = @s_major AND C.semester < @s_semester AND C.course_id NOT IN (SELECT course_id FROM Student_Instructor_Course_Take WHERE student_id = @StudentID))
			-- )
			
		SELECT C.* FROM Course C
		WHERE C.major = @s_major AND C.semester < @s_semester AND C.course_id NOT IN (SELECT course_id FROM Student_Instructor_Course_Take WHERE student_id = @StudentID)
		UNION
		SELECT C1.* FROM COURSE C1
		WHERE C1.course_id IN (SELECT course_id FROM Student_Instructor_Course_Take
								WHERE student_id = @StudentID AND grade IN ('F', 'FF', 'FA') AND dbo.FN_StudentCheckSMEligiability(course_id, student_id) = 0
								)
	END
END
GO
--INSERT INTO Course(name, major, is_offered, credit_hours, semester)  VALUES( 'Mathematics 2', 'DMET', 1, 3, 2)

--EXEC Procedures_ViewRequiredCourses 9, 'W23'
-----------------------------------
--2.3-MM

GO
create PROCEDURE Procedures_ViewOptionalCourse
@StudentID int,
@Current_semester_code VARCHAR(40)
AS
	declare @odd INT
IF @Current_semester_code LIKE '%W__%' OR @Current_semester_code LIKE '%S__R1%'
	SET @odd = 1
ELSE
	SET @odd = 0

IF NOT EXISTS (SELECT * FROM Student WHERE student_id = @StudentID)
print 'No such student ID exists'
ELSE
BEGIN
	IF NOT EXISTS (SELECT * FROM Semester WHERE semester_code = @Current_semester_code)
	PRINT 'No such semester code exists'
	ELSE
	BEGIN
	DECLARE @s_semester int
	DECLARE @s_major VARCHAR(40)
		
		SELECT @s_semester = semester, @s_major = major FROM Student
		WHERE student_id = @StudentID

		SELECT C.course_id, C.name, C.major, C.is_offered, C.credit_hours, C.semester FROM Course C
		WHERE C.major = @s_major AND C.semester >= @s_semester AND C.semester % 2 = @odd
		EXCEPT
		SELECT C.course_id, C.name, C.major, C.is_offered, C.credit_hours, C.semester FROM Course C
		INNER JOIN PreqCourse_course PC ON C.course_id = PC.course_id
		WHERE PC.prerequisite_course_id NOT IN (SELECT SIC.course_id FROM Student_Instructor_Course_Take SIC
												WHERE SIC.student_id = @StudentID)
	END
END
Go

-----------------------------------

-- Question 2.1.3


CREATE PROCEDURE DropALLTables
AS
BEGIN
drop table Exam_Student
drop table Request
drop table Installment
drop table Payment
drop table GradPlan_Course
drop table Graduation_Plan
drop table Slot
drop table Course_Semester
drop table Semester
drop table Student_Instructor_Course_Take
drop table Instructor_Course
drop table Instructor
drop table PreqCourse_course
drop table MakeUp_Exam
drop table Course
drop table Student_Phone 
drop table Student
drop table Advisor
end


----------------------------------------
-- Question 2.1.4
go
CREATE PROCEDURE clearAllTables
AS
BEGIN
	delete from MakeUp_Exam
	delete from Exam_Student
	delete from Request
	delete from Installment
	delete from Payment
	delete from GradPlan_Course
	delete from Graduation_Plan
	delete from Slot
	delete from Course_Semester
	delete from Semester
	delete from Student_Instructor_Course_Take
	delete from Instructor_Course
	delete from Instructor
	delete from PreqCourse_course
	delete from Course
	delete from Student_Phone 
	delete from Student
	delete from Advisor


END

--------------------------
-- Question 2.2 (E)


GO
CREATE VIEW Courses_Slots_Instructor AS
SELECT c.course_id , c.name,s.slot_id, s.day,s.time,s.location,I.name AS 'Instructor Name'
FROM Course c 
INNER JOIN Slot s ON c.course_id = s.course_id
INNER JOIN Instructor I ON I.instructor_id = s.instructor_id
GO

SELECT * FROM Courses_Slots_Instructor


---------------------------
-- Question 2.3 (A)
GO
CREATE PROCEDURE procedures_StudentRegistration(
	@f_name    varchar(40),
	@l_name    varchar(40),
	@password  varchar(40),
	@faculty   varchar(40),
	@email     varchar(40),
	@major     varchar(40),
	@Semester  int,
	@student_id int OUTPUT
)
AS
BEGIN
	INSERT INTO Student (f_name,l_name,password,faculty,email,major,semester)     
	Values (@f_name,@l_name,@password,@faculty,@email,@major,@semester)	
	
	Select @student_id = student_id
	From Student
	WHERE f_name = @f_name  AND l_name = @l_name AND password = @password AND faculty = @faculty AND email = @email AND major = @major AND semester = @Semester

END;
GO

DECLARE @id int
--EXEC procedures_StudentRegistration 'Omar', 'Farouk', 'cerato', 'Engineering','omar.mansour@student.guc.edu.eg','MET', 5, @id OUTPUT 

PRINT @id
-----------------------------
-- Question 2.3 (F)
GO

CREATE PROCEDURE AdminAddingSemester(
	@start_date date,
	@end_date date,
	@semester_code varchar(40)

)
AS
BEGIN
	INSERT INTO Semester (semester_code,start_date, end_date)
	Values (@semester_code,@Start_date, @end_date)
	
END
GO

--EXEC AdminAddingSemester '2023/10/02', '2024/01/14', 'Winter 2023 W23'


-----------------------------
-- Question 2.3 (K)


GO
create procedure Procedures_AdminAddExam(
	@type varchar (40),
	@date datetime,
	@courseID int
)
AS
BEGIN 
    insert INTO MakeUp_Exam (date, type,course_id)
    VALUES ( @date, @type, @courseID)
end

--EXEC Procedures_AdminAddExam 'First_Makeup', '2024/02/02', 1

-----------------------------
-- Question 2.3 (P)

GO
CREATE PROCEDURE Procedures_AdminDeleteSlots(
    @current_semester varchar(40)
)
AS
BEGIN 
    Delete From SLOT 
	WHERE slot_id NOT IN (SELECT slot_id 
					  FROM Slot s INNER JOIN Course_Semester c ON c.course_id = s.course_id
					  where c.semester_code = @current_semester)
END

INSERT INTO Slot (day, time, location, course_id, instructor_id) VALUES ('Monday', 1, 'C3.301', 1, 2)

--EXEC Procedures_AdminDeleteSlots 'W24'

-------------------------------------------------------------
-- Question 2.3 (U)
GO
Create procedure Procedures_AdvisorDeleteFromGP(
	@StudentID int,
	@semester_code varchar(40),
	@course_ID int
)
AS 
BEGIN
	Delete From GradPlan_Course 
	WHERE plan_id = (select plan_id
					 From Graduation_Plan
					 Where student_id= @StudentID AND semester_code = @semester_code)
		  AND semester_code = @semester_code
		  AND course_id = @course_ID
END

--EXEC Procedures_AdvisorDeleteFromGP 1, 'W23', 1

--------------------------------------------------
-- Question 2.3 (Z)

GO
CREATE PROCEDURE Procedures_AdvisorViewPendingRequests(
	@Advisor_ID int
)
AS
BEGIN
	SELECT * FROM Request
	WHERE advisor_id = @Advisor_ID AND status LIKE 'pending'

END

--EXECUTE Procedures_AdvisorViewPendingRequests 10

--------------------------------------------------
-- Question 2.3 (EE)

GO
CREATE PROCEDURE Procedures_StudentSendingCHRequest(
	@Student_ID int,
	@credit_hours int,
	@type varchar(40),
	@comment varchar (40)
)
AS
BEGIN
	DECLARE @advisor int
	SELECT @advisor = advisor_id FROM Student
	WHERE student_id = @Student_ID
	
	INSERT INTO Request(type, comment,status,credit_hours,student_id, advisor_id)
	Values (@type, @comment,'pending',@credit_hours,@Student_ID,@advisor)
END

--EXEC Procedures_StudentSendingCHRequest 7, 120, 'CRH', 'Please I need to graduate'

----------------------------
-- Question 2.3 (OO)
--DROP PROCEDURE Procedures_ChooseInstructor
GO
CREATE PROCEDURE Procedures_ChooseInstructor(
	@StudentID int, 
	@InstructorID int, 
	@CourseID int,
	@current_semester_code varchar(40)
	)
AS 
BEGIN
	UPDATE Student_Instructor_Course_Take
	SET instructor_id = @InstructorID
	WHERE student_id = @StudentID AND course_id = @CourseID AND semester_code = @current_semester_code
	
END

--EXEC Procedures_ChooseInstructor 1, 2, 1, 'W23'

-----------------------------------
--2.2-c (checked)
go
create view Instructors_AssignedCourses
as
select i.instructor_id,i.name as 'Instructor name',i.email,i.faculty,i.office,c.name as ' Course Name'
from (Instructor i inner join Instructor_Course ic on i.instructor_id=ic.instructor_id)inner join Course c
on ic.course_id=c.course_id
go
-------------------------------------------------------------------------------------
--2.2-H (checked)
go
create view Semster_offered_Courses
as
select course_id as 'Course id',name as 'Course name',semester as 'Semster code'
from Course
go
-------------------------------------------------------------------------------------
--2.3-D (checked)
create procedure Procedures_AdminListAdvisors
as
select* from Advisor
go
-------------------------------------------------------------------------------------
--2.3-I (checked)
go
create procedure Procedures_AdminLinkStudent
@instructor_id int,
@student_id int,
@course_id int,
@semster_code varchar(40)
as
insert into Student_Instructor_Course_Take
values(@student_id,@course_id,@instructor_id,@semster_code,null,null)
go
-------------------------------------------------------------------------------------
--2.3-N (checked)
create procedure Procedure_AdminUpdateStudentStatus
@StudentID int
as
if exists (select*
from Payment p inner join Installment i on p.payment_id=i.payment_id
where i.status='notPaid' and year(i.deadline)<year(current_timestamp) and @StudentID=p.student_id)
begin
update Student 
set financial_status=0
where student_id=@StudentID
end
go
-------------------------------------------------------------------------------------

--2.3-S (checked)
create procedure Procedures_AdvisorAddCourseGP
@student_id int,
@Semster_code varchar(40),
@course_name varchar(40)
as 
declare @pid int
declare @cid int
select @pid=p.plan_id from Graduation_Plan p where p.student_id=@student_id
select @cid=c.course_id from Course c where c.name=@course_name
insert into GradPlan_Course(plan_id, semester_code, course_id)
values(@pid,@Semster_code,@cid)
go
-------------------------------------------------------------------------------------
--2.3-X (checked)
create procedure Procedures_AdvisorViewAssignedStudents
@AdvisorID int,
@major varchar (40)
as
select s.student_id as 'Student id',s.f_name as 'Student name',s.major as 'Student major',c.name as 'Course name'
from (Student s inner join Student_Instructor_Course_Take sc on s.student_id=sc.student_id)inner join Course c on sc.course_id=c.course_id
where s.advisor_id=@AdvisorID and s.major=@major
go
--------------------------------------------------------------------------------------
--2.3-CC (checked)
go
create function FN_SemsterAvailableCourses
(@semster_code varchar (40))
returns table
as
return(select c.name from Course c inner join Course_Semester cs on c.course_id=cs.course_id
where cs.semester_code=@semster_code)
go
--------------------------------------------------------------------------------------
--2.3-HH (checked)
go
create function FN_StudentViewSlot
(@CourseID int, @InstructorID int)
returns table
as
return(select s.slot_id as 'Slot ID',s.location,s.time,s.day,c.name as 'Course Name',i.name as 'Instructor Name'
from Slot s inner join Course c on s.course_id=c.course_id inner join Instructor i on s.instructor_id=i.instructor_id
where s.course_id=@CourseID and s.instructor_id=@InstructorID)
go
--------------------------------------------------------------------------------------
--2.3-NN (checked)
go
create procedure Procedures_ViewMS
@StudentID int
as
declare @major varchar(40)
select @major=major from Student where student_id=@StudentID

select* from Course where major=@major
except
select c.* from Student_Instructor_Course_Take t inner join Course c on t.course_id=c.course_id
where t.student_id=@StudentID
go
--------------------------------------------------------------------------------------

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



-- 2.3 L
GO
CREATE PROCEDURE Procedures_AdminIssueInstallment
@payment_id INT
AS
BEGIN
   DECLARE @amount_to_be_paid DECIMAL(6)
   DECLARE @n_installments INT
   DECLARE @fund_percentage DECIMAL(3)
   DECLARE @deadline DATETIME
   SELECT @amount_to_be_paid = P.amount,
   @n_installments = P.n_installments,
   @fund_percentage = P.fund_percentage,
   @deadline = P.deadline
   FROM Payment P
   WHERE @payment_id = P.payment_id

   SET @amount_to_be_paid = @amount_to_be_paid - @amount_to_be_paid * (@fund_percentage / 100)
   SET @amount_to_be_paid = @amount_to_be_paid / @n_installments

   DECLARE @COUNTER INT = 0
   WHILE @COUNTER < @n_installments
   Begin     
      DECLARE @start_date DATETIME
      SET @start_date = DATEADD(MONTH, -1, @deadline)
      INSERT INTO Installment(payment_id, deadline, amount, start_date)
      VALUES(@payment_id, @deadline, @amount_to_be_paid, @start_date)

      SET @COUNTER = @COUNTER + 1
      SET @deadline = @start_date
   END
END

--Testing The Procedure
 --INSERT INTO Student(f_name,l_name)values('ahmed','mohamad')
 --INSERT INTO Payment(amount,deadline,n_installments,fund_percentage,student_id)values(200000,'2023/12/25 10:50:30',2,50,1)
 --EXEC Procedures_AdminIssueInstallment 1
 --SELECT * FROM Installment



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

-- Testing The Function
--DECLARE @OUT BIT = 0
--SET @OUT = dbo.FN_AdvisorLogin(1,'1234')
--PRINT @OUT


-- 2.3 V
GO
CREATE FUNCTION FN_Advisors_Requests(@advisor_id INT) RETURNS TABLE
AS
RETURN
(
   SELECT R.*
   FROM Request R
   WHERE R.advisor_id = @advisor_id
)

-- Testing The Function
--INSERT INTO Advisor VALUES('AHMED' , 'AHMED@GMAIL.COM' , 'C4.101' , '1234')
--INSERT INTO Advisor VALUES('alaa' , 'alaa@GMAIL.COM' , 'C5.101' , '0000')
--INSERT INTO Request VALUES('Any thing', 'pls get me out', 'pending', 10, null, 1, null)
--INSERT INTO Request VALUES('alright', 'fine', 'les go', 10, null, 2, null)
--select * from FN_Advisors_Requests(2)

--2.3 AA
GO
CREATE FUNCTION FN_StudentLogin(@ID INT , @Password VARCHAR(40)) RETURNS BIT
AS
BEGIN
   DECLARE @Success BIT = 0
   IF EXISTS(SELECT S.student_id FROM Student S WHERE S.student_id = @ID AND S.password = @Password)
   BEGIN
      SET @Success = 1
   END
   RETURN @Success
END

-- Testing The Function
--DECLARE @OUT BIT = 0
--SET @OUT = dbo.FN_StudentLogin(2,'1234')
--PRINT @OUT

--2.3 FF
GO
CREATE FUNCTION FN_StudentViewGP(@student_ID int) RETURNS TABLE
AS
RETURN
(
   SELECT S.student_id, S.f_name, S.l_name, GP.plan_id, C.course_id, C.name, GP.semester_code,
   GP.expected_grad_date, GP.semester_credit_hours, GP.advisor_id
   FROM Graduation_Plan GP INNER JOIN Student S ON GP.student_id = S.student_id
         INNER JOIN GradPlan_Course GPC ON GP.plan_id = GPC.plan_id
         INNER JOIN Course C ON GPC.course_id = C.course_id
   WHERE S.student_id = @student_ID
)

--2.3 JJ
GO
CREATE FUNCTION FN_StudentCheckSMEligiability(@course_id INT, @student_id INT) RETURNS BIT
AS
BEGIN
DECLARE @eligible BIT = 0
DECLARE @failed_or_did_not_attend_First_makeup BIT
DECLARE @no_of_failed_courses_even INT
DECLARE @no_of_failed_courses_odd INT
DECLARE @input_course_semester INT

    IF EXISTS (SELECT STCT.student_id
               FROM Student_Instructor_Course_Take STCT
               WHERE (STCT.grade = 'FF' OR STCT.grade IS NULL) AND STCT.student_id = @student_id AND STCT.exam_type = 'First_makeup' AND @course_id = STCT.course_id)
    SET @failed_or_did_not_attend_First_makeup = 1

    SELECT @no_of_failed_courses_even = COUNT(C.course_id)
    FROM Student_Instructor_Course_Take STCT INNER JOIN Course C ON STCT.student_id = @student_id AND STCT.course_id = C.course_id
    WHERE (STCT.grade = 'FF' OR STCT.grade = 'F' OR STCT.grade IS NULL ) AND (C.SEMESTER % 2 = 0)

    SELECT @no_of_failed_courses_odd = COUNT(C.course_id)
    FROM Student_Instructor_Course_Take STCT INNER JOIN Course C ON STCT.student_id = @student_id AND STCT.course_id = C.course_id
    WHERE (STCT.grade = 'FF' OR STCT.grade = 'F' OR STCT.grade IS NULL) AND (C.SEMESTER % 2 = 1)
    
    SELECT @input_course_semester = C.semester
    FROM Student_Instructor_Course_Take STCT INNER JOIN Course C ON C.course_id = STCT.course_id AND STCT.course_id = @course_id

    IF (@input_course_semester % 2 = 0 AND @failed_or_did_not_attend_First_makeup = 1 AND @no_of_failed_courses_even <= 2)
        SET @eligible = 1

    IF (@input_course_semester % 2 = 1 AND @failed_or_did_not_attend_First_makeup = 1 AND @no_of_failed_courses_odd <= 2)
        SET @eligible = 1

    RETURN @eligible 
END

--2.3 KK
GO
CREATE PROCEDURE Procedures_StudentRegisterSecondMakeup
@student_id INT,
@course_id INT,
@student_current_semester VARCHAR(40)
AS
DECLARE @is_course_even_or_odd BIT
DECLARE @exam_id INT

    SELECT @is_course_even_or_odd = 1
    FROM Course C 
    WHERE C.semester % 2 = 0 AND C.course_id = @course_id

    SELECT @is_course_even_or_odd = 0
    FROM Course C 
    WHERE C.semester % 2 = 1 AND C.course_id = @course_id

    IF (@is_course_even_or_odd = 1 AND DBO.FN_StudentCheckSMEligiability(@course_id,@student_id) = 1
        AND @student_current_semester NOT LIKE 'S%R%' AND @student_current_semester NOT LIKE 'W%')
        BEGIN
            SELECT @exam_id = ME.exam_id
            FROM MakeUp_Exam ME
            WHERE ME.course_id = @course_id AND ME.type = 'Second MakeUp'
            INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (@exam_id, @student_id, @course_id);
        END

    IF (@is_course_even_or_odd = 0 AND DBO.FN_StudentCheckSMEligiability(@course_id,@student_id) = 1
        AND @student_current_semester NOT LIKE 'S%R%' AND @student_current_semester NOT LIKE 'S%')
    BEGIN
        SELECT @exam_id = ME.exam_id
        FROM MakeUp_Exam ME
        WHERE ME.course_id = @course_id AND ME.type = 'Second MakeUp'
        INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (@exam_id, @student_id, @course_id);
    END


-- 2.3 Y
GO
CREATE PROCEDURE Procedures_AdvisorApproveRejectCourseRequest
    @requestID INT,
    @current_semester_code VARCHAR(40)
AS
    IF @requestID IS NULL OR @current_semester_code IS NULL
    BEGIN
        PRINT 'ONE OF THE INPUTS IS NULL'
    END
    ELSE IF @requestID NOT IN (SELECT request_id FROM Request)
    BEGIN
        PRINT 'ONE OF THE INPUTS IS INVALID'
    END
    ELSE
    BEGIN
        DECLARE @studentID INT, @courseID INT, @aHours INT, @cHours INT , @advisorID INT
        DECLARE @decision VARCHAR(40)

        SELECT @studentID = S.student_id, @courseID = C.course_id, @aHours = S.assigned_hours, @cHours = C.credit_hours , @advisorID = S.advisor_id
        FROM Request R JOIN Student S ON R.student_id = S.student_id JOIN Course C ON R.course_id = C.course_id
        WHERE request_id = @requestID AND is_offered = 1

        IF @aHours IS NULL
        OR @courseID IS NULL
        OR @cHours > @aHours
        OR EXISTS (SELECT *
                   FROM view_Course_prerequisites
                   WHERE Course_ID = @courseID AND Prerequisiite_ID NOT IN (
                        SELECT course_id 
                        FROM Student_Instructor_Course_Take
                        WHERE student_id = @studentID AND grade IS NOT NULL))
        BEGIN
            SET @decision = 'rejected'
        END
        ELSE
        BEGIN
            SET @decision = 'approved'
            INSERT INTO Student_Instructor_Course_Take (student_id, course_id, instructor_id, semester_code, grade) VALUES
            (@studentID,@courseID,@advisorID,@current_semester_code,null)
        END
        UPDATE Request
        SET status = @decision
        WHERE request_id = @requestID
        

    END


-- 2.2 D (checked)
GO
CREATE VIEW Student_Payment
AS
    SELECT P.*, S.f_name, S.l_name
    FROM Payment P JOIN Student S ON P.student_id = S.student_id
GO

-- 2.2 I(checked)
go
CREATE VIEW Advisors_Graduation_Plan
AS
    SELECT G.plan_id, G.semester_code, g.semester_credit_hours, g.expected_grad_date, g.student_id, A.advisor_id as 'Advisor_ID', A.name as 'Advisor_Name'
    FROM Graduation_Plan G JOIN Advisor A ON G.advisor_id = A.advisor_id
GO

-- 2.3 E(checked)
go
CREATE PROC AdminListStudentsWithAdvisors
AS
    SELECT S.f_name as [Student First Name], S.l_name as [Student Last Name], A.name as [Advisor Name]
    FROM Student S JOIN Advisor A ON S.advisor_id = A.advisor_id
GO

-- 2.3 J (checked)
go
CREATE PROC Procedures_AdminLinkStudentToAdvisor
    @studentID INT,
    @advisorID INT
AS
    IF @studentID IS NULL OR @advisorID IS NULL
    BEGIN
        PRINT 'ONE OF THE INPUTS IS NULL'
    END
    ELSE IF @studentID NOT IN (SELECT student_id FROM Student) OR @advisorID NOT IN (SELECT advisor_id FROM Advisor)
    BEGIN
        PRINT 'ONE OF THE INPUTS IS INVALID'
    END
    ELSE
    BEGIN
        UPDATE Student
        SET advisor_id = @advisorID
        WHERE student_id = @studentID
    END
GO
-- 2.3 O(checked)
CREATE VIEW all_Pending_Requests
AS
    SELECT R.*, S.f_name as [Student First Name], S.l_name as [Student Last Name], A.name as [Advisor Name]
    FROM Request R JOIN Student S ON R.student_id = S.student_id JOIN Advisor A ON S.advisor_id = A.advisor_id
    WHERE status = 'pending'
GO

-- 2.3 T(checked)
CREATE PROC Procedures_AdvisorUpdateGP
    @expected_grad_date DATE,
    @studentID INT
AS
    IF @expected_grad_date IS NULL OR @studentID IS NULL
    BEGIN
        PRINT 'ONE OF THE INPUTS IS NULL'
    END
    ELSE IF @studentID NOT IN (SELECT student_id FROM Student)
    BEGIN
        PRINT 'ONE OF THE INPUTS IS INVALID'
    END
    ELSE
    BEGIN
        UPDATE Graduation_Plan
        SET expected_grad_date = @expected_grad_date
        WHERE student_id = @studentID
    END
GO

-- 2.3 DD(checked)
create PROC Procedures_StudentSendingCourseRequest
    @studentID INT,
    @courseID INT,
    @type VARCHAR(40),
    @comment VARCHAR(40)
AS
    IF @studentID IS NULL OR @courseID IS NULL OR @type IS NULL
    BEGIN
        PRINT 'ONE OF THE INPUTS IS NULL'
    END
    ELSE IF @studentID NOT IN (SELECT student_id FROM Student) OR @courseID NOT IN (SELECT course_id FROM Course) OR @type <> 'course'
    BEGIN
        PRINT 'ONE OF THE INPUTS IS INVALID'
    END
    ELSE
    BEGIN
        DECLARE @advisorID INT

        SELECT @advisorID = advisor_id
        FROM Student
        WHERE student_id = @studentID

        INSERT INTO Request(type, comment, student_id, advisor_id, course_id)
        VALUES (@type, @comment, @studentID, @advisorID, @courseID)
    END
GO

-- 2.3 II(checked)


CREATE PROC Procedures_StudentRegisterFirstMakup
    @studentID INT,
    @courseID INT,
    @studentCurrentSemester VARCHAR(40)
AS

    IF @studentID IS NULL OR @courseID IS NULL OR @studentCurrentSemester IS NULL
    BEGIN
        PRINT 'ONE OF THE INPUTS IS NULL'
    END
    ELSE IF @studentID NOT IN (SELECT student_id FROM Student) OR @courseID NOT IN (SELECT course_id FROM Course)
    BEGIN
        PRINT 'ONE OF THE INPUTS IS INVALID'
    END
    ELSE
    BEGIN
        DECLARE @examID INT
		DECLARE @is_course_even_or_odd BIT
		DECLARE @exam_id INT

		SELECT @is_course_even_or_odd = 1
		FROM Course C	
		WHERE C.semester % 2 = 0 AND C.course_id = @courseID

		SELECT @is_course_even_or_odd = 0
		FROM Course C 
		WHERE C.semester % 2 = 1 AND C.course_id = @courseID

        IF ((((SELECT COUNT(*)
            FROM Student_Instructor_Course_Take
            WHERE student_id = @studentID AND course_id = @courseID AND grade LIKE 'F%' AND exam_type = 'Normal') = 1)
			AND @is_course_even_or_odd = 1 AND @studentCurrentSemester NOT LIKE 'S%R%' 
			AND @studentCurrentSemester NOT LIKE 'W%') OR (((SELECT COUNT(*)
            FROM Student_Instructor_Course_Take
            WHERE student_id = @studentID AND course_id = @courseID AND grade LIKE 'F%' AND exam_type = 'Normal') = 1)
			AND @is_course_even_or_odd = 0 AND @studentCurrentSemester NOT LIKE 'S%R%' 
			AND @studentCurrentSemester NOT LIKE 'S%'))
        BEGIN

            SELECT @examID = exam_id
            FROM MakeUp_Exam
            WHERE course_id = @courseID AND type = 'First MakeUp'

            INSERT INTO Exam_Student
            VALUES (@examID, @studentID, @courseID)
			
        END
        ELSE
        BEGIN
            PRINT 'CAN NOT REGISTER FIRST MAKEUP'
        END
    END
GO
