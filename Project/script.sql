-- DML
DROP DATABASE IF EXISTS project;
CREATE DATABASE project;

CREATE USER IF NOT EXISTS projectUser IDENTIFIED BY 'fakepassword';

USE project;

CREATE TABLE IF NOT EXISTS pessoa(
    id bigint primary key auto_increment unique not null,
    email varchar(100) unique not null,
    cpf varchar(14) unique not null,
    nome_completo varchar(100) not null,
    data_nascimento date,
    rg varchar(12),
    sexo enum('M', 'F'),
    cep int(8),
    estado char(2),
    cidade varchar(50),
    bairro varchar(50),
    rua varchar(50),
    numero integer
);

CREATE TRIGGER upperCaseOnInsertPerson BEFORE INSERT ON pessoa FOR EACH ROW
   SET NEW.sexo = UPPER(NEW.sexo);

CREATE TRIGGER upperCaseOnInsertState BEFORE INSERT ON pessoa FOR EACH ROW
   SET NEW.estado = UPPER(NEW.estado);

CREATE TABLE cliente(
    id bigint primary key auto_increment unique not null,
    id_pessoa bigint,
    pontos int check ( pontos >= 0 ),

    constraint id_pessoa_fk foreign key(id_pessoa) references pessoa(id)
);

CREATE TABLE funcionario(
    id bigint primary key auto_increment unique not null,
    id_pessoa bigint,
    salario decimal(15,2),
    turno enum('M', 'T', 'N'),
    cargo varchar(50),

    constraint id_pessoa_fk foreign key (id_pessoa) references pessoa(id)
);

CREATE TABLE venda(
    id_venda bigint primary key auto_increment unique not null,
    hora datetime,
    metodo_pagamento varchar(50)
);


CREATE TABLE pedido(
    id_pedido bigint,
    id_venda bigint,
    id_cliente bigint,
    id_funcionario bigint
);


-- DDL
INSERT INTO
    pessoa(email, cpf, nome_completo, data_nascimento, rg, sexo, estado)
    VALUES ('leonardo.cadu2@gmail.com', '470.470.478-44', 'Leonardo Freitas', '1997-12-20', '50.555.555-5', 'm', 'sp')