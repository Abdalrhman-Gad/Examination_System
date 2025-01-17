USE[ExaminationSystemDB]

GO

CREATE OR ALTER TRIGGER [Exam].TRG_Update_Exam_Degree
ON [Exam].[Exam_Questions]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF (UPDATE([Exam_Id]))
    BEGIN
        UPDATE e
        SET e.Total_Exam_Degree = e.Total_Exam_Degree - d.Degree
        FROM [Exam].[Exams] e
        JOIN deleted d ON e.Id = d.Exam_Id;

        UPDATE e
        SET e.Total_Exam_Degree = e.Total_Exam_Degree + i.Degree
        FROM [Exam].[Exams] e
        JOIN inserted i ON e.Id = i.Exam_Id;
    END

    ELSE IF (UPDATE([Degree]))
    BEGIN
        UPDATE e
        SET e.Total_Exam_Degree = e.Total_Exam_Degree + (i.Degree - d.Degree)
        FROM [Exam].[Exams] e
        JOIN inserted i ON e.Id = i.Exam_Id
        JOIN deleted d ON i.Exam_Id = d.Exam_Id AND i.Id= d.Id; 
    END
END


----trigger to prevent add Question of Type not Trueand false

CREATE  or alter TRIGGER Exam.T_Insert_Q_T_F
ON [Exam].[True_False]
AFTER  INSERT 
AS
BEGIN
BEGIN TRY
 declare @Question_id int =(SELECT Question_Id FROM inserted);
 IF(NOT EXISTS(SELECT 1 FROM Exam.Questions Q where Type='TRUE OR FALSE' and Q.Id=@Question_id))
            THROW 52000, 'Invalid QUESTION TYPE.', 1;
END TRY
BEGIN CATCH
		print 'Invalid QUESTION TYPE.';
		ROLLBACK;
END CATCH
END


select * from Exam.Questions

insert into Exam.True_False(Question_Id,Is_True) values(2,0)

SELECT * FROM Exam.True_False
 

----trigger to prevent add Question of Type not cCHOOSE
CREATE  or alter TRIGGER Exam.T_Insert_Q_CHOOSE
ON [Exam].Choices
AFTER  INSERT  
AS
BEGIN
BEGIN TRY
 declare @Question_id int =(SELECT Question_Id FROM inserted);
 IF(NOT EXISTS(SELECT 1 FROM Exam.Questions Q where Type='CHOOSE' and Q.Id=@Question_id))
            THROW 52000, 'Invalid QUESTION TYPE.', 1;
END TRY
BEGIN CATCH
		print 'Invalid QUESTION TYPE.';
		ROLLBACK;
END CATCH
END;

----trigger to prevent add Question of Type not TEXT

CREATE  or alter TRIGGER Exam.T_Insert_Q_TEXT         
ON [Exam].[Text_Answers]
AFTER  INSERT 
AS
BEGIN
BEGIN TRY
 declare @Question_id int =(SELECT Question_Id FROM inserted);
 IF(NOT EXISTS(SELECT 1 FROM Exam.Questions Q where Type='TEXT' and Q.Id=@Question_id))
            THROW 52000, 'Invalid QUESTION TYPE.', 1;
END TRY
BEGIN CATCH
		print 'Invalid QUESTION TYPE.';
		ROLLBACK;
END CATCH
END
----dddddddddd-

CREATE OR ALTER TRIGGER [Answer].Clac_Student_Answer_Degree_TEXT
ON[Answer].[Text_Answer]
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN 
	
	IF exists(select * from deleted)
	BEGIN
		 UPDATE [Answer].[Student_Answer]
		SET [Answer_Degree] = 0
		WHERE [Id] = (SELECT [Answer_Id] FROM deleted);
	END
	
	DECLARE @Answer_Id INT = (SELECT [Answer_Id] FROM inserted);
	
	DECLARE @Degree FLOAT;
	EXEC dbo.CalculateStudentAnswersResults @Student_Answer_Id = @Answer_Id,@Result =@Degree OUTPUT ;
	UPDATE [Answer].[Student_Answer]
	SET [Answer_Degree] = @Degree
	WHERE [Id] = @Answer_Id;
END


CREATE OR ALTER TRIGGER [Answer].Clac_Student_Answer_Degree_MCQ
ON[Answer].[Mcq_Answer]
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN 
	
	IF exists(select * from deleted)
	BEGIN
		 UPDATE [Answer].[Student_Answer]
		SET [Answer_Degree] = 0
		WHERE [Id] = (SELECT [Answer_Id] FROM deleted);
	END
	
	DECLARE @Answer_Id INT = (SELECT [Answer_Id] FROM inserted);
	
	DECLARE @Degree FLOAT;
	EXEC dbo.CalculateStudentAnswersResults @Student_Answer_Id = @Answer_Id,@Result =@Degree OUTPUT ;
	UPDATE [Answer].[Student_Answer]
	SET [Answer_Degree] = @Degree
	WHERE [Id] = @Answer_Id;
END


CREATE OR ALTER TRIGGER [Answer].Clac_Student_Answer_Degree_True_False
ON[Answer].[True_False_Answer]
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN 
	
	IF exists(select * from deleted)
	BEGIN
		 UPDATE [Answer].[Student_Answer]
		SET [Answer_Degree] = 0
		WHERE [Id] = (SELECT [Answer_Id] FROM deleted);
	END
	
	DECLARE @Answer_Id INT = (SELECT [Answer_Id] FROM inserted);
	
	DECLARE @Degree FLOAT;
	EXEC dbo.CalculateStudentAnswersResults @Student_Answer_Id = @Answer_Id,@Result =@Degree OUTPUT ;
	UPDATE [Answer].[Student_Answer]
	SET [Answer_Degree] = @Degree
	WHERE [Id] = @Answer_Id;
END
