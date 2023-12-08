-- Answers Starts here --
USE Advising_Team_109
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


GO
CREATE FUNCTION FN_StudentViewGP(@student_ID int) RETURNS TABLE
AS
RETURN
(
   SELECT S.student_id, S.f_name, S.l_name, GP.plan_id, C.course_id, C.name, GP.semster_code,
   GP.expected_grad_date, GP.semster_credit_hours, GP.advisor_id
   FROM Graduation_Plan GP INNER JOIN Student S ON GP.student_id = S.student_id
         INNER JOIN GradPlan_Course GPC ON GP.plan_id = GPC.plan_id
         INNER JOIN Course C ON GPC.course_id = C.course_id
   WHERE S.student_id = @student_ID
)

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


--USE Advising_Team_109
EXEC DropALLTables
EXEC clearAllTables
EXEC CreateALLTABLE
--PRINT 4 % 2

--DECLARE @eligible BIT
--SET @eligible = DBO.FN_StudentCheckSMEligiability(8,9)
--PRINT @eligible

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