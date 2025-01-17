USE[ExaminationSystemDB]

GO

CREATE OR ALTER TRIGGER [Exam].TRG_Update_Exam_Degree
ON [Exam].[Exam_Questions]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF (UPDATE([Exam_Id]))
    BEGIN
        UPDATE e
        SET e.Total_Exam_Degree = e.Total_Exam_Degree - d.Degree
        FROM [Exam].[Exams] e
        JOIN deleted d ON e.Id = d.Exam_Id;

        UPDATE e
        SET e.Total_Exam_Degree = e.Total_Exam_Degree + i.Degree
        FROM [Exam].[Exams] e
        JOIN inserted i ON e.Id = i.Exam_Id;
    END

    ELSE IF (UPDATE([Degree]))
    BEGIN
        UPDATE e
        SET e.Total_Exam_Degree = e.Total_Exam_Degree + (i.Degree - d.Degree)
        FROM [Exam].[Exams] e
        JOIN inserted i ON e.Id = i.Exam_Id
        JOIN deleted d ON i.Exam_Id = d.Exam_Id AND i.Id= d.Id; 
    END
END
