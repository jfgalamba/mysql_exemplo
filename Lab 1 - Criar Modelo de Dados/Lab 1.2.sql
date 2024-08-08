DROP DATABASE IF EXISTS ENSINO;
CREATE DATABASE ENSINO;

USE ENSINO;

DROP TABLE IF EXISTS Curso;
CREATE TABLE Curso (
    ID      INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nome    VARCHAR(100) NOT NULL COMMENT 'Designação oficial do curso',
    -- Duracao SMALLINT UNSIGNED NOT NULL,
    Duracao SMALLINT NOT NULL CHECK(Duracao > 0) COMMENT 'Duração em horas',
    Tipo    VARCHAR(50) NOT NULL COMMENT 'Tipo de curso'
);

DROP TABLE IF EXISTS Accao; 
CREATE TABLE Accao (
    ID              INTEGER PRIMARY KEY AUTO_INCREMENT,  
    Numero          INTEGER NOT NULL,
    DataInicial     DATE NOT NULL,
    DataFinal       DATE,
    Coordenador     VARCHAR(250),
    IDCurso         INTEGER NOT NULL,
    
    CONSTRAINT CursoFK FOREIGN KEY (IDCurso) REFERENCES Curso(ID) ON UPDATE CASCADE,
    CONSTRAINT NumeroIDCursoUK UNIQUE KEY (Numero, IDCurso)
);  

DROP TABLE IF EXISTS Estudante;
CREATE TABLE Estudante (
    ID              INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nome            VARCHAR(150) NOT NULL COMMENT 'Nomes pessoais',
    Apelido         VARCHAR(250) NOT NULL COMMENT 'Nomes de família',
    Endereco        VARCHAR(200) NOT NULL COMMENT 'Endereço excepto cidade e código postal',
    Cidade          VARCHAR(50) NOT NULL DEFAULT 'Lisboa',
    -- CodigoPostal    INTEGER NOT NULL CHECK(CodigoPostal >= 3000 AND CodigoPostal <= 4999 ),
    -- CodigoPostal    INTEGER NOT NULL CHECK(CodigoPostal BETWEEN 3000 AND 4999),
    CodigoPostal    INTEGER NOT NULL,
    DataNascimento  DATE NOT NULL,
    NISS            INTEGER NOT NULL UNIQUE CHECK (NISS > 0) COMMENT 'Número de Identificação da Segurança Social',

    CONSTRAINT CodigoPostalCHK CHECK(CodigoPostal BETWEEN 3000 AND 4999)
);

DROP TABLE IF EXISTS Inscricao; 
CREATE TABLE Inscricao(
    ID                  INTEGER PRIMARY KEY AUTO_INCREMENT,
    IDAccao             INTEGER NOT NULL,
    IDEstudante         INTEGER NOT NULL,
    DataInscricao       DATE DEFAULT (CURDATE()),
    -- Estado              VARCHAR(10) DEFAULT 'activa' 
                        -- CHECK(Estado = 'activa' OR Estado = 'suspensa' OR Estado = 'concluida'),
                        -- CHECK(Estado IN ('activa', 'suspensa', 'concluida'),
    Estado              ENUM('activa', 'suspensa', 'concluida') DEFAULT 'activa',
    ClassificacaoFinal  DECIMAL(4, 2),

    CONSTRAINT ClassificacaoCHK CHECK(ClassificacaoFinal BETWEEN 0 AND 20),
    CONSTRAINT AccaoFK FOREIGN KEY (IDAccao) REFERENCES Accao(ID) 
                        ON UPDATE CASCADE,
    CONSTRAINT EstudanteFK FOREIGN KEY (IDEstudante) REFERENCES Estudante(ID) 
                        ON UPDATE CASCADE,
    CONSTRAINT AccaoEstudanteUK UNIQUE KEY (IDAccao, IDEstudante)
);

DROP TABLE IF EXISTS EstudanteTrabalhador;
CREATE TABLE EstudanteTrabalhador(
    IDEstudante        INTEGER PRIMARY KEY,
    -- NIF                INTEGER NOT NULL UNIQUE CHECK(NIF BETWEEN 100000 AND 999999),
    NIF                INTEGER NOT NULL UNIQUE CHECK(LENGTH(NIF) = 9),
    DataEstatuto       DATE NOT NULL COMMENT 'Data de início do estatuto de estudante trabalhador',
    NumExames          SMALLINT NOT NULL DEFAULT 1 COMMENT 'Número de exames em época especial a que o estudante tem direito',
    Profissao          VARCHAR(20) DEFAULT 'N/D',
    
    CONSTRAINT EstudanteTrabalhadorFK FOREIGN KEY (IDEstudante) REFERENCES Estudante(ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

/*********************************************

    POPULAR O MODELO DADOS
        
 *********************************************/

INSERT INTO Curso
    (Nome, Duracao, Tipo)
VALUES
    ('Agricultura Aplicada', 1500, 'Ciências Agrárias'),
    ('Biologia', 1600, 'Ciências da Vida'),
    ('Contabilidade', 1700, 'Ciências Económicas e Fiscalidade')
;

INSERT INTO Accao
    (Numero, IDCurso, DataInicial, DataFinal, Coordenador)
VALUES
    (1, 1, '2019-07-02', '2021-09-02', 'Alberto Antunes'),
    (2, 1, '2021-08-02', '2023-04-02', 'Alberto Antunes'),
    (1, 2, '2021-02-02', '2022-12-02', 'Armando Almeida'),
    (1, 3, '2021-09-02', '2022-12-02', 'Arnaldo Alves'),
    (2, 3, '2021-11-02', '2023-02-02', 'Arnaldo Alves')
;

INSERT INTO Estudante 
    (Nome, Apelido, Endereco, Cidade, CodigoPostal, DataNascimento, NISS)
VALUES
    ('António', 'Américo', 'Rua do Alecrim, n. 1', 'Albufeira', 3001, '1997-08-22', 1111),
    ('Beatriz', 'Bastos', 'Rua do Beato, lote 2', 'Braga', 3002, '1997-02-23', 1112),
    ('Catarina', 'Coelho', 'Praça da Consituição, n. 3', 'Coimbra', 3003, '1998-02-23', 1113),
    ('Diogo', 'Diniz', 'Avenida Dom Afonso Lote 4', 'Domelas', 3004, '1995-02-04', 1114),
    ('Eduardo', 'Esteves', 'Praça de Espanha, n. 5', 'Évora', 3005, '2002-03-05', 1115),
    ('Filipa', 'Fernandes', 'Travessa da Ferreirinha, 6', 'Faro', 3006, '2004-02-29', 1116)
;

INSERT INTO Inscricao
    (IDEstudante, IDAccao, DataInscricao, ClassificacaoFinal)
VALUES
    (1, 2, '2021-05-15', 16),
    (2, 3, '2022-12-12', 15),
    (3, 3, '2022-12-10', 8),
    (4, 3, '2022-12-14', 7),
    (5, 2, '2021-05-10', 18),
    (6, 4, '2023-08-01', 17)
;

INSERT INTO EstudanteTrabalhador
    (IDEstudante, NIF, DataEstatuto, NumExames, Profissao)
VALUES
    (3, 292856580, '2020-02-12', 3, 'Restauração'),
    (4, 220727805, '2020-01-02', 5, 'Entretenimento'),
    (6, 226503054, '2020-02-02', 4, 'Programador')
;

/*********************************************

        VERIFICAÇÕES E OUTROS COMANDOS

 *********************************************/
/*
SELECT ID FROM Estudante WHERE Nome = 'Filipa';
SELECT * FROM `EstudanteTrabalhador`;

UPDATE Estudante SET ID = 10 WHERE ID = 6;

DELETE FROM Inscricao WHERE IDEstudante = 10;
DELETE FROM Estudante WHERE ID = 10;

ALTER TABLE Estudante RENAME Aluno;
ALTER TABLE Aluno RENAME Estudante;


ALTER TABLE EstudanteTrabalhador MODIFY NumExames TINYINT NULL;

ALTER TABLE Estudante DROP CONSTRAINT CodigoPostalCHK;
ALTER TABLE Estudante RENAME COLUMN CodigoPostal TO CodPostal;
ALTER TABLE Estudante ADD CONSTRAINT CodigoPostalCHK 
        CHECK(CodPostal BETWEEN 3000 AND 4999);
*/
