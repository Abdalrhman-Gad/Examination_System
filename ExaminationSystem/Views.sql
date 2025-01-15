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
CREATE VIEW V_Branch_Department_Track
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
	
