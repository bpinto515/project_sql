USE [p6g4]
GO

--- UDFS ---
-- Obter Horario de Orientador
GO
CREATE FUNCTION [fisioterapia].UDF_HORAORIEN()
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				horario AS HORASRIO
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif= [fisioterapia].Orientador.nif
		)
GO

SELECT * FROM [fisioterapia].UDF_HORAORIEN();
DROP FUNCTION [fisioterapia].UDF_HORAORIEN;

-- Obter Horario de Estagiario
GO
CREATE FUNCTION [fisioterapia].UDF_HORAEST()
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				horario_est AS HORARIO
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif= [fisioterapia].Estagiario.nif
		)
GO


SELECT * FROM [fisioterapia].UDF_HORAEST();
DROP FUNCTION [fisioterapia].UDF_HORAEST;



-- Obter Horario de Orientador/Estagiario FALTA REMOVER OS TUPLOS COM OS DOIS PARAMETROS NULL 
GO
CREATE FUNCTION [fisioterapia].UDF_HORAESTORI()
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				horario AS HORARIOORI,
				horario_est AS HORARIOEST
		FROM [fisioterapia].Pessoa  JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									FULL JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif= [fisioterapia].Estagiario.nif
									 FULL JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif= [fisioterapia].Orientador.nif
		)				
GO

SELECT * FROM [fisioterapia].UDF_HORAESTORI();
DROP FUNCTION [fisioterapia].UDF_HORAESTORI;

-- Obter perfil de Pessoa
Go
CREATE FUNCTION [fisioterapia].UDF_PESSOA()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			nif AS NIF,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
	FROM [fisioterapia].Pessoa
)
Go

SELECT * FROM [fisioterapia].UDF_PESSOA();
DROP FUNCTION [fisioterapia].UDF_PESSOA;


-- TODO O STAFF 
Go
CREATE FUNCTION [fisioterapia].UDF_TodoStaff()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			[fisioterapia].Staff.nif AS NIF
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
)
Go

DROP FUNCTION [fisioterapia].UDF_TodoStaff


-- PROCURAR PESSOA NO STAFF POR NIF
GO
CREATE FUNCTION [fisioterapia].UDF_PesquisaSTAFFnif(@nif int)
RETURNS TABLE AS
RETURN(
	SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
	WHERE [fisioterapia].Staff.nif LIKE @nif
)
GO
SELECT * FROM [fisioterapia].UDF_PesquisaSTAFFnif(nif)
--DROP FUNCTION [fisioterapia].UDF_PesquisaSTAFFnif

-- PROCURAR PESSOA NO STAFF POR NOME
GO
CREATE FUNCTION [fisioterapia].UDF_PesquisaSTAFFnome(@nome varchar(30))
RETURNS TABLE AS
RETURN(
	SELECT	nome AS Nome,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
	WHERE [fisioterapia].Pessoa.nome LIKE @nome
)
GO


--DROP FUNCTION [fisioterapia].UDF_PesquisaSTAFFnif

-- TODOS ESTAGIARIOS
Go
CREATE FUNCTION [fisioterapia].UDF_TodoEstag()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			[fisioterapia].Estagiario.nif AS NIF,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			horario_est AS Horario
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
							JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif
)
Go

SELECT * FROM [fisioterapia].UDF_TodoEstag();
-- DROP FUNCTION [fisioterapia].UDF_TodoEstag

-- TODODS ORIENTADORES
Go
CREATE FUNCTION [fisioterapia].UDF_TodoORI()
RETURNS Table AS
RETURN (
	SELECT	nome AS Nome,
			[fisioterapia].Orientador.nif AS NIF,
			mail AS E_Mail,
			sexo AS SEXO,
			data_nasc AS Data_de_Nascimento,
			horario AS Horario
	FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
							JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif=[fisioterapia].Orientador.nif
)
Go

SELECT * FROM [fisioterapia].UDF_TodoORI();
--DROP FUNCTION [fisioterapia].UDF_TodoORI

-- ORIENTADORES ENCARREGUES DE ESTAGIARIOS (param entrada nif orientador
Go
CREATE FUNCTION [fisioterapia].UDF_ORIENCEST(@nif int)
RETURNS Table AS
RETURN (
		SELECT
				t2.nome AS NOMEEst,
				t2.NIFEST AS NIF,
				t2.mail AS MAIL,
				t2.sexo AS SEXO,
				t2.data_nasc AS DATANASC

		FROM (SELECT nome,
				[fisioterapia].Orientador.nif AS NIFORI
					FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Pessoa.nif=[fisioterapia].Orientador.nif) t1
			JOIN 
				(SELECT nome, 
						nif_ori,
						mail,
						sexo,
						data_nasc,
					[fisioterapia].Estagiario.nif AS NIFEST
						FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Pessoa.nif=[fisioterapia].Estagiario.nif) t2
					ON t1.NIFORI=t2.nif_ori
			WHERE @nif = NIFORI
					 
)
Go

SELECT * FROM [fisioterapia].UDF_ORIENCEST(436256456);
--DROP FUNCTION [fisioterapia].UDF_ORIENCEST

-- ORIENTADORES ENCARREGUES DE ESTAGIARIOS (param de entrada , nif est
Go
CREATE FUNCTION [fisioterapia].UDF_ORIEST(@nif int)
RETURNS Table AS
RETURN (
		SELECT
				t1.nome AS NOMEORI,
				t1.NIFORI AS NIF

		FROM (SELECT nome,
				[fisioterapia].Orientador.nif AS NIFORI
					FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Pessoa.nif=[fisioterapia].Orientador.nif) t1
			JOIN 
				(SELECT nome, 
						nif_ori,
					[fisioterapia].Estagiario.nif AS NIFEST
						FROM [fisioterapia].Pessoa JOIN [fisioterapia].Staff ON [fisioterapia].Pessoa.nif=[fisioterapia].Staff.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Pessoa.nif=[fisioterapia].Estagiario.nif) t2
					ON t1.NIFORI=t2.nif_ori
			WHERE @nif = NIFEST
					 
)
Go

SELECT * FROM [fisioterapia].UDF_ORIEST(840384724);
--DROP FUNCTION [fisioterapia].UDF_ORIENCEST

-- Obter Perfil de Paciente (N processo, condiçao, peso, plano, altura descriçao, Tratamento/Notas)
GO
CREATE FUNCTION [fisioterapia].UDF_PERFILPAC(@nif int)
RETURNS TABLE AS
RETURN (
		SELECT nome AS NOME,
				 [fisioterapia].Paciente.nif AS NIF,
				 n_processo AS N_PROCESSO,
				 [fisioterapia].Paciente.descricao AS DESCRICAO,
				 altura AS ALTURA,
				 peso AS PESO,
				 condicao AS CONDICAO,
				 n_sessoes AS N_SESSOES,
				 n_total_sess AS N_TOTAL_SESS,
				 [fisioterapia].Paciente.id_plano AS PLANO,
				 t2.titulo AS TRATAMENTO,
				 t2.descricao AS DESCTRAT
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Paciente ON [fisioterapia].Pessoa.nif=[fisioterapia].Paciente.nif
									JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
									JOIN (SELECT  id_plano,id_trata, titulo, descricao
											FROM [fisioterapia].Sessao JOIN [fisioterapia].Possui ON [fisioterapia].Sessao.id=[fisioterapia].Possui.id_sess
																		JOIN [fisioterapia].Tratamento ON [fisioterapia].Possui.id_sess=[fisioterapia].Tratamento.id) t2 
																		ON [fisioterapia].Plano.id=t2.id_plano
					where @nif = [fisioterapia].Paciente.nif
		)
GO

	
SELECT * FROM [fisioterapia].UDF_PERFILPAC(333344444);
--DROP FUNCTION [fisioterapia].UDF_PERFILPAC;


-- Obter Mensagens de Staff
GO
CREATE FUNCTION [fisioterapia].UDF_MENSNIF(@nif int)
RETURNS TABLE AS
RETURN (
		SELECT nome AS RECEIVER,
				timestamp AS TIME_DATE,
				sender_mail AS SENT_BY,
				texto AS MENSAGEM
		FROM [fisioterapia].Pessoa JOIN [fisioterapia].Mensagem ON [fisioterapia].Pessoa.nif=[fisioterapia].Mensagem.nif_pessoa
									JOIN [fisioterapia].Staff ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
		WHERE @nif=nif_pessoa
		)
GO
SELECT * FROM [fisioterapia].Mensagem
SELECT * FROM [fisioterapia].UDF_MENSNIF(435324543);
-- DROP FUNCTION [fisioterapia].UDF_MENSNIF;

-- LOGIN- ORIENTADOR
GO
CREATE FUNCTION [fisioterapia].UDF_LOGINORI(@nif int, @password varchar(15))
RETURNS varchar(20)
AS
BEGIN
	Declare @tipo varchar(20);
	IF( EXISTS (SELECT [fisioterapia].Orientador.nif, password
				FROM [fisioterapia].Staff JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif=[fisioterapia].Orientador.nif
				WHERE @nif = [fisioterapia].Orientador.nif AND  @password= password))		
		BEGIN
			SET @tipo ='Orientador'
		END
	ELSE
		BEGIN
			SET @tipo ='Nada'
		END
	RETURN @tipo;
END
GO

SELECT [fisioterapia].UDF_LOGINORI(435324543,'paaforte') tipo;
-- DROP FUNCTION [fisioterapia].UDF_LOGINORI;

-- LOGIN- COORDENADOR
GO
CREATE FUNCTION [fisioterapia].UDF_LOGINCOOR(@nif int, @password varchar(15))
RETURNS varchar(20)
AS
BEGIN
	Declare @tipo varchar(20)
	IF( EXISTS (SELECT [fisioterapia].Coordenador.nif, password
				FROM [fisioterapia].Staff JOIN [fisioterapia].Coordenador ON [fisioterapia].Staff.nif=[fisioterapia].Coordenador.nif
				WHERE @nif = [fisioterapia].Coordenador.nif AND  @password= password))		
		BEGIN
			SET @tipo ='Coordenador'
		END
	ELSE
		BEGIN
			SET @tipo ='Nada'
		END
	RETURN @tipo;
END
GO

SELECT [fisioterapia].UDF_LOGINCOOR(345612345,'piorpass') tipo;
-- DROP FUNCTION [fisioterapia].UDF_LOGINCOOR;

-- LOGIN- ESTAGIARIO
GO
CREATE FUNCTION [fisioterapia].UDF_LOGINEST(@nif int, @password varchar(15))
RETURNS varchar(20)
AS
BEGIN
	Declare @tipo varchar(20)
	IF( EXISTS (SELECT [fisioterapia].Estagiario.nif, password
				FROM [fisioterapia].Staff JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif
				WHERE @nif = [fisioterapia].Estagiario.nif AND  @password= password))		
		BEGIN
			SET @tipo ='Estagiario'
		END
	ELSE
		BEGIN
			SET @tipo ='Nada'
		END
	RETURN @tipo;
END
GO

SELECT [fisioterapia].UDF_LOGINEST(840384724,'olaola123') tipo;
-- DROP FUNCTION [fisioterapia].UDF_LOGINEST;

-- ESTAGIARIOS ENCARREGUES DE PACIENTES (com o nif do estagiario obter os pacicentes)
Go
CREATE FUNCTION [fisioterapia].UDF_ESTENCPACI(@nif int)
RETURNS Table AS
RETURN (
		SELECT	t1.nome AS NOMEPAC,
				t1.NIFPAC AS NIF,
				t1.mail AS MAIL,
				t1.sexo AS SEXO,
				t1.data_nasc AS DATANASC
			FROM 
			(SELECT nome AS NOME,
					mail, sexo, data_nasc,
				[fisioterapia].Plano.id AS ID,
				[fisioterapia].Sessao.id_plano,
				[fisioterapia].Sessao.nif_est AS SESSNIFEST,
				[fisioterapia].Paciente.nif AS NIFPAC
			FROM [fisioterapia].Paciente JOIN [fisioterapia].Pessoa ON [fisioterapia].Paciente.nif=[fisioterapia].Pessoa.nif
										JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
										JOIN [fisioterapia].Sessao ON [fisioterapia].Plano.id=[fisioterapia].Sessao.id_plano) t1
			JOIN
			(SELECT nome AS NOME,
					[fisioterapia].Estagiario.nif AS ESTNIF
			FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif) t2
									ON t1.SESSNIFEST=t2.ESTNIF
			WHERE @nif = ESTNIF
			)
Go
SELECT * FROM [fisioterapia].UDF_ESTENCPACI(489347234);
--DROP FUNCTION [fisioterapia].UDF_ESTENCPACI

-- ORIENTADORES ENCARREGUES DE PACIENTES 
Go
CREATE FUNCTION [fisioterapia].UDF_ORIENCPACI(@nif int)
RETURNS Table AS
RETURN (
		SELECT	t1.nome AS NOMEPAC,
				t1.NIFPAC AS NIF,
				t1.mail AS MAIL,
				t1.sexo AS SEXO,
				t1.data_nasc AS DATANASC
			FROM 
			(SELECT nome,
					mail,
					sexo,
					data_nasc,
				[fisioterapia].Plano.id AS ID,
				[fisioterapia].Sessao.id_plano,
				[fisioterapia].Sessao.nif_orient AS SESSNIFORI,
				[fisioterapia].Paciente.nif AS NIFPAC
				
			FROM [fisioterapia].Paciente JOIN [fisioterapia].Pessoa ON [fisioterapia].Paciente.nif=[fisioterapia].Pessoa.nif
										JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
										JOIN [fisioterapia].Sessao ON [fisioterapia].Plano.id=[fisioterapia].Sessao.id_plano) t1
			JOIN
			(SELECT nome AS NOME,
					[fisioterapia].Orientador.nif AS ORINIF
			FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Orientador ON [fisioterapia].Staff.nif=[fisioterapia].Orientador.nif) t2
									ON t1.SESSNIFORI=t2.ORINIF
			WHERE @nif = ORINIF
			)
Go
SELECT * FROM [fisioterapia].UDF_ORIENCPACI(436256456);
--DROP FUNCTION [fisioterapia].UDF_ORIENCPACI

-- ESTAGIARIOS ENCARREGUES DE PACIENTES (com nif de paciente obter estagiario)
Go
CREATE FUNCTION [fisioterapia].UDF_ESTPAC(@nif int)
RETURNS Table AS
RETURN (
		SELECT	t2.NOME AS NOMEPAC,
				t2.ESTNIF AS NIF
			FROM 
			(SELECT nome AS NOME,
				[fisioterapia].Plano.id AS ID,
				[fisioterapia].Sessao.id_plano,
				[fisioterapia].Sessao.nif_est AS SESSNIFEST,
				[fisioterapia].Paciente.nif AS NIFPAC
			FROM [fisioterapia].Paciente JOIN [fisioterapia].Pessoa ON [fisioterapia].Paciente.nif=[fisioterapia].Pessoa.nif
										JOIN [fisioterapia].Plano ON [fisioterapia].Paciente.id_plano=[fisioterapia].Plano.id
										JOIN [fisioterapia].Sessao ON [fisioterapia].Plano.id=[fisioterapia].Sessao.id_plano) t1
			JOIN
			(SELECT nome AS NOME,
					[fisioterapia].Estagiario.nif AS ESTNIF
			FROM [fisioterapia].Staff JOIN [fisioterapia].Pessoa ON [fisioterapia].Staff.nif=[fisioterapia].Pessoa.nif
									JOIN [fisioterapia].Estagiario ON [fisioterapia].Staff.nif=[fisioterapia].Estagiario.nif) t2
									ON t1.SESSNIFEST=t2.ESTNIF
			WHERE @nif = NIFPAC
			)
Go
SELECT * FROM [fisioterapia].UDF_ESTPAC(840384724);
--DROP FUNCTION [fisioterapia].UDF_ESTPAC

-- VER HORARIO DE ESTAGIARIO 
GO
CREATE FUNCTION [fisioterapia].UDF_ESTHOR(@nif int)
RETURNS Table AS
RETURN (
		SELECT horario_est AS HORARIO
		FROM [fisioterapia].Estagiario
		WHERE nif=@nif
		)
GO

SELECT * FROM [fisioterapia].UDF_ESTHOR(840384724)
-- DROP FUNCTION [fisioterapia].UDF_ESTHOR

-- VER HORARIO DE ORIENTADOR
GO
CREATE FUNCTION [fisioterapia].UDF_ORIHOR(@nif int)
RETURNS Table AS
RETURN (
		SELECT horario AS HORARIO
		FROM [fisioterapia].Orientador
		WHERE nif=@nif
		)
GO

SELECT * FROM [fisioterapia].UDF_ORIHOR(436256456)
-- DROP FUNCTION [fisioterapia].UDF_ORIHOR

-- TESTES
