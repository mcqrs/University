USE Session
GO

CREATE PROCEDURE Count_Students AS
SELECT COUNT(*) FROM Students
 
EXEC Count_Students
