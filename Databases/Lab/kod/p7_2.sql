CREATE PROCEDURE Next_Course_2 
AS
EXEC Delete_Students_Complete;
UPDATE Students 
SET NumGroup=CONVERT(char(1),CONVERT(int, LEFT(NumGroup,1))+1)+ SUBSTRING(NumGroup,2,LEN(NumGroup)-1)
WHERE NumSt IN (SELECT NumSt FROM Students_complete_2);
GO

EXEC Next_Course_2;
GO
