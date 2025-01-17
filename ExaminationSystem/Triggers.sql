
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



--------------update result--------

SELECT * FROM Answer.Student_Answer

CREATE OR ALTER TRIGGER T_Update_Result
on [Answer].[Student_Answer] 
AFTER INSERT ,UPDATE 
AS
BEGIN
  DECLARE  @Student_SSN CHAR(14) ;
  DECLARE  @Answer_Degree INT ;
  DECLARE  @Exam_Question_Id INT ;

  (SELECT @Student_SSN=Student_SSN, @Answer_Degree=Answer_Degree ,@Exam_Question_Id=Exam_Question_Id FROM inserted)
  UPDATE [Exam].[Student_Exams] 
  SET Result+=@Answer_Degree
  where  Exam_Id=@Exam_Question_Id and Student_SSN=@Student_SSN
END;

---dd--
select * from [Answer].[Student_Answer]
select * from [Exam].[Student_Exams]