--PROCEDURE TO INSERT BRANCH
CREATE PROC [Organization].[Insert_Branch]
	@Name NVARCHAR(50),
	@Location NVARCHAR(20)
	AS
	BEGIN
		BEGIN TRY
			INSERT INTO [Organization].[Branch](Name,Location)
			VALUES(@Name,@Location)
		END TRY
		BEGIN CATCH
			PRINT 'Error while in inserting branch';
		END CATCH
	END

--PROCEDURE TO UPDATE BRANCH
CREATE PROC [Organization].[Update_Branch]
    @BranchId INT,        
    @Name NVARCHAR(50),
    @Location NVARCHAR(20)
AS
BEGIN
    BEGIN TRY
        UPDATE [Organization].[Branch]
        SET Name = @Name,
            Location = @Location
        WHERE Id = @BranchId  
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END

--PROCEDURE TO INSERT DEPARTMENT
CREATE PROC [Organization].[Insert_Department]
	@Name NVARCHAR(50),
	@Description NVARCHAR(100)
	AS
	BEGIN
		BEGIN TRY
			INSERT INTO [Organization].Department(Name,Description)
			VALUES(@Name,@Description)
		END TRY
		BEGIN CATCH
			PRINT 'Error while in inserting department';
		END CATCH
	END

--PROCEDURE TO UPADTE DEPARTMENT
CREATE PROC [Organization].[Update_Department]
    @DepartmentId INT,        
    @Name NVARCHAR(50),
    @Description NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        UPDATE [Organization].[Department]
        SET Name = @Name,
            Description = @Description
        WHERE Id = @DepartmentId 
    END TRY
    BEGIN CATCH
        PRINT 'Error while updating department';
    END CATCH
END


--PROCEDURE TO INSERT TRACK
CREATE PROC [Organization].[Insert_Track]
	@Name NVARCHAR(50),
	@Description NVARCHAR(100)
	AS
	BEGIN
		BEGIN TRY
			INSERT INTO [Organization].Track(Name,Description)
			VALUES(@Name,@Description)
		END TRY
		BEGIN CATCH
			PRINT 'Error while in inserting track';
		END CATCH
	END

--PROCEDURE TO UPDATE TRACK
CREATE PROC [Organization].[Update_Track]
    @TrackId INT,              
    @Name NVARCHAR(50),
    @Description NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        UPDATE [Organization].[Track]
        SET Name = @Name,
            Description = @Description
        WHERE Id = @TrackId
    END TRY
    BEGIN CATCH
        PRINT 'Error while updating track';  
    END CATCH
END

--PROCEDURE TO INSERT INTAKE
CREATE OR ALTER PROC [Organization].[Insert_Intake]
	@Number NVARCHAR(50),
	@Year int,
	@Round int
	AS
	BEGIN
		BEGIN TRY
			INSERT INTO [Organization].[Intake](Number,[Year],[Round])
			VALUES(@Number,@Year,@Round)
		END TRY
		BEGIN CATCH
			PRINT 'Error while in inserting Intake';
		END CATCH
	END

--PROCEDURE TO UPDATE INTAKE
CREATE OR ALTER PROC [Organization].[Update_Intake]
    @IntakeId INT,            
    @Number NVARCHAR(50),
    @Year INT,
    @Round INT
AS
BEGIN
    BEGIN TRY
        UPDATE [Organization].[Intake]
        SET Number = @Number,
            [Year] = @Year,
            [Round] = @Round
        WHERE Id = @IntakeId  
    END TRY
    BEGIN CATCH
        PRINT 'Error while updating Intake';  
    END CATCH
END


--PROCEDURE TO INSERT BRANCH DEPARTMENT
CREATE OR ALTER PROCEDURE [Organization].[Insert_Branch_Department]
    @Branch_Name NVARCHAR(50),
    @Department_Name NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        DECLARE @Branch_Id INT,
                @Department_Id INT;

        -- Get Branch ID
        SELECT @Branch_Id = B.Id
        FROM [Organization].[Branch] AS B
        WHERE B.Name = @Branch_Name;

        -- Get Department ID
        SELECT @Department_Id = D.Id
        FROM [Organization].[Department] AS D
        WHERE D.Name = @Department_Name;

        -- Check if exists
        IF (@Branch_Id IS NOT NULL AND @Department_Id IS NOT NULL)
        BEGIN
            INSERT INTO [Organization].[Branch_Department](Branch_Id, Department_Id)
            VALUES (@Branch_Id, @Department_Id);
        END
        ELSE
        BEGIN
            THROW 52000, 'Invalid Branch or Department Name provided.', 1;
        END

    END TRY
    BEGIN CATCH
        PRINT @@ERROR
    END CATCH
END

EXEC [Organization].[Insert_Branch_Department] 'ITI ASYUT','AI'


--PROCEDURE TO INSERT BRANCH DEPARTMENT TRACK
CREATE OR ALTER PROCEDURE [Organization].[Insert_Branch_Department_Track]
    @Branch_Name NVARCHAR(50),
    @Department_Name NVARCHAR(50),
	@Track_Name NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        DECLARE @Branch_Id INT,
                @Department_Id INT,
				@Track_Id INT,
				@Branch_Department_Id INT

		--GET BRANCH AND DEPARTMENT ID
        SELECT @Branch_Id=B_Id,
			   @Department_Id=D_Id
		FROM Organization.V_Branch_Department as VBD
		WHERE VBD.B_Name=@Branch_Name 
			  AND VBD.D_Name=@Department_Name

		--GET TRACK ID
		SELECT @Track_Id=Id
		FROM Organization.Track AS T
		WHERE T.Name=@Track_Name

        -- Check if exists
        IF (@Branch_Id IS NOT NULL AND @Department_Id IS NOT NULL 
		AND @Track_Id IS NOT NULL)
        BEGIN
            SELECT @Branch_Department_Id=BD.Id
			FROM [Organization].[Branch_Department] AS BD
			WHERE BD.Branch_Id=@Branch_Id AND BD.Department_Id=@Department_Id
			
			IF(@Branch_Department_Id IS NOT NULL)
			BEGIN
				INSERT INTO [Organization].[Branch_Department_Track]
				(Branch_Department_Id,Track_Id)
				VALUES(@Branch_Department_Id,@Track_Id)

			END
			ELSE
			BEGIN 
				THROW 52000, 'Invalid Branch or Department or Track Name provided.', 1;
			END
		END
        ELSE
        BEGIN
            THROW 52000, 'Invalid Branch or Department or Track Name provided.', 1;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END

EXEC [Organization].[Insert_Branch_Department_Track] 'ITI ASYUT','WEB','REACT'


CREATE OR ALTER PROC [Organization].[Insert_Branch_Department_Track_Intake]
	@Branch_Department_Track_Id INT,
	@Intake_Number nvarchar(50)
AS
BEGIN
	BEGIN TRY
		DECLARE @Intake_Id INT,
				@BDTI_Id INT

		--GET INTAKE ID
		SELECT @Intake_Id=I.Id
		FROM Organization.Intake AS I
		WHERE I.Number=@Intake_Number

		--CHECK Branch_Department_Track_Id IF EXIST
		SELECT @BDTI_Id=BDT.Id
		FROM [Organization].[Branch_Department_Track] AS BDT
		WHERE BDT.Id=@Branch_Department_Track_Id

		IF(@Intake_Id IS NOT NULL AND @BDTI_Id IS NOT NULL)
		BEGIN
			INSERT INTO [Organization].[Branch_Department_Track_Intake]
			(Branch_Department_Track_Id,Intake_Id)
			VALUES(@BDTI_Id,@Intake_Id)
		END
		ELSE
		BEGIN
			THROW 52000, 'Invalid Branch Department Track ID or Intake Name provided.', 1;
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END

EXEC [Organization].[Insert_Branch_Department_Track_Intake] 15,'INTK2024-2'

--PROCEDURE TO INSERT 
CREATE OR ALTER PROCEDURE [Organization].[Insert_Branch_Department_Track_Intake_Instructor_Course]
    @Branch_Department_Track_Intake_ID INT,
    @Instructor_SSN NVARCHAR(50),
    @Course_Code CHAR(5)
AS
BEGIN
    BEGIN TRY
        DECLARE @Instructor_Course_Id INT;

        -- Validate Instructor SSN
        IF NOT EXISTS (
            SELECT 1
            FROM Parson.Instructor AS I
            WHERE I.SSN = @Instructor_SSN
        )
        BEGIN
            THROW 52000, 'Invalid Instructor SSN provided.', 1;
        END

        -- Validate Course Code
        IF NOT EXISTS (
            SELECT 1
            FROM Organization.Course AS C
            WHERE C.Code = @Course_Code
        )
        BEGIN
            THROW 52000, 'Invalid Course Code provided.', 1;
        END

        -- Get Instructor Course ID
        SELECT @Instructor_Course_Id = IC.Id
        FROM Organization.Instructor_Course AS IC
        WHERE IC.Course_Code = @Course_Code AND IC.Instructor_SSN = @Instructor_SSN;

        IF @Instructor_Course_Id IS NOT NULL
        BEGIN
            INSERT INTO [Organization].[Branch_Department_Track_Intake_Instructor_Course]
                (Branch_Department_Track_Intake_ID, Instructor_Course_Id)
            VALUES
                (@Branch_Department_Track_Intake_ID, @Instructor_Course_Id);
        END
        ELSE
        BEGIN
            THROW 52001, 'Instructor is not assigned to this course.', 1;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END


EXEC [Organization].[Insert_Branch_Department_Track_Intake_Instructor_Course]2,'40001234567890','C001'

CREATE OR ALTER PROCEDURE [Organization].[Insert_Branch_Department_Track_intake_student]
    @Branch_Name NVARCHAR(50),
    @Department_Name NVARCHAR(50),
	@Track_Name NVARCHAR(50),
	@Intake_Number NVARCHAR(50) ,
	@student_SSN char(14)
AS
BEGIN
    BEGIN TRY
        DECLARE
		        @Track_Id int ,
		        @Branch_Department_Id INT,
				@Branch_Department_Track_ID INT,
				@Branch_Department_Track_Intake_ID INT,
				@Student_SSN_ char(14),
				@Intake_ID int,
				@student_t int

	  --GET BRANCH_DEPARTMENT ID
        SELECT @Branch_Department_Id=BD.Id
		FROM Organization.Branch_Department BD , Organization.Branch B, Organization.Department D 
		WHERE  B.Name=@Branch_Name and D.Name= @Department_Name and B.Id=BD.Branch_Id and D.Id=BD.Department_Id
	
			
		--GET Branch_Department_track_id
		SELECT @Track_Id=Track.Id ,@Branch_Department_Track_ID=BDT.Branch_Department_Id
		FROM Organization.Track , Organization.Branch_Department_Track BDT
		WHERE Track.Name=@Track_Name and Track.Id=BDT.Track_Id
		 
		--Get intake_id

		SELECT @Intake_ID=Id
		FROM Intake
		WHERE Intake.Number=@Intake_Number


	    --GET Branch_Department_track_intake_ID
		SELECT @Branch_Department_Track_Intake_ID=BDTI.Id
		FROM Branch_Department_Track_Intake BDTI , Branch_Department_Track BDT
		WHERE BDT.Id=BDTI.Branch_Department_Track_Id AND
		BDTI.Branch_Department_Track_Id=@Branch_Department_Track_ID and BDTI.Intake_Id=@Intake_ID
		
		SELECT @Student_SSN_=Student.SSN
		FROM Parson.Student
		WHERE Student.SSN=@student_SSN
	
		  IF (@Student_SSN_ IS NOT NULL AND @Branch_Department_Track_Intake_ID IS NOT NULL)
		  BEGIN
			SELECT @student_t=Id
			FROM Branch_Department_Track_Intake_Student BDTIS 
			WHERE BDTIS.Student_SSN=@Student_SSN_ and BDTIS.Branch_Department_Track_Intake_Id=@Branch_Department_Track_Intake_ID
			
			IF(@student_t IS NULL)
			BEGIN
				INSERT INTO Organization.Branch_Department_Track_Intake_Student
				VALUES(@Branch_Department_Track_Intake_ID,@Student_SSN_)
			END
			ELSE
			BEGIN
				THROW 52000, 'Invalid Data', 1;
			END
		  END
		  ELSE
		  BEGIN
			THROW 52000, 'Invalid Data', 1;
		  END
	END TRY
	begin catch
		PRINT ERROR_MESSAGE();
	end catch
end

EXEC [Organization].[Insert_Branch_Department_Track_intake_student]'ITI ASYUT','WEB','.NET','INTK2024-1','30001234567890'


---KASBAN
CREATE OR ALTER PROCEDURE addQuestionTrueAndfalse
    @question VARCHAR(250),
    @istrue BIT,
    @instructor_id CHAR(14),
    @course_name VARCHAR(30)
AS
BEGIN
    BEGIN TRY
        DECLARE @id INT;
        DECLARE @course_code CHAR(5);
        DECLARE @instructorCourse_id INT;

        -- Get Course Code
        SELECT @course_code = Code
        FROM Organization.Course
        WHERE Name = @course_name;

        IF @course_code IS NULL
        BEGIN
            THROW 52000, 'Invalid course name provided.', 1;
        END

        -- Get Instructor Course ID
        SELECT @instructorCourse_id = id
        FROM Organization.Instructor_Course
        WHERE Instructor_SSN = @instructor_id AND Course_Code = @course_code;

        IF @instructorCourse_id IS NULL
        BEGIN
            THROW 52001, 'Instructor is not assigned to the specified course.', 1;
        END

        -- Insert Question
        INSERT INTO Exam.Questions (Question_Text, Created_At, Type, Instructor_Course_Id)
        VALUES (@question, GETDATE(), 'true or false', @instructorCourse_id);

        -- Get the newly inserted Question ID
        SELECT @id = SCOPE_IDENTITY();

        -- Insert into True_False with explicit columns
        INSERT INTO Exam.True_False (Question_Id, Is_True)
        VALUES (@id, @istrue);

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


execute addQuestionTrueAndfalse 'ARE U OK?',1,'40001234567891','Data Structures'


CREATE OR ALTER PROCEDURE addQuestionChoices
    @question VARCHAR(250),
    @instructor_id CHAR(14),
    @course_name VARCHAR(30)
AS
BEGIN
    BEGIN TRY
        DECLARE @course_code CHAR(5);
        DECLARE @instructorCourse_id INT;

        -- Validate Course Existence
        SELECT @course_code = Code
        FROM Organization.Course
        WHERE Name = @course_name;

        IF @course_code IS NULL
        BEGIN
            THROW 52000, 'Invalid course name provided.', 1;
        END

        -- Validate Instructor-Course Relationship
        SELECT @instructorCourse_id = id
        FROM Organization.Instructor_Course
        WHERE Instructor_SSN = @instructor_id AND Course_Code = @course_code;

        IF @instructorCourse_id IS NULL
        BEGIN
            THROW 52001, 'Instructor is not assigned to the specified course.', 1;
        END

        -- Insert Question
        INSERT INTO Exam.Questions (Question_Text, Created_At, Type, Instructor_Course_Id)
        VALUES (@question, GETDATE(), 'CHOOSE', @instructorCourse_id);

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


exec addQuestionmZQChoices 'quest choice','40001234567891','Data Structures'


CREATE OR ALTER PROCEDURE addQuestionText
    @question VARCHAR(250),
    @answer VARCHAR(250),
    @instructor_id CHAR(14),
    @course_name VARCHAR(30)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;  

        DECLARE @question_id INT;
        DECLARE @course_code CHAR(5);
        DECLARE @instructorCourse_id INT;
        -- Input Validation
        IF (LTRIM(RTRIM(@question)) = '' OR LTRIM(RTRIM(@answer)) = '')
        BEGIN
            THROW 52002, 'Question and Answer cannot be empty.', 1;
        END

        -- Validate Course
        SELECT @course_code = Code
        FROM Organization.Course
        WHERE Name = @course_name;

        IF @course_code IS NULL
        BEGIN
            THROW 52000, 'Invalid course name provided.', 1;
        END

        -- Validate Instructor-Course Assignment
        SELECT @instructorCourse_id = id
        FROM Organization.Instructor_Course
        WHERE Instructor_SSN = @instructor_id AND Course_Code = @course_code;

        IF @instructorCourse_id IS NULL
        BEGIN
            THROW 52001, 'Instructor is not assigned to the specified course.', 1;
        END
		-- Prevent Duplicate Question Entry
        IF EXISTS (
            SELECT 1
            FROM Exam.Questions
            WHERE Question_Text = @question AND Instructor_Course_Id = @instructorCourse_id
        )
        BEGIN
            THROW 52003, 'Duplicate question detected for this instructor and course.', 1;
        END

        -- Insert Question
        INSERT INTO Exam.Questions (Question_Text, Created_At, Type, Instructor_Course_Id)
        VALUES (@question, GETDATE(), 'TEXT', @instructorCourse_id);

        -- Retrieve Question ID
        SET @question_id = SCOPE_IDENTITY();

        -- Insert Answer into Text_Answers
        INSERT INTO Exam.Text_Answers (Question_Id, Answer_Text)
        VALUES (@question_id, @answer);

        COMMIT TRANSACTION;  -- Commit if all successful

        PRINT 'Question and answer inserted successfully.';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;  -- Rollback on error

        -- Detailed Error Reporting
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error occurred: ' + @ErrorMessage;
        THROW 52004, @ErrorMessage, 1;
    END CATCH
END