use empresa;

select *
from empregado
where depto_num in (10, 30, 40)
  and salario between 5000 and 8000
order by depto_num, salario desc;

desc departamento;
select *
from departamento;

select numero, nome
from departamento
where nome like '%r__';

select nome, substr(nome, 1, 5) as Iniciais, length(nome) tamanho
from departamento
where nome like '%r__';

select lower(nome), substr(nome, 1, 5) as Iniciais, length(nome) tamanho
from departamento
where nome like '%r__';

select nome,
       sexo,
       case sexo
           when 'M' then 'Masc.'
           when 'F' then 'Fem.'
           else 'N/I'
           end as Sexo_Descrição
from empregado;

select avg(salario), sum(salario), max(salario), min(salario)
from empregado;
select count(*)
from empregado
where codigo_ger is not null;

select depto_num, sexo, round(avg(salario), 2) Media_sal
from empregado
group by depto_num, sexo
order by depto_num, sexo;

select depto_num, sexo, round(avg(salario), 2) Media_sal
from empregado
where depto_num in (20, 40, 80)
group by depto_num, sexo;

-- SUM, AVG, MAX, MIN, COUNT: USA APENAS HAVING    
select depto_num, sexo, round(avg(salario), 2) Media_sal
from empregado
where depto_num in (20, 40, 80)
group by depto_num, sexo
having avg(salario) > 6000
order by media_sal desc;

select depto_num, sexo, count(*)
from empregado
where depto_num in (20, 40, 80)
group by depto_num, sexo
having count(*) > 1
order by depto_num;









    
