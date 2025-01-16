use [ExaminationSystemDB]
go


CREATE PROCEDURE Person.InsertInstructor
    @SSN CHAR(14),
    @Name VARCHAR(50),
    @Salary INT,
    @Gender CHAR(1),
    @BirthDate DATE,
    @Phone CHAR(11),
    @Address VARCHAR(20),
    @BranchId INT = NULL,
    @IsManager BIT = 0
AS
BEGIN
    -- Validate SSN length
    IF LEN(@SSN) <> 14
    BEGIN
        PRINT 'Error: SSN must be 14 digits long.';
        RETURN;
    END;

    -- Validate SSN numeric structure
    IF @SSN LIKE '%[^0-9]%'
    BEGIN
        PRINT 'Error: SSN must contain only numeric characters.';
        RETURN;
    END;

    -- Validate century and birth date from SSN
    DECLARE @Century INT = CAST(SUBSTRING(@SSN, 1, 1) AS INT);
    DECLARE @Year INT = CAST(SUBSTRING(@SSN, 2, 2) AS INT);
    DECLARE @Month INT = CAST(SUBSTRING(@SSN, 4, 2) AS INT);
    DECLARE @Day INT = CAST(SUBSTRING(@SSN, 6, 2) AS INT);
    DECLARE @FullYear INT;

    IF @Century = 2
        SET @FullYear = 1900 + @Year;
    ELSE IF @Century = 3
        SET @FullYear = 2000 + @Year;
    ELSE
    BEGIN
        PRINT 'Error: Invalid century in SSN.';
        RETURN;
    END;

    -- Validate month and day
    IF @Month < 1 OR @Month > 12
    BEGIN
        PRINT 'Error: Invalid month in SSN.';
        RETURN;
    END;

    IF @Day < 1 OR @Day > 31 OR TRY_CAST(CONCAT(@FullYear, '-', @Month, '-', @Day) AS DATE) IS NULL
    BEGIN
        PRINT 'Error: Invalid day in SSN.';
        RETURN;
    END;

    -- Validate BirthDate matches SSN
    IF @BirthDate <> CONCAT(@FullYear, '-', RIGHT('0' + CAST(@Month AS VARCHAR), 2), '-', RIGHT('0' + CAST(@Day AS VARCHAR), 2))
    BEGIN
        PRINT 'Error: BirthDate does not match SSN.';
        RETURN;
    END;

    -- Validate governorate code
    DECLARE @GovernorateCode INT = CAST(SUBSTRING(@SSN, 8, 1) AS INT);
    IF @GovernorateCode < 1 OR @GovernorateCode > 29
    BEGIN
        PRINT 'Error: Invalid governorate code in SSN.';
        RETURN;
    END;

    -- Validate Gender
    IF UPPER(@Gender) NOT IN ('M', 'F')
    BEGIN
        PRINT 'Error: Gender must be either "M" or "F".';
        RETURN;
    END;

    -- Validate Salary
    IF @Salary <= 0
    BEGIN
        PRINT 'Error: Salary must be a positive value.';
        RETURN;
    END;

    -- Validate Phone length
    IF LEN(@Phone) <> 11
    BEGIN
        PRINT 'Error: Phone number must be 11 digits long.';
        RETURN;
    END;

    -- Check if BranchId exists in Organization.Branch table
    IF @BranchId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Organization.Branch WHERE Id = @BranchId)
    BEGIN
        PRINT 'Error: BranchId does not exist in the Organization.Branch table.';
        RETURN;
    END;

    -- Insert the record if all validations pass
    BEGIN TRY
        INSERT INTO Person.Instructor
        (SSN, Name, Salary, Gender, BirthDate, Phone, [Address], BranchId, IsManager)
        VALUES
        (@SSN, @Name, @Salary, @Gender, @BirthDate, @Phone, @Address, @BranchId, @IsManager);

        PRINT 'Instructor record inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error: Unable to insert instructor record.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;


GO


CREATE PROCEDURE CalculateStudentAnswersResults 
    @Student_Answer_Id INT,
    @Result FLOAT OUTPUT -- Use OUTPUT to return non-integer values
AS
BEGIN
    -- Check if Student_Answer_Id exists
    IF NOT EXISTS (SELECT 1 FROM [Answer].[Student_Answer] WHERE Id = @Student_Answer_Id)
    BEGIN
        PRINT 'Error: This ID does not exist in Student_Answer';
        RETURN;
    END

    -- Get Question ID and type
    DECLARE @Questions_Id INT = (
        SELECT [Question_Id]
        FROM [Exam].[Exam_Questions]
        WHERE [Id] = (SELECT [Exam_Question_Id] FROM [Answer].[Student_Answer] WHERE Id = @Student_Answer_Id)
    );

    DECLARE @Questions_Type NVARCHAR(50) = (
        SELECT [Type] 
        FROM [Exam].[Questions]
        WHERE [Id] = @Questions_Id
    );

    DECLARE @Questions_Degree FLOAT = (
        SELECT [Degree]
        FROM [Exam].[Exam_Questions]
        WHERE [Id] = @Questions_Id
    );

    -- Handle different question types
    IF (@Questions_Type = 'TEXT')
    BEGIN
        -- Calculate degree for TEXT questions
        DECLARE @DegreeMatch FLOAT = dbo.GetMatchingValue(
            (SELECT [Question_Text] FROM [Exam].[Questions] WHERE [Id] = @Questions_Id),
            (SELECT [Answer_Text] FROM [Exam].[Text_Answers] WHERE [Question_Id] = @Questions_Id),
            (SELECT [Student_Answer_Text] FROM [Answer].[Text_Answer] WHERE [Answer_Id] = @Student_Answer_Id)
        );

        SET @Result = CEILING((@DegreeMatch * @Questions_Degree) / 100.0);
    END
    ELSE IF (@Questions_Type = 'TRUE OR FALSE')
    BEGIN
        -- Calculate degree for TRUE/FALSE questions
        IF (
            (SELECT [Answer_Flag] 
             FROM [Answer].[True_False_Answer]
             WHERE [Answer_Id] = @Student_Answer_Id) = 
            (SELECT [Is_True] 
             FROM [Exam].[True_False] 
             WHERE [Question_Id] = @Questions_Id)
        )
        BEGIN
            SET @Result = @Questions_Degree;
        END
        ELSE
        BEGIN
            SET @Result = 0;
        END
    END
    ELSE
    BEGIN
        -- Calculate degree for MCQ questions
        DECLARE @numOfChoices INT = (SELECT COUNT(*) FROM [Exam].[Choices] WHERE [Question_Id] = @Questions_Id);
        DECLARE @numOfTrueChoices INT = (SELECT COUNT(*) FROM [Exam].[Choices] WHERE [Question_Id] = @Questions_Id AND [Is_True] = 1);
        DECLARE @numOfAnswerChoices INT = (SELECT COUNT(*) FROM [Answer].[Mcq_Answer] WHERE [Answer_Id] = @Student_Answer_Id);
        DECLARE @numOfAnswerTrueChoices INT = (
            SELECT COUNT(*) 
            FROM [Answer].[Mcq_Answer] M
            JOIN [Exam].[Choices] C ON C.Id = M.Choice_Id
            WHERE C.[Is_True] = 1 AND M.[Answer_Id] = @Student_Answer_Id
        );

        -- Calculate Answer Degree
        DECLARE @Answer_Degree FLOAT;
        SET @Answer_Degree = 
            CASE
                WHEN @numOfAnswerChoices = 0 THEN 0
                ELSE 
                    (
                        @numOfAnswerTrueChoices * (@Questions_Degree / @numOfTrueChoices) -- Points for correct answers
                    ) - (
                        (@numOfAnswerChoices - @numOfAnswerTrueChoices) * (@Questions_Degree / @numOfChoices) -- Penalty for incorrect answers
                    )
            END;

        SET @Result = @Answer_Degree;
    END
END;

GO

------------------ Try Test (Fill Exam Questions)--------
CREATE PROCEDURE FillExamQuestions
    @ExamID INT
AS
BEGIN
	-- Check Exam Number
    SELECT Q.Question_Text, Q.Type
    FROM 
       Exam.Exam_Questions EQ INNER JOIN Exam.Questions Q
	   ON EQ.Question_Id = Q.Id
	   WHERE EQ.Exam_Id = @ExamID;
END;