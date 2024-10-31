/*Создание БД*/
USE master
Go
CREATE DATABASE Fclub ON
(Name= Session, 
FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ Fclub.mdf'
) 
LOG ON 
(Name= Fclub_log, 
FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ Fclub_log.ldf'
) 
Go

/*Авторасширение БД*/
ALTER DATABASE Fclub SET AUTO_SHRINK ON
ALTER DATABASE Fclub SET RECOVERY SIMPLE

