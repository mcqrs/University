USE Fclub
CREATE TABLE �������
( IDPass int NOT NULL PRIMARY KEY,
  ����_��������� date DEFAULT GETDATE(),
  ����_����������� date NOT NULL,
  IDClient int NOT NULL /*��� ���������� ������� ��� ������ ��������*/
)
GO