# Examination System Database

## Overview

The **Examination System Database** is a SQL Server-based project designed to manage examination processes efficiently. It allows instructors to create exams, students to take exams, and training managers to oversee the process. The system ensures data integrity, access control, and automation of key functionalities like exam evaluation and backup management.

## Features

- **Question Pool**: Supports multiple-choice, true/false, and text-based questions.
- **Exam Creation**: Instructors can create exams manually or select random questions.
- **Student Exam Handling**: Stores students' answers, evaluates responses, and calculates scores.
- **Course & Instructor Management**: Tracks course details, instructors, and student enrollments.
- **User Authentication**: Role-based access for admin, training managers, instructors, and students.
- **Performance Optimization**: Uses indexes, constraints, and triggers for best performance.
- **Automated Backup**: Ensures daily data backups for security.

## System Requirements

- **Database Management**: SQL Server
- **Roles & Permissions**:
  - **Admin**: Manages system-level configurations.
  - **Training Manager**: Manages branches, tracks, intakes, and student records.
  - **Instructor**: Creates exams and evaluates student performance.
  - **Student**: Takes exams at scheduled times.

## Database Structure

- **Entities**:
- **Person Schema**
  - **Instructor**: Manages instructor assignments.
  - **Student**: Tracks student enrollments and personal information.
- **Organization Schema**
  - **Branch**: Store's branch informations.
  - **Department**: Store's department information.
  - **Track**: Stroes track informations.
  - **Intake**: Stores intake informations.
  - **Branch Department**: Stores branch ID and each department on it.
  - **Branch Department Track**: Stores branch_department id and its track's id's.
  - **Branch Department Track Intake**: Stores branch_department_track id and its intake's id's.
  - 
  - 
  - **Exams**: Stores exam definitions, scheduling, and results.
  - 
  - **Questions**: Maintains a pool of different types of questions.
  - **Exam Attempts**: Records students' answers and calculated scores.
## Usage

- **Admins**: Manage users and system-wide configurations.
- **Training Managers**: Add students, manage courses, and assign tracks.
- **Instructors**: Create exams, assign questions, and evaluate responses.
- **Students**: Take scheduled exams and view results.

## Project Deliverables

- **Entity-Relationship Diagram (ERD)**: [https://drive.google.com/file/d/1mOuU3TBOPHmVBzEAlRuEp6CaV-17BGPC/view?usp=sharing]
- **SQL Database Files**: Tables, indexes, and constraints.
- **SQL Scripts**:
  - Individual team member contributions.
  - Full database structure and object creation.
- **Test Queries & Results**: Verification of database integrity and functionality.
- **User Accounts & Credentials**: Predefined accounts and their roles.

## Contributors

- [Abdalrhman gad]
- [Amr kasnban]
- [Abdalaziz taha]
- [Hossam mamdouh]
- [Mahmoud abdalrady]
- [Esraa saied]

## Contact

For any inquiries or contributions, please reach out to [Gadwork44@gmail.com].

