USE Fclub
GO

CREATE TABLE ������
(IDClient  int NOT NULL,
������� nvarchar(20) NOT NULL,
��� nvarchar(20) NOT NULL,
�������� nvarchar(20) NOT NULL,
������� char(16) NOT NULL,
���_���������� nvarchar(20) NOT NULL,
IDPass int NOT NULL
)
GO


ALTER TABLE ������
ADD
PRIMARY KEY (IDClient)
GO


CREATE TABLE ������������
(IDEquipment int NOT NULL,
�������� nvarchar(30) NOT NULL,
)
GO

ALTER TABLE ������������
ADD
PRIMARY KEY (IDEquipment)
GO

CREATE TABLE ���������
(IDStuff int NOT NULL,
������� nvarchar(20) NOT NULL,
��� nvarchar(20) NOT NULL,
�������� nvarchar(20),
��������� nvarchar(20) NOT NULL,
�������� money,
������� char(16),
���� date DEFAULT GETDATE(),
IDTraining int 
)
GO

ALTER TABLE ���������
ADD
PRIMARY KEY (IDStuff)
GO

CREATE TABLE �������
(IDPass int NOT NULL,
����_��������� date DEFAULT GETDATE(),
����_����������� date DEFAULT GETDATE()
)
GO

ALTER TABLE �������
ADD
PRIMARY KEY (IDPass)
GO

CREATE TABLE ����������
(IDTraining int NOT NULL,
IDEquipment int NOT NULL,
�������� nvarchar(20) NOT NULL,
����� nvarchar(20) NOT NULL
)
GO

ALTER TABLE ����������
ADD
PRIMARY KEY (IDTraining)
GO