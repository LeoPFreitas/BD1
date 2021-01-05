-- Liste o nome do empregado e o nome do departamento que trabalha

--  INNER JOIN
select empregado.nome, empregado.codigo, departamento.nome, departamento.numero
from empregado
         join departamento
              on empregado.depto_num = departamento.numero;

-- JOIN, PODE SER USADO INNER JOIN
select d.numero, d.nome, d.codigo_ger, e.nome
from departamento d
         inner join empregado e
                    on e.codigo = d.codigo_ger
                        and d.numero in (10, 20, 40, 70); -- usando and

select d.numero, d.nome, d.codigo_ger, e.nome
from departamento d
         inner join empregado e
                    on e.codigo = d.codigo_ger
where d.numero in (10, 20, 40, 70); -- usando where

select distinct codigo_ger
from departamento;

-- JOIN SEM INNER JOINT NO FROM
select d.numero, d.nome, d.codigo_ger, e.nome
from departamento d,
     empregado e
where e.codigo = d.codigo_ger
  and d.numero in (10, 30, 40, 70);

-- OUTER JOIN: EXISTE O LEFT (pega toda a tabela da esquerda) E O RIGTH (pega toda a tabela da direita)
-- pode omitir o outer
select d.numero, d.nome, d.codigo_ger, e.nome
from departamento d
         left outer join empregado e
                         on e.codigo = d.codigo_ger;

-- JUNÇÃO DE MULTIPLAS TABELAS
desc trabalha_em;
select e.nome as NomeEmp, p.nome as NomeProj, t.horas, d.nome as NomeDepto
from trabalha_em t
         inner join empregado e on t.codigo_emp = e.codigo
         inner join projeto p on t.projeto_num = p.numero
         inner join departamento d on p.depto_num = d.numero;

select e.nome as Nome_Emp, p.nome as Nome_Proj, t.horas, d.nome as NomeDepto
from trabalha_em t,
     empregado e,
     projeto p,
     departamento d
where t.codigo_emp = e.codigo
  and t.projeto_num = p.numero
  and p.depto_num = d.numero;
    
        