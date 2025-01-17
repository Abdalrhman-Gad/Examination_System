USE [ExaminationSystemDB]

GO

CREATE SCHEMA Exam

CREATE TABLE Exam.Exams (
	[Id] INT IDENTITY(1,1),
	[Start_Time] DATETIME NOT NULL,
	[End_Time] DATETIME NOT NULL,
	[Total_Time] AS DATEDIFF(MINUTE, [Start_Time], [End_Time]) PERSISTED,
	[Allowances] NVARCHAR(150),
	[Branch_Department_Track_Intake_Course_Instructor_Id] INT NOT NULL,
	Total_Exam_Degree INT NOT NULL CONSTRAINT DF_Exam_Total_Exam_Degree DEFAULT 0 ,
	CONSTRAINT PK_Exams_Id PRIMARY KEY ([Id]),

	CONSTRAINT FK_Exams_Branch_Department_Track_Intake_Course_Instructor_Id 
	FOREIGN KEY ([Branch_Department_Track_Intake_Course_Instructor_Id]) 
	REFERENCES Organization.Branch_Department_Track_Intake_Instructor_Course(Id)
)

GO

CREATE TABLE Exam.Questions (
	[Id] INT IDENTITY(1,1),
	[Question_Text] VARCHAR(150) NOT NULL,
	[Created_At] DATE CONSTRAINT DF_Questions_Created_At DEFAULT GETDATE(),
	[Type] CHAR(13) NOT NULL,
	[Instructor_Course_Id] INT NOT NULL,
	CONSTRAINT PK_Questions_Id PRIMARY KEY ([Id]),
	CONSTRAINT CK_Questions_Type CHECK(UPPER([Type]) IN ('TEXT', 'CHOOSE', 'TRUE OR FALSE')),
	CONSTRAINT FK_Questions_Instructor_Course_Id 
	FOREIGN KEY ([Instructor_Course_Id]) 
	REFERENCES Organization.Instructor_Course(Id)
) ON ExaminationSystemDB_FG3

GO

CREATE TABLE Exam.Exam_Questions (
	[Id] INT IDENTITY(1,1),
	[Exam_Id] INT NOT NULL,
	[Question_Id] INT NOT NULL,
	[Degree] INT NOT NULL,
	CONSTRAINT PK_Exam_Questions_Id PRIMARY KEY ([Id]),
	CONSTRAINT FK_Exam_Questions_Exam_Id FOREIGN KEY ([Exam_Id]) REFERENCES Exam.Exams([Id]),
	CONSTRAINT FK_Exam_Questions_Question_Id FOREIGN KEY ([Question_Id]) REFERENCES Exam.Questions([Id]),
	CONSTRAINT UQ_Exam_Questions_ExamId_QuestionId UNIQUE ([Exam_Id], [Question_Id]),
	CONSTRAINT CK_Exam_Questions_Degree CHECK ([Degree] > 0)
) ON ExaminationSystemDB_FG3;

GO

CREATE TABLE Exam.Student_Exams (
	[Id] INT IDENTITY(1,1),
	[Student_SSN] CHAR(14) NOT NULL,
	[Exam_Id] INT NOT NULL,
	[Result] FLOAT NOT NULL,
	[Type] CHAR(1) NOT NULL,
	CONSTRAINT PK_Student_Exams_Id PRIMARY KEY ([Id]),
	CONSTRAINT FK_Student_Exams_Student_SSN FOREIGN KEY ([Student_SSN]) REFERENCES Person.Student([SSN]),
	CONSTRAINT FK_Student_Exams_Exam_Id FOREIGN KEY ([Exam_Id]) REFERENCES Exam.Exams([Id]),
	CONSTRAINT UQ_Student_Exams_ExamId_StudentSSN UNIQUE ([Exam_Id], [Student_SSN]),
	CONSTRAINT CK_Student_Exams_Type CHECK (UPPER([Type]) IN ('C', 'E')),
	CONSTRAINT CK_Student_Exams_Result CHECK ([Result] >= 0)
) ON ExaminationSystemDB_FG3;

GO

CREATE TABLE Exam.Choices (
    [Id] INT IDENTITY(1,1),
    [Question_Id] INT NOT NULL, 
	[Choice_Text] NVARCHAR(255) NOT NULL,
    [Is_True] BIT NOT NULL,  
	CONSTRAINT PK_Choices_Id PRIMARY KEY ([Id]),
    CONSTRAINT PK_Choices_QuestionId_Text UNIQUE ([Question_Id], [Choice_Text]),
	CONSTRAINT FK_Choices_Question_Id FOREIGN KEY ([Question_Id]) REFERENCES Exam.Questions([Id]) ON DELETE CASCADE ON UPDATE CASCADE
) ON ExaminationSystemDB_FG3;

GO

CREATE TABLE Exam.True_False (
    [Question_Id] INT NOT NULL UNIQUE, 
    [Is_True] BIT NOT NULL, 
    CONSTRAINT FK_True_False_Question_Id FOREIGN KEY ([Question_Id]) REFERENCES Exam.Questions([Id]) ON DELETE CASCADE ON UPDATE CASCADE
) ON ExaminationSystemDB_FG3;

GO

CREATE TABLE Exam.Text_Answers (
   [Question_Id] INT NOT NULL UNIQUE,
    [Answer_Text] NVARCHAR(255) NOT NULL,
    CONSTRAINT FK_Text_Answers_Question_Id FOREIGN KEY ([Question_Id]) REFERENCES Exam.Questions([Id]) ON DELETE CASCADE ON UPDATE CASCADE
) ON ExaminationSystemDB_FG3;

GO