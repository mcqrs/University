CREATE PROCEDURE Recovery_Students_Complete
AS
INSERT Students 
SELECT NumSt, FIO, NumGroup  
FROM ArchiveStudents   
WHERE LEFT(NumGroup,1)=6;
DELETE FROM ArchiveStudents 
WHERE LEFT(NumGroup,1)=6;
GO