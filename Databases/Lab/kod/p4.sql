CREATE PROCEDURE Enter_Students (@Fio AS VARCHAR(30), @Group AS VARCHAR(10))  AS
INSERT INTO Students (FIO, NumGroup) 
VALUES (@Fio, @Group);
GO

USE Session
GO

DECLARE @Stud VARCHAR(30), @Group varchar(10);
SET @Stud='Светлова Вероника';
SET @Group ='53504/3';
EXEC Enter_Students  @Stud, @Group;

DECLARE @Stud VARCHAR(30), @Group varchar(10);
SET @Stud='Новая Наталья';
SET @Group ='53504/3';
EXEC Enter_Students  @Stud, @Group;