/*�������� �������*/
USE Fclub
CREATE TABLE ���������
(IDStuffer int NOT NULL PRIMARY KEY,
������� nvarchar(20) NOT NULL,
��� nvarchar(20) NOT NULL,
�������� nvarchar(20) NULL,
��������� nvarchar(20) NOT NULL,
�������� money NOT NULL,
������� char(16) NOT NULL,
���� date DEFAULT GETDATE()
)
GO

/*���������� �������*/
INSERT ���������
(IDStuffer,�������,���,��������,���������,��������,�������)
VALUES
('01','������','����','����������','������������','40000','+7(900)626-33-83'),
('02','������','���������','����������','�����������','70000','+7(952)318-35-28'),
('03','�������','������','������������','�������� �� ��������','40000','+7(981)744-22-34'),
('04','�������','������','����������','������','50000','+7(931)456-21-89'),
('05','���������','����','����������','�������������','40000','+7(921)904-20-15'),
('06','�����','�����','��������','������','50000','+7(951)389-79-42'),
('07','������','��������','�������������','������','50000','+7(904)849-28-85'),
('08','������','������','��������','������','50000','+7(952)628-33-19'),
('09','������','��������','�����������','������','50000','+7(981)255-40-62'),
('10','��������','�������','���������','������','50000','+7(981)105-24-18');
GO
