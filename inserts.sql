----------------------
USE futebol;
GO
--INSERTS

INSERT INTO clube (nome_clube, nif_clube) VALUES
('Sporting CP', 123456789),
('SL Benfica', 223456789),
('FC Porto', 323456789),
('SC Braga', 423456789),
('Vitória SC', 523456789),
('Boavista FC', 623456789),
('Marítimo', 723456789),
('Belenenses', 823456789),
('Estoril Praia', 923456789),
('Rio Ave', 113456789),
('BestClub', 503456789),
('Desportivo Porto', 503466789)

INSERT INTO olheiro (nome_olheiro, email, data_contratacao) VALUES
('Carlos Mendes', 'cmendes@mail.com', '2015-06-12'),
('João Silva', 'jsilva@mail.com', '2017-03-08'),
('Ricardo Santos', 'rsantos@mail.com', '2016-01-20'),
('Pedro Costa', 'pcosta@mail.com', '2018-07-14'),
('Miguel Lopes', 'mlopes@mail.com', '2019-09-01'),
('André Gomes', 'agomes@mail.com', '2020-11-23'),
('Bruno Rocha', 'brocha@mail.com', '2014-04-02'),
('Luís Almeida', 'lalmeida@clubes.pt', '2021-02-18'),
('Fábio Ferreira', 'fferreira@mail.com', '2013-12-30'),
('Diogo Martins', 'dmartins@mail.com', '2022-05-10'),
('Joao Mendes', 'jmendes@clubes.pt', '2015-06-12')


INSERT INTO jogador (nome, idade, posicao, anos_carreira) VALUES
('Tiago Silva', 24, 'Médio', 5),
('Rui Costa', 28, 'Avançado', 8),
('André Pinto', 21, 'Defesa', 3),
('João Pereira', 30, 'Guarda-Redes', 10),
('Bruno Fernandes', 25, 'Médio', 7),
('Nuno Gomes', 26, 'Avançado', 6),
('Daniel Sousa', 22, 'Defesa', 4),
('Pedro Mendes', 27, 'Médio', 9),
('Fábio Coentrão', 29, 'Defesa', 11),
('Ricardo Carvalho', 31, 'Defesa', 12)


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2018-07-01', '2021-06-30'
FROM jogador j
JOIN clube c ON c.nome_clube = 'Sporting CP'
JOIN olheiro o ON o.nome_olheiro = 'João Silva'
WHERE j.nome = 'Tiago Silva';


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2017-01-15', '2020-01-14'
FROM jogador j
JOIN clube c ON c.nome_clube = 'SL Benfica'
JOIN olheiro o ON o.nome_olheiro = 'Carlos Mendes'
WHERE j.nome = 'Rui Costa';


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2019-08-20', '2022-08-19'
FROM jogador j
JOIN clube c ON c.nome_clube = 'FC Porto'
JOIN olheiro o ON o.nome_olheiro = 'Pedro Costa'
WHERE j.nome = 'André Pinto';


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2016-09-10', '2019-09-09'
FROM jogador j
JOIN clube c ON c.nome_clube = 'SC Braga'
JOIN olheiro o ON o.nome_olheiro = 'Ricardo Santos'
WHERE j.nome = 'João Pereira';


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2020-02-01', '2023-01-31'
FROM jogador j
JOIN clube c ON c.nome_clube = 'Vitória SC'
JOIN olheiro o ON o.nome_olheiro = 'Miguel Lopes'
WHERE j.nome = 'Bruno Fernandes';


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2022-07-01', '2025-06-30'
FROM jogador j
JOIN clube c ON c.nome_clube = 'Sporting CP'
JOIN olheiro o ON o.nome_olheiro = 'João Silva'
WHERE j.nome = 'Tiago Silva'


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2021-01-10', '2024-01-09'
FROM jogador j
JOIN clube c ON c.nome_clube = 'SL Benfica'
JOIN olheiro o ON o.nome_olheiro = 'Carlos Mendes'
WHERE j.nome = 'Rui Costa'


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2020-08-15', '2023-08-14'
FROM jogador j
JOIN clube c ON c.nome_clube = 'FC Porto'
JOIN olheiro o ON o.nome_olheiro = 'Pedro Costa'
WHERE j.nome = 'André Pinto'

INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2019-07-01', '2022-06-30'
FROM jogador j
JOIN clube c ON c.nome_clube = 'SC Braga'
JOIN olheiro o ON o.nome_olheiro = 'Miguel Lopes'
WHERE j.nome = 'Bruno Fernandes'


INSERT INTO contrato (id_jogador, id_clube, id_olheiro, data_inicio, data_fim)
SELECT j.id_jogador, c.id_clube, o.id_olheiro, '2023-01-01', '2026-01-01'
FROM jogador j
JOIN clube c ON c.nome_clube = 'Vitória SC'
JOIN olheiro o ON o.nome_olheiro = 'Diogo Martins'
WHERE j.nome = 'Ricardo Carvalho'
