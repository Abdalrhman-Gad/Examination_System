USE [ExaminationSystemDB]

GO


CREATE SCHEMA Answer;
GO

CREATE TABLE Answer.Student_Answer (
    Id INT,
    Student_SSN CHAR(14) NOT NULL,
    Exam_Question_Id INT NOT NULL,
    Answer_Degree INT,
    CONSTRAINT PK_Student_Answer_Id PRIMARY KEY (Id),
    CONSTRAINT FK_Student_Answer_Student_Id FOREIGN KEY (Student_SSN) REFERENCES Person.Student(Ssn),
    CONSTRAINT FK_Student_Answer_Exam_Question_Id FOREIGN KEY (Exam_Question_Id) REFERENCES Exam.Exam_Questions(Id)
)ON ExaminationSystemDB_FG4;
GO

CREATE TABLE Answer.Text_Answer (
    Answer_Id INT,
    Student_Answer_Text NVARCHAR(255),
    CONSTRAINT FK_Text_Answer_Answer_Id FOREIGN KEY (Answer_Id) REFERENCES Answer.Student_Answer(Id)
)ON ExaminationSystemDB_FG4;
GO

CREATE TABLE Answer.True_False_Answer (
    Answer_Id INT,
    Answer_Flag BIT NOT NULL,
    CONSTRAINT FK_True_False_Answer_Answer_Id FOREIGN KEY (Answer_Id) REFERENCES Answer.Student_Answer(Id)
)ON ExaminationSystemDB_FG4;
GO

CREATE TABLE Answer.Mcq_Answer (
    Answer_Id INT,
    Choice_Id INT,
    CONSTRAINT FK_Mcq_Answer_Answer_Id FOREIGN KEY (Answer_Id) REFERENCES Answer.Student_Answer(Id),
    CONSTRAINT FK_Mcq_Answer_Choice_Id FOREIGN KEY (Choice_Id) REFERENCES [Exam].[Choices](Id)
)ON ExaminationSystemDB_FG4;
GO