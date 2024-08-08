USE ENSINO;

DROP TABLE IF EXISTS Item;
CREATE TABLE Item (
	ID 		  INTEGER PRIMARY KEY AUTO_INCREMENT,
	Codigo	  VARCHAR(20) UNIQUE,
    Descricao VARCHAR(100)
-- );
) COLLATE utf8mb4_bin;

-- SHOW CHARACTER SET LIKE 'utf%';

INSERT INTO Item
	(Codigo, Descricao)
VALUES 
    ('A123#PQ',  'Mesa'),
    ('a123#PQ',  'Aparador'),
	('12X3#MJ',  'Sapato'),
	('K2X3#F1',  'Capacete')
;
    
-- Duplicate entry 'a123#PQ' for key 'Item.Codigo'
    
DELETE FROM Item;

SELECT * FROM Item WHERE Codigo RLIKE '^[A-Z]';
SELECT * FROM Item WHERE REGEXP_LIKE(Codigo, '^[A-Z]', 'c');

SELECT * FROM Item WHERE Codigo RLIKE '^[a-z]';
SELECT * FROM Item WHERE REGEXP_LIKE(Codigo, '^[a-z]', 'c');







SELECT 'A123 #PQ' RLIKE '^[A-Z]';

SELECT 'a123 #PQ' RLIKE '^[A-Z]';

SELECT REGEXP_LIKE('a123 #PQ', '^[A-Z]', 'c');
