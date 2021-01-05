drop database if exists empresa;
create database empresa;
use empresa;

CREATE TABLE empregado
(
    codigo     int           NOT NULL,
    nome       varchar(60)   NOT NULL,
    cpf        varchar(14)   NOT NULL,
    sexo       char(1),
    datanasc   date,
    logradouro varchar(50),
    nro        int,
    salario    decimal(8, 2) NOT NULL,
    depto_num  int,
    codigo_ger int,
    CONSTRAINT empregado_pk PRIMARY KEY (codigo),
    CONSTRAINT empregado_sexo_ck CHECK (sexo in ('M', 'F', 'm', 'f')),
    CONSTRAINT empregado_salario_ck CHECK (salario > 0)
);

CREATE TABLE departamento
(
    numero          int         NOT NULL,
    nome            varchar(20) NOT NULL,
    codigo_ger      int,
    data_inicio_ger date,
    CONSTRAINT depto_pk PRIMARY KEY (numero),
    CONSTRAINT depto_nome_uk UNIQUE (nome)
);

CREATE TABLE dependente
(
    codigo_emp int         NOT NULL,
    nome       varchar(60) NOT NULL,
    cpf        varchar(14),
    sexo       char(1),
    datanasc   date,
    parentesco varchar(10),
    CONSTRAINT dependente_pk PRIMARY KEY (codigo_emp, nome),
    CONSTRAINT dependente_sexo_ck CHECK (sexo in ('M', 'F', 'm', 'f')),
    CONSTRAINT dependente_codemp_fk FOREIGN KEY (codigo_emp) REFERENCES empregado (codigo)
);

CREATE TABLE depto_localizacoes
(
    depto_num   int         NOT NULL,
    localizacao varchar(40) NOT NULL,
    CONSTRAINT depto_localizacoes_pk PRIMARY KEY (depto_num, localizacao),
    CONSTRAINT depto_localizacoes_dep_fk FOREIGN KEY (depto_num) REFERENCES departamento (numero) ON DELETE CASCADE
);

CREATE TABLE projeto
(
    numero      int         NOT NULL,
    nome        varchar(20) NOT NULL,
    localizacao varchar(40),
    depto_num   int,
    CONSTRAINT projeto_pk PRIMARY KEY (numero),
    CONSTRAINT projeto_nome_uk UNIQUE (nome),
    CONSTRAINT projeto_depto_fk FOREIGN KEY (depto_num) REFERENCES departamento (numero)
);

CREATE TABLE trabalha_em
(
    codigo_emp  int NOT NULL,
    projeto_num int NOT NULL,
    horas       numeric(6, 2),
    CONSTRAINT trabalhaem_pk PRIMARY KEY (codigo_emp, projeto_num),
    CONSTRAINT trabalhaem_emp_fk FOREIGN KEY (codigo_emp) REFERENCES empregado (codigo),
    CONSTRAINT trabalhaem_proj_fk FOREIGN KEY (projeto_num) REFERENCES projeto (numero),
    CONSTRAINT trabalhaem_horas_ck CHECK (horas > 0)
);

INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (1, 'Edson Arantes do Nascimento', '112.356.757-34', 'M', '1940-10-27', 'Av. Pele', 1294, 12000.00, 10, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (2, 'MC Zoinho', '123.456.789-10', 'M', '1978-03-10', 'Morro do canta galo???', 14, 1.00, 90, 19);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (3, 'Reginaldo Rossi', '344.522.456-34', 'M', '1985-05-07', 'Rua street', 888, 1600.00, 90, 19);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (4, 'Neymar', '658.235.641-10', 'M', '1980-10-25', 'Subida do Morro', 125, 510.00, 10, 1);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (5, 'Professor Pedro', '200.125.123.3', 'M', '2010-02-03', 'Rua Quatro', 520, 1000.00, 70, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (6, 'Tia Anastacia', '452.321.741-58', 'F', '1952-02-03', 'Sitio do Pica-Pau Amarelo', 666, 1800.00, 50, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (7, 'Bruno Gagliasso', '137.841.543-20', 'M', '2010-10-06', 'rua vinte', 700, 1000.00, 20, 26);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (8, 'Roberto Jefferson', '333.422.456-34', 'M', '1989-05-07', 'Rua cinco', 888, 1500.00, 40, 14);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (9, 'Gisele Bundchen', '377.422.456-34', 'F', '1989-05-07', 'Rua quatro', 888, 1500.00, 30, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (10, 'Hebe Camargo', '858.045.579-05', 'F', '1910-08-24', 'Av. 35', 576, 27467.88, 80, 15);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (11, 'Chico Anysio', '659.067.694-04', 'M', '1938-11-01', 'Av. 15', 179, 4675.69, 60, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (12, 'Michael Jackson', '274.968.699-57', 'M', '1990-01-09', 'Av. 18', 169, 4644.00, 90, 19);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (13, 'Galvao Bueno', '587.068.397-58', 'M', '1946-12-30', 'Av. 477', 12, 6844.00, 10, 1);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (14, 'Lula', '578.056.965-58', 'M', '1960-12-02', 'Av. 58', 792, 6544.57, 40, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (15, 'Gloria Maria', '796.068.085-37', 'F', '1815-01-19', 'Av. 98', 8078, 6844.00, 80, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (16, 'Cid Moreira', '799.795.357-26', 'M', '1889-07-22', 'Av. 548', 890, 7988.00, 80, 15);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (17, 'Ney Matogrosso', '976.489.074-58', NULL, '1970-04-25', 'Av. 79', 1682, 8986.00, 90, 19);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (18, 'Ronaldo Nazario de Lima', '579.689.975-05', 'M', '1982-11-29', 'Av. 97', 800, 10000.00, 10, 1);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (19, 'Roberto Carlos', '001.111.222-11', 'M', '1956-07-13', 'Rua de salto', 25, 15000.00, 90, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (20, 'Mario Pulica', '458.562.159.56', 'M', '1985-11-16', 'Cadeiao', 777, 20000.00, 60, 11);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (21, 'Que Mario???', '459.562.159.56', 'M', '1985-11-16', 'Cadeiao', 777, 20000.00, 60, 11);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (22, 'David Brasil', '348.476.790-10', 'M', '1980-11-24', 'Av. 24', 69, 6867.88, 80, 15);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (23, 'Clodovil Hernandes', '578.069.698-79', 'M', '1939-11-24', 'Av. 24', 111, 5675.69, 80, 15);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (24, 'Tiririca', '678.809.888-08', 'M', '1939-11-07', 'Av. 234', 111, 7898.00, 40, 14);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (25, 'Professor Fabio', '355.687.679-70', 'M', '1985-06-20', 'Av. 32', 131, 10005.69, 70, 5);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (26, 'Vera Fisher', '888.666.555-55', 'F', '1980-01-09', 'Casa das Tias', 124, 9999.00, 20, NULL);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (27, 'Tony Ramos', '118.865.521-12', 'M', '1962-11-16', 'Rua dos Pelos', 321, 7000.00, 20, 26);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (28, 'Xuxa', '134.965.434-90', 'F', '1968-01-19', 'Rua dos Baixinhos', 123, 4500.00, 50, 6);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (29, 'Henri Castelli', '463.212.131-00', 'M', '1982-07-14', 'Rua Passarela', 12, 3500.00, 30, 9);
INSERT INTO empregado (codigo, nome, cpf, sexo, datanasc, logradouro, nro, salario, depto_num, codigo_ger)
VALUES (30, 'Chaves', '297.315.718-13', 'M', '1972-10-12', 'Barril do Chaves', 13, 2200.00, 50, 6);

INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Esportes', 10, 1, '2005-04-27');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Atores', 20, 26, '1990-06-21');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Moda', 30, 9, '2000-10-15');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Politica', 40, 14, '2003-01-01');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Infantil', 50, 6, '1980-03-01');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Comedia', 60, NULL, '2008-09-13');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Escola', 70, 5, '2013-01-01');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Apresentadores', 80, 15, '1985-12-25');
INSERT INTO departamento (nome, numero, codigo_ger, data_inicio_ger)
VALUES ('Cantores', 90, 19, '1973-06-13');

INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (12, 'Janet Jackson', '545.989.777-11', 'F', '1982-02-28', 'Irmão');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (25, 'Alana', NULL, 'F', '2012-04-09', 'Filho');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (24, 'Tiririquinha', '999.888.777-66', 'M', '1990-12-25', 'Filho');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (12, 'Latoya Jackson', '190.190.190-19', 'F', '1979-03-19', 'Irmão');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (18, 'Ronaldinho de Lima', NULL, 'M', '1997-08-16', 'Filho');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (18, 'Bia de Lima', NULL, 'F', '2004-04-14', 'Filho');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (28, 'Paquita', '814.543.277-12', 'F', '1999-11-19', 'Filho');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (13, 'Popó Bueno', NULL, 'M', '1982-05-11', 'Filho');
INSERT INTO dependente (codigo_emp, nome, cpf, sexo, datanasc, parentesco)
VALUES (13, 'Kaká Bueno', NULL, 'M', '1985-10-06', 'Filho');

INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (10, 'Palmeiras The Best 1914');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (10, 'Itaquerão 1910');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (20, 'Globo Studio');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (30, 'Salão Top Model');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (30, 'Salão da Modéstia');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (40, 'Congresso Nacional');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (50, 'TV Colosso');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (60, 'Comédia Insana');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (60, 'Só Riso');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (70, 'IFSP São Carlos');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (80, 'Rede Repórter');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (90, 'Cred Card Hall');
INSERT INTO depto_localizacoes (depto_num, localizacao)
VALUES (90, 'Teatro Municipal');

INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Chapinhas Mil', 100, 'Salão de Beleza', 30);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Avaina de Pau', 200, 'Banheiro', 60);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('BD2 A Missão', 300, 'LIG', 70);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Stand Up Show', 400, 'Teatro', 20);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Fome Zero', 500, 'Senado', 40);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Manifestações Zero', 510, 'Brasil', 40);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('The New Teletubes', 600, 'Inferno', 50);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Jornal do IFSP', 700, 'Sala do Fuxico', 80);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('The Voice Brasil', 800, 'Globo', 90);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Copa FIFA 2014', 900, 'Maracanã', 10);
INSERT INTO projeto (nome, numero, localizacao, depto_num)
VALUES ('Olimpíadas 2016', 910, 'Cidade Maravilhosa', 10);

INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (4, 900, 50);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (13, 900, 100);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (1, 900, 300);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (9, 100, 32);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (29, 100, 8);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (11, 200, 72.5);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (30, 200, 17.5);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (2, 800, 320);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (3, 800, 122.5);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (12, 800, 77.5);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (15, 700, 55);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (16, 700, 75);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (22, 700, 22.5);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (5, 300, 36);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (25, 300, 80);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (14, 500, 412);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (8, 500, 265);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (6, 600, 62);
INSERT INTO trabalha_em (codigo_emp, projeto_num, horas)
VALUES (28, 600, 210.5);

ALTER TABLE empregado
    ADD CONSTRAINT empregado_depto_fk FOREIGN KEY (depto_num) REFERENCES departamento (numero);

ALTER TABLE empregado
    ADD CONSTRAINT empregado_codger_fk FOREIGN KEY (codigo_ger) REFERENCES empregado (codigo);

ALTER TABLE departamento
    ADD CONSTRAINT depto_codger_fk FOREIGN KEY (codigo_ger) REFERENCES empregado (codigo);