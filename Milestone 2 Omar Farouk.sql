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
exec Procedures_AdvisorViewAssignedStudents 1,'CS'
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
