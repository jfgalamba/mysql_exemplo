DROP DATABASE IF EXISTS Eventos;
CREATE DATABASE Eventos;

USE Eventos;

DROP TABLE IF EXISTS Evento;
CREATE TABLE Evento (
    ID        INTEGER PRIMARY KEY,
    Titulo    VARCHAR(50) NOT NULL UNIQUE COMMENT 'Designação do evento',
    Descricao VARCHAR(1000) NOT NULL COMMENT 'Dados extra sobre o convite',
    DataHora  DATETIME COMMENT 'Data e hora do evento'
);

DROP TABLE IF EXISTS Convidado;
CREATE TABLE Convidado (
    ID              INTEGER PRIMARY KEY,
    PrimNome        VARCHAR(100) NOT NULL COMMENT 'Primeiro nome pessoal',
    UltmNome        VARCHAR(100) NOT NULL COMMENT 'Último apelido',
    EndEmail        VARCHAR(150) NOT NULL
       CHECK(LOCATE('@', EndEmail) <> 0 AND LOCATE('@', EndEmail, LOCATE('@', EndEmail) + 1) = 0),
    DataNascimento  DATE NOT NULL
);

DROP TABLE IF EXISTS Convite;
CREATE TABLE Convite (
    ID           INTEGER PRIMARY KEY,
    IDEvento     INTEGER NOT NULL,
    IDConvidado  INTEGER NOT NULL,
    DataEnvio    DATE DEFAULT(CURDATE()),
    
    FOREIGN KEY EventoFK (IDEvento) REFERENCES Evento(ID) ON UPDATE CASCADE,
    FOREIGN KEY ConvidadoFK (IDConvidado) REFERENCES Convidado(ID) ON UPDATE CASCADE,
    UNIQUE KEY EventoConvidadoUK (IDEvento, IDConvidado) 
);

INSERT INTO Evento 
	(ID, Titulo, Descricao, DataHora)
VALUES
	(100, 'Maratona de Prog C#', 'Maratona de programação em C#. Truques e dicas. Concursos', '2022-06-26 09:43:40'),
	(101, 'O uProcessador 6502', 'O CPU por trás de computadores clássicos como o VIC-20, Commodore 64, etc.', '2022-06-16 10:43:40')
;

INSERT INTO Convidado
	(ID, PrimNome, UltmNome, EndEmail, DataNascimento)
VALUES
	(4500, 'Alberto', 'Antunes', 'alb@mail.com', '1998-11-20'),
	(4515, 'Armando', 'Almeida', 'arm@mail.com', '1988-05-10'),
	(4597, 'Arnaldo', 'Avelar', 'arn@mail.com', '1966-01-15')
;

INSERT INTO Convidado
	(ID, PrimNome, UltmNome, EndEmail, DataNascimento)
VALUES
	(4560, 'Augusto', 'Amaral', 'aug@mail.com', '1998-11-20')
;

INSERT INTO Convite
	(ID, IDEvento, IDConvidado)
VALUES
	(5500, 100, 4500),
    (5501, 100, 4597),
    (5502, 101, 4515),
	(5503, 101, 4597)
;

/*
SET @email = 'abc@xyz';
SET @email = '@';
SET @email = 'abc@xyz@';
SET @email = 'abc';
SET @email = '';
SELECT LOCATE('@', @email) <> 0 AND LOCATE('@', @email, LOCATE('@', @email) + 1) = 0;
*/


