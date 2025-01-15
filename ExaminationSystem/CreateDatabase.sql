-- Create the database ExaminationSystemDB
USE [MASTER]
GO

CREATE DATABASE ExaminationSystemDB 
ON 
PRIMARY (
    NAME = ExaminationSystemDB_Primary,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ExaminationSystemDB_Primary.mdf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
),
FILEGROUP ExaminationSystemDB_FG1 (
    NAME = ExamSystem_Data1,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ExamSystem_Data1.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
),
FILEGROUP ExaminationSystemDB_FG2 (
    NAME = ExamSystem_Data2,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ExamSystem_Data2.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
),
FILEGROUP ExaminationSystemDB_FG3 (
    NAME = ExamSystem_Data3,
    FILENAME = 'F:\iti\sql\project\DB_Files\ExamSystem_Data3.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
),
FILEGROUP ExaminationSystemDB_FG4 (
    NAME = ExamSystem_Data4,
    FILENAME = 'F:\iti\sql\project\DB_Files\ExamSystem_Data4.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
)
LOG ON (
    NAME = ExaminationSystemDB_Log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ExaminationSystemDB_Log.ldf',
    SIZE = 20MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 10MB
);















--if we use online database
-- Add Filegroup ExamSystem_FG1 and its files
ALTER DATABASE examinationsystem_SampleDB
ADD FILEGROUP ExamSystem_FG1;

ALTER DATABASE examinationsystem_SampleDB
ADD FILE (
    NAME = ExamSystem_Data1,
    FILENAME = 'D:\sql-freeasphost-user-dbs\ExamSystem_Data1.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
) TO FILEGROUP ExamSystem_FG1;

ALTER DATABASE examinationsystem_SampleDB
ADD FILE (
    NAME = ExamSystem_Data2,
    FILENAME = 'D:\sql-freeasphost-user-dbs\ExamSystem_Data2.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
) TO FILEGROUP ExamSystem_FG1;

-- Add Filegroup ExamSystem_FG2 and its files
ALTER DATABASE examinationsystem_SampleDB
ADD FILEGROUP ExamSystem_FG2;

ALTER DATABASE examinationsystem_SampleDB
ADD FILE (
    NAME = ExamSystem_Data3,
    FILENAME = 'D:\sql-freeasphost-user-dbs\ExamSystem_Data3.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
) TO FILEGROUP ExamSystem_FG2;

ALTER DATABASE examinationsystem_SampleDB
ADD FILE (
    NAME = ExamSystem_Data4,
    FILENAME = 'D:\sql-freeasphost-user-dbs\ExamSystem_Data4.ndf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
) TO FILEGROUP ExamSystem_FG2;
