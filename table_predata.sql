USE [p6g4];
GO

-- VALUES FOR TABLE PESSOA
INSERT INTO [fisioterapia].Pessoa (nif,nome,mail, sexo, data_nasc) VALUES
	
	(333344444, 'Rui Torres', 'rtrtrt@gmail.com', 'M', '1990-02-10'),
	(567834512, 'Joana Pires', 'joaninha2@gmail.com', 'F', '1974-01-01'),
	(985672103, 'Maria Domingues', 'maridomi@gmail.com', 'F', '2000-03-15'),
	(840384724, 'Joao Neto', 'joanete@gmail.com', 'M', '2001-07-25'),
	(489347234, 'Pedro Bastos', 'pedrobastos10@gmail.com', 'M', '1989-02-25'),
	(876598675, 'Miguel Morais', 'doisemes@gmail.com', 'M', '1988-11-22'),
	(345612345, 'Andre Gomes', 'andregomes00@gmail.com', 'M', '1994-12-20'),
	(234527643, 'Rita Pereira', 'pereirita@gmail.com', 'F', '2001-03-19'),
	(342524356, 'Luis Carvalho', 'luiscarvalho@gmail.com', 'M', '1985-04-03'),
	(435324543, 'Miguel Cruz', 'miguelc@gmail.com', 'M', '1990-07-20'),
	(437465243, 'Telmo Silva', 'telva20@gmail.com', 'M', '2001-11-03'),
	(436256456, 'Pedro Castro', 'pedrocastro@gmail.com', 'M', '2002-12-20');

SELECT * FROM [fisioterapia].Pessoa;

-- VALUES FOR TABLE MENSAGEM
SET IDENTITY_INSERT [fisioterapia].Mensagem ON
INSERT INTO [fisioterapia].Mensagem (id,timestamp,sender_mail, texto, nif_pessoa) VALUES
	(1, '2019-10-12 20:23:21', 'andregomes00@gmail.com', 'Nao esquecer marcar a consulta de quarta-feira!', 876598675),
	(2, '2020-04-12 17:00:00', 'pedrobastos10@gmail.com', 'Mudar plano de Rui Torres.', 345612345),
	(3, '2020-04-13 08:21:40', 'pereirita@gmail.com', 'Desmarcar a sessao de Joana Pires.', 489347234),
	(4, '2020-05-12 11:10:23', 'luiscarvalho@gmail.com', ' Reunir o staff na terca-feira.', 234527643);
SET IDENTITY_INSERT [fisioterapia].Mensagem OFF

SELECT * FROM [fisioterapia].Mensagem;
DELETE FROM [fisioterapia].Mensagem WHERE id=1;

-- VALUES FOR TABLE STAFF
INSERT INTO [fisioterapia].Staff (nif,password) VALUES
	(840384724, 'olaola123'),
	(489347234, 'password111'),
	(876598675, 'passwordfraca'),
	(345612345, 'piorpass'),
	(234527643, '123123987'),
	(435324543, 'paaforte'),
	(437465243, 'bdefixe'),
	(436256456, 'bdnaoefixe'),
	(342524356, 'naosei');
	

SELECT * FROM [fisioterapia].Staff;

--VALUES FOR TABLE Coordenador
INSERT INTO [fisioterapia].Coordenador (nif) VALUES
	(876598675),
	(345612345);


SELECT * FROM [fisioterapia].Coordenador;

-- VALUES FOR TABLE Estagiario
INSERT INTO [fisioterapia].Estagiario (nif,horario_est, nif_ori) VALUES
	(840384724, 'Segunda-feira a Sexta Feira das 08:30 as 17:30', 436256456 ),
	(489347234, 'Sabado e Domingo das 10:00 as 18:00', 435324543),
	(342524356, 'Segunda-feira a Sexta Feira das 08:30 as 17:30', 436256456);


SELECT * FROM [fisioterapia].Estagiario;



--VALUES FOR TABLE Orientador
INSERT INTO [fisioterapia].Orientador (nif, horario, nif_coord) VALUES
	(234527643, 'Segunda-feira a Sexta Feira das 08:30 as 17:30', 876598675),
	(436256456, 'Sabado e Domingo das 10:00 as 18:00', 345612345),
	(435324543, 'Segunda-feira a Sexta Feira das 08:30 as 17:30', 876598675),
	(437465243, 'Sabado e Domingo das 10:00 as 18:00', 345612345);

SELECT * FROM [fisioterapia].Orientador;

-- VALUES FOR TABLE Plano
INSERT INTO [fisioterapia].Plano (id, n_total_sess, horario_sess) VALUES
	(1,10,'Segunda-Feira das 14:00 as 15:00'),
	(2,15,'Terca-Feira das 10:00 as 11:00'),
	(3,5,'Sabado das 16:00 as 17:00');


SELECT * FROM [fisioterapia].Plano;

-- VALUES FOR TABLE Sessao
INSERT INTO [fisioterapia].Sessao (id, data, id_plano, nif_orient, nif_est) VALUES
	(1,'2020-04-20',3,436256456,840384724),
	(2,'2020-04-18',2,435324543,489347234),
	(3,'2020-04-23',1,436256456,342524356);

SELECT * FROM [fisioterapia].Sessao;

-- VALUES FOR  TABLE Paciente

INSERT INTO [fisioterapia].Paciente (nif, n_processo, descricao, altura, peso, condicao, n_sessoes, dia_entrada, id_plano) VALUES
	(333344444, 23342, 'Paciente com um entorce no tornozelo esquerdo', 175, 80,'Paciente a progredir bem', 7,'2020-04-07', 2),
	(567834512, 24522, 'Recuperacao de um paciente com uma fratura de uma clavicula', 167, 70, 'Paciente ainda na fase inicial do tratamento',1,'2020-04-05',3),
	(985672103, 24123, 'Recuperacao de um paciente com uma fratura no tornozelo direito', 189, 90, 'Paciente quase recuperado na fase final do tratamento',14,'2020-04-1' ,2),
	(840384724, 25234, 'Recuperacao de um paciente com um entorse no pulso direito', 170, 50,'Paciente a meio do tratamento mas sem progresso',9,'2020-04-20',1 );

SELECT * FROM [fisioterapia].Paciente;

-- VALUES FOR TABLE Tratamento

INSERT INTO [fisioterapia].Tratamento (id, titulo, descricao) VALUES
	(1,'Tratamento1','Descricao do Tratamento1 muito cientifica para mim'),
	(2,'Tratamento2','Descricao do Tratamento2 muito cientifica para mim'),
	(3,'Tratamento3','Descricao do Tratamento3 muito cientifica para mim'),
	(4,'Tratamento4','Descricao do Tratamento4 muito cientifica para mim');

SELECT * FROM [fisioterapia].Tratamento;

-- VALUES FOR TABLE Possui

INSERT INTO [fisioterapia].Possui (id_sess, id_trata) VALUES
	(3, 2),
	(2, 4),
	(1, 3);

SELECT * FROM [fisioterapia].Possui;



