USE Session
GO

--1
CREATE VIEW Disciplines_with_balls 
AS SELECT Distinct Name FROM Disciplines 
INNER JOIN Uplans ON Disciplines.NumDisc=Uplans.NumDisc 
INNER JOIN Balls ON Uplans.IdDisc=Balls.IdDisc;
GO

SELECT * FROM Disciplines_with_balls;


