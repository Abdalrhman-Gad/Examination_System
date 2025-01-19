use [ExaminationSystemDB]
GO

ALTER DATABASE [ExaminationSystemDB] SET TRUSTWORTHY ON;
GO

EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;
GO
CREATE ASSEMBLY ClassLibrary2
FROM 'F:\iti\sql\project\clr\ClassLibrary2\bin\Debug\ClassLibrary2.dll'
WITH PERMISSION_SET = UNSAFE;
GO



CREATE FUNCTION GetMatchingValue(@Questions NVARCHAR(150), @Answers NVARCHAR(255), @StudentAnswers NVARCHAR(255))
RETURNS int
EXTERNAL NAME ClassLibrary2.SimilarityService.GetMatchingValue;
GO


select dbo.GetMatchingValue('What is SQL?', 'It is Structured Query Language.', 'The SQL is Structured Query Language.')
