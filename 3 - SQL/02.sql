use empresa;
select *
from empregado;
select *
from departamento; -- FROM indica a tabela que usaremos para a consulta

desc empregado;
select codigo, nome, cpf, depto_num
from empregado;
select distinct nome, depto_num
from empregado; -- DISTINCT TIRA VALOR DUPLICADO

select nome,
       salario       as sal_base,
       salario * 12     sal_anual,
       salario * 1.1 as sal_reajustado
from empregado; -- AS troca o nome da coluna. O AS é OPCIONAL

select *
from dependente
where parentesco = 'Filho'
  and sexo = 'M' -- AND une mais umma CONDIÇÃO
  and codigo_emp = 13;

select *
from dependente
where codigo_emp = 12
   or -- OR ou condicional
    codigo_emp = 13
   or codigo_emp = 18;

select *
from dependente
where codigo_emp in (12, 13, 18); -- IN mesma versão do OR, porém mais elegante

select codigo, nome, depto_num, sexo
from empregado
where (depto_num = 20 or depto_num = 50)
  and sexo = 'F'; -- AND é mais forte que o OR

select *
from empregado
where sexo = 'M'
order by salario desc; -- DESC decrescente

select *
from empregado
order by depto_num, salario desc; -- ORDER BY sempre por ULTIMO!!

select sexo, codigo, nome, salario, salario * 1.2 as "sal anual" -- ASPAS DUPLAS só quando for dar apelido
from empregado
order by 4 desc;

select *
from empregado
where datanasc >= '2000-01-01';

select nome, salario
from empregado
where salario between 3000 and salario <= 7000 -- BETWEEN é a msm coisa que intervalo com <= >=
order by salario;

select nome, datanasc
from empregado
where datanasc between '1981-01-01' and '1990-12-31'
order by datanasc;

select *
from empregado
where nome LIKE '%h%'; -- % caracter coringa(%) e uso do LIKE

select *
from empregado
where nome LIKE '_a%'; -- coringa(_) : _ serve pra quando você quer a posiçao exata do caracter

select codigo, nome, codigo_ger
from empregado
where codigo_ger is null; -- usar IS NULL quando quiser filtrar algum valor que está como null

select codigo, nome, codigo_ger
from empregado
where codigo_ger is not null;

select cpf, nome
from empregado
where lower(nome) = 'neymar'; -- lower converte tudo para minusculo

select cpf, nome, upper(nome) as nome_maiusculo
from empregado
where lower(nome) = 'neymar';

select nome, length(nome) tam_nome
from empregado;

select logradouro, substr(logradouro, 3)
from empregado; -- SUBSTR pega parte de uma string

select logradouro, nro, concat(logradouro, ', ', nro) as Endreco
from empregado; -- CONCAT contaneção

select salario, round(salario, 1)
from empregado; -- ROUND arredondamento por numero de casas decimais

select salario, round(salario, 1), truncate(salario, 1)
from empregado; -- TRUNCATE corta o digito

select mod(salario, 100)
from empregado; -- MOD resto da divisão

select nome, coalesce(codigo_ger, depto_num, -1)
from empregado;

select nome,
       case sexo
           when 'M' then 'Masculino' -- IF ELSE
           when 'F' then 'Feminino'
           else 'Não Informado'
           end as sexo_desc
from empregado;

select nome,
       salario,
       case
           when salario > 10000 then salario * 1.1
           when salario > 5000 then salario * 1.2
           when salario > 1000 then salario * 1.05
           else salario
           end
from empregado;

select nome, coalesce(replace(replace(sexo, 'M', 'Masc.'), 'F', 'Fem.'), 'N/I')
from empregado;


-- FUNCOES AGREGADAS
-- SUM (soma)
-- AVG (media)
-- MAX (maximo)
-- MIN (minimo)
-- COUNT (conta)
select SUM(salario)
from empregado; -- SOMA
select COUNT(*)
from empregado;

select depto_num, sexo, sum(salario), avg(salario)
from empregado
group by depto_num, sexo
order by depto_num, sexo;

select depto_num, sum(salario)
from empregado
group by depto_num
having sum(salario) > 30000 -- HAVING para filtrar quando usa funcao agregada
order by sum(salario) desc;

select codigo_ger, count(*)
from empregado
where codigo_ger is not null
group by codigo_ger
having count(*) >= 3
order by count(*) desc;
    

