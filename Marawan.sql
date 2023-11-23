
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

CREATE PROCEDURE clearAllTables
AS
BEGIN
	DELETE FROM Student_Phone
	DELETE FROM PreqCourse_course
	DELETE FROM Course_Semester
	DELETE FROM Exam_Student
	DELETE FROM GradPlan_Course
	DELETE FROM Graduation_Plan
	DELETE FROM Installment
	DELETE FROM Instructor_Course
	DELETE FROM Student_Instructor_Course_Take
	DELETE FROM MakeUp_Exam
	DELETE FROM Payment
	DELETE FROM Slot
	DELETE FROM Request
	DELETE FROM Semester
	DELETE FROM Course	
	DELETE FROM Advisor
	DELETE FROM Instructor
	DELETE FROM Student

END


--------------------------
-- Question 2.2 (E)


GO
CREATE VIEW Courses_Slots_Instructor AS
SELECT c.course_id , c.name,s.slot_id, s.day,s.time,s.location,I.name AS 'Instructor Name'
FROM Course c 
INNER JOIN Slot s ON c.course_id = s.course_id
INNER JOIN Instructor I ON I.instructor_id = s.instructor_id
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
    insert INTO MakeUp_Exam (type, date,course_id)
    VALUES ( @type, @date, @courseID)
end

-----------------------------
-- Question 2.3 (P)

Go 

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

