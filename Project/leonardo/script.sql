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
INSERT INTO pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
VALUES ('leonardo.cadu2@gmail.com', '470.470.478-44', 'Leonardo Freitas', '1997-12-20', '50.555.555-5', 'm', 'sp');
