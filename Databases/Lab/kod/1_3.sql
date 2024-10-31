USE Session;
GO

--3
CREATE VIEW Students_complete (Fio, Direction, Numer_of_balls) 
AS  SELECT NumSt, NumDir, COUNT(Ball) 
	FROM Balls JOIN Uplans ON Balls.IdDisc=Uplans.IdDisc 
	WHERE Semestr=1  
	GROUP BY NumSt, NumDir 
HAVING Count(Ball)=(SELECT COUNT( *) 
					FROM Uplans u 
					WHERE Uplans.NumDir=u.NumDir and semestr=1);
GO

SELECT * FROM Students_complete;
