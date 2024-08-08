USE ENSINO;

-- -------------------------------------------------
--
--  EXERCÍCIOS LAB 2.1
--
-- -------------------------------------------------

--
-- 1.1
--

SELECT * 
FROM   Curso
WHERE  Nome = 'Contabilidade';     -- id do Curso de contabilidade -> 3

SELECT ID 
FROM   Accao 
WHERE IDCurso = 3 AND Numero = 2; 	-- id de Contabilidade 2 -> 5

SELECT * 
FROM   Inscricao
WHERE  IDAccao = 5;

SELECT ID, 
       Nome,
       DataNascimento,
       YEAR(CURDATE()) - YEAR(DataNascimento) AS 'IdadeAproximada1'
FROM   Estudante
WHERE  ID IN (1004, 1005);


/*
SELECT  ID,
        Nome,
        DataNascimento,
        IF(
            MONTH(DataNascimento) > MONTH(CURDATE()) OR 
            MONTH(DataNascimento) = MONTH(CURDATE()) AND DAY(DataNascimento) > DAY(CURDATE())
            ,
            YEAR(CURDATE()) - YEAR(DataNascimento) - 1
            ,
            YEAR(CURDATE()) - YEAR(DataNascimento)
        )   AS Idade1,
        TIMESTAMPDIFF(YEAR, DataNascimento, CURDATE())  AS Idade2
FROM    Estudante
WHERE   ID IN (1004, 1005);
*/

-- SELECT TIMESTAMPDIFF(YEAR, '2023-06-06', '2024-05-06');
-- SELECT TIMESTAMPDIFF(MONTH, '2023-06-06', '2024-05-06');
-- SELECT TIMESTAMPDIFF(YEAR, '2023-03-06', '2024-05-06');
-- SELECT TIMESTAMPDIFF(YEAR, '2022-05-07', '2024-05-06');

--
-- 1.2
--

SELECT CONCAT(Apelido, ', ', Nome) AS NomeCompleto,
       DataNascimento,
       NISS
FROM   Estudante
WHERE  YEAR(DataNascimento) BETWEEN 1998 AND 2001;

-- WHERE  YEAR(DataNascimento) IN (1998, 1999, 2000, 2001);
-- WHERE  DataNascimento BETWEEN '1998-01-01' AND '2001-12-31';

-- 
-- 1.3
--

SELECT IDCurso,
       Numero,
       Coordenador
FROM   Accao
WHERE  YEAR(DataInicial) = 2021;

--
-- 1.4
--

SELECT *
FROM   Estudante
WHERE  MONTH(DataNascimento) = 2 AND
       CHAR_LENGTH(Nome) >= 6;

--
-- 1.5
--

SELECT Nome, 
       Duracao
FROM   Curso
WHERE  Duracao % 10 = 0;

SELECT Nome, 
       Duracao
FROM   Curso
WHERE  RIGHT(Duracao, 1) = 0;

-- UPDATE Curso SET Duracao = 1703 WHERE ID = 3;
-- SELECT MOD(1700, 10), MOD(1703, 10);
-- SELECT MOD(15, 3), 15 % 3, MOD(17, 3), 17 % 3;
-- SELECT RIGHT('ABCDEF', 3), RIGHT(1706, 1);
-- SELECT LEFT('ABCDEF', 3), LEFT(1706, 1);

--
-- 2.1
-- 

-- LENGTH      -> comprimento em bytes
-- CHAR_LENGTH -> comprimento em caracteres

SELECT LENGTH('ABC 123'), CHAR_LENGTH('ABC 123');

SELECT LENGTH('ABC€∏∆'), CHAR_LENGTH('ABC€∏∆');
SELECT LENGTH('€'), LENGTH('∏'), LENGTH('∆');

-- A -> 65   -> 01000001 1 byte   UTF8, UTF16, UTF32, UCS-2
-- € -> 8364 -> 3 bytes

--
-- 2.2
-- 

SELECT LEFT(Nome, 3),
       CodigoPostal
FROM   Estudante
WHERE  CodigoPostal % 2 = 0;

--
-- 2.3
-- 

SELECT Nome,
       LPAD(Apelido, 15, '_'),     -- o que era pedido no exercício
       CONCAT(REPEAT('_', 15 - CHAR_LENGTH(APELIDO)), Apelido),
       RPAD(Apelido, 15, '.')      -- coluna extra para vermos o RPAD
FROM   Estudante;

-- SELECT LPAD('ALBERTO', 15, '.');

--
-- 2.4
-- 

SELECT Nome,
       SUBSTRING_INDEX(Apelido, ' ', -1) AS Apelido
FROM   Estudante;


-- SET @Apelidos1 = 'Castro Coelho';
-- SET @Apelidos2 = 'Fernandes Ferreira';

-- SELECT SUBSTRING_INDEX(@Apelidos1, ' ', -1), SUBSTRING_INDEX(@Apelidos2, ' ', -1);
-- SELECT SUBSTRING_INDEX(@Apelidos1, ' ', 1), SUBSTRING_INDEX(@Apelidos2, ' ', 1);

--
-- 3
-- 

SELECT IDEstudante,
       DataInscricao
FROM   Inscricao
WHERE  DataInscricao > CURDATE() - INTERVAL 1 YEAR;

-- 
-- 4
-- 

SELECT DataNascimento,
       IF(MONTH(DataNascimento) > MONTH(CURDATE()) 
          OR MONTH(DataNascimento) = MONTH(CURDATE()) 
             AND DAY(DataNascimento) > DAY(CURDATE()),
          YEAR(CURDATE()) - YEAR(DataNascimento) - 1,
          YEAR(CURDATE()) - YEAR(DataNascimento))  AS 'Idade'
FROM   Estudante;

SELECT DataNascimento,
       TIMESTAMPDIFF(YEAR, DataNascimento, CURDATE()) AS 'Idade'
FROM   Estudante;


-- SET @DataNasc = '2001-06-01';
-- SET @Idade = YEAR(CURDATE()) - YEAR(@DataNasc);

-- SELECT IF(MONTH(@DataNasc) > MONTH(CURDATE()) 
--           OR MONTH(@DataNasc) = MONTH(CURDATE()) 
--              AND DAY(@DataNasc) > DAY(CURDATE()),
--           @Idade - 1,
--           @Idade);
          

-- SELECT @Idade;

-- IF(EXPRESSÃO, CONSEQUÊNCIA, ALTERNATIVA)
-- C/C++ e outras: EXPRESSÃO ? CONSEQUÊNCIA : ALTERNATIVA 

-- SELECT IF(2 > 1, 'A', 'B');

--
-- 5
--

SELECT Nome,
       Duracao,
       CONCAT(Duracao DIV 10, 'd', Duracao % 10, 'h'),
       CONCAT(Duracao DIV 10, 'd', LPAD(Duracao % 10, 2, '0'), 'h')
FROM   Curso;

--
-- 6
-- 

SELECT Cidade,
       Endereco,
       CodigoPostal,
       Cidade,
       CASE WHEN Cidade IN ('Évora', 'Faro') THEN 'SUL'
            WHEN Cidade IN ('Lisboa', 'Leiria', 'Coimbra') THEN 'CENTRO'
            WHEN Cidade IN ('Porto', 'Guimarães', 'Braga') THEN 'NORTE'
            ELSE 'OUTRA_REGIAO'
       END AS Regiao
FROM   Estudante;
