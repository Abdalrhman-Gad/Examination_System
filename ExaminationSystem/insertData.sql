
use[ExaminationSystemDB]
GO


-- Insert into Organization.Branch
INSERT INTO Organization.Branch ([Name], [Location])
VALUES 
('Main Branch', 'Cairo'),
('North Branch', 'Alexandria'),
('East Branch', 'Ismailia'),
('West Branch', 'Giza'),
('South Branch', 'Aswan');

-- Insert into Organization.Department
INSERT INTO Organization.Department ([Name], [Description])
VALUES 
('Computer Science', 'CS Department'),
('Information Technology', 'IT Department'),
('Data Science', 'DS Department'),
('Cyber Security', 'CSec Department'),
('Artificial Intelligence', 'AI Department');

-- Insert into Organization.Track
INSERT INTO Organization.Track ([Name], [Description])
VALUES 
('Software Engineering', 'Track for SE'),
('Cyber Security', 'Track for CS'),
('Data Analytics', 'Track for DA'),
('Web Development', 'Track for WD'),
('AI and Robotics', 'Track for AI');

-- Insert into Organization.Intake
INSERT INTO Organization.Intake (Number, [Year], [Round])
VALUES 
('Intake 1', 2023, 1),
('Intake 2', 2023, 2),
('Intake 3', 2024, 1),
('Intake 4', 2024, 2),
('Intake 5', 2025, 1);

-- Insert into Organization.Course
INSERT INTO Organization.Course (Code, [Name], [Description], Min_Degree, Max_Degree)
VALUES 
('CS101', 'Intro to CS', 'Basics of Computer Science', 50, 100),
('SE201', 'Software Design', 'Advanced Software Design', 40, 100),
('IT301', 'Networks', 'Networking Basics', 60, 100),
('AI401', 'Machine Learning', 'Introduction to ML', 50, 100),
('DA501', 'Big Data', 'Big Data Tools and Techniques', 70, 100);

-- Insert into Organization.Branch_Department
INSERT INTO Organization.Branch_Department (Branch_Id, Department_Id)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);
-- Insert into Organization.Branch_Department_Track
INSERT INTO Organization.Branch_Department_Track (Branch_Department_Id, Track_Id)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Organization.Branch_Department_Track_Intake
INSERT INTO Organization.Branch_Department_Track_Intake (Branch_Department_Track_Id, Intake_Id)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Person.Student
INSERT INTO Person.Student (SSN, FullName, Gender, BirthDate, Phone, [Address])
VALUES 
('30001010100123', 'Ahmed Hassan', 'M', '2000-01-01', '01012345670', 'Cairo'),
('30002020200234', 'Aya Mahmoud', 'F', '2001-02-02', '01098765432', 'Alexandria'),
('30003030300345', 'Mohamed Ali', 'M', '2002-03-03', '01112345678', 'Ismailia'),
('30004040400456', 'Sara Adel', 'F', '2003-04-04', '01234567890', 'Giza'),
('30005050500567', 'Hussein Khaled', 'M', '2004-05-05', '01555555555', 'Aswan'),
('30006060600678', 'Nourhan Fathy', 'F', '2005-06-06', '01066666666', 'Cairo'),
('30007070700789', 'Youssef Tamer', 'M', '2006-07-07', '01177777777', 'Alexandria'),
('30008080800890', 'Mariam Hany', 'F', '2007-08-08', '01288888888', 'Ismailia'),
('30009090900901', 'Omar Gamal', 'M', '2008-09-09', '01599999999', 'Giza'),
('30010101001012', 'Laila Mohamed', 'F', '2009-10-10', '01000000000', 'Aswan');

-- Insert into Organization.Branch_Department_Track_Intake_Student
INSERT INTO Organization.Branch_Department_Track_Intake_Student (Branch_Department_Track_Intake_Id, Student_SSN)
VALUES 
(1, '30001010100123'), (2, '30002020200234'), (3, '30003030300345'), 
(4, '30004040400456'), (5, '30005050500567'),
(1, '30006060600678'), (2, '30007070700789'), (3, '30008080800890'), 
(4, '30009090900901'), (5, '30010101001012');

-- Insert into Person.Instructor
INSERT INTO Person.Instructor (SSN, Name, Salary, Gender, BirthDate, Phone, [Address], BranchId, IsManager)
VALUES 
('20001010100123', 'Dr. Ahmed Hassan', 10000, 'M', '1975-01-01', '01012345000', 'Cairo', 1, 1),
('20002020200234', 'Dr. Aya Mahmoud', 9000, 'F', '1980-02-02', '01098765000', 'Alexandria', 2, 0),
('20003030300345', 'Dr. Mohamed Ali', 8500, 'M', '1985-03-03', '01112345000', 'Ismailia', 3, 0),
('20004040400456', 'Dr. Sara Adel', 8700, 'F', '1990-04-04', '01234567000', 'Giza', 4, 0),
('20005050500567', 'Dr. Hussein Khaled', 8000, 'M', '1995-05-05', '01555555000', 'Aswan', 5, 0);

-- Insert into Organization.Instructor_Course
INSERT INTO Organization.Instructor_Course (Instructor_SSN, Course_Code)
VALUES 
('20001010100123', 'CS101'), ('20002020200234', 'SE201'),
('20003030300345', 'IT301'), ('20004040400456', 'AI401'),
('20005050500567', 'DA501');

-- Insert into Organization.Branch_Department_Track_Intake_Instructor_Course
INSERT INTO Organization.Branch_Department_Track_Intake_Instructor_Course (Instructor_Course_Id, Branch_Department_Track_Intake_ID)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Exam.Exams
INSERT INTO Exam.Exams ([Start_Time], [End_Time], [Allowances], [Branch_Department_Track_Intake_Course_Instructor_Id])
VALUES 
('2025-01-15 09:00:00', '2025-01-15 12:00:00', 'Open Notes', 1),
('2025-01-16 10:00:00', '2025-01-16 13:00:00', 'Closed Book', 2),
('2025-01-17 11:00:00', '2025-01-17 14:00:00', 'Calculator Allowed', 3),
('2025-01-18 08:00:00', '2025-01-18 11:00:00', 'Formula Sheet', 4),
('2025-01-19 09:30:00', '2025-01-19 12:30:00', 'None', 5);


-- Insert data for Exam.Questions
INSERT INTO Exam.Questions ([Question_Text], [Type], [Instructor_Course_Id])
VALUES 
    ('What is 2 + 2?', 'CHOOSE', 1),
    ('Explain Newtons laws of motion.', 'TEXT', 2),
    ('Is the Earth flat?', 'TRUE OR FALSE', 3);

-- Insert data for Exam.Exam_Questions
INSERT INTO Exam.Exam_Questions ([Exam_Id], [Question_Id], [Degree])
VALUES 
    (1, 1, 5),
    (1, 2, 10),
    (2, 3, 15);

-- Insert data for Exam.Student_Exams
INSERT INTO Exam.Student_Exams ([Student_SSN], [Exam_Id], [Result], [Type])
VALUES 
    ('30001010100123', 1, 85.0, 'C'),
    ('30001010100123', 2, 90.0, 'E');

-- Insert data for Exam.Choices
INSERT INTO Exam.Choices ([Question_Id], [Choice_Text], [Is_True])
VALUES 
    (1, '4', 1),
    (1, '5', 0),
    (3, 'Yes', 0),
    (3, 'No', 1);

-- Insert data for Exam.True_False
INSERT INTO Exam.True_False ([Question_Id], [Is_True])
VALUES 
    (3, 0);

-- Insert data for Exam.Text_Answers
INSERT INTO Exam.Text_Answers ([Question_Id], [Answer_Text])
VALUES 
    (2, 'Newtons laws describe the relationship between motion and force.');

-- Insert data for Answer.Student_Answer
INSERT INTO Answer.Student_Answer ([Id], [Student_SSN], [Exam_Question_Id], [Answer_Degree])
VALUES 
    (1, '30001010100123', 1, 5),
    (2, '30001010100123', 3, 10);

-- Insert data for Answer.Text_Answer
INSERT INTO Answer.Text_Answer ([Answer_Id], [Student_Answer_Text])
VALUES 
    (1, 'The answer is 4.');

-- Insert data for Answer.True_False_Answer
INSERT INTO Answer.True_False_Answer ([Answer_Id], [Answer_Flag])
VALUES 
    (2, 0);

-- Insert data for Answer.Mcq_Answer
INSERT INTO Answer.Mcq_Answer ([Answer_Id], [Choice_Id])
VALUES 
    (1, 1),
    (2, 4);
