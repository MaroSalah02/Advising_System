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

   SET @amount_to_be_paid = @amount_to_be_paid * (@fund_percentage / 100)
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
   
GO
-- Testing The Function
--DECLARE @OUT BIT = 0
--SET @OUT = dbo.FN_AdvisorLogin(1,'1234')
--PRINT @OUT