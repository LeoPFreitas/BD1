CREATE USER IF NOT EXISTS projectUser IDENTIFIED BY 'fakepassword';

-- DDL
DROP DATABASE IF EXISTS project;
CREATE DATABASE project;

USE project;

CREATE TABLE IF NOT EXISTS pessoa
(
    id              bigint primary key auto_increment unique not null,
    email           varchar(100) unique                      not null,
    cpf             varchar(14) unique                       not null,
    nome_completo   varchar(100)                             not null,
    data_nascimento date,
    rg              varchar(12),
    sexo            enum ('M', 'F'),
    cep             int(8),
    estado          char(2),
    cidade          varchar(50),
    bairro          varchar(50),
    rua             varchar(100),
    numero          integer
);

CREATE TABLE IF NOT EXISTS cliente
(
    id     bigint unique not null primary key,
    pontos int check ( pontos >= 0 ),

    FOREIGN KEY (id)
        REFERENCES pessoa (id)
);

CREATE TABLE IF NOT EXISTS funcionario
(
    id      bigint unique not null primary key,
    salario decimal(15, 2),
    turno   enum ('M', 'T', 'N'),
    cargo   varchar(50),

    FOREIGN KEY (id)
        REFERENCES pessoa (id)
);

CREATE TABLE IF NOT EXISTS categoria
(
    id        bigint primary key auto_increment unique not null,
    descricao text
);

CREATE TABLE IF NOT EXISTS ingrediente
(
    id        bigint primary key auto_increment unique not null,
    nome      varchar(100),
    descricao text
);

CREATE TABLE IF NOT EXISTS bolo
(
    id        bigint primary key auto_increment unique not null,
    categoria bigint,
    nome      varchar(50),
    descricao text,
    tipo      varchar(30),
    peso      integer check ( peso > 0 ),
    sabor     varchar(40),

    FOREIGN KEY (categoria)
        REFERENCES pessoa (id)
);

CREATE TABLE IF NOT EXISTS venda
(
    id_venda         bigint primary key auto_increment unique not null,
    data             date,
    valor            decimal(13, 4),
    metodo_pagamento varchar(50),
    quantidade       integer,
    id_cliente       bigint,
    id_funcionario   bigint,

    FOREIGN KEY (id_cliente)
        REFERENCES cliente (id),
    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id)
);

CREATE TABLE IF NOT EXISTS telefone
(
    id_pessoa bigint,
    telefone  bigint(14),

    PRIMARY KEY (id_pessoa, telefone),
    FOREIGN KEY (id_pessoa)
        REFERENCES pessoa (id)
);

CREATE TABLE IF NOT EXISTS dependente
(
    id              bigint unique not null,
    id_funcionario  bigint,
    nome            varchar(100),
    data_nascimento date,

    PRIMARY KEY (id, id_funcionario),
    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id)
);

CREATE TABLE IF NOT EXISTS bolo_ingrediente
(
    id_bolo        bigint,
    id_ingrediente bigint,
    quantidade     integer,

    PRIMARY KEY (id_bolo, id_ingrediente),
    FOREIGN KEY (id_bolo)
        REFERENCES bolo (id),
    FOREIGN KEY (id_ingrediente)
        REFERENCES ingrediente (id)
);

CREATE TABLE IF NOT EXISTS venda_bolo
(
    id_bolo    bigint,
    id_venda   bigint,
    quantidade integer,

    PRIMARY KEY (id_bolo, id_venda),
    FOREIGN KEY (id_bolo)
        REFERENCES bolo (id),
    FOREIGN KEY (id_venda)
        REFERENCES venda (id_venda)
);

CREATE TRIGGER upperCaseOnInsertPerson
    BEFORE INSERT
    ON pessoa
    FOR EACH ROW
    SET NEW.sexo = UPPER(NEW.sexo);

CREATE TRIGGER upperCaseOnInsertState
    BEFORE INSERT
    ON pessoa
    FOR EACH ROW
    SET NEW.estado = UPPER(NEW.estado);

-- DML
-- Pessoa
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('leonardo.cadu2@gmail.com', '470.470.478-44', 'Leonardo Freitas', '1997-12-20', '50.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('leonardo.cadu3@gmail.com', '470.470.478-40', 'Leonardo Freitas', '1997-12-20', '40.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('a@a.com', '270.443.478-44', 'Pessoa 1', '2010-12-20', '50.435.555-5', 'm', 'rj');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('b@b.com', '432.443.478-44', 'Pessoa 2', '1990-12-20', '50.435.521-5', 'f', 'rj');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('c@c.com', '127.443.478-44', 'Pessoa 3', '2010-12-20', '50.435.555-1', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('d@d.com', '443.470.478-44', 'Pessoa 4', '1997-12-20', '50.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('LEONARDO.cadu2@gsail.com', '443.470.478-41', 'Pessoa 5', '1997-12-20', '50.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('s@gmail.com', '443.470.478-42', 'Pessoa 6', '1997-12-20', '50.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('lala@gmail.com', '443.470.478-43', 'Pessoa 7', '1997-12-20', '50.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('pero@hotmail.com', '443.470.478-46', 'Pessoa 8', '1997-12-20', '50.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('te@te.com', '443.470.478-47', 'Pessoa 9', '1997-12-20', '50.555.555-5', 'm', 'sp');
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('S@ds.com', '443.470.478-48', 'Pessoa 10', '1997-12-20', '50.555.555-5', 'm', 'sp');

-- Funcionario
INSERT INTO funcionario(id, salario, turno, cargo)
VALUES (1, 5000.00, 'M', 'Vendedor');
INSERT INTO funcionario(id, salario, turno, cargo)
VALUES (2, 15000.00, 'N', 'Vendedor');
INSERT INTO funcionario(id, salario, turno, cargo)
VALUES (3, 325000.00, 'N', 'Caixa');
INSERT INTO funcionario(id, salario, turno, cargo)
VALUES (4, 1000.00, 'N', 'Vendedor');

-- Cliente
INSERT INTO cliente(id, pontos)
VALUES (3, 20);
INSERT INTO cliente(id, pontos)
VALUES (4, 200);
INSERT INTO cliente(id, pontos)
VALUES (5, 0);
INSERT INTO cliente(id, pontos)
VALUES (6, 10);
INSERT INTO cliente(id, pontos)
VALUES (7, 2134);
INSERT INTO cliente(id, pontos)
VALUES (8, 1344);
INSERT INTO cliente(id, pontos)
VALUES (9, 32);
INSERT INTO cliente(id, pontos)
VALUES (10, 1234);

-- Categoria
INSERT INTO categoria (id, descricao)
VALUES (1, 'cat 1');
INSERT INTO categoria (id, descricao)
VALUES (2, 'cat 2');
INSERT INTO categoria (id, descricao)
VALUES (3, 'cat 3');

-- Ingrediente
INSERT INTO ingrediente (id, nome, descricao)
VALUES (1, 'Chocolate', 'Chocolate do fino');
INSERT INTO ingrediente (id, nome, descricao)
VALUES (2, 'Doce de leite', 'Descricao');
INSERT INTO ingrediente (id, nome, descricao)
VALUES (3, 'Acucar', 'Descricao');
INSERT INTO ingrediente (id, nome, descricao)
VALUES (4, 'Chocolate 2', 'Ingrediente 4');
INSERT INTO ingrediente (id, nome, descricao)
VALUES (5, 'Chocolate 3', 'ingrediente 5');

-- Bolo
INSERT INTO bolo (categoria, nome, descricao, tipo, peso, sabor)
VALUES (1, 'bolo 1', 'descricao 1', 'festa', 1200, 'chocolate');
INSERT INTO bolo (categoria, nome, descricao, tipo, peso, sabor)
VALUES (2, 'bolo 2', 'descricao 2', 'festa', 2200, 'doce de leite');
INSERT INTO bolo (categoria, nome, descricao, tipo, peso, sabor)
VALUES (2, 'bolo 3', 'descricao 3', 'gigante', 11200, 'doce de leite');
INSERT INTO bolo (categoria, nome, descricao, tipo, peso, sabor)
VALUES (4, 'bolo 4', 'descricao 4', 'casamento', 340, 'chocolate');
INSERT INTO bolo (categoria, nome, descricao, tipo, peso, sabor)
VALUES (5, 'bolo 5', 'descricao 5', 'fit', 12030, 'doce de leite');
INSERT INTO bolo (categoria, nome, descricao, tipo, peso, sabor)
VALUES (6, 'bolo 6', 'descricao 6', 'colorido', 13200, 'doce de leite');

-- Venda
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'cartao', 2, 3, 1);
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'cartao', 1, 4, 1);
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'cartao', 2, 3, 1);
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'cartao', 1, 4, 1);
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'dinheiro', 2, 5, 2);
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'dinheiro', 1, 6, 2);
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'dinheiro', 2, 3, 1);
INSERT INTO venda (data, valor, metodo_pagamento, quantidade, id_cliente, id_funcionario)
VALUES ('2020-02-10', 1212, 'boleto', 1, 8, 1);

-- Telefone
INSERT INTO telefone (id_pessoa, telefone)
VALUES (1, 11963476347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (1, 11963432347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (2, 11496348747);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (1, 44363476347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (2, 11963476347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (3, 11963432347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (4, 11496348747);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (5, 44363476347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (6, 11963476347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (7, 11963432347);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (6, 11496348747);
INSERT INTO telefone (id_pessoa, telefone)
VALUES (1, 44363486347);

-- Dependente
INSERT INTO dependente (id, id_funcionario, nome, data_nascimento)
VALUES (1, 1, 'Pietra', '1993-02-10');
INSERT INTO dependente (id, id_funcionario, nome, data_nascimento)
VALUES (2, 1, 'Dep 2', '1993-02-10');
INSERT INTO dependente (id, id_funcionario, nome, data_nascimento)
VALUES (3, 2, 'Dep 3', '1993-02-10');

-- bolo_ingrediente
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (1, 1, 3);
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (1, 4, 3);
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (1, 5, 3);
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (1, 2, 3);
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (1, 3, 3);
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (2, 5, 3);
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (2, 2, 3);
INSERT INTO bolo_ingrediente (id_bolo, id_ingrediente, quantidade)
VALUES (3, 3, 3);

-- venda_bolo
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (1, 2, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (2, 2, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (3, 2, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (3, 3, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (1, 4, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (5, 5, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (3, 6, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (2, 7, 3);
INSERT INTO venda_bolo (id_bolo, id_venda, quantidade)
VALUES (2, 8, 3);

-- 3 consultas simples (em uma única tabela) e que façam filtros utilizando AND e OR. No mínimo uma delas deve usar a cláusula ORDER BY.
-- Retorna o todos funcionarios que trabalham no turno da noite e possuem o cargo de vendedor
SELECT t.*
FROM project.funcionario t
WHERE t.turno = 'N'
  AND t.cargo = 'Vendedor'
ORDER BY id;

-- Retorna todas os campos dos bolo que possuem a categoria 1 ou 2
SELECT b.*
FROM project.bolo b
WHERE b.categoria = 1
   OR b.categoria = 2
ORDER BY categoria;

-- Retorna todos o clientes que possuem pontuacao superior a 100 e ordena descrente por pontuacao
SELECT c.id as cliente_id, c.pontos
FROM project.cliente c
WHERE c.pontos > 100
ORDER BY pontos desc;

-- 2 consultas que utilizem funções de manipulação de caracteres (LIKE, SUBSTR, LENGTH, UPPER, etc)
-- Retorna o nome completo maiusculo e o rg das pessoas cujo email comeca com 'leo' e possuem o rg que comeca com 50
SELECT upper(p.nome_completo), p.rg
FROM pessoa p
WHERE 'leo' = substr(p.email, 1, 3)
  AND p.rg like '50%';

-- Retorna o nome em minusculo, o estado em maiusculo e o tamanho do nome das pessoa que são do estado RJ
SELECT lower(p.nome_completo), upper(p.estado), length(p.nome_completo) as tamanho_nome
FROM pessoa p
WHERE LOWER(p.estado) = 'rj';

-- 2 consultas que utilizem inner join de duas tabelas
-- Retorna o nome completo, quantidade de pontos, id e quantidade de telefones dos clientes
SELECT p.nome_completo, c.pontos, c.id as cliente_id, count(t.telefone) as qnt_telefones
FROM cliente c
         INNER JOIN pessoa p on c.id = p.id
         INNER JOIN telefone t ON t.id_pessoa = c.id
group by c.id, c.pontos, p.nome_completo, c.id;

-- Retorna o nome do funcionario, seu salario e o nome do dependente
SELECT f.salario, p.nome_completo, d.nome as dep_nome
FROM funcionario f
         INNER JOIN pessoa p on f.id = p.id
         INNER JOIN dependente d on d.id_funcionario = f.id;

-- 2 consultas que utilizem inner join de três ou mais tabelas
-- Retorna o nome dos ingredientes e a quantidade de bolos que possuem esse ingrediente
SELECT count(b.id) as num_bolos, i.nome
FROM bolo_ingrediente bi
         JOIN bolo b on b.id = bi.id_bolo
         JOIN ingrediente i on bi.id_ingrediente = i.id
GROUP BY i.nome;

-- Seleciona todos os clientes que realizaram uma venda e retorna o nome do cliente, i id da venda e o turno do
-- funcionario que realizou a venda
SELECT p.nome_completo as cliente, v.id_venda, f.turno
FROM pessoa p
         JOIN venda v ON v.id_cliente = p.id
         JOIN funcionario f on v.id_funcionario = f.id;

-- 2 consultas que utilizem outer join (left ou right) de tabelas
-- Seleciona o nome, id e telefone das pessoas (mesmo se telefone for null)
SELECT p.nome_completo, p.id as pessoa_id, t.telefone
FROM pessoa p
         LEFT JOIN telefone t ON p.id = t.id_pessoa;

-- Retorna o nome de todos os clientes e a quantidade de vendas por ele
SELECT p.nome_completo, count(v.quantidade) as vendas
FROM pessoa p
         JOIN cliente c on p.id = c.id
         LEFT JOIN venda v ON v.id_cliente = c.id
GROUP BY p.nome_completo;

-- 2 consultas que utilizem GROUP BY e funções agregadas (SUM, COUNT, MAX, MIN, AVG)
-- Retorna a media de salarios dos funcionarios por cargo
SELECT f.cargo, round(avg(salario), 2) as salario_medio
FROM pessoa p
         JOIN funcionario f on p.id = f.id
group by f.cargo;

-- Retorna o maior e menor salario de funcionario
SELECT min(f.salario) as min_salario, max(f.salario) as max_salario
from funcionario f;


-- 2 consultas que utilizem a cláusula HAVING juntamente com GROUP BY
-- Seleciona todos o funcionarios que possuem mais de 1 ddependentes e retorna ser nome completo e a contagem de dependentes que ele possui
SELECT p.nome_completo, count(d.id) as qnt_dep
FROM pessoa p
         JOIN funcionario f on p.id = f.id
         JOIN dependente d on f.id = d.id_funcionario
GROUP BY p.nome_completo
HAVING qnt_dep > 1;

-- Seleciona todos as pessoas que possuem mais de 2 telefones cadastrados e mostra o nome e a quantidade de telefones
SELECT p.nome_completo, count(t.telefone) as num_tel
FROM telefone t
         join pessoa p on p.id = t.id_pessoa
GROUP BY p.id
HAVING num_tel > 2;

-- 4 consultas que utilizem subconsultas, sendo que ao menos duas delas utilizem os operadores IN, ANY, ALL para tartar subconsultas que retornam mais de 1 registro
-- Seleciona o nome dos funcionarios e seu id
SELECT nome_completo, id
FROM pessoa
WHERE id IN (
    SELECT id
    from funcionario
);

-- Seleciona o nome dos clientes e seus ids
SELECT nome_completo, id
FROM pessoa c
WHERE id IN (
    SELECT id
    FROM cliente
);

-- Nome do bolo da venda 6
SELECT nome
FROM bolo
WHERE id IN (
    SELECT venda_bolo.id_bolo
    from venda_bolo
    WHERE id_venda = 6
);

-- Seleciona nome e sexo de todos clientes
SELECT nome_completo, sexo
from pessoa
WHERE id IN (
    SELECT id
    from cliente
);

-- 1 consulta que utilize o operador UNION
-- Seleciona o id de todos o clientes e funcionarios cadastrados
SELECT c.id
FROM cliente c
UNION
SELECT f.id
FROM funcionario f;

-- 1 consulta que utilize o operador EXISTS ou NOT EXISTS
-- Seleciona os funcionarios que possuem cargo de Caixa
SELECT f.*
FROM funcionario f
WHERE exists(
              SELECT 1
              FROM venda v
              WHERE v.id_funcionario = f.id
          );
