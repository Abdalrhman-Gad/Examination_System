CREATE TABLE INSTRUCTOR_COURSE
(
    INSTRUCTOR_ID CHAR(14) NOT NULL,
    COURSE_CODE CHAR(5) NOT NULL,
    CONSTRAINT PK_INSTRUCTOR_COURSE PRIMARY KEY (INSTRUCTOR_ID, COURSE_CODE),
    CONSTRAINT FK_INSTRUCTOR_COURSE_INSTRUCTOR_ID FOREIGN KEY (INSTRUCTOR_ID) REFERENCES INSTRUCTOR(SSN),
    CONSTRAINT FK_INSTRUCTOR_COURSE_COURSE_CODE FOREIGN KEY (COURSE_CODE) REFERENCES COURSE(CODE)
) ON ExamSystem_FG2;

---------------------------------------------------
CREATE TABLE BDIT_STUDENT
(
    STUDENT_ID CHAR(14) NOT NULL,
    BDIT_ID INT NOT NULL,
    CONSTRAINT PK_BDIT_STUDENT_COURSE PRIMARY KEY (STUDENT_ID,BDIT_ID),
    CONSTRAINT FK_BDIT_STUDENT_STUDENT_ID FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(SSN),
    CONSTRAINT FK_BDIT_STUDENT_BDIT_ID FOREIGN KEY (BDIT_ID) REFERENCES BRANCH_DEPARTMENT_INTAKE_TRACK(ID)
)ON ExamSystem_FG2;
-------------------------------------

CREATE TABLE STUDENT 
(
	SSN CHAR(14),
	[FULL_NAME] VARCHAR(50) NOT NULL,
	GENDER CHAR(1) NOT NULL DEFAULT 'M',
	BIRTH_DATE DATE NOT NULL,
	PHONE CHAR(11) NOT NULL,
	AGE AS DATEDIFF(YEAR,BIRTH_DATE,GETDATE()),
	[ADDRESS] VARCHAR(20) NOT NULL,
	ACCOUNT_ID INT,
	CONSTRAINT PK_STUDENT_SSN PRIMARY KEY (SSN),
	CONSTRAINT CK_STUDENT_SSN CHECK (LEN(SSN) = 14),
	CONSTRAINT CK_STUDENT_GENDER CHECK(UPPER(GENDER) IN ('M','F')),
	
	CONSTRAINT FK_STUDENT_ACCOUNTID 
	FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNT(ID) ON UPDATE CASCADE 
)ON ExamSystem_FG2; 

SP_BINDRULE PHONE_ROLE,'STUDENT.PHONE'