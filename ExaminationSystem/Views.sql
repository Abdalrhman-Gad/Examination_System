--VIEW TO SHOW ALL DATA ABOUT DEPARTMENTS IN EACH BRANCH
CREATE VIEW Organization.V_Branch_Department
(B_Id,B_Name,B_Location,D_Id,D_Name,D_Desc)
WITH ENCRYPTION
AS
	SELECT B.*,D.*
	FROM Organization.Branch AS B JOIN Organization.Branch_Department AS DB
	ON B.Id=DB.Branch_Id 
	JOIN Organization.Department AS D
	ON DB.Department_Id=D.Id

SELECT * FROM Organization.V_Branch_Department

--VIEW TO SHOW ALL DATA ABOUT TRACKS ON EACH DEPARTMENTS IN EACH BRANSH
CREATE OR ALTER VIEW Organization.V_Branch_Department_Track
(B_Id,B_Name,B_Location,D_Id,D_Name,D_Desc,T_Id,T_Name,T_Desc)
WITH ENCRYPTION
AS
	SELECT vbd.*,t.*
	FROM Organization.Track AS T 
	JOIN Organization.Branch_Department_Track AS BDT
	ON T.Id=BDT.Track_Id
	JOIN Organization.Branch_Department AS BD
	ON BDT.Branch_Department_Id=BD.Id
	JOIN Organization.V_Branch_Department AS VBD
	ON VBD.B_Id=BD.Branch_Id and VBD.D_Id=BD.Department_Id

SELECT * FROM Organization.V_Branch_Department_Track


--VIEW TO SHOW ALL DATA ABOUTIN TAKES ON EACH TRACKS IN EACH DEPARTMENTS IN EACH BRANSH
CREATE OR ALTER VIEW Organization.V_Branch_Department_Track_Intake
(B_Id,B_Name,B_Location,D_Id,D_Name,D_Desc,T_Id,T_Name,T_Desc,I_Id,I_Number,I_Year,I_Round)
WITH ENCRYPTION
AS
	SELECT VBDT.*,I.* 
	FROM Organization.Intake AS I
	JOIN Organization.Branch_Department_Track_Intake AS BDTI
	ON I.Id=BDTI.Intake_Id
	JOIN Organization.Branch_Department_Track AS BDT
	ON BDT.Id=BDTI.Branch_Department_Track
	JOIN Organization.V_Branch_Department_Track AS VBDT
	ON VBDT.T_Id=BDT.Track_Id
	JOIN Organization.Branch_Department AS BD
	ON VBDT.B_Id=BD.Branch_Id AND VBDT.D_Id=BD.Department_Id

SELECT * FROM Organization.V_Branch_Department_Track_Intake

CREATE VIEW Organization.V_Branche_Department_Track_Intake_Students 
WITH ENCRYPTION
AS
	