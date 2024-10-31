/*Создание таблицы*/
USE Fclub
CREATE TABLE Клиент
(IDClient  int NOT NULL PRIMARY KEY,
Фамилия nvarchar(20) NOT NULL,
Имя nvarchar(20) NOT NULL,
Отчество nvarchar(20) NULL,
Телефон char(12) NOT NULL,
IDPass int NOT NULL
)
GO
