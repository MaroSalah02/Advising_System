-- 2.2 D (checked)
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
