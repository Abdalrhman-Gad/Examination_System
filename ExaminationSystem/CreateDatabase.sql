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
