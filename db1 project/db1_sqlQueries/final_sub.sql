CREATE DATABASE Advising_Team_35

GO
CREATE PROC CreateAllTables
AS
CREATE TABLE Course (
course_id INT PRIMARY KEY IDENTITY,
name VARCHAR(40) NOT NULL,
major VARCHAR(40),
is_offered BIT,
credit_hours INT,
semester INT 
);
CREATE TABLE PreqCourse_course (
    prerequisite_course_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (prerequisite_course_id, course_id),
    FOREIGN KEY (prerequisite_course_id) references course ,
    FOREIGN KEY (course_id) references course 
);

CREATE TABLE Instructor (
instructor_id INT PRIMARY KEY IDENTITY,
name VARCHAR(40) NOT NULL,
email VARCHAR(40),
faculty VARCHAR(40),
office VARCHAR(40)
);

CREATE TABLE Instructor_Course (
    course_id INT NOT NULL, 
    instructor_id INT NOT NULL,
    PRIMARY KEY (course_id, instructor_id),
    FOREIGN KEY (course_id) references course on delete cascade,
    FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE NO ACTION
)

CREATE TABLE Semester (
semester_code VARCHAR(40) PRIMARY KEY,
start_date DATE,
end_date DATE
) 

CREATE TABLE Course_Semester (
course_id INT NOT NULL,
semester_code VARCHAR(40) NOT NULL,
PRIMARY KEY(course_id, semester_code),
FOREIGN KEY (course_id) references course on delete cascade,
FOREIGN KEY (semester_code) REFERENCES Semester
); 

CREATE TABLE Advisor (
advisor_id INT PRIMARY KEY IDENTITY,
name VARCHAR(40) NOT NULL,
email VARCHAR(40),
office VARCHAR(40),
password VARCHAR(40)
); 

CREATE TABLE Slot (
slot_id INT PRIMARY KEY IDENTITY,
day VARCHAR(40) NOT NULL,
time VARCHAR(40),
location VARCHAR(40),
course_id INT,
instructor_id INT,
FOREIGN KEY (course_id) REFERENCES  Course on delete cascade,
FOREIGN KEY (instructor_id) REFERENCES  Instructor
)

CREATE TABLE Student(
student_id INT PRIMARY KEY IDENTITY,
f_name VARCHAR(40) NOT NULL,
l_name VARCHAR(40) NOT NULL,
gpa DECIMAL,
faculty VARCHAR(40),
email VARCHAR(40),
major VARCHAR(40), 
password VARCHAR(40),
financial_status BIT ,
semester INT,
acquired_hours INT ,
assigned_hours INT, 
advisor_id INT ,
FOREIGN KEY (advisor_id) REFERENCES  Advisor
);

CREATE TABLE Student_Phone(
student_id INT NOT NULL,
phone_number VARCHAR(40) NOT NULL,
PRIMARY KEY(student_id, phone_number),
FOREIGN KEY (student_id) REFERENCES  Student 
);

CREATE TABLE Student_Instructor_Course_Take (
student_id INT NOT NULL,
course_id INT NOT NULL,
instructor_id INT, 
semester_code VARCHAR(40),
exam_type VARCHAR(40) DEFAULT 'Normal',
grade VARCHAR(40),
PRIMARY KEY(student_id,course_id),
FOREIGN KEY (student_id) REFERENCES  Student,
FOREIGN KEY (course_id) REFERENCES  Course,
FOREIGN KEY (instructor_id) REFERENCES  Instructor
)

CREATE TABLE Graduation_Plan (
    plan_id INT IDENTITY NOT NULL, 
    semester_code VARCHAR(40) NOT NULL, 
    semester_credit_hours INT,
    expected_grad_date DATE,
    advisor_id INT, 
    student_id INT,
    PRIMARY KEY(plan_id, semester_code),
    FOREIGN KEY (advisor_id) REFERENCES Advisor ,
    FOREIGN KEY (student_id) REFERENCES Student 
);

CREATE TABLE GradPlan_Course (
    plan_id INT NOT NULL,
    semester_code VARCHAR(40) NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (plan_id, semester_code, course_id),
    FOREIGN KEY (plan_id, semester_code) REFERENCES Graduation_Plan(plan_id, semester_code),
    FOREIGN KEY (course_id) references course(course_id)  on delete cascade
);


CREATE TABLE Request (
request_id INT PRIMARY KEY IDENTITY,
type VARCHAR(40),
comment VARCHAR(40),
status VARCHAR(40) DEFAULT 'pending',
credit_hours INT,
student_id INT, 
advisor_id INT,
course_id INT,
FOREIGN KEY (student_id) REFERENCES  Student,
FOREIGN KEY (advisor_id) REFERENCES  Advisor,
FOREIGN KEY (course_id) REFERENCES  Course 
);


CREATE TABLE MakeUp_Exam (
exam_id INT PRIMARY KEY IDENTITY,
date DATETIME,
type VARCHAR(40),
course_id INT, 
FOREIGN KEY (course_id) references course on delete cascade
);
    
CREATE TABLE Exam_Student (
exam_id INT NOT NULL,
student_id INT NOT NULL,
course_id INT,
PRIMARY KEY(exam_id, student_id),
FOREIGN KEY (student_id) REFERENCES  Student,
FOREIGN KEY (exam_id) REFERENCES  MakeUp_Exam,
FOREIGN KEY (course_id) REFERENCES  Course
);

CREATE TABLE Payment(                 
payment_id INT PRIMARY KEY IDENTITY,
amount INT,
deadline DATETIME,
n_installments INT,
status VARCHAR(40) DEFAULT 'notPaid',
fund_percentage DECIMAL,
start_date DATETIME,
student_id int,
semester_code varchar(40),
FOREIGN KEY (student_id) REFERENCES student ON DELETE NO ACTION,
FOREIGN KEY (semester_code) REFERENCES semester ON DELETE NO ACTION
);


CREATE TABLE Installment(                   
payment_id INT NOT NULL,
deadline DATETIME NOT NULL,    
amount INT,
status VARCHAR(40),
start_date DATETIME 
PRIMARY KEY(payment_id,deadline),
FOREIGN KEY (payment_id) REFERENCES Payment
)
GO

-----DROP TABLES-----
GO
CREATE PROCEDURE DropAllTables 
AS
DROP TABLE Installment, Payment, Exam_Student, MakeUp_Exam, Request, GradPlan_Course, Graduation_Plan, Slot, Course_Semester,
Student_Instructor_Course_Take, Instructor_Course,PreqCourse_course, Student_phone, Student, Advisor, Semester, Instructor, Course ;
GO



----clear table-----

GO
CREATE PROCEDURE clearAllTables
AS
EXEC DropAllTables
EXEC CreateAllTables
GO

-----a-------
GO
create VIEW view_students
AS
select *
from student 
where financial_status = 1
GO

----b-----

create VIEW view_Course_prerequisites
AS
select c.course_id as 'Courses Id',
c.name,
c.major,
c.is_offered,
c.credit_hours,
c.semester,
pc.prerequisite_course_id
 
from course c 
LEFT outer join PreqCourse_course pc ON c.course_id = pc.course_id;
go

-----c-------
go
create VIEW Instructors_AssignedCourses AS
select i.instructor_id,
i.name,
i.email,
i.faculty,
i.office,
ic.course_id
from Instructor i
left outer join Instructor_Course ic on i.instructor_id=ic.instructor_id;
go

-----d--------


create VIEW Student_Payment AS
select  
 P.payment_id,
    P.amount,
    P.deadline,
    P.n_installments,
    P.status,
    P.fund_percentage,
    P.semester_code,
    P.start_date,
S.student_id,
    S.f_name,
    S.l_name
   
    from Student S 
    inner join Payment p on  S.student_id= P.student_id;
    
  go  
 
    -----e-------
    create VIEW Courses_Slots_Instructor AS
    select  
    c.course_id as CourseID,
    c.name as course_name,
    s.slot_id as SlotID,
    s.time as SlotTime,
    s.day as SlotDay,
     s.location as SlotLocation,
     i.name as 'Slot’s Instructor name'
    from Course c
    inner join slot s on c.course_id=s.course_id
    inner join instructor i on i.instructor_id =i.instructor_id;
    go
    
    ----f----
    create VIEW Courses_MakeupExams 
    as
    select  c.name as Course_name,
    c.semester as Course_semester,
    m.exam_id,
    m.date,
    m.type,
    c.course_id
    from course c
    left join MakeUp_Exam m on  c.course_id = m.course_id;
    go

    ----g-----
    go
    create VIEW Students_Courses_transcript as
    select S.student_id as 'student id',
    S.f_name as 'first name',
    S.l_name as 'last name',
    c.course_id as 'CourseID',
    c.name as 'course name',
    st.exam_type as 'exam type',
    st.grade as 'course grade',
    st.semester_code as 'semester',
    i.name as 'Instructor’s name'
    
    from student S, Student_Instructor_Course_Take st, Course c, instructor i where 
    S.student_id=st.student_id and c.course_id = st.course_id and i.instructor_id = st.instructor_id;
         go
         
    ----h----
    go
    create view semester_offered_Courses as 
    select  
    c.course_id,
    c.name as 'course_name',
    sem.semester_code as 'semester_code'
    from semester sem ,Course_Semester cs, course c where sem.semester_code= cs.semester_code and c.course_id = cs.course_id;
    go
  
    ----i------
    create view Advisors_Graduation_Plan as
    SELECT
    g.*,
    a.name as 'advisor name'
    from Graduation_Plan g
    left join Advisor a on g.advisor_id=a.advisor_id;
GO

----2.A---

CREATE PROC Procedures_StudentRegistration
@first_name varchar (40),
@last_name varchar (40),
@password varchar (40),
@faculty varchar (40),
@email varchar(40),
@major varchar (40),
@Semester int,
@id int OUTPUT
AS
INSERT INTO Student(f_name,l_name,password,faculty,email,major,semester)
Values(@first_name,@last_name,@password, @faculty, @email, @major, @Semester)
SELECT @id = s.student_id from student s where s.email = @email;
GO



----2.B---

CREATE PROC Procedures_AdvisorRegistration
@advisor_name varchar (40), @password varchar (40),
@email varchar (40), @office varchar (40), @id int output
AS
INSERT INTO Advisor (name, password, email, office)
Values (@advisor_name, @password, @email, @office)
SELECT @id = a.advisor_id from advisor a where a.email = @email;
GO
--C--
GO
CREATE PROCEDURE Procedures_AdminListStudents
AS
BEGIN
SELECT * FROM Student
END
--D--
GO
CREATE PROCEDURE Procedures_AdminListAdvisors
AS
BEGIN
SELECT * FROM Advisor
END

--E--
GO
CREATE PROCEDURE AdminListStudentsWithAdvisors
AS
BEGIN 
SELECT *
FROM Student S full outer join Advisor A ON S.advisor_id = A.advisor_id 
END

 

--F--
GO
CREATE PROCEDURE AdminAddingSemester
@semester_code VARCHAR(40),
@start_date DATE,
@end_date DATE
AS
BEGIN
INSERT INTO Semester
Values (@semester_code,@start_date,@end_date)
end 

--G--
GO
CREATE PROCEDURE Procedures_AdminAddingCourse
@name VARCHAR(40),
@major VARCHAR(40),
@is_offered BIT,
@credit_hours INT,
@semester VARCHAR(40)
AS
BEGIN
INSERT INTO Course(name,major,is_offered,credit_hours,semester)
Values (@name,@major,@is_offered,@credit_hours,@semester)
END


--H--
GO
CREATE PROC Procedures_AdminLinkInstructor
@Instructor_Id INT,
@course_ID INT,
@slot_id INT
AS
UPDATE slot
SET instructor_id = @Instructor_Id, course_id=@course_ID
WHERE slot_id = @slot_id
GO

--I--

GO
CREATE PROC Procedures_AdminLinkStudent  
@Instructor_Id INT,
@student_ID INT, 
@course_ID INT, 
@semester_code VARCHAR(40)
AS
INSERT INTO Student_Instructor_Course_Take VALUES(@student_ID,@course_ID,@Instructor_Id,@semester_code,NULL,NULL)
GO

--J--

GO
CREATE PROC Procedures_AdminLinkStudentToAdvisor 
@studentID INT,
@advisorID INT
AS
UPDATE Student
SET advisor_id = @advisorID
WHERE student_id=@studentID
GO

--K--

GO
CREATE PROCEDURE Procedures_AdminAddExam
@Type VARCHAR(40),
@date DATETIME,
@courseID INT
AS
INSERT INTO MakeUp_Exam(date,type,course_id) VALUES(@date,@Type,@courseID)
GO

--L--

CREATE PROC Procedures_AdminIssueInstallment
@payment_ID INT
AS
DECLARE @cnt INT = 0;
DECLARE @n_installments INT
DECLARE @days INT
DECLARE @amount INT
DECLARE @status VARCHAR(40)
SELECT @n_installments = p.n_installments, @amount = p.amount, @status = p.status FROM Payment p WHERE p.payment_id=@payment_ID
SELECT @days = DATEDIFF(d, GETDATE(), p.deadline) FROM Payment p WHERE p.payment_id=@payment_ID

WHILE @cnt < @n_installments
BEGIN
   INSERT INTO Installment VALUES(@payment_ID, DATEADD(d, @days*(@cnt+1)/@n_installments, GETDATE()), @amount/@n_installments, @status, GETDATE())
   SET @cnt = @cnt + 1;
END;
GO

--M--
CREATE PROC Procedures_AdminDeleteCourse 
@courseID INT
AS
DELETE FROM PreqCourse_course WHERE prerequisite_course_id=@courseID OR course_id=@courseID
DELETE FROM Slot WHERE course_id=@courseID
DELETE FROM Course WHERE course_id=@courseID

GO

--N--
CREATE PROC Procedure_AdminUpdateStudentStatus 
@StudentID INT
AS
UPDATE Student 
SET financial_status = 0
Where student_id = @StudentID AND student_id IN (SELECT p.student_id FROM Installment i, Payment p WHERE i.payment_id=p.payment_id AND p.student_id=student_id AND DATEDIFF(d,GETDATE(),i.deadline)<0);
GO

--O--
GO
CREATE VIEW all_Pending_Requests AS
SELECT r.comment AS 'Pending requests details', s.f_name 'initiated student name', a.name AS'Related advisor name'  FROM Request r INNER JOIN Student s ON r.student_id = s.student_id INNER JOIN Advisor a ON r.advisor_id = a.advisor_id
GO
--P--
GO
CREATE PROC Procedures_AdminDeleteSlots
@current_semester varchar(40) 
AS
DELETE FROM Slot WHERE course_id IN (SELECT c.course_id FROM Course_Semester c WHERE c.semester_code = @current_semester)
GO
  


  -----Q-----
GO
CREATE FUNCTION FN_AdvisorLogin
(@ID INT, @password VARCHAR(40))
RETURNS BIT
AS
BEGIN
DECLARE @OUT INT
IF EXISTS
(SELECT* FROM Advisor A WHERE A.advisor_id=@ID AND A.password=@password)
SET @OUT=1
ELSE
SET @OUT=0
RETURN @OUT
END

-----R-----
GO
CREATE PROCEDURE Procedures_AdvisorCreateGP
@Semester_code varchar(40),
@expected_graduation_date date, 
@sem_credit_hours int,
@advisor_id int,
@student_id int
AS
DECLARE @AQUIREDh INT
SELECT @AQUIREDh=S.acquired_hours FROM Student S WHERE S.student_id=@student_id
IF @AQUIREDh>157
BEGIN
INSERT INTO Graduation_Plan(semester_code,expected_grad_date,semester_credit_hours,advisor_id,student_id)
VALUES(@Semester_code,@expected_graduation_date,@sem_credit_hours,@advisor_id,@student_id)
END
GO

--S--
GO
CREATE PROC Procedures_AdvisorAddCourseGP
@student_id int,
@Semester_code varchar (40),
@course_name varchar (40)
AS
DECLARE @plan_id INT,
 @COURSE_ID INT;
SELECT @plan_id = p.plan_id FROM Graduation_Plan p WHERE p.student_id=@student_id
SELECT  @COURSE_ID=C.course_id FROM Course C WHERE C.name=@course_name
INSERT INTO GradPlan_Course VALUES(@plan_id,@Semester_code,@COURSE_ID)
GO

-----T-----
CREATE PROCEDURE Procedures_AdvisorUpdateGP
@expected_grad_date date,
@studentID int
AS
UPDATE Graduation_Plan
SET expected_grad_date=@expected_grad_date
WHERE Graduation_Plan.student_id=@studentID
GO

-----U-----
CREATE PROCEDURE Procedures_AdvisorDeleteFromGP
@studentID int,
@semester_code varchar(40),
@courseID int
AS
DELETE FROM GradPlan_Course
WHERE course_id=@courseID AND semester_code=@semester_code
AND @studentID IN(SELECT student_id FROM Graduation_Plan G WHERE G.student_id=@studentID) 
GO

-----V-----
GO
CREATE FUNCTION  FN_Advisors_Requests
(@advisorID int)
RETURNS TABLE
AS
RETURN(SELECT* FROM Request R WHERE R.advisor_id=@advisorID)
GO

----W----
GO
CREATE PROCEDURE  Procedures_AdvisorApproveRejectCHRequest
@RequestID int, 
@Current_semester_code varchar (40)
AS
DECLARE @Rtype VARCHAR(40), @STUDENTID INT, @Rstatus VARCHAR(40);
select @Rtype=R.type, @Rstatus=r.status , @STUDENTID=R.student_id from Request R where R.request_id=@RequestID


DECLARE @GPA DECIMAL
SELECT @GPA=S.gpa
FROM Student S
WHERE S.student_id=@STUDENTID

Declare @requested_hours INT
select @requested_hours= R.credit_hours
From Request R    
Where R.request_id=@RequestID 

DECLARE @Assined_hours INT
SELECT @Assined_hours=S.assigned_hours
FROM STUDENT S,Request R
WHERE R.request_id=@RequestID AND R.student_id=S.student_id

IF
(@Assined_hours+@requested_hours<=34) AND @Rtype='credit_hours' AND @requested_hours<=3 AND @GPA<=3.7 AND @Rstatus = 'pending'
BEGIN
UPDATE Request
SET status='accepted'
WHERE request_id=@RequestID
UPDATE Student
SET assigned_hours=assigned_hours+@requested_hours
WHERE student_id=@STUDENTID
UPDATE Payment
SET amount=amount+1000*@requested_hours
WHERE student_id=@STUDENTID AND semester_code=@Current_semester_code

DECLARE @PAYMENTID INT
SELECT @PAYMENTID=P.payment_id FROM Payment P
WHERE P.student_id=@STUDENTID AND P.semester_code=@Current_semester_code
UPDATE Installment
SET amount=amount+1000*@requested_hours
WHERE payment_id=@PAYMENTID AND deadline=dbo.FN_StudentUpcoming_installment(@STUDENTID)
END
ELSE
BEGIN
UPDATE Request
SET status='rejected'
WHERE request_id=@RequestID
END
GO

-----X-----
CREATE PROCEDURE Procedures_AdvisorViewAssignedStudents
@AdvisorID int,
@major varchar(40)
AS
SELECT S.student_id,S.f_name,S.l_name,S.major,C.name FROM Student S LEFT OUTER JOIN Student_Instructor_Course_Take SICT ON (S.student_id=SICT.student_id) INNER JOIN Course C ON(C.course_id=SICT.course_id)
WHERE S.major=@major AND S.advisor_id=@AdvisorID
GO

-----Y-----
GO
CREATE PROCEDURE Procedures_AdvisorApproveRejectCourseRequest
@RequestID int,
@current_semester_code varchar(40)
 AS

 DECLARE @COURSE_ID INT
DECLARE @STUDENT_ID INT
SELECT @COURSE_ID=R.course_id, @STUDENT_ID=R.student_id
FROM Request R
WHERE R.request_id=@RequestID

DECLARE @SEMESTER_HOURS INT 
Select @SEMESTER_HOURS =SUM (C.credit_hours)
FROM Student_Instructor_Course_Take  SS  INNER JOIN Course C ON C.course_id=SS.course_id
WHERE SS.semester_code=@Current_semester_code AND SS.student_id=@STUDENT_ID


DECLARE @Rtype VARCHAR(40)
SELECT @Rtype=R.type from Request R where R.request_id=@RequestID

DECLARE @COURSE_HOURS INT 
SELECT @COURSE_HOURS=C.credit_hours
FROM Course C , Request R
WHERE C.course_id=R.course_id AND @RequestID=R.request_id

DECLARE @Assined_hours INT
SELECT @Assined_hours=S.assigned_hours
FROM STUDENT S,Request R
WHERE R.request_id=@RequestID AND R.student_id=S.student_id


DECLARE @NUMofPRE INT
SELECT @NUMofPRE=COUNT(PRE.prerequisite_course_id)
FROM PreqCourse_course PRE
WHERE PRE.course_id=@COURSE_ID

DECLARE @PREtaken INT
SELECT @PREtaken= COUNT(PRE.prerequisite_course_id)
FROM PreqCourse_course PRE
INNER JOIN Student_Instructor_Course_Take SC ON PRE.prerequisite_course_id=SC.course_id
WHERE PRE.course_id=@COURSE_ID AND SC.student_id=@STUDENT_ID

IF (@COURSE_HOURS + @SEMESTER_HOURS <=@Assined_hours) AND @PREtaken=@NUMofPRE AND @Rtype='course'
BEGIN
UPDATE Request
SET status='accepted'
WHERE request_id=@RequestID
INSERT INTO Student_Instructor_Course_Take(student_id,course_id,semester_code)
VALUES(@STUDENT_ID,@COURSE_ID,@current_semester_code)

END
ELSE
BEGIN
UPDATE Request
SET status='rejected'
WHERE request_id=@RequestID
END
GO

-----Z-----
GO
CREATE PROCEDURE Procedures_AdvisorViewPendingRequests
@Advisor_ID int
AS
SELECT * FROM Request R WHERE R.advisor_id=@Advisor_ID AND R.status='pending'
GO


----AA----

GO
CREATE FUNCTION FN_StudentLogin
(@StudentID int,
@password varchar (40))
RETURNS BIT
AS
BEGIN
DECLARE @return BIT
	IF EXISTS (	
		SELECT 1 FROM Student s
		WHERE s.student_id = @StudentID and s.password = @password
		)
			set @return = 1
		else
			set @return = 0
	return @return
END


----BB----

GO
CREATE PROCEDURE Procedures_StudentaddMobile
(@StudentID int, 
@mobile_number varchar (40))
AS
INSERT INTO Student_Phone
VALUES (@StudentID,@mobile_number)
GO


----CC----

GO
CREATE FUNCTION FN_SemsterAvailableCourses
(@semster_code varchar (40))
RETURNS TABLE
AS
RETURN
SELECT c.* FROM COURSE c , Course_Semester cs
WHERE cs.semester_code = @semster_code and c.course_id = cs.course_id
GO

----DD----

GO
CREATE PROCEDURE Procedures_StudentSendingCourseRequest
(@StudentID int, @courseID int, @type varchar (40), @comment varchar (40))
AS
DECLARE @v1 int;
select @v1 = credit_hours from Course x where x.course_id = @courseID;
DECLARE @v2 int;
select @v2 = advisor_id from Student y where y.student_id = @StudentID;
INSERT INTO Request (type, comment,status,credit_hours,student_id, advisor_id, course_id)
VALUES (@type,@comment,'pending',@v1, @StudentID,@v2,@courseID)
GO

----EE----

GO
CREATE PROCEDURE Procedures_StudentSendingCHRequest
(@StudentID int, @credithours int, @type varchar (40), @comment varchar (40))
AS
DECLARE @v1 int;
select @v1 = advisor_id from Student y where y.student_id = @StudentID;
INSERT INTO Request (type, comment,status,credit_hours,student_id, advisor_id, course_id)
VALUES (@type,@comment,'pending',@credithours, @StudentID,@v1,null)
GO


---FF---
GO
CREATE FUNCTION FN_StudentViewGP
(@student_ID int)
RETURNS TABLE
AS
RETURN
SELECT s.student_id, s.f_name, s.l_name, g.plan_id, gc.course_id, c.name, gc.semester_code, g.expected_grad_date, g.semester_credit_hours, g.advisor_id
FROM student s, Graduation_Plan g, GradPlan_Course gc, course c
WHERE s.student_id = g.student_id and g.plan_id = gc.plan_id and gc.course_id = c.course_id
and  s.student_id = @student_ID
GO


---GG----
CREATE FUNCTION FN_StudentUpcoming_installment
(@StudentID int)
RETURNS DATETIME
AS
BEGIN
DECLARE @returnMIN DATETIME;
SELECT TOP 1 @returnMIN = (i.deadline) FROM
Payment p, installment i
where p.payment_id = i.payment_id AND P.student_id=@StudentID AND i.status='unpaid'
ORDER BY i.deadline 
return @returnMIN;
END;
GO


---HH----
GO
CREATE FUNCTION FN_StudentViewSlo
(@CourseID int, @InstructorID int)
RETURNS TABLE
AS
RETURN
SELECT * FROM Slot s
WHERE s.course_id = @CourseID and s.instructor_id = @InstructorID
GO

------II------
CREATE PROCEDURE Procedures_StudentRegisterFirstMakeup
 @StudentID int,
 @courseID int,
 @studentCurrent_semester varchar (40)
 
 AS
 DECLARE @exam_id INT
 IF EXISTS(SELECT * FROM Student_Instructor_Course_Take  SC WHERE SC.student_id=@StudentID AND SC.course_id=@courseID AND SC.exam_type='Normal' AND SC.grade IN ('F', 'FF', NULL) ) 
 AND NOT EXISTS(SELECT * FROM MakeUp_Exam M INNER JOIN Exam_Student E ON M.exam_id=E.exam_id  WHERE M.course_id=@courseID AND E.student_id=@StudentID)
 AND EXISTS(SELECT exam_id FROM MakeUp_Exam where course_id=@courseID)
BEGIN
 INSERT INTO Student_Instructor_Course_Take(student_id,course_id,semester_code,exam_type)
 VALUES(@StudentID,@courseID,@studentCurrent_semester,'First Makeup')
 (SELECT @exam_id= exam_id FROM MakeUp_Exam where course_id=@courseID)
 INSERT INTO Exam_Student VALUES(@exam_id,@StudentID, @courseID)
 END
 GO
 -----JJ-----
 CREATE FUNCTION  FN_StudentCheckSMEligiability
 ( @CourseID int, @StudentID int)
 RETURNS BIT
 AS 
 BEGIN
 DECLARE @OUT BIT
 DECLARE @EVENF INT
 DECLARE @ODDF INT
 
 SELECT @EVENF=COUNT(SC.course_id)
 FROM Student_Instructor_Course_Take SC
 INNER JOIN Course C ON SC.course_id=C.course_id
 WHERE SC.student_id=@StudentID AND SC.grade IN('FF','F') AND C.semester%2=0
 
 SELECT @ODDF=COUNT(SC.course_id)
 FROM Student_Instructor_Course_Take SC
 INNER JOIN Course C ON SC.course_id=C.course_id
 WHERE SC.student_id=@StudentID AND SC.grade IN('FF','F') AND C.semester%2=1


IF EXISTS (SELECT * FROM Student_Instructor_Course_Take SC WHERE SC.student_id=@StudentID AND SC.course_id=@CourseID AND SC.exam_type='First Makeup' AND SC.grade IN('F','FF','FA'))
  AND @EVENF<=2 AND @ODDF<=2
  SET @OUT=1
ELSE
 SET @OUT=0
 RETURN @OUT
 END
 
 GO
 ----KK----
CREATE PROCEDURE Procedures_StudentRegisterSecondMakeup
@StudentID int,
@courseID int,@StudentCurrentSemester Varchar (40)
AS
DECLARE @exam_id INT
DECLARE @ELIGIBLE BIT
SET @ELIGIBLE=dbo.FN_StudentCheckSMEligiability(@courseID,@StudentID)
IF @ELIGIBLE=1 AND EXISTS(SELECT exam_id FROM MakeUp_Exam where course_id=@courseID)
BEGIN
 INSERT INTO Student_Instructor_Course_Take(student_id,course_id,semester_code,exam_type)
 VALUES(@StudentID,@courseID,@StudentCurrentSemester,'Second Makeup')
 (SELECT @exam_id = exam_id FROM MakeUp_Exam where course_id=@courseID)
 INSERT INTO Exam_Student VALUES(@exam_id,@StudentID, @courseID)
 END
---LLL--
GO
CREATE PROCEDURE Procedures_ViewRequiredCourses
@StudentID int, 
@current_semester_code Varchar(40)
AS
SELECT C.* 
FROM Course C INNER JOIN Student_Instructor_Course_Take SEM ON SEM.course_id=C.course_id 
INNER JOIN Student s ON s.student_id = SEM.student_id

WHERE C.course_id IN (SELECT sc.course_id FROM Student_Instructor_Course_Take  SC WHERE SC.grade IN ('F', 'FF', 'FA')  AND sc.semester_code<>@current_semester_coden AND s.student_id=@StudentID)
---MM----
GO
CREATE PROCEDURE Procedures_ViewOptionalCourse
@StudentID int, 
@current_semester_code Varchar(40)
AS
SELECT C.* 
FROM Course C INNER JOIN Student_Instructor_Course_Take SEM ON SEM.course_id=C.course_id
INNER JOIN Student s ON s.student_id = SEM.student_id
WHERE c.semester <> s.semester AND s.student_id=@StudentID AND s.major= c.major AND c.course_id NOT IN 
(SELECT course_id FROM Student_Instructor_Course_Take where student_id=@StudentID)
AND c.course_id IN (SELECT course_id FROM GradPlan_Course WHERE student_id=@StudentID AND semester_code=@current_semester_code)
GO
---NN---
GO
CREATE PROCEDURE Procedures_ViewMS
@Student_id int
AS 
SELECT C.*
FROM Course C
Where c.course_id NOT IN (
SELECT course_id 
FROM Student_Instructor_Course_Take x
Where @Student_id=x.student_id)


--OO--
GO
CREATE PROCEDURE Procedures_ChooseInstructor
 @Student_ID int, @Instructor_ID int, @Course_ID int,
@current_semester_code varchar(40)
AS 
UPDATE Student_Instructor_Course_Take 
SET instructor_id=@instructor_id
WHERE @current_semester_code=semester_code
AND @Student_ID=student_id