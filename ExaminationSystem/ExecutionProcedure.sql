USE[ExaminationSystemDB]
GO




               --Insert Branch
EXEC [Organization].[Insert_Branch] 'Helwan','Helwan'


               --Insert Department
EXEC [Organization].[Insert_Department] 'AIt', 'Artifical Inelligence';

               --Insert Track
EXEC [Organization].[Insert_Track] 'Web Development', 'Track for Web Development';


               --Insert Intake
EXEC [Organization].[Insert_Intake] 'INTK2024-3', 2024, 2;


               --Insert Department into Branch
EXEC [Organization].[Insert_Branch_Department] 'ITI ASYUT','AI'
  

               --INSERT BRANCH DEPARTMENT TRACK
EXEC [Organization].[Insert_Branch_Department_Track] 'ITI ASYUT','WEB','REACT'

               --Insert Branch Department Track into Intake
                
EXEC [Organization].[Insert_Branch_Department_Track_Intake] 10,'INTK2024-2'

               --Insert Instructor to Course into Track into intake 
EXEC [Organization].[Insert_Branch_Department_Track_Intake_Instructor_Course]2,'40001234567890','C002'

               --Insert Student into Track into intake  
EXEC [Organization].[Insert_Branch_Department_Track_intake_student]'ITI ASYUT','WEB','.NET','INTK2024-2','30001234567890'

               --Add true and false Question 
EXEC  [addQuestionTrueAndfalse] 'ARE U OK?',1,'40001234567891','Data Structures'

               --Add MCQ Question
EXEC [addQuestionChoices] 'quest choice','40001234567891','Data Structures'

                --Add Text Question

EXEC addQuestionText @question='Where did you go?',@answer= 'Aswan',@instructor_id='40001234567899',@course_name='Software Engineering';



----------------------------
-- Execute the procedure, passing the input parameter and capturing the output
DECLARE @ResultValue FLOAT;
EXEC CalculateStudentAnswersResults 
    @Student_Answer_Id = 1,
    @Result = @ResultValue OUTPUT; -- Capture the output
PRINT 'The calculated result is: ' + CAST(@ResultValue AS NVARCHAR(50));


--Insert Branch
EXEC [Organization].[Insert_Branch] 'Aswan','Aswan'


               --Insert Department
EXEC [Organization].[Insert_Department] 'Graphic', 'Graphic Design';

               --Insert Track
EXEC [Organization].[Insert_Track] '3D Gaming', 'Track for Gaming ';


               --Insert Intake
EXEC [Organization].[Insert_Intake] 'INTK2024-4', 2024, 2;


               --Insert Department into Branch
EXEC [Organization].[Insert_Branch_Department] 'Aswan','Graphic'
  

               --INSERT BRANCH DEPARTMENT TRACK
EXEC [Organization].[Insert_Branch_Department_Track] 'Aswan','Graphic','3D Gaming'

               --Insert Branch Department Track into Intake
                
EXEC [Organization].[Insert_Branch_Department_Track_Intake] 10,'INTK2024-3'