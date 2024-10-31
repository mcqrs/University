CREATE PROCEDURE List_Students_Dir1 (@Dir AS INT, @Disc AS VARCHAR(30))
AS
SELECT Distinct Students.FIO 
FROM Groups 
JOIN Students ON Groups.NumGroup=Students.NumGroup 
JOIN Balls ON Students.NumSt=Balls.NumSt 
JOIN Uplans ON Uplans.IdDisc=Balls.IdDisc 
WHERE Groups.NumDir=@Dir and NumDisc=(SELECT NumDisc 
									  FROM Disciplines 
									  WHERE Name=@Disc);
GO

USE Session
GO

EXEC List_Students_Dir1 230100, 'Физика'

