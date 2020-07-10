USE [p6g4]
GO

-----  TRIGGERS ------

--- TRIGGER DE BACKUP DE TODA INFORMACAO SOBRE PESSOAS
Go
CREATE TRIGGER BACKUP_PESSOA ON [fisioterapia].Pessoa INSTEAD OF DELETE AS
BEGIN
	IF  NOT (EXISTS (
				SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'fisioterapia' AND TABLE_NAME = 'PESSOA_BACKUP'))
				CREATE TABLE [fisioterapia].PESSOA_BACKUP (
														nif INT NOT NULL,
														nome INT NOT NULL,
														mail VARCHAR(50) NOT NULL,
														sexo char NOT NULL,
														data_nasc date NOT NULL)
	INSERT INTO [fisioterapia].PESSOA_BACKUP SELECT * FROM DELETED
	Delete FROM [fisioterapia].Pessoa Where [fisioterapia].Pessoa.nif=( SELECT nif FROM DELETED)
END
Go
