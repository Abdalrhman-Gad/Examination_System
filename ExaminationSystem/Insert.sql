INSERT INTO Organization.Branch ([Name], [Location]) VALUES
('ITI ASYUT', 'ASYUT'),
('ITI MINYA', 'MINYA'),
('ITI CAIRO', 'CAIRO'),
('ITI ALEX', 'ALEXANDRIA'),
('ITI SUEZ', 'SUEZ'),
('ITI LUXOR', 'LUXOR'),
('ITI QENA', 'QENA'),
('ITI ZAGAZIG', 'ZAGAZIG'),
('ITI FAYOUM', 'FAYOUM'),
('ITI MANSOURA', 'MANSOURA');
GO

INSERT INTO Organization.Department ([Name], [Description]) VALUES
('WEB', 'Web Development Department'),
('DESIGN', 'Graphic Design Department'),
('CLOUD', 'Cloud Computing Department'),
('AI', 'Artificial Intelligence Department'),
('NETWORK', 'Network Engineering Department'),
('DATA SCIENCE', 'Data Science Department'),
('SECURITY', 'Cyber Security Department'),
('MOBILE', 'Mobile App Development Department'),
('GAME DEV', 'Game Development Department'),
('ROBOTICS', 'Robotics and Automation Department');
GO

INSERT INTO Organization.Track ([Name], [Description]) VALUES
('.NET', '.NET Development Track'),
('ANGULAR', 'Frontend with Angular Track'),
('DJANGO', 'Backend with Django Track'),
('REACT', 'Frontend with React Track'),
('NODEJS', 'Backend with NodeJS Track'),
('PYTHON', 'Python Programming Track'),
('JAVA', 'Java Development Track'),
('ANDROID', 'Android App Development Track'),
('IOS', 'iOS App Development Track'),
('DEVOPS', 'DevOps and CI/CD Track');
GO

INSERT INTO Organization.Intake (Number, [Year], [Round]) VALUES
('INTK2024-1', 2024, 1),
('INTK2024-2', 2024, 2),
('INTK2023-1', 2023, 1),
('INTK2023-2', 2023, 2),
('INTK2022-1', 2022, 1),
('INTK2022-2', 2022, 2),
('INTK2021-1', 2021, 1),
('INTK2021-2', 2021, 2),
('INTK2020-1', 2020, 1),
('INTK2020-2', 2020, 2);
GO

INSERT INTO Organization.Branch_Department (Branch_Id, Department_Id) VALUES
(1, 1),  -- ITI ASYUT - WEB
(1, 2),  -- ITI ASYUT - DESIGN
(2, 1),  -- ITI MINYA - WEB
(2, 3),  -- ITI MINYA - CLOUD
(3, 4),  -- ITI CAIRO - AI
(4, 5),  -- ITI ALEX - NETWORK
(5, 6),  -- ITI SUEZ - DATA SCIENCE
(6, 7),  -- ITI LUXOR - SECURITY
(7, 8),  -- ITI QENA - MOBILE
(8, 9);  -- ITI ZAGAZIG - GAME DEV
GO

INSERT INTO Organization.Branch_Department_Track (Branch_Department_Id, Track_Id) VALUES
(1, 1),  -- ASYUT - WEB - .NET
(2, 2),  -- ASYUT - DESIGN - ANGULAR
(3, 3),  -- MINYA - WEB - DJANGO
(4, 4),  -- MINYA - CLOUD - REACT
(5, 5),  -- CAIRO - AI - NODEJS
(6, 6),  -- ALEX - NETWORK - PYTHON
(7, 7),  -- SUEZ - DATA SCIENCE - JAVA
(8, 8),  -- LUXOR - SECURITY - ANDROID
(9, 9),  -- QENA - MOBILE - IOS
(10, 10); -- ZAGAZIG - GAME DEV - DEVOPS
GO

INSERT INTO Organization.Branch_Department_Track_Intake (Branch_Department_Track_Id, Intake_Id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
GO

INSERT INTO Person.Student (SSN, FullName, Gender, BirthDate, Phone, [Address]) VALUES
('30001234567890', 'Ahmed Ali', 'M', '2000-01-01', '01012345678', 'Cairo'),
('30001234567891', 'Sara Mohamed', 'F', '1999-05-15', '01112345678', 'Giza'),
('30001234567892', 'Omar Hassan', 'M', '2001-03-20', '01212345678', 'Alexandria'),
('30001234567893', 'Mona Adel', 'F', '1998-12-10', '01512345678', 'Tanta'),
('30001234567894', 'Ali Mahmoud', 'M', '2000-07-25', '01098765432', 'Asyut'),
('30001234567895', 'Nour Hany', 'F', '1999-09-12', '01198765432', 'Luxor'),
('30001234567896', 'Mostafa Zaki', 'M', '2001-05-18', '01298765432', 'Mansoura'),
('30001234567897', 'Aya Tarek', 'F', '1998-11-30', '01598765432', 'Fayoum'),
('30001234567898', 'Ibrahim Khaled', 'M', '2000-03-09', '01087654321', 'Beni Suef'),
('30001234567899', 'Salma Yehia', 'F', '1999-07-14', '01187654321', 'Sohag');
GO

INSERT INTO Person.Instructor (SSN, Name, Salary, Gender, BirthDate, Phone, [Address], BranchId, IsManager) VALUES
('40001234567890', 'Dr. Youssef Gamal', 10000, 'M', '1980-01-01', '01087654321', 'Cairo', 1, 1),
('40001234567891', 'Dr. Fatma Said', 9500, 'F', '1985-03-15', '01187654321', 'Giza', 2, 0),
('40001234567892', 'Dr. Hossam Tarek', 9200, 'M', '1982-06-20', '01287654321', 'Alexandria', 3, 0),
('40001234567893', 'Dr. Mona Samir', 9800, 'F', '1987-11-10', '01587654321', 'Tanta', 1, 0),
('40001234567894', 'Dr. Ahmed Kamal', 9700, 'M', '1983-09-25', '01076543210', 'Asyut', 2, 0),
('40001234567895', 'Dr. Lamia Hassan', 9300, 'F', '1981-05-30', '01176543210', 'Luxor', 3, 0),
('40001234567896', 'Dr. Khaled Mansour', 9600, 'M', '1984-02-28', '01276543210', 'Mansoura', 1, 0),
('40001234567897', 'Dr. Heba Ali', 9900, 'F', '1986-08-22', '01576543210', 'Fayoum', 2, 0),
('40001234567898', 'Dr. Tamer Elbaz', 9500, 'M', '1982-12-19', '01065432109', 'Beni Suef', 3, 0),
('40001234567899', 'Dr. Reem Adel', 9700, 'F', '1983-06-16', '01165432109', 'Sohag', 1, 0);
GO

INSERT INTO Organization.Branch_Department_Track_Intake_Student (Branch_Department_Track_Intake_Id, Student_SSN) VALUES
(1, '30001234567890'),
(2, '30001234567891'),
(3, '30001234567892'),
(4, '30001234567893'),
(5, '30001234567894'),
(6, '30001234567895'),
(7, '30001234567896'),
(8, '30001234567897'),
(9, '30001234567898'),
(10, '30001234567899');
GO

INSERT INTO Organization.Course (Code, [Name], [Description], Min_Degree, Max_Degree)
VALUES 
('C001', 'Introduction to Programming', 'Learn the basics of programming using Python.', 0, 100),
('C002', 'Data Structures', 'Study common data structures such as lists, stacks, queues, and trees.', 30, 100),
('C003', 'Web Development', 'Introduction to building websites using HTML, CSS, and JavaScript.', 40, 100),
('C004', 'Database Systems', 'Learn about relational databases and SQL queries.', 50, 100),
('C005', 'Computer Networks', 'Study the basics of computer networking and protocols.', 60, 100),
('C006', 'Artificial Intelligence', 'Learn the fundamentals of AI and machine learning algorithms.', 70, 100),
('C007', 'Operating Systems', 'Learn about OS design, process management, and memory management.', 80, 100),
('C008', 'Cybersecurity', 'Study security protocols, encryption techniques, and security policy implementation.', 90, 100),
('C009', 'Mobile Application Development', 'Introduction to building mobile apps for iOS and Android.', 50, 100),
('C010', 'Software Engineering', 'Learn software development methodologies, project management, and team collaboration.', 60, 100);
GO

INSERT INTO Organization.Instructor_Course (Instructor_SSN, Course_Code)
VALUES
('40001234567890', 'C001'), -- Dr. Youssef Gamal
('40001234567891', 'C002'), -- Dr. Fatma Said
('40001234567892', 'C003'), -- Dr. Hossam Tarek
('40001234567893', 'C004'), -- Dr. Mona Samir
('40001234567894', 'C005'), -- Dr. Ahmed Kamal
('40001234567895', 'C006'), -- Dr. Lamia Hassan
('40001234567896', 'C007'), -- Dr. Khaled Mansour
('40001234567897', 'C008'), -- Dr. Heba Ali
('40001234567898', 'C009'), -- Dr. Tamer Elbaz
('40001234567899', 'C010'); -- Dr. Reem Adel
GO


INSERT INTO Organization.Branch_Department_Track_Intake_Instructor_Course (Instructor_Course_Id, Branch_Department_Track_Intake_ID)
VALUES
(2, 1), -- Instructor_Course_Id = 2, Branch_Department_Track_Intake_ID = 1
(3, 2), -- Instructor_Course_Id = 3, Branch_Department_Track_Intake_ID = 2
(4, 3), -- Instructor_Course_Id = 4, Branch_Department_Track_Intake_ID = 3
(5, 4), -- Instructor_Course_Id = 5, Branch_Department_Track_Intake_ID = 4
(6, 5), -- Instructor_Course_Id = 6, Branch_Department_Track_Intake_ID = 5
(7, 6), -- Instructor_Course_Id = 7, Branch_Department_Track_Intake_ID = 6
(8, 7), -- Instructor_Course_Id = 8, Branch_Department_Track_Intake_ID = 7
(9, 8), -- Instructor_Course_Id = 9, Branch_Department_Track_Intake_ID = 8
(10, 9), -- Instructor_Course_Id = 10, Branch_Department_Track_Intake_ID = 9
(11, 10); -- Instructor_Course_Id = 11, Branch_Department_Track_Intake_ID = 10
GO


-- Insert data into Exam.Exams
INSERT INTO Exam.Exams (Start_Time, End_Time, Allowances, Branch_Department_Track_Intake_Course_Instructor_Id)
VALUES 
('2025-01-10 09:00:00', '2025-01-10 11:00:00', 'Calculator allowed', 11),
('2025-01-11 10:00:00', '2025-01-11 12:00:00', 'Open book', 2),
('2025-01-12 13:00:00', '2025-01-12 15:00:00', 'None', 3),
('2025-01-13 09:30:00', '2025-01-13 11:30:00', 'Dictionary allowed', 4),
('2025-01-14 14:00:00', '2025-01-14 16:00:00', 'Calculator allowed', 5),
('2025-01-15 08:00:00', '2025-01-15 10:00:00', 'None', 6),
('2025-01-16 11:00:00', '2025-01-16 13:00:00', 'Open book', 7),
('2025-01-17 15:00:00', '2025-01-17 17:00:00', 'Calculator allowed', 8),
('2025-01-18 09:00:00', '2025-01-18 11:00:00', 'None', 9),
('2025-01-19 10:00:00', '2025-01-19 12:00:00', 'Open book', 10);

-- Insert data into Exam.Questions
INSERT INTO Exam.Questions (Question_Text, Type, Instructor_Course_Id)
VALUES
('What is SQL?', 'TEXT', 11),
('Choose the correct syntax for SELECT.', 'CHOOSE', 2),
('SQL is case sensitive.', 'TRUE OR FALSE', 3),
('Explain normalization.', 'TEXT', 4),
('Select the aggregate function.', 'CHOOSE', 5),
('Indexes improve query speed.', 'TRUE OR FALSE', 6),
('Describe JOIN types.', 'TEXT', 7),
('Identify the primary key constraint.', 'CHOOSE', 8),
('Databases can be relational.', 'TRUE OR FALSE', 9),
('Explain ACID properties.', 'TEXT', 10);

-- Insert data into Exam.Exam_Questions
INSERT INTO Exam.Exam_Questions (Exam_Id, Question_Id, Degree)
VALUES
(6, 11, 10),
(6, 2, 15),
(7, 3, 5),
(7, 4, 20),
(3, 5, 15),
(3, 6, 10),
(4, 7, 25),
(4, 8, 15),
(5, 9, 5),
(5, 10, 20);

-- Insert data into Exam.Student_Exams using provided student data
INSERT INTO Exam.Student_Exams (Student_SSN, Exam_Id, Result, Type)
VALUES
('30001234567890', 6, 87.5, 'C'),
('30001234567891', 7, 91.0, 'E'),
('30001234567892', 3, 78.5, 'C'),
('30001234567893', 4, 85.0, 'E'),
('30001234567894', 5, 90.0, 'C'),
('30001234567895', 8, 82.0, 'E'),
('30001234567896', 9, 88.0, 'C'),
('30001234567897', 3, 79.5, 'E'),
('30001234567898', 4, 84.0, 'C'),
('30001234567899', 5, 89.5, 'E');

-- Insert data into Exam.Choices
INSERT INTO Exam.Choices (Question_Id, Choice_Text, Is_True)
VALUES
(3, 'SELECT * FROM table;', 1),
(3, 'GET * FROM table;', 0),
(3, 'SUM()', 1),
(6, 'COUNT()', 1),
(6, 'PRIMARY KEY', 1),
(6, 'FOREIGN KEY', 0),
(9, 'INDEX', 0),
(9, 'DEFAULT', 0),
(9, 'AVG()', 1),
(9, 'ORDER BY', 0);

truncate  table Exam.Choices

-- Insert data into Exam.True_False
INSERT INTO Exam.True_False (Question_Id, Is_True)
VALUES
(4, 0),
(7, 1),
(10, 1);

truncate table Exam.True_False

-- Insert data into Exam.Text_Answers
INSERT INTO Exam.Text_Answers (Question_Id, Answer_Text)
VALUES
(2, 'SQL stands for Structured Query Language.'),
(5, 'Normalization reduces data redundancy.'),
(8, 'JOINs combine rows from multiple tables.'),
(11, 'ACID stands for Atomicity, Consistency, Isolation, Durability.')
	