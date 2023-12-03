
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
EXEC procedures_StudentRegistration 'Omar', 'Farouk', 'cerato', 'Engineering','omar.mansour@student.guc.edu.eg','MET', 5, @id OUTPUT 

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

EXEC AdminAddingSemester '2023/10/02', '2024/01/14', 'Winter 2023 W23'


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

EXEC Procedures_AdminAddExam 'First_Makeup', '2024/02/02', 1

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

EXEC Procedures_AdminDeleteSlots 'W24'

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

EXEC Procedures_AdvisorDeleteFromGP 1, 'W23', 1

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

EXECUTE Procedures_AdvisorViewPendingRequests 10

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

EXEC Procedures_StudentSendingCHRequest 7, 120, 'CRH', 'Please I need to graduate'

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

EXEC Procedures_ChooseInstructor 1, 2, 1, 'W23'