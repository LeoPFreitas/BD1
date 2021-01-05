-- 1. Liste o total de horas trabalhadas por empregados no projeto de código 100;
select sum(horas)
from trabalha_em
where projeto_num = 100;

-- 2. Liste a média de horas trabalhadas nos projetos 100, 200 ou 500;
select projeto_num, avg(horas) Media_horas
from trabalha_em
where projeto_num in (100, 200, 500)
group by projeto_num;

--  3.Encontre a soma e a média de horas trabalhadas nos projetos. Arredonde para exibir com 2 casas decimais;
select round(sum(horas), 2) Total_horas, round(avg(horas), 2) as Media_horas
from trabalha_em;

-- 4. Liste a quantidade de empregados que trabalham em cada departamento;
select depto_num, count(*)
from empregado
group by depto_num;

-- 5. Liste o maior e o menor salário de cada departamento;
select depto_num, max(salario), min(salario)
from empregado
group by depto_num;

-- 6. Liste a quantidade de funcionários que trabalham em cada departamento para os departamentos que possuem mais do que 3 empregados
select depto_num, count(*)
from empregado
group by depto_num
having count(*) > 3;

-- 7. . Liste a média salarial por sexo dentro de cada departamento
select depto_num, sexo, avg(salario)
from empregado
group by depto_num, sexo
order by depto_num;

-- 8. Liste a quantidade de dependentes por grau de parentesco e, dentro do mesmo grau de parentesco, por sexo;
desc dependente;
select parentesco, sexo, count(*)
from dependente
group by parentesco, sexo;

-- 9. Liste a media salarial dos subordinados de cada gerente. Considere apenas os empregados que possuem gerente. 
-- Deixe na listagem apenas os gerentes com média salarial de subordinados superior a 4000. Ordene os resultados por médiasalarial decrescentemente.
select codigo_ger, round(avg(salario), 2) media_sal
from empregado
where codigo_ger is not null
group by codigo_ger
having avg(salario) > 4000
order by avg(salario) desc;



