-- 4 entidade 
--Clube, jogador, olheiro e contratos (jogadores, clubes, olheiro, data de início e data de fim de contrato).


CREATE DATABASE futebol
GO

--Criacao de tabelas

CREATE TABLE clube(
	id_clube INT IDENTITY (1,1),
	nome_clube VARCHAR (30) NOT NULL,
	nif_clube INT NOT NULL UNIQUE
		CONSTRAINT ck_clube_nif_clube CHECK (nif_clube > 0 AND LEN(CAST(nif_clube AS VARCHAR)) = 9),
		CONSTRAINT pk_clube_id_clube PRIMARY KEY (id_clube)
)

CREATE TABLE olheiro (
	id_olheiro INT IDENTITY(1,1),
	nome_olheiro VARCHAR (30) NOT NULL,
	email VARCHAR (20) UNIQUE, 
	data_contratacao DATE NOT NULL,
	CONSTRAINT pk_olheiro_id_olheiro PRIMARY KEY (id_olheiro),
	CONSTRAINT ck_olheiro_data_contratacao CHECK (data_contratacao < GETDATE()) --<=

)

CREATE TABLE jogador (
	id_jogador INT IDENTITY (1,1),		
	nome VARCHAR (30) NOT NULL,
	idade INT,
	posicao VARCHAR (20) NOT NULL,
	anos_carreira FLOAT,--decimal
	CONSTRAINT pk_jogador_ida_jogador PRIMARY KEY (id_jogador),
	CONSTRAINT ck_jogador_posicao CHECK (posicao IN ('Guarda-Redes','Defesa','Médio','Avançado')),
	CONSTRAINT ck_jogador_anos_carreira CHECK (anos_carreira >= 0 AND anos_carreira < idade)
)

CREATE TABLE contrato (
	id_contrato INT IDENTITY (1,1),
	id_jogador INT NOT NULL,		
	id_clube INT NOT NULL,		
	id_olheiro INT NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim DATE NOT NULL,
	CONSTRAINT pk_contrato_id_contrato PRIMARY KEY (id_contrato),
	CONSTRAINT fk_jogador_id_jogador FOREIGN KEY(id_jogador) REFERENCES jogador(id_jogador),
	CONSTRAINT fk_clube_id_clube FOREIGN KEY (id_clube) REFERENCES clube(id_clube),
	CONSTRAINT fk_olheiro_id_olheiro FOREIGN KEY (id_olheiro) REFERENCES olheiro(id_olheiro),
	CONSTRAINT ck_contrato_datas CHECK (data_fim > data_inicio),
	CONSTRAINT uq_contrato UNIQUE (id_jogador, id_clube, data_inicio)

)