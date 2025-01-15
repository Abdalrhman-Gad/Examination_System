USE [ExaminationSystemDB]
GO

-- Create schema
CREATE SCHEMA Person
GO


-- INSTRUCTOR TABLE
CREATE TABLE Person.Instructor 
(
    SSN CHAR(14),
    Name VARCHAR(50) NOT NULL,
    Salary INT NOT NULL,
    Gender CHAR(1) NOT NULL DEFAULT 'M',
    BirthDate DATE NOT NULL,
    Age AS DATEDIFF(YEAR, BirthDate, GETDATE()),
    Phone CHAR(11) NOT NULL,
    [Address] VARCHAR(20) NOT NULL,
    AccountId INT,
    BranchId INT,
    IsManager BIT CONSTRAINT DF_Instructor_IsManager DEFAULT 0 NOT NULL,
    CONSTRAINT PK_Instructor_SSN PRIMARY KEY (SSN),
    CONSTRAINT CK_Instructor_SSN CHECK (LEN(SSN) = 14),
    CONSTRAINT CK_Instructor_Gender CHECK(UPPER(Gender) IN ('M', 'F')),
    CONSTRAINT FK_Instructor_BranchId FOREIGN KEY (BranchId) REFERENCES Organization.Branch(Id) ON UPDATE CASCADE ON DELETE SET NULL
) ON ExaminationSystemDB_FG2;
GO

-- Create rule for phone validation
CREATE RULE Phone_Rule 
AS @Phone LIKE '01[0125][0-9]%%%%%%%%';
GO

-- Bind rule to phone column in Instructor
SP_BINDRULE Phone_Rule, 'Person.Instructor.Phone';
GO

-- STUDENT TABLE
CREATE TABLE Person.Student 
(
    SSN CHAR(14),
    FullName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL DEFAULT 'M',
    BirthDate DATE NOT NULL,
    Phone CHAR(11) NOT NULL,
    Age AS DATEDIFF(YEAR, BirthDate, GETDATE()),
    [Address] VARCHAR(20) NOT NULL,
    AccountId INT,
    CONSTRAINT PK_Student_SSN PRIMARY KEY (SSN),
    CONSTRAINT CK_Student_SSN CHECK (LEN(SSN) = 14),
    CONSTRAINT CK_Student_Gender CHECK(UPPER(Gender) IN ('M', 'F')),
) ON ExaminationSystemDB_FG2;
GO

-- Bind rule to phone column in Student
SP_BINDRULE Phone_Rule, 'Person.Student.Phone';
GO
