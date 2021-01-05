-- 1. Liste o código e o nome dos empregados, e o número e nome do departamento em que trabalham.
select e.codigo Emp_codigo, e.nome Emp_nome, d.numero Depto_num, d.nome Depto_nome
from empregado e
         join departamento d on e.depto_num = d.numero;

-- 2. Liste os números e nomes dos projetos e os nomes dos departamentos que os controlam;
select p.numero projeto_num, p.nome projeto_nome, d.nome departamento_nome
from projeto p
         join departamento d on p.depto_num = d.numero;

-- 3. Liste o código, nome e sexo dos empregados e as horas trabalhadas por eles em qualquer projeto;
select e.codigo emp_codigo, e.nome emp_nome, e.sexo emp_sexo, t.horas horas_trabalhadas
from empregado e
         join trabalha_em t on e.codigo = t.codigo_emp;

-- 4. Liste para cada gerente de empregados, o seu código, o seu nome, bem como o código e nome de seus subordinados;
select e2.nome nome_gerente, e2.codigo, e1.nome nome_subordinado
from empregado e1
         join empregado e2 on e1.codigo_ger = e2.codigo
where e1.codigo_ger is not null
order by codigo;

-- 5. Liste o nome e salário dos empregados e o nome dos projetos em que trabalham.
select e.nome nome, e.salario salario, p.nome
from trabalha_em t
         join empregado e on t.codigo_emp = e.codigo
         join projeto p on t.projeto_num = p.numero;

-- 6. Liste o nome e salário dos empregados e o nome dos projetos em que trabalham.
-- Inclua nos resultados também os empregados que não trabalham em projetos.
select e.nome nome, e.salario salario, p.nome
from trabalha_em t
         join projeto p on t.projeto_num = p.numero
         right outer join empregado e on t.codigo_emp = e.codigo

-- 7. Liste o nome do empregado, o nome do projeto e as horas trabalhadas pelo empregado no projeto.


-- 8. Liste o nome do departamento, o nome de seu gerente e as suas localizações.


-- 9. Liste o número, o nome e a média salarial de cada departamento;


-- 10. Liste o número, o nome, o total de funcionários e a média salarial de cada departamento;


-- 11. Liste o número e o nome dos departamentos que possuem mais de 3 funcionários;


-- 12. Liste para cada supervisor de funcionários, o seu nome e o número de subordinados que este possui; 

