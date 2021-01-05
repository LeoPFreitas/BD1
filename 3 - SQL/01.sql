use bd1teste;
CREATE TABLE CATEGORIA
(
    ID        int,
    descricao varchar(30),

    constraint categ_pk primary key (id)
);

create table quarto
(
    nro    int,
    tipo   char(1),
    cat_id int,

    constraint quarto_pk primary key (nro),
    foreign key (cat_id) references categoria (id) on delete cascade
);

insert into categoria
values (1, 'Luxo');
insert into categoria
values (2, 'Standard');

insert into quarto
values (101, 'S', 2);
insert into quarto
values (102, 'D', 2);

select *
from categoria;
select *
from quarto;

drop table categoria;

update quarto
set tipo = 'T'
where nro = 102;

delete
from quarto
where nro = 102;

delete
from categoria
where id = 1;

alter table quarto
    drop foreign key quarto_ibfk_1;
alter table quarto
    add foreign key (cat_id) references categoria (id);
