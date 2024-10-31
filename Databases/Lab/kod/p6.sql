CREATE PROCEDURE Number_Groups (@Dir AS int, @Number AS int OUTPUT)
AS
SELECT @Number =COUNT(NumGroup) 
FROM Groups 
WHERE NumDir=@Dir;
GO

USE Session
GO

DECLARE @Group int;
EXEC Number_Groups 230100, @Group OUTPUT;
SELECT @Group;
 GO