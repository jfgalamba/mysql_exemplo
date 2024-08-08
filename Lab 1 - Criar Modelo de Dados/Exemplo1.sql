
DROP DATABASE IF EXISTS Exemplo1;
CREATE DATABASE Exemplo1;

USE Exemplo1;

-- Obrigatório       : NOT NULL
-- Único             : UNIQUE
-- Valor por Omissão : DEFAULT
-- Restrição         : CHECK 
-- Comentário/Desc   : COMMENT      

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
	ID	    INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nome 	VARCHAR(50) NOT NULL COMMENT 'Nome completo',
    Morada 	VARCHAR(100) NOT NULL DEFAULT 'N/D'
)

DROP TABLE IF EXISTS Encomenda;
CREATE TABLE Encomenda (
	ID			INTEGER PRIMARY KEY,
    `Data`		DATE NOT NULL,
    IDCliente	INTEGER NOT NULL   -- Propositadamente, a chave-estrangeira fica por criar...
);

INSERT INTO Cliente
	(Nome, Morada)
VALUES
	('Armando', 'Porto'),
    ('Alberto', 'Lisboa')
;

INSERT INTO Encomenda
	(ID, `Data`, IDCliente)
VALUES
	(177, '2017-01-01', 2),
	(191, '2017-01-10', 1),
	(199, '2017-01-10', 2)
;
    
    


