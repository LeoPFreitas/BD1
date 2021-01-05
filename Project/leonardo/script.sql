-- DML
DROP DATABASE IF EXISTS project;
CREATE DATABASE project;

CREATE USER IF NOT EXISTS projectUser IDENTIFIED BY 'fakepassword';

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
    rua             varchar(50),
    numero          integer
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

CREATE TABLE cliente
(
    id        bigint primary key auto_increment unique not null,
    id_pessoa bigint,
    pontos    int check ( pontos >= 0 ),

    FOREIGN KEY (id_pessoa)
        REFERENCES pessoa (id)
);

CREATE TABLE funcionario
(
    id        bigint primary key auto_increment unique not null,
    id_pessoa bigint,
    salario   decimal(15, 2),
    turno     enum ('M', 'T', 'N'),
    cargo     varchar(50),

    FOREIGN KEY (id_pessoa)
        REFERENCES pessoa (id)
);

# TODO atualizar hora e data do BrModelo e Modelo Físico
CREATE TABLE venda
(
    id_venda         bigint primary key auto_increment unique not null,
    hora             datetime,
    metodo_pagamento varchar(50)
);

CREATE TABLE pedido
(
    id_pedido      bigint unique not null,
    id_venda       bigint,
    id_cliente     bigint,
    id_funcionario bigint,

    PRIMARY KEY (id_pedido, id_venda, id_cliente, id_funcionario),
    FOREIGN KEY (id_venda)
        REFERENCES venda (id_venda),
    FOREIGN KEY (id_cliente)
        REFERENCES cliente (id),
    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id)
);

CREATE TABLE itens
(
    id_pedido bigint,
    item      varchar(255),

    PRIMARY KEY (id_pedido, item),
    FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido)
);

CREATE TABLE bolo
(
    id        bigint primary key auto_increment unique not null,
    nome      varchar(50),
    descricao text,
    tipo      varchar(30),
    peso      integer check ( peso > 0 ),
    sabor     varchar(40)
);

CREATE TABLE categoria
(
    id        bigint,
    id_bolo   bigint,
    descricao text,

    PRIMARY KEY (id, id_bolo),
    FOREIGN KEY (id_bolo)
        REFERENCES bolo (id)
);

CREATE TABLE pedido_bolo
(
    id_pedido  bigint,
    id_bolo    bigint,
    quantidade integer check ( quantidade > 0 ),

    PRIMARY KEY (id_pedido, id_bolo),
    FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_bolo)
        REFERENCES bolo (id)
);

CREATE TABLE telefone
(
    id_pessoa bigint,
    telefone  bigint(14),

    PRIMARY KEY (id_pessoa, telefone),
    FOREIGN KEY (id_pessoa)
        REFERENCES pessoa (id)
);


CREATE TABLE dependente
(
    id              bigint unique not null,
    id_funcionario  bigint,
    nome            varchar(100),
    data_nascimento date,

    PRIMARY KEY (id, id_funcionario),
    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id)
);

-- DDL
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('leonardo.cadu2@gmail.com', '470.470.478-44', 'Leonardo Freitas', '1997-12-20', '50.555.555-5', 'm', 'sp')