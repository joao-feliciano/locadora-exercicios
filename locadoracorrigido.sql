CREATE TABLE endereco (
	cod_end SERIAL PRIMARY KEY, 
	logradouro varchar(40) not null,
	tipo_log varchar(40),
	complemento varchar(20),
	cidade varchar(60) not null, 
	uf varchar(2) not null,
	cep varchar(8) not null,
	numero varchar(10),
	bairro varchar(60) 
)

create table profissao(
	cod_prof SERIAL PRIMARY KEY,
	nome varchar(60)
)

create table cliente(
	cod_cli SERIAL PRIMARY KEY, 
	cpf varchar(11),
	nome varchar(60),
	telefone varchar(10),
	fk_cod_prof integer not null,
	foreign key (fk_cod_prof) references profissao(cod_prof)
)

--tabela associativa -> 2 clientes pode ter o mesmo endereço 
--cod_cli esta associando os clientes com seus respectivos endereços 
create table cli_endereco(
	fk_cod_end integer not null,
	fk_cod_cli integer not null,
	primary key(fk_cod_end, fk_cod_cli),
	foreign key (fk_cod_end) references endereco(cod_end),
	foreign key (fk_cod_cli) references cliente(cod_cli)
)

CREATE TABLE dependente(
	fk_cod_cli integer not null, --chave primaria composta - combinação do cod_cli com o cod_dep nao se repita 
	fk_cod_dep integer not null,
	primary key(fk_cod_cli, fk_cod_dep),
	foreign key (fk_cod_cli) references cliente(cod_cli),
	foreign key (fk_cod_dep) references cliente(cod_cli),
	parentesco varchar(20)
)

CREATE TABLE categoria(
	cod_cat SERIAL primary key,
	nome varchar(60),
	valor money
)

CREATE TABLE genero(
	cod_gen SERIAL primary key,
	nome varchar(60)
)

CREATE TABLE ator(
	cod_ator SERIAL primary key, 
	nome varchar(60)
)

CREATE TABLE filmes(
	cod_filme SERIAL primary key,
	titulo_original varchar(100),
	titulo varchar(100),
	quantidade int,
	fk_cod_cat integer not null,
	fk_cod_gen integer not null,
	foreign key (fk_cod_cat) references categoria(cod_cat),
	foreign key (fk_cod_gen) references genero(cod_gen) 
)

CREATE TABLE filme_ator(
	fk_cod_ator integer not null,
	fk_cod_filme integer not null,
	primary key(fk_cod_ator, fk_cod_filme),
	foreign key(fk_cod_ator) references ator(cod_ator),
	foreign key (fk_cod_filme) references filmes(cod_filme),
	diretor varchar(1)
)

CREATE TABLE locacao(
	cod_loc SERIAL primary key,
	data_loc date,
	desconto money,
	multa money,
	sub_total money,
	fk_cod_cli integer not null,
	foreign key (fk_cod_cli) references cliente(cod_cli)
)

CREATE TABLE locacao_filme(
	fk_cod_loc integer not null,
	fk_cod_filme integer not null,
	primary key(fk_cod_loc, fk_cod_filme),
	valor money,
	num_dias int,
	data_devol date
)

INSERT INTO profissao (nome) VALUES
('Desenvolvedor Junior'), 
('Desenvolvedor Pleno'),
('Desenvolvedor Senior');

select * from profissao
			
INSERT INTO endereco (logradouro, tipo_log, complemento, cidade, uf, cep, numero, bairro) VALUES
('Rua dos bobos', 'Residencial', 'Apto 101', 'Cidade A', 'SP', '12345678', '0', 'Bairro A'),
('Rua dos Alfeneieros', 'Comercial', 'Loja 2', 'Cidade B', 'RJ', '87654321', '4', 'Bairro B'),
('Rua sem nome', 'Residencial', 'Casa', 'Cidade C', 'MG', '13579135', '30', 'Bairro C');

select * from endereco
delete from cliente where cod_cli = 16
INSERT INTO cliente (cpf, nome, telefone, fk_cod_prof) VALUES
('12345678901', 'Axl Rose', '999999999', 1),
('12345678902', 'Freddie Mercury', '988888888', 2),
('12345678903', 'Paul McCartney', '977777777', 3),
('12345678904', 'John Lennon', '966666666', 1),
('12345678905', 'John Escrevennon', '955555555', 2),
('12345678906', 'Elton John', '944444444', 3),
('12345678907', 'Chester Bennington', '933333333', 1),
('12345678908', 'Steven Tyler', '922222222', 2),
('12345678909', 'Bon Scott', '911111111', 3),
('12345678910', 'Mau Scott', '900000000', 1);

select * from cliente

INSERT INTO cli_endereco (fk_cod_end, fk_cod_cli) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 4),
(2, 5),
(3, 6),
(1, 7),
(2, 8),
(3, 9),
(1, 10);

select * from cli_endereco

-- Exemplo de inserção de dependentes para cada cliente
INSERT INTO dependente (fk_cod_cli, fk_cod_dep, parentesco) VALUES
    (1, 1, 'Filho'), 
    (2, 2, 'Filha'),   
    (3, 3, 'Filho'),   
    (4, 4, 'Filha'),   
    (5, 5, 'Filho'),   
    (6, 6, 'Filha'),   
    (7, 7, 'Filho'),   
    (8, 8, 'Filha'),   
    (9, 9, 'Filho'),   
    (10, 10, 'Filha');  

select * from dependente
delete from categoria where cod_cat = 10
INSERT INTO categoria (nome, valor) VALUES
('Ação', 10.00),
('Comédia', 8.00),
('Drama', 9.00),
('Ficção Científica', 12.00),
('Terror', 7.00);

select * from categoria
	
INSERT INTO genero (nome) VALUES
('Aventura'),
('Comédia'),
('Drama'),
('Ficção Científica'),
('Terror');

select * from genero

	
INSERT INTO ator (nome) VALUES
('Robert Downey Jr.'),
('Chris Evans'),
('Scarlett Johansson'),
('Mark Ruffalo'),
('Chris Hemsworth');

select * from ator

INSERT INTO filmes (titulo_original, titulo, quantidade, fk_cod_cat, fk_cod_gen) VALUES
('The Avengers', 'Os Vingadores', 10, 1, 1),
('Iron Man', 'Homem de Ferro', 5, 1, 1),
('Thor', 'Thor', 7, 1, 1),
('Captain America', 'Capitão América', 6, 1, 1),
('The Hulk', 'O Hulk', 4, 1, 1),
('Black Widow', 'Viúva Negra', 8, 1, 3),
('Ant-Man', 'Homem-Formiga', 3, 1, 1),
('Guardians of the Galaxy', 'Guardiões da Galáxia', 9, 1, 4),
('Doctor Strange', 'Doutor Estranho', 7, 1, 4),
('Spider-Man', 'Homem-Aranha', 5, 1, 1),
('Avengers: Age of Ultron', 'Vingadores: Era de Ultron', 6, 1, 1),
('Avengers: Infinity War', 'Vingadores: Guerra Infinita', 7, 1, 1),
('Avengers: Endgame', 'Vingadores: Ultimato', 8, 1, 1),
('Captain Marvel', 'Capitã Marvel', 4, 1, 3),
('Black Panther', 'Pantera Negra', 6, 1, 3);

select * from filmes

INSERT INTO filme_ator (fk_cod_ator, fk_cod_filme, diretor) VALUES
(1, 1, 'S'),
(2, 1, 'N'),
(3, 1, 'N'),
(4, 1, 'N'),
(5, 1, 'N'),
(1, 2, 'S'),
(2, 3, 'N'),
(3, 4, 'N'),
(4, 5, 'N'),
(5, 6, 'N');

select * from filme_ator

-- Inserir locações
INSERT INTO locacao (data_loc, desconto, multa, sub_total, fk_cod_cli)
VALUES
    ('2024-06-01', 10.00, 0.70, 50.00, 1),
    ('2024-06-02', 5.00, 0.90, 30.00, 2),
    ('2024-06-03', 0.00, 0.00, 40.00, 3),
    ('2024-06-04', 0.00, 0.00, 25.00, 4),
    ('2024-06-05', 15.00, 0.60, 70.00, 5),
    ('2024-06-06', 0.00, 0.00, 60.00, 6),
    ('2024-06-07', 5.00, 0.00, 35.00, 7),
    ('2024-06-08', 0.00, 0.00, 20.00, 8),
    ('2024-06-09', 10.00, 0.00, 55.00, 9),
    ('2024-06-10', 0.00, 0.99, 45.00, 10),
    ('2024-06-11', 0.00, 0.00, 65.00, 1),
    ('2024-06-12', 5.00, 5.00, 40.00, 2),
    ('2024-06-13', 0.00, 3.80, 30.00, 3),
    ('2024-06-14', 0.00, 0.00, 15.00, 4),
    ('2024-06-15', 10.00, 2.00, 80.00, 5),
    ('2024-06-16', 0.00, 0.00, 55.00, 6),
    ('2024-06-17', 5.00, 4.00, 25.00, 7),
    ('2024-06-18', 0.00, 0.00, 10.00, 8),
    ('2024-06-19', 10.00, 9.00, 60.00, 9),
    ('2024-06-20', 0.00, 0.00, 50.00, 10);


select * from locacao

	
INSERT INTO locacao_filme (fk_cod_loc, fk_cod_filme, valor, num_dias, data_devol) VALUES
	(1, 1, 10.00, 2, '2024-06-03'),   -- Locação 1, Filme 1
    (1, 2, 8.00, 3, '2024-06-05'),   -- Locação 1, Filme 2
    (2, 3, 12.00, 1, '2024-06-04'),  -- Locação 2, Filme 3
    (2, 4, 7.00, 2, '2024-06-06'),   -- Locação 2, Filme 4
    (3, 5, 15.00, 3, '2024-06-07'),  -- Locação 3, Filme 5
    (3, 6, 10.00, 2, '2024-06-09'),  -- Locação 3, Filme 6
    (4, 7, 8.00, 1, '2024-06-10'),   -- Locação 4, Filme 7
    (4, 8, 5.00, 3, '2024-06-11'),   -- Locação 4, Filme 8
    (5, 9, 20.00, 2, '2024-06-12'),  -- Locação 5, Filme 9
    (5, 10, 18.00, 4, '2024-06-14'), -- Locação 5, Filme 10
    (6, 11, 10.00, 1, '2024-06-15'), -- Locação 6, Filme 11
    (6, 12, 7.00, 2, '2024-06-17'),  -- Locação 6, Filme 12
    (7, 13, 12.00, 3, '2024-06-18'), -- Locação 7, Filme 13
    (7, 14, 9.00, 1, '2024-06-20'),  -- Locação 7, Filme 14
    (8, 15, 18.00, 2, '2024-06-21'), -- Locação 8, Filme 15
    (8, 1, 15.00, 3, '2024-06-23'),  -- Locação 8, Filme 1
    (9, 2, 7.00, 1, '2024-06-25'),   -- Locação 9, Filme 2
    (9, 3, 10.00, 4, '2024-06-26'),  -- Locação 9, Filme 3
    (10, 4, 12.00, 2, '2024-06-28'), -- Locação 10, Filme 4
    (10, 5, 9.00, 3, '2024-06-30'),  -- Locação 10, Filme 5
    (11, 6, 15.00, 1, '2024-07-01'), -- Locação 11, Filme 6
    (11, 7, 11.00, 2, '2024-07-03'), -- Locação 11, Filme 7
    (12, 8, 18.00, 3, '2024-07-05'), -- Locação 12, Filme 8
    (12, 9, 10.00, 1, '2024-07-07'), -- Locação 12, Filme 9
    (13, 10, 7.00, 2, '2024-07-08'), -- Locação 13, Filme 10
    (13, 11, 12.00, 3, '2024-07-10'),-- Locação 13, Filme 11
    (14, 12, 15.00, 1, '2024-07-11'),-- Locação 14, Filme 12
    (14, 13, 8.00, 2, '2024-07-13'), -- Locação 14, Filme 13
    (15, 14, 10.00, 3, '2024-07-15'), -- Locação 15, Filme 14
    (15, 15, 17.00, 1, '2024-07-16'); -- Locação 15, Filme 15




select * from locacao_filme
	
--EXERCICIO 01 - todos os filmes alugados por um cliente específico, incluindo a data de locação e a data de devolução

SELECT cliente.nome, filmes.titulo, locacao_filme.data_devol, locacao.data_loc
FROM locacao_filme 
JOIN locacao ON locacao_filme.fk_cod_loc = locacao.cod_loc
JOIN filmes ON locacao_filme.fk_cod_filme = filmes.cod_filme
JOIN cliente ON locacao.fk_cod_cli = cliente.cod_cli
WHERE cliente.nome = 'Axl Rose';

--EXERCICIO 02 - Obter uma lista de clientes e seus dependentes.
SELECT *
FROM cliente
JOIN dependente ON cliente.cod_cli = dependente.fk_cod_cli;

--EXERCICIO 03 -  Listar todos os filmes de um determinado gênero.
SELECT *
from filmes
JOIN genero ON filmes.fk_cod_gen = genero.cod_gen
WHERE genero.nome = 'Drama'

--EXERCICIO 04 - Exibir todos os clientes que têm uma profissão específica.
SELECT cliente.nome AS cliente, profissao.nome AS profissao
FROM cliente
JOIN profissao ON cliente.fk_cod_prof = profissao.cod_prof
WHERE profissao.nome = 'Desenvolvedor Pleno';

--EXERCICIO 05 - Encontrar todos os filmes em uma categoria específica com quantidade disponível maior que 5.
SELECT filmes.titulo, categoria.nome, filmes.quantidade
from filmes
JOIN categoria ON filmes.fk_cod_cat = categoria.cod_cat
WHERE quantidade > 5;

--EXERCICIO 06 - Listar todos os atores que participaram de filmes com um determinado título.
SELECT ator.nome, filmes.titulo
FROM ator
JOIN filme_ator ON ator.cod_ator = filme_ator.fk_cod_ator
JOIN filmes ON filme_ator.fk_cod_filme = filmes.cod_filme
WHERE filmes.titulo = 'Capitão América';

--EXERCICIO 07 - Obter o endereço completo de um cliente específico.
SELECT endereco.logradouro, endereco.numero, endereco.complemento, endereco.bairro, endereco.cidade, endereco.uf, endereco.cep
FROM endereco
JOIN cli_endereco ON endereco.cod_end = cli_endereco.fk_cod_end
JOIN cliente ON cli_endereco.fk_cod_cli = cliente.cod_cli
WHERE cliente.nome = 'Freddie Mercury';

--EXERCICIO 08 - Listar todos os filmes e seus respectivos gêneros e categorias.
SELECT filmes.titulo, genero.nome AS genero, categoria.nome AS categoria
FROM filmes
JOIN genero ON filmes.fk_cod_gen = genero.cod_gen
JOIN categoria ON filmes.fk_cod_cat = categoria.cod_cat;

--EXERCICIO 09 - Mostrar todos os clientes que alugaram um filme específico e a data de locação.
SELECT cliente.nome AS Cliente, locacao.data_loc AS Data_Locacao
FROM cliente
JOIN locacao ON cliente.cod_cli = locacao.fk_cod_cli
JOIN locacao_filme ON locacao.cod_loc = locacao_filme.fk_cod_loc
JOIN filmes ON locacao_filme.fk_cod_filme = filmes.cod_filme
WHERE filmes.titulo = 'Homem de Ferro';  

--EXERCICIO 10 - Exibir a lista de clientes com multas superiores a um valor específico.
SELECT cliente.nome AS Cliente, locacao.multa
FROM cliente
JOIN locacao ON cliente.cod_cli = locacao.fk_cod_cli
WHERE locacao.multa::numeric > 2.00;  --locacao.multa::numeric - convertendo multa para o tipo numeric

--EXERCICIO 11 - Listar todas as locações feitas em um período específico.
SELECT locacao.cod_loc AS Cod_Locacao, cliente.nome AS Cliente, locacao.data_loc AS Data_Locacao
FROM locacao
JOIN cliente ON locacao.fk_cod_cli = cliente.cod_cli
WHERE locacao.data_loc BETWEEN '2024-06-01' AND '2024-06-05'; 

--EXERCICIO 12 - Obter a quantidade total de filmes alugados por cada cliente. 
SELECT cliente.nome AS Cliente, COUNT(locacao_filme.fk_cod_filme) AS Total_Filmes_Alugados
FROM cliente
JOIN locacao ON cliente.cod_cli = locacao.fk_cod_cli
JOIN locacao_filme ON locacao.cod_loc = locacao_filme.fk_cod_loc
GROUP BY cliente.nome;

--EXERCICIO 13 - Listar os clientes e os filmes que eles alugaram, ordenados por data de locação.
SELECT cliente.nome AS Cliente, filmes.titulo AS Filme, locacao.data_loc AS Data_Locacao
FROM cliente
JOIN locacao ON cliente.cod_cli = locacao.fk_cod_cli
JOIN locacao_filme ON locacao.cod_loc = locacao_filme.fk_cod_loc
JOIN filmes ON locacao_filme.fk_cod_filme = filmes.cod_filme
ORDER BY locacao.data_loc;

--EXERCICIO 14 - Mostrar todos os clientes que moram em uma cidade específica e que alugaram filmes de uma categoria específica.
SELECT DISTINCT cliente.nome AS cliente, endereco.cidade, categoria.nome AS categoria
FROM cliente
JOIN cli_endereco ON cliente.cod_cli = cli_endereco.fk_cod_cli
JOIN endereco ON cli_endereco.fk_cod_end = endereco.cod_end
JOIN locacao ON cliente.cod_cli = locacao.fk_cod_cli
JOIN locacao_filme ON locacao.cod_loc = locacao_filme.fk_cod_loc
JOIN filmes ON locacao_filme.fk_cod_filme = filmes.cod_filme
JOIN categoria ON filmes.fk_cod_cat = categoria.cod_cat
WHERE endereco.cidade = 'Cidade A'  
  AND categoria.nome = 'Ação';  

--EXERCICIO 15 - Encontrar todos os atores que participaram de pelo menos 5 filmes, listando o nome do ator e o número de filmes em que atuou. (DESAFIO)
SELECT ator.nome AS Ator, COUNT(filme_ator.fk_cod_filme) AS Numero_Filmes
FROM ator
JOIN filme_ator ON ator.cod_ator = filme_ator.fk_cod_ator
GROUP BY ator.nome
HAVING COUNT(filme_ator.fk_cod_filme) >= 5; 

--EXERCICIO 16 - Exibir a quantidade total de filmes alugados por categoria e gênero, incluindo apenas as categorias e gêneros que têm mais de 5 filmes alugados no total (DESAFIO)
SELECT categoria.nome AS Categoria, genero.nome AS Genero, COUNT(locacao_filme.fk_cod_filme) AS Total_Filmes_Alugados
FROM locacao_filme
JOIN filmes ON locacao_filme.fk_cod_filme = filmes.cod_filme
JOIN categoria ON filmes.fk_cod_cat = categoria.cod_cat
JOIN genero ON filmes.fk_cod_gen = genero.cod_gen
GROUP BY categoria.nome, genero.nome
HAVING COUNT(locacao_filme.fk_cod_filme) > 5;

