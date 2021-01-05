-- EXCERCICIOS PARTE 1
use empresa;
-- 1. LISTE TODOS OS DADOS DE TODOS OS DEPARTAMENTOS:
select *
from departamento;

-- 2. LISTE O NOME, SEXO E DATA DE NASCIMENTO DOS EMPREGADOS:
select nome, sexo, datanasc
from empregado;

-- 3. LISTE O NUMERO E NOME DOS DEPARTAMENTOS DE NÚMEROS 30,40,50 OU 80:
select numero, nome
from departamento
where numero = 30
   or numero = 40
   or numero = 50
   or numero = 80;

-- 4. LISTE O NOME, DATA DE NASCIMENTO, SEXO E SALÁRIO DOS EMPREGADOS DO SEXO MASCULINO QUE GANHAM ENTRE 3000 E 8000 E QUE NASCERAM ENTRE 1930 E 1959.
select nome, datanasc, sexo, salario
from empregado
where sexo = 'M'
  and salario between 3000 and 8000
  and datanasc >= '1930-01-01'
  and datanasc <= '1959-12-31';

-- 5. LISTE O CODIGO, NOME, CODIGO DO GERENTE E SALARIO DOS EMPREGADOS COM SALARIO MAIOR OU IGUAL A 5000 E GERENCIADOS PELOS EMPREGADOS DE CODIGOS 14,15 OU 19.
-- ORDENE POR CÓDIGO DE GERENTE CRESCENTEMENTE E POR SALARIO DECRESCENTEMENTE.
select nome, codigo_ger, salario
from empregado
where salario >= 5000
  and codigo_ger in (14, 15, 19)
order by codigo_ger, salario desc;