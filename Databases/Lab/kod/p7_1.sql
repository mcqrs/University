USE Session
GO

CREATE PROCEDURE Delete_Students_Complete
AS
INSERT INTO ArchiveStudents 
SELECT YEAR(GETDATE()), NumSt, FIO, NumGroup  
FROM Students  
WHERE LEFT(NumGroup,1)=6;
DELETE FROM Students 
WHERE LEFT(NumGroup,1)=6;
GO
