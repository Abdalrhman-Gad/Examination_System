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
		DECLARE @Intake_Id INT,@BDTI_Id INT

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