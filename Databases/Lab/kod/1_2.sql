USE Session
GO

--2
CREATE VIEW Students_top_and_last1 (Fio, Complete)
AS (SELECT A.Stud, 'NO' 
	FROM (SELECT NumSt AS Stud  FROM Students 
	EXCEPT Select Distinct NumSt AS Stud FROM Balls)
	AS A)
UNION
 (SELECT NumSt, 'Five'  
  FROM Balls 
  WHERE Ball=5);
GO

SELECT * FROM Students_top_and_last;