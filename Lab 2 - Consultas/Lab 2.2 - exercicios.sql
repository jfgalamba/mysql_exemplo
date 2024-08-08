USE ENSINO;

--
-- 1
--

SELECT NomeEstudante
FROM   InscricaoEstudante
WHERE  Classificacao=(SELECT MAX(Classificacao)
                      FROM   InscricaoEstudante);

/*
SELECT Nome
FROM   Estudante
JOIN   Inscricao
ON     Estudante.ID = Inscricao.IDEstudante
WHERE  Classificacao = (SELECT MAX(Classificacao) 
                        FROM   Inscricao);
*/


--
-- 2
-- 

/*
 
 Consultar https://www.w3schools.com/mysql/mysql_having.asp e 
  https://stackoverflow.com/questions/2905292/where-vs-having
  Resumo: 
  1. Apenas o HAVING permite filtrar os resultados de funções 
     e expressões agregadas (eg, COUNT, GROUP BY)
  2. O HAVING pode ser utilizado para filtrar resultados 
     como o WHERE, mas é ineficiente porque ele actual *DEPOIS*
     do SELECT reunir todas as linhas, ao passo que o WHERE 
     actua antes (ie, o WHERE filtra logo as linhas). 
 */

--
-- 3.1
-- 

SELECT COUNT(*)
FROM   Inscricao AS I
JOIN   Accao     AS A
ON     I.IDAccao = A.ID
JOIN   Curso     AS C
ON     A.IDCurso = C.ID
WHERE  C.Nome = 'Biologia';

--
-- 3.2
-- 

SELECT A.Numero,
       C.Duracao
FROM   Accao AS A 
JOIN   Curso AS C
ON     A.IDCurso = C.ID
WHERE  C.Nome = 'Contabilidade';

--
-- 3.3
--

SELECT AVG(I.Classificacao)
FROM   Inscricao AS I
JOIN   Accao     AS A
ON     I.IDAccao = A.ID
JOIN   Curso     AS C
ON     A.IDCurso = C.ID
WHERE  C.Nome = 'Agricultura Aplicada';

--
-- 3.4
-- 

SELECT E.Nome, 
       C.Nome,
       I.Classificacao
FROM   Estudante AS E
JOIN   Inscricao AS I
ON     E.ID = I.IDEstudante
JOIN   Accao     AS A
ON     I.IDAccao = A.ID
JOIN   Curso     AS C
ON     A.IDCurso = C.ID
ORDER BY I.Classificacao DESC
LIMIT 3;

-- 
-- 3.5
-- 

SELECT E.Nome, 
       C.Nome,
       I.Classificacao
FROM   Estudante AS E
JOIN   Inscricao AS I
ON     E.ID = I.IDEstudante
JOIN   Accao     AS A
ON     I.IDAccao = A.ID
JOIN   Curso     AS C
ON     A.IDCurso = C.ID
WHERE  I.Classificacao = (SELECT MAX(Classificacao) FROM Inscricao)
ORDER BY I.Classificacao DESC





