use [ExaminationSystemDB]
go

EXEC Exam.InsertExam 
    @Start_Time = '2025-01-15 09:00:00',
    @End_Time = '2025-01-20 12:00:00',
    @Allowances = 'Extra time for certain students',
    @Branch_Department_Track_Intake_Course_Instructor_Id = 1,
    @Total_Exam_Degree = 100;

SELECT * FROM Exam.Exams
SELECT * FROM Organization.Branch_Department_Track_Intake_Instructor_Course

select * from Person.Instructor
select * from Organization.Course
select * from Organization.Instructor_Course

EXEC addQuestionTrueAndfalse 
    @question = 'ARE U OK?', 
    @istrue = 1, 
    @instructor_id = '40001234567891', 
    @course_name = 'Data Structures';

EXEC addQuestionChoices 
    @question = 'What is the time complexity of binary search?', 
    @instructor_id = '40001234567891', 
    @course_name = 'Data Structures';

EXEC addQuestionText 
    @question = 'Explain the concept of binary trees.', 
    @answer = 'A binary tree is a tree data structure in which each node has at most two children.', 
    @instructor_id = '40001234567891', 
    @course_name = 'Data Structures';
select * from Exam.Questions
update [Exam].[Questions]
set [Instructor_Course_Id] = 1
EXEC Exam.Allocate_Questions_For_Exam
    @Exam_Id = 1,                       
    @Course_Code = 'C002',             
    @Num_Choose_Questions = 5,          
    @Choose_Question_Degree = 2,        
    @Num_True_False_Questions = 3,      
    @True_False_Question_Degree = 1,    
    @Num_Text_Questions = 2,            
    @Text_Question_Degree = 3;

select * from Person.Student

DECLARE @StudentsList Exam.StudentSSNTableType;

INSERT INTO @StudentsList (SSN)
VALUES ('30001010100123'), 
       ('30001234567890'), 
       ('30001234567891');

EXEC Exam.Assign_Exam_To_Students
    @Exam_Id = 1,               
    @Exam_Type = 'C',          
    @StudentsList = @StudentsList;




