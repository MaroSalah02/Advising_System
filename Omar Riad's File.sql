--2.2-B
GO
CREATE VIEW view_Course_prerequisites(Course_ID, Course_Name, Course_Major, C_is_offered, C_Credit_Hours, C_Semester, Prerequisiite_ID, Prerequisite_Name, Prerequisite_Major, P_is_offered, P_Credit_Hours, P_Semester)
AS
SELECT C.course_id, c.name, c.major, c.is_offered, c.credit_hours, c.semester, p.course_id, p.name, p.major, p.is_offered, p.credit_hours, p.semester FROM Course c
LEFT OUTER JOIN PreqCourse_course pc ON c.course_id = pc.course_id
LEFT OUTER JOIN Course p ON pc.prerequisite_course_id = p.course_id
GO

--2.2-G
GO
CREATE VIEW Students_Courses_transcript(Student_ID, First_Name, Last_Name, Course_ID, Course_Name, Exam_Type, Course_Grade, Semester, Instructor_Name)
AS
SELECT s.student_id, S.f_name, S.l_name, T.course_id, c.name, T.exam_type, T.grade, T.semester_code, I.name FROM Student S, Student_Instructor_Course_Take T, Course C, Instructor I
WHERE S.student_id = T.student_id AND T.course_id = C.course_id
GO

--2.3-C
GO
CREATE PROCEDURE Procedures_AdminListStudents
AS
SELECT * FROM Student
GO

--2.3-H
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

--2.3-M
GO
CREATE PROCEDURE Procedures_AdminDeleteCourse
@courseID int
AS
DELETE FROM Slot
WHERE course_id = @courseID

DELETE FROM Course
WHERE course_id = @courseID
GO

--2.3-R
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