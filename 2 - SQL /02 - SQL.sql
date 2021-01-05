CREATE DATABASE bd1teste;
USE bd1teste;
show databases;
show tables;

CREATE TABLE TABELA1
(
    id       int,
    nome     varchar(40) not null,
    datanasc date,
    cpf      varchar(14),
    equipe   varchar(30) default 'Palmeiras',

    constraint tab1_pk primary key (id),
    constraint tab1_cpf_uk unique (cpf),
    constraint tab1_nasc_ck check (datanasc >= '1910-01-01')
);

DESC tabela1;

CREATE TABLE TABELA2
(
    id        int primary key,
    descricao varchar(20),
    id_tab1   int,

    constraint tab2_idtab1_fk foreign key (id_tab1) references tabela1 (id)
);

DESC tabela2;

ALTER TABLE tabela1
    ADD sexo char(1);
ALTER TABLE tabela1
    MODIFY equipe varchar(40);
ALTER TABLE tabela1
    change datanasc data_nasc date;
ALTER TABLE tabela1
    drop sexo;

ALTER TABLE tabela2
    drop foreign key tab2_idtab1_fk;
ALTER TABLE tabela2
    add foreign key (id_tab1) references tabela1 (id);

DROP TABLE tabela2;
DROP TABLE tabela1;

SHOW TABLES;
