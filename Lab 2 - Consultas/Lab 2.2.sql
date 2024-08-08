USE ESTUDANTES;


/*
Preliminar: analisar a query seguinte

SELECT ID
FROM   Curso
WHERE  Nome = 'Contabilidade';

SELECT *
FROM   Accao
WHERE  IDCurso = 3;

SELECT *
FROM   Accao
JOIN   Curso
ON     Accao.IDCurso = Curso.ID
-- WHERE  Curso.Nome = 'Contabilidade';
*/

-- -------------------------------------------------
--
--  LAB 2.2
--
-- -------------------------------------------------

SELECT Accao.ID, 
       Curso.Nome, 
       Accao.Numero, 
       Accao.DataInicial, 
       Accao.DataFinal, 
       Curso.Duracao
FROM   Accao
JOIN   Curso
ON     Accao.IDCurso = Curso.ID;


SELECT Estudante.Nome, Curso.Nome, Duracao
FROM   Estudante 
JOIN   Inscricao
ON     Inscricao.IDEstudante = Estudante.ID
JOIN   Accao
ON     Inscricao.IDAccao = Accao.ID
JOIN   Curso
ON     Accao.IDCurso = Curso.ID;


SELECT Estudante.Nome, Curso.Nome, Duracao
FROM   Estudante, Inscricao, Accao, Curso
WHERE  Inscricao.IDEstudante = Estudante.ID 
       AND Inscricao.IDAccao = Accao.ID 
       AND Accao.IDCurso = Curso.ID;


SELECT Estudante.Nome, Curso.Nome, Duracao
FROM   Estudante 
JOIN   Inscricao
ON     Inscricao.IDEstudante = Estudante.ID
JOIN   Accao
ON     Inscricao.IDAccao = Accao.ID
JOIN   Curso
ON     Accao.IDCurso = Curso.ID
WHERE  Curso.Nome IN ('Biologia', 'Agricultura Aplicada');


DROP VIEW IF EXISTS AccaoCurso;
CREATE VIEW AccaoCurso AS
   SELECT Accao.ID AS IDAccao, 
          Curso.Nome AS NomeCurso, 
          Accao.Numero, 
          Accao.DataInicial, 
          Accao.DataFinal, 
          Curso.Duracao,
          Curso.Tipo
   FROM   Accao
   JOIN   Curso
   ON     Accao.IDCurso = Curso.ID;


DROP VIEW IF EXISTS InscricaoEstudante;
CREATE VIEW InscricaoEstudante AS
   SELECT Inscricao.ID AS IDInscricao,
          Inscricao.Classificacao,
          Inscricao.IDAccao,
          Inscricao.DataInscricao,
          Estudante.ID AS IDEstudante,
          Estudante.Nome AS NomeEstudante,
          Estudante.Apelido AS Apelido
   FROM   Inscricao
   JOIN   Estudante
   ON     Inscricao.IDEstudante = Estudante.ID;


SELECT NomeEstudante, NomeCurso, Duracao
FROM   AccaoCurso
JOIN   InscricaoEstudante
ON     AccaoCurso.IDAccao = InscricaoEstudante.IDAccao
WHERE  NomeCurso IN ('Biologia', 'Agricultura Aplicada');


SELECT Nome, DataInscricao, NIF
FROM   Estudante, EstudanteTrabalhador
WHERE  Estudante.ID = EstudanteTrabalhador.IDEstudante;


SELECT NomeEstudante  AS 'Nome estudante', 
       NomeCurso      AS 'Curso', 
       DataInscricao  AS 'Data de inscricao', 
       NIF
FROM   AccaoCurso AS AC, InscricaoEstudante AS IE, EstudanteTrabalhador AS ET
WHERE  AC.IDAccao = IE.IDAccao AND
       IE.IDEstudante = ET.IDEstudante;


SELECT NomeEstudante  AS 'Nome estudante', 
       NomeCurso      AS 'Curso', 
       DataInscricao  AS 'Data de inscricao', 
       COALESCE(NIF, '<nao aplicavel>') AS NIF
FROM   InscricaoEstudante AS IE
JOIN   AccaoCurso AS AC
ON     IE.IDAccao = AC.IDAccao
LEFT OUTER JOIN EstudanteTrabalhador AS ET 
ON     IE.IDEstudante = ET.IDEstudante;


SELECT NomeEstudante, 
       Classificacao
FROM   InscricaoEstudante
ORDER BY Classificacao;


SELECT NomeEstudante,
       Classificacao,
       DataInscricao
FROM   InscricaoEstudante
ORDER BY Classificacao, DataInscricao ASC;


SELECT NomeEstudante, 
       Classificacao
FROM   InscricaoEstudante
ORDER BY Classificacao DESC
LIMIT 5;  -- ou LIMIT 0, 5


SELECT NomeEstudante, 
       Classificacao
FROM   InscricaoEstudante
ORDER BY Classificacao DESC
LIMIT 5, 5;


SELECT NomeEstudante, 
       Classificacao
FROM   InscricaoEstudante
ORDER BY Classificacao DESC
LIMIT 0, 7;


SELECT NomeEstudante, 
       Classificacao
FROM   (SELECT NomeEstudante, 
               Classificacao 
        FROM InscricaoEstudante
        ORDER BY Classificacao DESC
        LIMIT 7) AS M5
ORDER BY Classificacao ASC;


SELECT MAX(Classificacao), MIN(Classificacao), AVG(Classificacao)
FROM   InscricaoEstudante;


SELECT NomeCurso,
       Count(*) AS NumAccoes
FROM   AccaoCurso
GROUP BY NomeCurso;


SELECT IDAccao,
       AVG(Classificacao) AS Média
FROM   InscricaoEstudante
GROUP BY IDAccao;


SELECT C.ID, C.Nome, COUNT(I.IDEstudante), AVG(I.Classificacao)
FROM Inscricao AS I
JOIN Accao     AS A
ON   I.IDAccao = A.ID
JOIN Curso     AS C
ON   A.IDCurso = C.ID
GROUP BY C.ID;



