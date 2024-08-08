USE ENSINO;

-- -------------------------------------------------
--
--  EXERCÍCIOS LAB 2.1
--
-- -------------------------------------------------

--
-- 1.1
--

SELECT ID
FROM   Curso
WHERE  Nome = 'Contabilidade';   -- id do Curso de contabilidade -> 3

SELECT ID
FROM   Accao
WHERE  IDCurso = 3 AND Numero = 2;  -- id de Contabilidade 2 -> 5

SELECT IDEstudante
FROM   Inscricao
WHERE  IDAccao = 5;

SELECT ID,
	   Nome,
       DataNascimento,
       YEAR(CURDATE()) - YEAR(DataNascimento)   AS 'IdadeAproximada'
FROM   Estudante
WHERE  ID IN (1004, 1005);
-- WHERE ID = 1004 OR ID = 1005;

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

-- WHERE  DataNascimento BETWEEN '1998-01-01' AND '2001-12-31';
-- WHERE  YEAR(DataNascimento) IN (1998, 1999, 2000, 2001);

--
-- 1.3
-- 

SELECT Numero,
       Coordenador
FROM   Accao
WHERE  YEAR(DataInicial) = 2021;

--
-- 1.4
-- 

SELECT *
FROM   Estudante
WHERE  MONTH(DataNascimento) = 2 AND CHAR_LENGTH(Nome) >= 6;

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

SELECT LEFT(Nome, 3)
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
       SUBSTRING_INDEX(Apelido, ' ', -1)
FROM   Estudante;

SET @Apelidos1 = 'Castro Coelho Costa';
SET @Apelidos2 = 'Fernandes Ferreira';

SELECT SUBSTRING_INDEX(@Apelidos1, ' ', 1),
       SUBSTRING_INDEX(@Apelidos1, ' ', -1);

SELECT SUBSTRING_INDEX('ABC/DEF/GHI/JKL', '/', 3),
       SUBSTRING_INDEX('ABC/DEF/GHI/JKL', '/', 1),
       SUBSTRING_INDEX('ABC/DEF/GHI/JKL', '/', -3),
       SUBSTRING_INDEX('ABC/DEF/GHI/JKL', '/', -1);








