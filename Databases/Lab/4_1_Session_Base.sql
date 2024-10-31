USE master
Go
CREATE DATABASE Session ON
(Name= Session, 
FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ Session.mdf'
) 
LOG ON 
(Name= Session_log, 
FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ Session_log.ldf'
) 
Go

EXEC SP_HELPDB Session
Go

ALTER DATABASE Session SET AUTO_SHRINK ON

ALTER DATABASE Session SET RECOVERY SIMPLE

ALTER DATABASE Session
 MODIFY FILE (name=Session, maxsize=100MB)
 go
 EXEC SP_HELPDB Session
 Go

