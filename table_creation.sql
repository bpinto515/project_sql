USE [p6g4];
GO

CREATE SCHEMA [fisioterapia];

create table [fisioterapia].Pessoa(
	nif			int				not null,
	nome		varchar(30)				,
	mail		varchar(30)				,
	sexo		char					,
	data_nasc	date	
	primary key (nif)
	);

create table [fisioterapia].Mensagem(
	id			int	 IDENTITY(1,1) not null,
	timestamp	time					,
	sender_mail	varchar(30)				,
	texto		varchar(100)			,
	nif_pessoa	int				not null
	primary key (id)
	);

create table [fisioterapia].Staff(
	nif				int				not null,
	password		varchar(15)				,
	primary key (nif)
	);

create table [fisioterapia].Estagiario(
	nif				int				not null,
	horario_est		varchar(200)				,
	nif_ori			int				not null
	primary key (nif)
	);

create table [fisioterapia].Coordenador(
	nif				int				not null			
	primary key (nif)
	);

create table [fisioterapia].Orientador(
	nif				int				not null,
	horario		varchar(200)				,
	nif_coord		int				not null
	primary key (nif)
	);

create table [fisioterapia].Plano(
	id					int				not null,
	n_total_sess		int		check (n_total_sess>=0)	,
	horario_sess		varchar(200)			
	primary key (id)
	);

create table [fisioterapia].Sessao(
	id				int				not null,
	data			date					,
	id_plano		int				not null,
	nif_orient		int				not null,
	nif_est			int				not null
	primary key (id)
	);

create table [fisioterapia].Paciente(
	nif				int				not null,
	n_processo		int						,
	descricao		varchar(200)			,
	altura			int		check (altura>=0),
	peso			int		check (peso>=0)	,
	condicao		varchar(100)			,
	n_sessoes		int						,
	dia_entrada		date					,
	id_plano		int				not null
	primary key (nif)
	);

create table [fisioterapia].Tratamento(
	id				int				not null,
	titulo			varchar(15)				,
	timestamp		time					,
	descricao		varchar(200)	
	primary key (id)
	);


create table [fisioterapia].Possui(
	id_sess				int				not null,
	id_trata			int				not null
	primary key (id_sess, id_trata)
	);

ALTER TABLE [fisioterapia].Mensagem
ADD CONSTRAINT MENSPESS 
FOREIGN KEY (nif_pessoa) REFERENCES [fisioterapia].Pessoa(nif);



ALTER TABLE [fisioterapia].Staff
ADD CONSTRAINT STAFFPESS
FOREIGN KEY (nif) REFERENCES [fisioterapia].Pessoa(nif);

ALTER TABLE [fisioterapia].Estagiario
ADD CONSTRAINT ESTSTAFF
FOREIGN KEY (nif) REFERENCES [fisioterapia].Staff(nif);
ALTER TABLE [fisioterapia].Estagiario
ADD CONSTRAINT ESTORI
FOREIGN KEY (nif_ori) REFERENCES [fisioterapia].Orientador(nif);



ALTER TABLE [fisioterapia].Coordenador
ADD CONSTRAINT COORDSTAFF
FOREIGN KEY (nif) REFERENCES [fisioterapia].Staff(nif);

ALTER TABLE [fisioterapia].Orientador
ADD CONSTRAINT ORIENSTAFF
FOREIGN KEY (nif) REFERENCES [fisioterapia].Staff(nif);
ALTER TABLE [fisioterapia].Orientador
ADD CONSTRAINT ORIENCOORD
FOREIGN KEY (nif_coord) REFERENCES [fisioterapia].Coordenador(nif);

ALTER TABLE [fisioterapia].Sessao
ADD CONSTRAINT SESSPLAN
FOREIGN KEY (id_plano) REFERENCES [fisioterapia].Plano(id);
ALTER TABLE [fisioterapia].Sessao
ADD CONSTRAINT SESSORIEN
FOREIGN KEY (nif_orient) REFERENCES [fisioterapia].Orientador(nif);
ALTER TABLE [fisioterapia].Sessao
ADD CONSTRAINT SESSEST
FOREIGN KEY (nif_est) REFERENCES [fisioterapia].Estagiario(nif);


ALTER TABLE [fisioterapia].Paciente
ADD CONSTRAINT PACIPESS
FOREIGN KEY (nif) REFERENCES [fisioterapia].Pessoa(nif);
ALTER TABLE [fisioterapia].Paciente
ADD CONSTRAINT PACIPLAN
FOREIGN KEY (id_plano) REFERENCES [fisioterapia].Plano(id);


ALTER TABLE [fisioterapia].Possui
ADD CONSTRAINT POSSSESS
FOREIGN KEY (id_sess) REFERENCES [fisioterapia].Sessao(id);
ALTER TABLE [fisioterapia].Possui
ADD CONSTRAINT POSSTRAT
FOREIGN KEY (id_trata) REFERENCES [fisioterapia].Tratamento(id);

--ALTER TABLE [fisioterapia].Estagiario
--DROP CONSTRAINT ESTORI
--DROP TABLE [fisioterapia].Mensagem
--DROP SCHEMA [fisioterapia]