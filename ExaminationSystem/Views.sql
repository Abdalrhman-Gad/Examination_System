USe[ExaminationSystemDB]
GO
--VIEW TO SHOW ALL DATA ABOUT DEPARTMENTS IN EACH BRANCH
CREATE VIEW Organization.V_Branch_Department
(B_Id,B_Name,B_Location,D_Id,D_Name,D_Desc)
WITH ENCRYPTION
AS
	SELECT B.*,D.*
	FROM Organization.Branch AS B 
	JOIN Organization.Branch_Department AS DB
	ON B.Id=DB.Branch_Id 
	JOIN Organization.Department AS D
	ON DB.Department_Id=D.Id
GO

SELECT * FROM Organization.V_Branch_Department

--VIEW TO SHOW ALL DATA ABOUT TRACKS ON EACH DEPARTMENTS IN EACH BRANSH
CREATE VIEW Organization.V_Branch_Department_Track
(B_Id,B_Name,B_Location,D_Id,D_Name,D_Desc,T_Id,T_Name,T_Desc)
WITH ENCRYPTION
AS
	SELECT VBD.*,T.*
	FROM Organization.Track AS T 
	JOIN Organization.Branch_Department_Track AS BDT
	ON T.Id=BDT.Track_Id
	JOIN Organization.Branch_Department AS BD
	ON BDT.Branch_Department_Id=BD.Id
	JOIN Organization.V_Branch_Department AS VBD
	ON VBD.B_Id=BD.Branch_Id AND VBD.D_Id=BD.Department_Id
GO

SELECT * FROM Organization.V_Branch_Department_Track


--VIEW TO SHOW ALL DATA ABOUT INTAKES ON EACH TRACKS IN EACH DEPARTMENTS IN EACH BRANSH
CREATE OR ALTER VIEW Organization.V_Branch_Department_Track_Intake
(B_Id,B_Name,B_Location,D_Id,D_Name,D_Desc,T_Id,T_Name,T_Desc,I_Id,I_Number,I_Year,I_Round)
WITH ENCRYPTION
AS
	SELECT VBDT.*,I.* 
	FROM Organization.Intake AS I
	JOIN Organization.Branch_Department_Track_Intake AS BDTI
	ON I.Id=BDTI.Intake_Id
	JOIN Organization.Branch_Department_Track AS BDT
	ON BDT.Id=BDTI.Branch_Department_Track_Id
	JOIN Organization.V_Branch_Department_Track AS VBDT
	ON VBDT.T_Id=BDT.Track_Id
	JOIN Organization.Branch_Department AS BD
	ON VBDT.B_Id=BD.Branch_Id AND VBDT.D_Id=BD.Department_Id
GO

SELECT * FROM Organization.V_Branch_Department_Track_Intake

--VIEW TO SHOW ALL DATA ABOUT STUDENTS ON EACH INTAKES ON EACH TRACKS IN EACH DEPARTMENTS IN EACH BRANSH
CREATE VIEW Organization.V_Branche_Department_Track_Intake_Students 
WITH ENCRYPTION
AS
	SELECT VBDTI.*,S.*
	FROM Person.Student AS S
	JOIN Organization.Branch_Department_Track_Intake_Student AS BDTIS
	ON BDTIS.Student_SSN=S.SSN
	JOIN Organization.Branch_Department_Track_Intake AS BDTI
	ON BDTI.Id=BDTIS.Branch_Department_Track_Intake_Id
	JOIN Organization.V_Branch_Department_Track_Intake AS VBDTI
	ON BDTI.Intake_Id=VBDTI.I_Id
GO

SELECT * FROM Organization.V_Branche_Department_Track_Intake_Students


CREATE VIEW Organization.V_Branch_Department_Track_Intake_Instructor_Course
WITH ENCRYPTION 
AS
	SELECT VBDTI.*,I.*,C.Code,	C.Name AS Course_Name,C.Description,C.Min_Degree,C.Max_Degree
	FROM [Person].[Instructor] AS I
	JOIN [Organization].[Instructor_Course] AS IC
	ON I.SSN=IC.Instructor_SSN
	JOIN [Organization].[Course] AS C
	ON C.Code=IC.Course_Code
	JOIN [Organization].[Branch_Department_Track_Intake_Instructor_Course] AS BDTIIC
	ON BDTIIC.Instructor_Course_Id=IC.Id
	JOIN Organization.Branch_Department_Track_Intake AS BDTI
	ON BDTI.Id=BDTIIC.Branch_Department_Track_Intake_ID
	JOIN Organization.V_Branch_Department_Track_Intake AS VBDTI
	ON BDTI.Intake_Id=VBDTI.I_Id


CREATE OR ALTER VIEW Organization.V_Student_Eaxm
AS
	SELECT 
	Person.Student.*, 
	Exam.Exams.Id AS Exam_Id, 
	Exam.Exams.*, 
	Student_Exams.Result,
	Track.Id AS Track_Id, 
	Track.Name, 
	Intake.Id AS Intake_Id, 
	Intake.Number 
	FROM 
	Person.Student 
	JOIN Exam.Student_Exams 
	ON Person.Student.SSN = Exam.Student_Exams.Student_SSN
	JOIN Exam.Exams 
	ON Exam.Exams.Id = Exam.Student_Exams.Exam_Id
	JOIN Organization.Branch_Department_Track_Intake BDTI 
	ON Exam.Exams.Branch_Department_Track_Intake_Course_Instructor_Id = BDTI.Branch_Department_Track_Id
	JOIN Organization.Branch_Department_Track
	ON BDTI.Branch_Department_Track_Id = Organization.Branch_Department_Track.Id
	JOIN Organization.Track 
	ON Organization.Branch_Department_Track.Track_Id = Organization.Track.Id
	JOIN Organization.Intake 
	ON BDTI.Intake_Id = Organization.Intake.Id;

SELECT * FROM Organization.V_Student_Eaxm


CREATE OR ALTER VIEW Exam.V_Exam_Questions
(E_Id,S_Time,E_Time,T_Time,Allowence,BDTICI,Q_Id,Q_Text,
Created_At,Type,Ins_Cou_Id)
WITH ENCRYPTION
AS
	SELECT E.*,Q.*
	FROM [Exam].[Questions] AS Q
	JOIN [Exam].[Exam_Questions] AS EQ
	ON Q.Id = EQ.Question_Id
	JOIN [Exam].[Exams] AS E
	ON EQ.Exam_Id=E.Id

SELECT * FROM Exam.V_Exam_Questions

CREATE OR ALTER VIEW Exam.V_Exam_Questions_Choices
(E_Id,S_Time,E_Time,T_Time,Allowence,BDTICI,Q_Id,Q_Text,
Created_At,Type,Ins_Cou_Id,C_Id,C_Q_Id,C_Text,C_Is_True)
WITH ENCRYPTION
AS
	SELECT E.*,Q.*,C.*
	FROM [Exam].[Questions] AS Q
	JOIN [Exam].[Exam_Questions] AS EQ
	ON Q.Id = EQ.Question_Id
	JOIN [Exam].[Exams] AS E
	ON EQ.Exam_Id=E.Id
	JOIN [Exam].[Choices] AS C
	ON C.Question_Id=Q.Id

SELECT * FROM Exam.V_Exam_Questions_Choices

CREATE OR ALTER VIEW Exam.V_Exam_Questions_T_F
(E_Id,S_Time,E_Time,T_Time,Allowence,BDTICI,Q_Id,Q_Text,
Created_At,Type,Ins_Cou_Id,TF_Q_Id,TF_Is_True)
WITH ENCRYPTION
AS
	SELECT E.*,Q.*,TF.*
	FROM [Exam].[Questions] AS Q
	JOIN [Exam].[Exam_Questions] AS EQ
	ON Q.Id = EQ.Question_Id
	JOIN [Exam].[Exams] AS E
	ON EQ.Exam_Id=E.Id
	JOIN [Exam].[True_False] AS TF
	ON TF.Question_Id=Q.Id

SELECT * FROM Exam.V_Exam_Questions_T_F

CREATE OR ALTER VIEW Exam.V_Exam_Questions_Text
(E_Id,S_Time,E_Time,T_Time,Allowence,BDTICI,Q_Id,Q_Text,
Created_At,Type,Ins_Cou_Id,TEXT_Q_Id,Text_Answer)
WITH ENCRYPTION
AS
	SELECT E.*,Q.*,TA.*
	FROM [Exam].[Questions] AS Q
	JOIN [Exam].[Exam_Questions] AS EQ
	ON Q.Id = EQ.Question_Id
	JOIN [Exam].[Exams] AS E
	ON EQ.Exam_Id=E.Id
	JOIN [Exam].[Text_Answers] AS TA
	ON TA.Question_Id=Q.Id


SELECT * FROM Exam.V_Exam_Questions_T_F

CREATE VIEW Answer.V_Student_Answer
WITH ENCRYPTION 
AS
	SELECT S.*, SA.*
	FROM Answer.Student_Answer AS SA
	JOIN Person.Student AS S
	ON S.SSN=SA.Student_SSN

SELECT * FROM Answer.V_Student_Answer

CREATE VIEW Answer.V_Student_Answer_T_F
WITH ENCRYPTION 
AS
	SELECT S.*, SA.*,TF.*
	FROM Answer.Student_Answer AS SA
	JOIN Person.Student AS S
	ON S.SSN=SA.Student_SSN
	JOIN Answer.True_False_Answer TF
	ON SA.Id=TF.Answer_Id

SELECT * FROM Answer.V_Student_Answer_T_F

CREATE VIEW Answer.V_Student_Answer_MCQ
WITH ENCRYPTION 
AS
	SELECT S.*, SA.*,MCQ.*
	FROM Answer.Student_Answer AS SA
	JOIN Person.Student AS S
	ON S.SSN=SA.Student_SSN
	JOIN [Answer].[Mcq_Answer] AS MCQ
	ON SA.Id=MCQ.Answer_Id

SELECT * FROM Answer.V_Student_Answer_MCQ

CREATE VIEW Answer.V_Student_Answer_Text
WITH ENCRYPTION 
AS
	SELECT S.*, SA.*,T.*
	FROM Answer.Student_Answer AS SA
	JOIN Person.Student AS S
	ON S.SSN=SA.Student_SSN
	JOIN [Answer].[Text_Answer] AS T
	ON SA.Id=T.Answer_Id
SELECT * FROM Answer.V_Student_Answer_Text
