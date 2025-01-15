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
	FROM Parson.Student AS S
	JOIN Organization.Branch_Department_Track_Intake_Student AS BDTIS
	ON BDTIS.Student_SSN=S.SSN
	JOIN Organization.Branch_Department_Track_Intake AS BDTI
	ON BDTI.Id=BDTIS.Branch_Department_Track_Intake_Id
	JOIN Organization.V_Branch_Department_Track_Intake AS VBDTI
	ON BDTI.Intake_Id=VBDTI.I_Id
GO

SELECT * FROM Organization.V_Branche_Department_Track_Intake_Students


CREATE VIEW Organization.Branch_Department_Track_Intake_Instructor_Course
WITH ENCRYPTION 
	SELECT VBDTI.*,I.*,C.*
	FROM [Parson].[Instructor] AS I
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
