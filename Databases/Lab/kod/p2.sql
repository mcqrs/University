USE Session
GO

CREATE PROCEDURE Count_Students_Sem @Count_sem AS INT
AS
SELECT COUNT(Distinct NumSt) 
FROM Balls JOIN Uplans ON Uplans.IdDisc=Balls.IdDisc 
WHERE Semestr>=@Count_sem;
GO

EXEC Count_Students_Sem 1

DECLARE @kol int;
SET @kol=2;
EXEC Count_Students_Sem @kol;
