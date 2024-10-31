USE Session; 
CREATE TABLE Groups
(IdGroup int IDENTITY(1,1) PRIMARY KEY,
 IdSt int,
 Quantity int CHECK (Quantity BETWEEN 0 AND 20))
go
CREATE TABLE Students
(IdSt int IDENTITY (1,1) PRIMARY KEY,
 FIO varchar(50),
 NumPhone int,
 IdGroup int FOREIGN KEY REFERENCES Groups
 ON DELETE SET NULL
 ON UPDATE CASCADE)
 Go
