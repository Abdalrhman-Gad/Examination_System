
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

