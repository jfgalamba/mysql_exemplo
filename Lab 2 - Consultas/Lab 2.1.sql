USE ENSINO;

INSERT INTO Estudante 
    (ID, Nome, Apelido, Endereco, Cidade, CodigoPostal, DataNascimento, NISS)
VALUES
    (1001, 'Arnaldo', 'Avelar', 'Av. António Ferreira', 'Amarante', 3050, '1999-05-05', 2111),
    (1002, 'Bernardo', 'Bastinhas', 'Pr. Baptista Ferreira', 'Braga', 3002, '1998-02-25', 2112),
    (1003, 'Carla', 'Conceição', 'Rua Carolina Ferreira', 'Covilhã', 3051, '2000-01-01', 2113),
    (1004, 'Duarte', 'Domingos', 'Bairro David Ferreira', 'Darque', 3052, '1998-01-14', 2114),
    (1005, 'Eugénia', 'Estrela', 'Travessa Euleutério Ferreira', 'Estremoz', 3091, '2002-11-17', 2115),
    (1006, 'Fernanda', 'Fonseca', 'Urbanização Francisco Ferreira', 'Fátima', 3092, '2001-08-15', 2116)
;

INSERT INTO Inscricao
    (ID, IDEstudante, IDAccao, DataInscricao, Classificacao, Estado)
VALUES
    (5001, 1001, 2, '2019-05-11', 16, 'activa'),
    (5002, 1002, 4, '2021-08-11', 6, 'suspensa'),
    (5003, 1003, 4, '2021-07-28', 18, 'activa'),
    (5004, 1004, 5, '2021-10-28', 18, 'activa'),
    (5005, 1005, 5, '2021-10-30', 16, 'activa'),
    (5006, 1006, 3, '2020-10-30', 5, 'activa')
;

-- DELETE FROM Estudante WHERE ID > 1000;
-- DELETE FROM Inscricao WHERE ID > 5000;

SELECT ID FROM Curso WHERE Nome = 'Contabilidade';
SELECT ID FROM Accao WHERE IDCurso = 3 AND Numero = 1;

SELECT 	IDEstudante, 
		Classificacao, 
        DataInscricao
FROM 	Inscricao 
WHERE 	IDAccao = 4;

SELECT 	Nome, 
		Endereco, 
        DataNascimento
FROM 	Estudante
WHERE 	Cidade = 'Lisboa' OR Cidade = 'Coimbra';

SELECT 	Nome, 
		Endereco, 
        DataNascimento
FROM 	Estudante
WHERE 	Cidade IN ('Lisboa', 'Coimbra');

SELECT 	Nome, 
		Endereco, 
        DataNascimento
FROM 	Estudante
WHERE 	Cidade <> 'Porto';

SELECT 	Nome,
		Endereco
FROM	Estudante
WHERE	Endereco LIKE 'Rua%';

SELECT 	Nome,
		Endereco
FROM	Estudante
WHERE	Endereco RLIKE '^Rua';

SELECT	*
FROM 	Estudante
-- WHERE 	CodigoPostal >= 3002 AND CodigoPostal <= 3005;
WHERE  CodigoPostal BETWEEN 3002 AND 3005;

SELECT 	*
FROM   	Estudante
WHERE  	CodigoPostal < 3002 OR CodigoPostal > 3005;

SELECT 	*
FROM 	Estudante
WHERE 	NOT (CodigoPostal >= 3002 AND CodigoPostal <= 3005);

SELECT 	*
FROM 	Estudante
WHERE 	CodigoPostal NOT BETWEEN 3002 AND 3005;

SELECT 	Nome, Apelido, DataNascimento
FROM 	Estudante
WHERE 	DataNascimento BETWEEN '1998-01-01' AND '1998-12-31';

SELECT 	Nome, Apelido, DataNascimento 
FROM 	Estudante
WHERE 	YEAR(DataNascimento) = 1998;


SELECT 	IDEstudante,
		IDEstudante 							AS 'ID do estudante',
		DATEDIFF(CURDATE(), DataInscricao) 		AS 'Dias desde a inscricao'
FROM 	Inscricao
WHERE 	IDAccao = 2;

SELECT ID FROM Curso WHERE Nome = 'Agricultura Aplicada';
SELECT ID FROM Accao WHERE IDCurso = 1 AND Numero = 2;

SELECT IDEstudante, DataInscricao
FROM   Inscricao
-- WHERE  DataInscricao >= CURDATE() - INTERVAL 14 MONTH;
WHERE  DataInscricao >= CURDATE() - INTERVAL 44 MONTH;

SELECT	IDEstudante,
		DAYOFYEAR(DataInscricao),
		DAYOFMONTH(DataInscricao),
		DAYOFWEEK(DataInscricao)
FROM 	Inscricao;

SELECT DAYOFWEEK(CURDATE());

SELECT	CONCAT(Nome, ' ', Apelido) 	AS "Nome completo", 
		DataNascimento 			AS "Data de nascimento"
FROM 	Estudante
WHERE 	DataNascimento BETWEEN '1998-01-01' AND '1998-12-31';

DROP VIEW IF EXISTS EstCont;
CREATE VIEW EstContab AS
	SELECT 	IDEstudante,
			DataInscricao
	FROM   	Inscricao
	WHERE 	IDAccao IN (4, 5)
;
    
SELECT * FROM EstContab;

DROP VIEW IF EXISTS EstNatureza;
CREATE VIEW EstNatureza AS
	SELECT 	IDEstudante,
			DataInscricao
	FROM   	Inscricao
	WHERE 	IDAccao IN (1, 2, 3)
;

SELECT * FROM EstNatureza;

DROP VIEW IF EXISTS Maiores25;
CREATE VIEW Maiores25 AS
	SELECT 	*
	FROM	Estudante
	WHERE	DataNascimento < CURDATE() - INTERVAL 25 YEAR;
            -- Não funciona: CURDATE() - DataNascimento >= INTERVAL 25 YEAR;

SELECT	Nome, Endereco, Cidade, DataNascimento
FROM 	Maiores25;

SELECT	CONCAT(Nome, ' ', Apelido) AS 'Nome completo', 
		Endereco, 
        Cidade, 
        DataNascimento
FROM	Maiores25
WHERE   Nome LIKE 'António%';

-- UPDATE Estudante 
-- 		SET DataNascimento = DataNascimento - INTERVAL 1 YEAR
-- WHERE Nome LIKE 'António%';

