CREATE DATABASE teste; -- criação da BD
USE teste; -- conectar a BD

CREATE TABLE estudante
(
    id        INT AUTO_INCREMENT,
    nome      VARCHAR(40) NOT NULL,
    sexo      CHAR(1) DEFAULT 'M',
    data_nasc DATE,
    cpf       VARCHAR(11),
    PRIMARY KEY (id),
    CHECK (sexo = 'M' OR sexo = 'F'),
    UNIQUE (cpf)
);

create table empregado
(
    codigo     int           NOT NULL,
    nome       varchar(60)   NOT NULL,
    cpf        varchar(14)   not null,
    sexo       char(1),
    datanasc   date,
    logradouro varchar(50),
    nro        int,
    salario    decimal(8, 2) not null,
    depto_num  int,
    codigo_ger int,
    constraint empregado_pk primary key (codigo),
    constraint empregado_sexo_ck check (sexo in ('M', 'F', 'm', 'f')),
    constraint empregado_salario_ck check (salario > 0)
);

create table departamento
(
    numero          int,
    nome            varchar(20),
    codigo_ger      int,
    data_inicio_ger date,
    constraint depto_pk primary key (numero),
    constraint depto_nome_uk unique (nome),
    constraint depto_codger_fk foreign key (codigo_ger) references empregado (codigo)
);

alter table empregado
    ADD fone varchar(20);
alter table empregado
    ADD fone2 varchar(20);

alter table empregado
    modify fone varchar(16);

alter table empregado
    change fone telefone varchar(16);

alter table empregado
    drop fone2;
alter table empregado
    drop telefone;

alter table empregado
    add constraint emp_deptonum_fk foreign key (depto_num) references departamento (numero);

desc departamento;
desc empregado;

ALTER TABLE estudante
    AUTO_INCREMENT = 100;

DESC estudante;

alter table departamento
    drop foreign key departamento_ibfk_1;
alter table departamento
    add constraint depto_codger_fk foreign key (codigo_ger) references empregado (codigo);

drop table estudante;

SHOW TABLES;

-- CONSTRAINS (Restrições)
-- 1. PRIMARY KEY
-- 2. FOREIGN KEY
-- 3. UNIQUE
-- 4. NOT NULL
-- 5. CHECK
-- 6. DEFAULT

INSERT INTO departamento
values (10, 'Vendas', null, '2019-03-25');
INSERT INTO departamento
values (20, 'Compras', null, null);
INSERT INTO departamento(nome, numero)
values ('Fiscal', 30);
SELECT *
FROM departamento;

desc empregado;
INSERT INTO empregado
values (1, 'João da Silva', '123321', 'M', '2001-08-13',
        'Rua XXXXxxx', 214, 2750.85, 10, null);
INSERT INTO empregado
values (2, 'Maria Joaquina', '967000', 'F', '2003-11-03',
        'Rua ZZzzzZZzz', 666, 1988.5, 20, 1);
INSERT INTO empregado(codigo, nome, cpf, salario)
values (3, 'Joãozinho', '000111', 592.00);

SELECT *
FROM empregado;

UPDATE departamento
SET codigo_ger = 2
WHERE numero = 30;
UPDATE departamento
SET data_inicio_ger = '2020-08-18'
WHERE numero = 30;

UPDATE departamento
SET codigo_ger      = 1,
    data_inicio_ger = '2017-04-11'
WHERE numero = 20;

UPDATE departamento
SET codigo_ger = 3
WHERE nome = 'Vendas';

SET SQL_SAFE_UPDATES = 0;

UPDATE empregado
set sexo      = 'M',
    depto_num = 20,
    salario   = 1200.00
where codigo = 3;

UPDATE empregado
set salario = salario * 1.2
where depto_num = 20;

UPDATE empregado
set salario = salario * 1.1
where depto_num = 20
  AND sexo = 'M'
  AND datanasc > '2018-10-01';

UPDATE empregado
set sexo = 'X'
where depto_num = 10
   OR codigo_ger = 1
   OR codigo_ger = 1;

UPDATE empregado
set logradouro = 'Rua Padrão',
    nro        = 1
where logradouro is null;

UPDATE empregado
set depto_num = 10
where codigo_ger is not null;

UPDATE empregado
set cpf = '22222222222'
where (salario = 2750.85 OR salario = 2386.2)
  AND datanasc = '2003-11-03';

select *
from departamento;
select *
from empregado;
desc empregado;

delete
from departamento
where numero = 10;
delete
from empregado
where logradouro = 'Rua Padrão';

update departamento
set codigo_ger = null;

-- DDL
-- CREATE. TABLE
-- ALTER TABLE (ADD, MODIFY, CHANGE, DROP)
-- DROP TABLE


-- DML
-- 1. INSERT. INTO  -- Inserir dados nas tabelas
-- 2. UPDATE 		-- Atualiza dados nas tabelas
-- 3. DELETE FROM	-- Remove dados das tabelas