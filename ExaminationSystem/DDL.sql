USE[ExaminationSystemDB]

GO

CREATE SCHEMA Organization

--BRANCH TABLE
CREATE TABLE Organization.Branch
(
    Id INT IDENTITY,
    [Name] NVARCHAR(50) NOT NULL,
    [Location] NVARCHAR(20) NOT NULL,
    CONSTRAINT PK_BRANCH_ID PRIMARY KEY (ID),
    CONSTRAINT UQ_BRANCH_NAME UNIQUE (NAME),
) ON ExaminationSystemDB_FG1;


--DEPARTMENT TABLE
CREATE TABLE Organization.Department
(
	Id INT IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_DEPARTMENT_ID PRIMARY KEY(ID),
	CONSTRAINT UQ_DEPARTMENT_NAME UNIQUE (NAME),
)ON ExaminationSystemDB_FG1;

--TRACK TABLE
CREATE TABLE Organization.Track
(
	Id INT IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_TRACK_ID PRIMARY KEY(ID),
	CONSTRAINT UQ_TRACK_NAME UNIQUE (NAME),
)ON ExaminationSystemDB_FG1;

--INTAKE TABLE
CREATE TABLE Organization.Intake
(
	Id INT IDENTITY,
	Number NVARCHAR(50) NOT NULL,
	[Year] INT DEFAULT(YEAR(GETDATE())),
	[Round] int NOT NULL,

	CONSTRAINT PK_INTAKE_ID PRIMARY KEY(ID),
	CONSTRAINT UQ_INTAKE_NUMBER UNIQUE (Number),
)ON ExaminationSystemDB_FG1;

--COURSE TABLE
CREATE TABLE Organization.Course
(
	Code CHAR(5),
	[Name] NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(100) NOT NULL,
	Min_Degree INT NOT NULL,
	Max_Degree INT NOT NULL,
	CONSTRAINT PK_COURSE_CODE PRIMARY KEY(Code),
	CONSTRAINT UQ_COURSE_NAME UNIQUE (Name),
)ON ExaminationSystemDB_FG1;

--Branch Department TABLE
CREATE TABLE Organization.Branch_Department
(
	Id int IDENTITY,
	Branch_Id int NOT NULL,
	Department_Id int NOT NULL,
	CONSTRAINT PK_Branch_Department_ID PRIMARY KEY(Id),
	CONSTRAINT FK_Branch_Department_Branch_Id FOREIGN KEY(Branch_Id) REFERENCES Organization.Branch(Id),
	CONSTRAINT FK_Branch_Department_Department_Id FOREIGN KEY(Department_Id) REFERENCES Organization.Department(Id),
	CONSTRAINT UQ_Branch_Branch_Id_Department_ID UNIQUE(Branch_Id,Department_Id),
)ON ExaminationSystemDB_FG1;

--Branch Department TRACK TABLE
CREATE TABLE Organization.Branch_Department_Track
(
	Id int IDENTITY,
	Branch_Department_Id int NOT NULL,
	Track_Id int NOT NULL,
	CONSTRAINT PK_Branch_Department_Track_ID PRIMARY KEY(Id),

	CONSTRAINT FK_Branch_Department_Track_Branch_Department_Id FOREIGN KEY(Branch_Department_Id) 
	REFERENCES Organization.Branch_Department(Id),

	CONSTRAINT FK_Branch_Department_Track_Track_Id FOREIGN KEY(Track_Id)
	REFERENCES Organization.Track(Id),

	CONSTRAINT UQ_Branch_Department_Track_Branch_Department_Id_Track_Id
	UNIQUE(Branch_Department_Id,Track_Id),
)ON ExaminationSystemDB_FG1;

--Branch Department TRACK INTAKE TABLE 
CREATE TABLE Organization.Branch_Department_Track_Intake
(
	Id int IDENTITY,
	Branch_Department_Track_Id int NOT NULL,
	Intake_Id int NOT NULL,
	CONSTRAINT PK_Branch_Department_Track_Intake_ID PRIMARY KEY(Id),

	CONSTRAINT FK_Branch_Department_Track_Intake_Branch_Department_Track
	FOREIGN KEY(Branch_Department_Track_Id) 
	REFERENCES Organization.Branch_Department_Track(Id),

	CONSTRAINT FK_Branch_Department_Track_Intake_Intake_Id
	FOREIGN KEY(Intake_Id)
	REFERENCES Organization.Intake(Id),

	CONSTRAINT UQ_Branch_Department_Track_Intake_Branch_Department_Track_Intake_Id
	UNIQUE(Branch_Department_Track_Id,Intake_Id),
)ON ExaminationSystemDB_FG1;

--Branch Department TRACK INTAKE STUDENT TABLE 
CREATE TABLE Organization.Branch_Department_Track_Intake_Student
(
	Id int IDENTITY,
	Branch_Department_Track_Intake_Id int NOT NULL,
	Student_SSN CHAR(14) NOT NULL,
	CONSTRAINT PK_Branch_Department_Track_Intake_Student_ID PRIMARY KEY(Id),

	CONSTRAINT FK_Branch_Department_Track_Intake_Student_Branch_Department_Track_Intake_Id
	FOREIGN KEY(Branch_Department_Track_Intake_Id) 
	REFERENCES Organization.Branch_Department_Track_Intake(Id),

	CONSTRAINT FK_Branch_Department_Track_Intake_Student_Student_SSN
	FOREIGN KEY(Student_SSN)
	--STUDENT TABLE
	REFERENCES Parson.Student(SSN),

	CONSTRAINT UQ_Branch_Department_Track_Intake_Student_Branch_Department_Track_Intake_Id_Student_SSN
	UNIQUE(Branch_Department_Track_Intake_Id,Student_SSN),
)ON ExaminationSystemDB_FG1;

CREATE SYNONYM BDTIS FOR Organization.Branch_Department_Track_Intake_Student 
CREATE SYNONYM BDTI FOR Organization.Branch_Department_Track_Intake
CREATE SYNONYM BDT FOR Organization.Branch_Department_Track
CREATE SYNONYM BD FOR Organization.Branch_Department


