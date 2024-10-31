CREATE PROCEDURE Next_Course (@Group AS VARCHAR(10)='13504/1')
AS
UPDATE Students 
SET NumGroup=CONVERT(char(1),CONVERT(int, LEFT(NumGroup,1))+1)+ SUBSTRING(NumGroup,2,LEN(NumGroup)-1)
 WHERE NumGroup=@Group;
GO

USE Session
GO

DECLARE @Group VARCHAR(10);
 SET @Group='13504/3';
 EXEC Next_Course @Group;
 GO