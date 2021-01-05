create database clube;
use clube;

create table jogador
(
    id        smallint,
    nome      varchar(50) not null,
    cpf       varchar(14) unique,
    data_nasc date,
    salario   numeric(8, 2),
    id_equipe smallint,

    constraint jogador_pk primary key (id),
    check (salario > 0)
);

create table equipe
(
    id   smallint,
    nome varchar(30) not null,

    constraint equipe_pk primary key (id)
);

alter table jogador
    add constraint equip_jogador foreign key (id_equipe) references equipe (id);