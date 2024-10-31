USE Fclub
CREATE TABLE Пропуск
( IDPass int NOT NULL PRIMARY KEY,
  Дата_активации date DEFAULT GETDATE(),
  Дата_деактивации date NOT NULL,
  IDClient int NOT NULL /*Для нахождения клиента при потери пропуска*/
)
GO