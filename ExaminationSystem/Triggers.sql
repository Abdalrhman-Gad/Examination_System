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

	ELSE
    BEGIN
        UPDATE e
        SET e.Total_Exam_Degree = e.Total_Exam_Degree + (ISNULL(i.Degree,0) - ISNULL(d.Degree,0))
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

<<<<<<< HEAD
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
<<<<<<< HEAD
=======


--------------update result--------
SELECT * FROM Answer.Student_Answer
DROP TRIGGER dbo.T_Update_Result

CREATE OR ALTER TRIGGER [Answer].T_Update_Result
on [Answer].[Student_Answer] 
AFTER INSERT ,UPDATE ,DELETE
AS
BEGIN
  DECLARE  @Student_SSN CHAR(14) ;
  DECLARE  @Answer_Degree INT ;
  DECLARE  @Exam_Question_Id INT ;

  SELECT @Student_SSN=Student_SSN, @Answer_Degree=Answer_Degree ,@Exam_Question_Id=Exam_Question_Id FROM inserted
   IF (UPDATE(Answer_Degree))
    BEGIN
        UPDATE ST
        SET ST.Result = ST.Result - d.Answer_Degree
        FROM [Exam].[Student_Exams] ST
        JOIN deleted d ON ST.Id = d.Exam_Question_Id;

        UPDATE ST
       SET ST.Result = ST.Result + i.Answer_Degree
        FROM [Exam].[Student_Exams] ST
        JOIN inserted i ON ST.Id = i.Exam_Question_Id;
	END
 ELSE
  BEGIN
  UPDATE ST
        SET St.Result = ST.Result + (ISNULL(i.Answer_Degree,0) - ISNULL(d.Answer_Degree,0))
        FROM [Exam].[Student_Exams]  ST
        JOIN inserted i ON ST.Id= i.Exam_Question_Id
        JOIN deleted d ON ST.Id = d.Exam_Question_Id AND i.Id= d.Id; 
  END
END;
---------------------
--TRIGGER TO INSERT STUDENT ANSWER IN EXAM DATE AND TIME
CREATE OR ALTER TRIGGER Check_Student_Answer_Time
ON [Answer].[Student_Answer]
AFTER INSERT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (
            SELECT 1
            FROM INSERTED i
            JOIN [Exam].[Exam_Questions] eq ON i.Exam_Question_Id = eq.Id
            JOIN [Exam].[Exams] e ON eq.Exam_Id = e.Id
            WHERE GETDATE() NOT BETWEEN e.Start_Time AND e.End_Time
        )
        BEGIN
            ROLLBACK;  -- Rollback first
            THROW 52000, 'Cannot insert answer, exam time has ended.', 1;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
