----------------
USE futebol;
GO
--Queries Simples

--1. Listar todos os jogadores.
SELECT *
FROM jogador

--2. Mostrar os nomes e posições dos jogadores com mais de 10 anos de carreira.

SELECT *
FROM jogador
WHERE anos_carreira > 10

--3. Listar os clubes com NIF iniciado por '50'.

SELECT nome_clube
FROM clube
WHERE nif_clube LIKE '50%'

--4. Mostrar os emails dos olheiros contratados após 2020.

SELECT email
FROM olheiro
WHERE YEAR(data_contratacao) > 2020

--5. Listar os jogadores com idade entre 25 e 30 anos.

SELECT nome
FROM jogador
WHERE idade BETWEEN 25 AND 30

--6. Listar jogadores cujo nome começa por 'Jo'.

SELECT nome
FROM jogador 
WHERE nome LIKE 'Jo%'

--7. Listar olheiros cujo email termina em '@clubes.pt'.

SELECT *
FROM olheiro
WHERE email LIKE '%@clubes.pt'

--8. Listar clubes que tenham 'Desportivo' no nome.

SELECT *
FROM clube
WHERE nome_clube LIKE '%Desportivo%'

--9. Listar jogadores cuja posição contenha 'Avan'

SELECT *
FROM jogador
WHERE posicao LIKE '%Avan%'

--10. Listar clubes cujo nome contenha simultaneamente as letras 'a' e 'o'.

SELECT *
FROM clube
WHERE nome_clube LIKE '%a%' 
	AND nome_clube LIKE '%o%'

--------

--Queries com JOINS

--1. Listar nomes dos jogadores e o nome do clube onde têm contrato.

SELECT j.nome, c.nome_clube
FROM clube AS c
LEFT JOIN contrato AS ct ON c.id_clube=ct.id_clube
LEFT JOIN jogador AS j ON ct.id_jogador=j.id_jogador
WHERE ct.id_clube IS NOT NULL

--2. Mostrar os jogadores e o nome do olheiro responsável por cada contrato.

SELECT j.*, o.nome_olheiro
FROM jogador AS j
INNER JOIN contrato AS c ON j.id_jogador=c.id_jogador
INNER JOIN olheiro AS o ON c.id_olheiro=o.id_olheiro
ORDER BY j.nome ASC

--3. Listar clubes e jogadores que já passaram por eles.

SELECT DISTINCT c.nome_clube AS 'Nome do clube', j.nome AS 'Nome do jogador'
FROM clube AS c
INNER JOIN contrato AS ct ON c.id_clube=ct.id_clube
INNER JOIN jogador AS j ON ct.id_jogador=j.id_jogador

--4. Mostrar todos os jogadores sem contrato

SELECT DISTINCT j.*
FROM jogador AS j
LEFT JOIN contrato AS c ON j.id_jogador=c.id_jogador
WHERE c.id_clube IS NULL

--5. Mostrar todos os clubes e o número de contratos por clube.

SELECT c.nome_clube AS 'Nome do clube', COUNT(ct.id_clube) AS 'Número de contratos'
FROM clube AS c
LEFT JOIN contrato AS ct ON c.id_clube=ct.id_clube
GROUP BY c.nome_clube
ORDER BY c.nome_clube ASC

--6. Jogadores com mais de 2 contratos

SELECT j.nome
FROM jogador AS j
INNER JOIN contrato AS c ON j.id_jogador=c.id_jogador
GROUP BY j.nome
HAVING COUNT(c.id_jogador) > 2

--7. Olheiros com contratos em mais de 3 clubes diferentes

SELECT o.nome_olheiro
FROM olheiro AS o
INNER JOIN contrato AS ct ON o.id_olheiro=ct.id_olheiro
GROUP BY o.nome_olheiro
HAVING COUNT(DISTINCT ct.id_clube) > 3

--8. Clubes que contrataram mais de 4 jogadores diferentes

SELECT c.nome_clube
FROM clube AS c
INNER JOIN contrato AS ct ON c.id_clube=ct.id_clube
GROUP BY c.nome_clube
HAVING COUNT(DISTINCT ct.id_jogador) > 4


------------------
--Funções de Agregação (SUM, AVG, MAX, MIN, COUNT)

--1. Mostrar o número total de jogadores.

SELECT COUNT(*) AS 'Número total de jogadores'
FROM jogador

--2. Calcular a média de idade dos jogadores.

SELECT AVG(idade) AS 'Média da idade'
FROM jogador

--3. Obter a idade máxima e mínima dos jogadores

SELECT MAX(idade) AS 'Máxima idade', MIN(idade) AS 'Mínima idade'
FROM jogador

--4. Contar o total de contratos por olheiro.

SELECT o.nome_olheiro AS 'Olheiro', COUNT(ct.id_contrato) AS 'Número de contratos'
FROM olheiro AS o
INNER JOIN contrato AS ct ON o.id_olheiro=ct.id_olheiro
GROUP BY o.nome_olheiro
ORDER BY o.nome_olheiro ASC

--5. Somar os anos de carreira de todos os jogadores.

SELECT SUM(anos_carreira) AS 'Total de anos de carreira'
FROM jogador

----------------

--Subqueries (SNC e SC)

--1. Mostrar os jogadores com mais idade que a média (SNC).

SELECT nome AS 'Jogadores com idade maior do que a média'
FROM jogador
WHERE idade > (
	SELECT AVG(idade)
	FROM jogador)

--2. Listar os clubes com pelo menos um jogador com mais de 10 anos de carreira (SNC).

SELECT nome_clube AS 'Nome do clube'
FROM clube c
INNER JOIN contrato ct ON ct.id_clube=c.id_clube
WHERE ct.id_jogador IN
	(SELECT id_jogador
	FROM jogador
	WHERE anos_carreira > 10)


--3. Mostrar os olheiros que nunca intermediaram um contrato (SNC).


SELECT o.*
FROM olheiro AS o
WHERE o.id_olheiro NOT IN
	(SELECT c.id_olheiro
	FROM contrato AS c)

-- outra forma

SELECT o.*
FROM olheiro AS o
WHERE NOT EXISTS (
    SELECT 1
    FROM contrato AS c
    WHERE c.id_olheiro = o.id_olheiro
)


--4. Apresentar os jogadores e o número total de contratos de cada um (SC).


SELECT j0.id_jogador AS 'Id jogador', j0.nome AS 'Nome do jogador',
	(SELECT COUNT(c1.id_jogador)
	FROM contrato AS c1
	WHERE c1.id_jogador = j0.id_jogador) AS 'Total de contratos'
FROM jogador AS j0

	
--5. Listar os clubes onde todos os jogadores contratados têm mais de 5 anos de carreira (SC)

SELECT c.nome_clube AS 'Nome do clube' 
FROM clube AS c
WHERE c.id_clube = ANY (SELECT c1.id_clube
	FROM jogador j
	INNER JOIN contrato AS c1 ON c1.id_jogador=j.id_jogador
	WHERE c.id_clube=c1.id_clube
	GROUP BY c1.id_clube
	HAVING SUM(j.anos_carreira) > 5
	
)
ORDER BY c.nome_clube 


--Outra resolução
SELECT c.nome_clube AS 'Nome do clube'
FROM clube AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM contrato AS co
    INNER JOIN jogador AS j ON j.id_jogador = co.id_jogador
    WHERE co.id_clube = c.id_clube
      AND j.anos_carreira <= 5
)


SELECT c.nome_clube AS 'Nome do clube'
FROM clube AS c
WHERE 5 < ALL (
    SELECT j.anos_carreira
    FROM contrato AS co
    INNER JOIN jogador AS j ON j.id_jogador = co.id_jogador
    WHERE co.id_clube = c.id_clube
)
--id jogador
--3, 1

--id clube
--3,1

--nome
--FC porto, sporting cp


select *
from contrato