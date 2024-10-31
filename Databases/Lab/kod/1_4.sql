USE Session;
GO

--4
CREATE VIEW Students_complete_2 AS 
	SELECT Students.NumSt 
	FROM Students JOIN Groups ON Groups.NumGroup = Students.NumGroup 
	WHERE NOT EXISTS (SELECT * FROM Uplans  
					  WHERE (Semestr=CONVERT(int, LEFT(Students.NumGroup,1))*2-1 OR 
					  Semestr=CONVERT(int, LEFT(Students.NumGroup,1))*2) AND 
		              Groups.NumDir=Uplans.NumDir AND NOT EXISTS (SELECT * FROM Balls
 																  WHERE Balls.IdDisc=Uplans.IdDisc and Students.NumSt=Balls.NumSt));
GO

SELECT * FROM Students_complete_2;
