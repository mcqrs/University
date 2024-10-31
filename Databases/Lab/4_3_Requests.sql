USE Session
GO

--3.1
SELECT DISTINCT Title
FROM Directions
JOIN Uplans ON
Directions.NumDir = Uplans.NumDir
JOIN Balls ON
Uplans.IdDisc = Balls.IdDisc
GO

--3.2
SELECT DISTINCT Name
FROM Disciplines
INNER JOIN Uplans ON
Disciplines.NumDisc=Uplans.NumDisc
WHERE Uplans.Semestr=1
GO

--3.3
SELECT DISTINCT NumGroup
FROM Students
INNER JOIN Balls ON
Students.NumSt = Balls.NumSt
GO

--3.4
SELECT  Name, Balls.NumSt
FROM Disciplines
JOIN Uplans ON
Disciplines.NumDisc=Uplans.NumDisc
JOIN Balls ON
Uplans.IdDisc=Balls.IdDisc
GO

--3.5
SELECT Groups.NumGroup
FROM Groups
	INNER JOIN Students ON Students.NumGroup = Groups.NumGroup
	GROUP BY Students.NumGroup, Groups.Quantity, Groups.NumGroup
	HAVING COUNT(Students.NumSt) < Groups.Quantity
GO

--3.6
SELECT Groups.NumGroup
FROM
(
	(
		SELECT Students.NumGroup
		FROM Students
		JOIN Balls ON Balls.NumSt = Students.NumSt
		GROUP BY Students.NumGroup, Balls.NumSt
		HAVING COUNT(Balls.NumSt) > 1
	)
	UNION
	(
		SELECT Students.NumGroup
		FROM Students 
		EXCEPT  
		SELECT Students.NumGroup
		FROM Balls 
		JOIN Students ON Students.NumSt = Balls.NumSt
	)
) AS Groups
GO

--3.7
SELECT Name 
FROM
(
		(
			SELECT Uplans.NumDisc 
			FROM Uplans
			WHERE Uplans.Semestr = '1'
        )
        INTERSECT
        (
			SELECT Uplans.NumDisc
			FROM Uplans
			WHERE Uplans.Semestr = '2'
		)
) AS GroupsN 
JOIN Disciplines ON GroupsN.NumDisc = Disciplines.NumDisc
GO

--3.8 
SELECT DISTINCT Disciplines.Name
FROM Disciplines 
	JOIN Uplans ON Disciplines.NumDisc = Uplans.NumDisc 
		WHERE Uplans.Semestr < '2' AND Uplans.NumDisc != '4'
GO

--3.9 
SELECT DISTINCT Balls.Ball, Balls.NumSt, Students.Fio, Students.NumGroup
FROM Balls 
	RIGHT JOIN Students ON Students.NumSt = Balls.NumSt;
GO

--3.10 изменить
(SELECT DISTINCT Students.FIO, Balls.Ball
FROM Balls
	 RIGHT JOIN Students ON Students.NumSt = Balls.NumSt
	 GROUP BY Students.Fio
)
 UNION 
(SELECT DISTINCT Students.FIO
FROM Students
	 JOIN Balls ON Balls.NumSt = Students.NumSt
	 JOIN Uplans ON Uplans.IdDisc = Balls.IdDisc 
	 JOIN Disciplines ON Disciplines.NumDisc = Uplans.NumDisc
	 WHERE Balls.Ball = '4' AND Disciplines.Name = 'Электроника'
	 GROUP BY Students.Fio)
GO



--4.1
SELECT Students.FIO
FROM Students
JOIN Balls ON Students.NumSt = Balls.NumSt
GROUP BY Students.FIO
HAVING COUNT(*) = 1
GO

--4.2
SELECT FIO
FROM Students
LEFT OUTER JOIN Balls
ON Balls.NumSt = Students.NumSt
WHERE Ball IS NULL
GO

--4.3 Выберите группы, в которых есть студенты, сдавшие все экзамены 1 семестра
SELECT NumGroup FROM 
   (SELECT NumGroup,
	COUNT(NumDisc) AS ExQuantity
	FROM Students
	JOIN Balls ON Students.NumSt = Balls.NumSt
	JOIN Uplans ON Uplans.IdDisc = Balls.IdDisc
	WHERE Semestr = 1
	GROUP BY NumGroup) 
AS AllEx
WHERE AllEx.ExQuantity = (SELECT COUNT(DISTINCT NumDisc)
					  FROM uplans
					  WHERE semestr = 1)
GO

--4.4
SELECT DISTINCT NumGroup
FROM Students
LEFT OUTER JOIN Balls ON Students.NumSt = Balls.NumSt
WHERE Ball IS NULL
GO

--4.5
SELECT NumDisc FROM Disciplines
WHERE NOT EXISTS
(
	SELECT NumDisc
	FROM Uplans
	WHERE NumDir = 231000 AND NumDisc = Disciplines.NumDisc
)
GO

--4.6
SELECT Disciplines.Name 
FROM Disciplines 
	WHERE NOT EXISTS 
	(
		SELECT DISTINCT Uplans.NumDisc 
		FROM Uplans 
		JOIN Balls ON Uplans.IdDisc = Balls.IdDisc
		WHERE Uplans.NumDisc = Disciplines.NumDisc AND Uplans.NumDir = '231000'
	)
GO

--4.7
/*SELECT NumGroup FROM Groups 
WHERE NOT EXISTS
(
	SELECT * FROM Students AS s WHERE s.NumGroup=Groups.NumGroup
	EXCEPT
	SELECT * FROM Students
	WHERE EXISTS 
	(
		SELECT * FROM Balls
		WHERE IdDisc=
		(
			SELECT NumDisc
			FROM Disciplines 
			WHERE Name='Физика'
		)
		AND Students.NumSt=Balls.NumSt
	)
)
GO*/

SELECT Students.NumGroup FROM Students
EXCEPT
(SELECT Groups.NumGroup FROM Groups 
 JOIN Students ON Groups.NumGroup=Students.NumGroup
 WHERE NOT EXISTS (SELECT DISTINCT * FROM Balls WHERE Students.NumSt=Balls.NumSt
				   AND EXISTS (SELECT * FROM Disciplines 
							   JOIN Uplans ON Disciplines.NumDisc=Uplans.NumDisc
                               WHERE NAME='Физика' AND Uplans.NumDir=Groups.NumDir
				              )
				  )
)
GO

SELECT Groups.NumGroup
FROM(
	SELECT Groups.NumGroup
	FROM Students
		JOIN Balls ON Balls.NumSt = Students.NumSt
		JOIN Uplans ON Uplans.IdDisc = Balls.IdDisc
		JOIN Disciplines ON Disciplines.NumDisc = Uplans.NumDisc
		JOIN Groups ON Groups.NumGroup = Students.NumGroup
		WHERE Disciplines.Name = 'Физика'
	GROUP BY Groups.NumGroup, Groups.Quantity
	HAVING COUNT(Balls.NumSt) = Groups.Quantity)
	AS Groups
GO


--4.8
SELECT DISTINCT Students.NumGroup 
FROM Students, Balls, Groups
	WHERE Students.NumSt = Balls.NumSt 
	AND EXISTS 
	(
		SELECT DISTINCT Balls.IdDisc 
		FROM Uplans 
		WHERE Balls.IdDisc = Uplans.IdDisc AND Students.NumSt = Balls.NumSt AND Uplans.Semestr = 1
	)
	AND Groups.NumGroup = Students.NumGroup
GROUP BY Students.NumGroup, Groups.Quantity
HAVING (Groups.Quantity - COUNT(Students.NumGroup) = 0)
GO

--4.9
SELECT DISTINCT Students.Fio 
FROM Students 
	JOIN Balls ON Students.NumSt = Balls.NumSt
		WHERE Balls.Ball NOT IN (SELECT MIN(Balls.Ball) FROM Balls)
GO

--4.10
SELECT Students.Fio 
FROM Students
	JOIN Balls ON Students.NumSt = Balls.NumSt
GROUP BY Students.Fio
HAVING COUNT(Balls.Ball) = (
	SELECT MAX(mark) 
	FROM (
		SELECT COUNT(Balls.Ball) AS mark, Students.FIO 
		FROM Students
			JOIN Balls ON Balls.NumSt = Students.NumSt
		GROUP BY Students.FIO
	) AS Student_Fio
)
GO
