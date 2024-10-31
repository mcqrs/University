USE Fclub
GO

CREATE TABLE Клиент
(IDClient  int NOT NULL,
Фамилия nvarchar(20) NOT NULL,
Имя nvarchar(20) NOT NULL,
Отчество nvarchar(20) NOT NULL,
Телефон char(16) NOT NULL,
Вид_тренировки nvarchar(20) NOT NULL,
IDPass int NOT NULL
)
GO


ALTER TABLE Клиент
ADD
PRIMARY KEY (IDClient)
GO


CREATE TABLE Оборудование
(IDEquipment int NOT NULL,
Название nvarchar(30) NOT NULL,
)
GO

ALTER TABLE Оборудование
ADD
PRIMARY KEY (IDEquipment)
GO

CREATE TABLE Сотрудник
(IDStuff int NOT NULL,
Фамилия nvarchar(20) NOT NULL,
Имя nvarchar(20) NOT NULL,
Отчество nvarchar(20),
Должность nvarchar(20) NOT NULL,
Зарплата money,
Телефон char(16),
Дата date DEFAULT GETDATE(),
IDTraining int 
)
GO

ALTER TABLE Сотрудник
ADD
PRIMARY KEY (IDStuff)
GO

CREATE TABLE Пропуск
(IDPass int NOT NULL,
Дата_активации date DEFAULT GETDATE(),
Дата_деактивации date DEFAULT GETDATE()
)
GO

ALTER TABLE Пропуск
ADD
PRIMARY KEY (IDPass)
GO

CREATE TABLE Тренировка
(IDTraining int NOT NULL,
IDEquipment int NOT NULL,
Название nvarchar(20) NOT NULL,
Время nvarchar(20) NOT NULL
)
GO

ALTER TABLE Тренировка
ADD
PRIMARY KEY (IDTraining)
GO