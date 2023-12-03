--2.2-B -- CHECKED 
GO
CREATE VIEW view_Course_prerequisites(Course_ID, Course_Name, Course_Major, C_is_offered, C_Credit_Hours, C_Semester, Prerequisiite_ID, Prerequisite_Name, Prerequisite_Major, P_is_offered, P_Credit_Hours, P_Semester)
AS
SELECT C.course_id, c.name, c.major, c.is_offered, c.credit_hours, c.semester, p.course_id, p.name, p.major, p.is_offered, p.credit_hours, p.semester FROM Course c
LEFT OUTER JOIN PreqCourse_course pc ON c.course_id = pc.course_id
LEFT OUTER JOIN Course p ON pc.prerequisite_course_id = p.course_id
GO

--2.2-G -- CHECKED
GO
CREATE VIEW Students_Courses_transcript(Student_ID, First_Name, Last_Name, Course_ID, Course_Name, Exam_Type, Course_Grade, Semester, Instructor_Name)
AS
SELECT s.student_id, S.f_name, S.l_name, T.course_id, c.name, T.exam_type, T.grade, T.semester_code, I.name 
FROM Student S, Student_Instructor_Course_Take T, Course C, Instructor I
WHERE S.student_id = T.student_id AND T.course_id = C.course_id AND I.instructor_id = T.instructor_id
GO

--2.3-C -- CHECKED
GO
CREATE PROCEDURE Procedures_AdminListStudents
AS
SELECT * FROM Student
GO

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

--2.3-R -- CHECKED 
GO
CREATE PROCEDURE Procedures_AdvisorCreateGP
@sem_code VARCHAR(40),
@exp_grad_date DATE,
@sem_credit_hours int,
@advisor int,
@student int
AS
INSERT INTO Graduation_Plan(semster_code, semster_credit_hours, expected_grad_date, advisor_id, student_id) 
VALUES(@sem_code, @sem_credit_hours, @exp_grad_date, @advisor, @student)
GO

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

--2.3-BB -- checked 
GO
CREATE PROCEDURE Procedures_StudentaddMobile
@StudentID INT,
@mobile_number VARCHAR(40)
AS
INSERT INTO Student_phone
VALUES(@StudentID,@mobile_number);
GO


--2.3-GG -- CHECKED

go;
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

    return @UpcomingDeadline;
end
go;

----swcond makeup eligibility
--GO
--CREATE FUNCTION FN_StudentCheckSMEligiability(@course_id INT, @student_id INT) RETURNS BIT
--AS
--BEGIN
--DECLARE @eligible BIT = 0
--DECLARE @failed_or_did_not_attend_First_makeup BIT
--DECLARE @no_of_failed_courses_even INT
--DECLARE @no_of_failed_courses_odd INT
--DECLARE @input_course_semester INT

--    IF EXISTS (SELECT STCT.student_id
--               FROM Student_Instructor_Course_Take STCT
--               WHERE (STCT.grade = 'FF' OR STCT.grade IS NULL) AND STCT.student_id = @student_id AND STCT.exam_type = 'First_makeup' AND @course_id = STCT.course_id)
--    SET @failed_or_did_not_attend_First_makeup = 1

--    SELECT @no_of_failed_courses_even = COUNT(C.course_id)
--    FROM Student_Instructor_Course_Take STCT INNER JOIN Course C ON STCT.student_id = @student_id AND STCT.course_id = C.course_id
--    WHERE (STCT.grade = 'FF' OR STCT.grade = 'F' OR STCT.grade IS NULL ) AND (C.SEMESTER % 2 = 0)

--    SELECT @no_of_failed_courses_odd = COUNT(C.course_id)
--    FROM Student_Instructor_Course_Take STCT INNER JOIN Course C ON STCT.student_id = @student_id AND STCT.course_id = C.course_id
--    WHERE (STCT.grade = 'FF' OR STCT.grade = 'F' OR STCT.grade IS NULL) AND (C.SEMESTER % 2 = 1)
    
--    SELECT @input_course_semester = C.semester
--    FROM Student_Instructor_Course_Take STCT INNER JOIN Course C ON C.course_id = STCT.course_id AND STCT.course_id = @course_id

--    IF (@input_course_semester % 2 = 0 AND @failed_or_did_not_attend_First_makeup = 1 AND @no_of_failed_courses_even <= 2)
--        SET @eligible = 1

--    IF (@input_course_semester % 2 = 1 AND @failed_or_did_not_attend_First_makeup = 1 AND @no_of_failed_courses_odd <= 2)
--        SET @eligible = 1

--    RETURN @eligible 
--END

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