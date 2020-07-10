USE [p6g4]
GO

--- STORED PROCEDURES ----- 

-- Guardar as alteraçoes do email de qualquer staff
Go
Create PROCEDURE [fisioterapia].ALTMAIL(@nif int,
										@mail varchar(30)
										)
AS
BEGIN
	BEGIN  
        UPDATE [fisioterapia].Pessoa
			SET   mail  =@mail  
        WHERE nif = @nif 
    END  
	
END
Go

SELECT * FROM [fisioterapia].Pessoa;
[fisioterapia].ALTMAIL 876598675, 'tresemes@gmail.com'
-- DROP PROCEDURE [fisioterapia].ALTMAIL

-- ALTERAR ORIENTADORES ENCARREGUES DE ESTAGIARIOS
Go
Create PROCEDURE [fisioterapia].ALTORIEST(@nifest int,
										@nif_ori int
										)
AS
BEGIN
	BEGIN  
        UPDATE [fisioterapia].Estagiario
			SET nif = @nifest,
				nif_ori = @nif_ori
			WHERE nif=@nifest 
	END
END
GO
SELECT * FROM [fisioterapia].Orientador;
SELECT * FROM [fisioterapia].Estagiario;
[fisioterapia].ALTORIEST 342524356, 234527643
-- DROP PROCEDURE [fisioterapia].ALTORIEST

-- ENVIAR EMAIL
Go
Create PROCEDURE [fisioterapia].MAILSEND(@nif_pessoa int,
										@sender_mail varchar(30),
										@texto varchar(100)
										)
AS
BEGIN
	BEGIN
		INSERT INTO [fisioterapia].Mensagem (nif_pessoa, timestamp, sender_mail, texto)
									VALUES  (@nif_pessoa,CURRENT_TIMESTAMP, @sender_mail, @texto)
	END
END
GO


[fisioterapia].MAILSEND nif, sender_mail, texto
-- DROP PROCEDURE [fisioterapia].MAILSEND


-- alteraçao do estagiario encarregue de um paciente
Go
Create PROCEDURE [fisioterapia].ALTESTPACI(@nifpac int,
										@nifest int
										)
AS
BEGIN
	BEGIN  
		UPDATE [fisioterapia].Sessao
		SET nif_est = (SELECT nif_est =@nifest
							FROM [fisioterapia].Sessao JOIN [fisioterapia].Plano ON [fisioterapia].Sessao.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Paciente ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Pessoa ON [fisioterapia].Pessoa.nif=[fisioterapia].Paciente.nif 
							)
        
		WHERE @nifpac = (SELECT [fisioterapia].Pessoa.nif
							FROM [fisioterapia].Sessao JOIN [fisioterapia].Plano ON [fisioterapia].Sessao.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Paciente ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
														JOIN [fisioterapia].Pessoa ON [fisioterapia].Pessoa.nif=[fisioterapia].Paciente.nif )
	END
END
GO 
SELECT * FROM [fisioterapia].Orientador;
SELECT * FROM [fisioterapia].Sessao;
[fisioterapia].ALTESTPACI 333344444, 342524356
-- DROP PROCEDURE [fisioterapia].ALTESTPACI
