
DROP DATABASE IF EXISTS Produtos;
CREATE DATABASE Produtos;

USE Produtos;

DROP TABLE IF EXISTS Categoria;
CREATE TABLE Categoria (
	Numero		INTEGER PRIMARY KEY,
    Designacao  VARCHAR(20) NOT NULL UNIQUE COMMENT 'Nome único da categoria',
    Descricao   VARCHAR(100)
);

DROP TABLE IF EXISTS Produto;
CREATE TABLE Produto (
	ID          VARCHAR(10) PRIMARY KEY,
    Nome        VARCHAR(20) NOT NULL UNIQUE COMMENT 'Nome do produto',
    Quantidade  SMALLINT NOT NULL DEFAULT 0 CHECK(Quantidade >= 0) COMMENT 'Quantidade em stock',
    -- Quantidade  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    NumeroCategoria  INTEGER NOT NULL,
    FOREIGN KEY CategoriaFK (NumeroCategoria) REFERENCES Categoria(Numero)
);

INSERT INTO Categoria
	(Numero, Designacao, Descricao)
VALUES
	(1, 'Vestuário', 'Roupa em geral. Não inclui calçado'),
    (2, 'Perfume', '....')
;
    
INSERT INTO Produto
	(ID, Nome, Quantidade, NumeroCategoria)
VALUES
	('NKCAM4519', 'Camisola Nike', 20, 1),
	('CHCLC2318', 'Calças Chevignon', 50, 1),
	('PRPRF2222', 'Paco Rabanne XL', 100, 2),
	('HBPRF2222', 'Hugo Boss', 25, 2)
;




