-- Betania Leite
select version();

    select * from read_csv_auto(
        'dados_brutos/acidentes2025.csv',
        delim=';', 
        header=true,
        encoding = 'latin-1',
        sample_size=-1
    )
    LIMIT 10;

create or replace table acidentes_prf_2025 as
select * from read_csv_auto(
    'dados_brutos/acidentes2025.csv',
    delim = ';',
    header = true,
    encoding = 'latin-1',
    sample_size = -1
);

describe acidentes_prf_2025;

select data_inversa, dia_semana, horario, uf, br, municipio,
    causa_acidente, tipo_acidente, classificacao_acidente, 
    fase_dia, condicao_metereologica, tipo_pista, tracado_via,
    uso_solo, mortos from acidentes_prf_2025
        limit 20;

select data_inversa, uf, br, municipio, causa_acidente, mortos
    from acidentes_prf_2025
    order by mortos desc
    limit 20;


select data_inversa, uf, br, municipio, causa_acidente, mortos
    from acidentes_prf_2025
    where uf = 'PE' and municipio = 'RECIFE'
    order by mortos desc
    limit 20;

select data_inversa, uf, br, municipio, causa_acidente, mortos
    from acidentes_prf_2025
    where uf = 'PE' and municipio in ('RECIFE', 'OLINDA')
    order by mortos desc
    limit 20;

select data_inversa, uf, br, municipio, causa_acidente, mortos
    from acidentes_prf_2025
    where uf = 'PE' and municipio in ('RECIFE', 'OLINDA', 'IGARASSU', 'JABOATAO DOS GUARARAPES')
    order by mortos desc
    limit 20;

select data_inversa, uf, br, municipio, causa_acidente, mortos
    from acidentes_prf_2025
    where mortos >=1
    order by mortos desc
    limit 20;

select distinct municipio from acidentes_prf_2025
    where uf = 'PE' and mortos>=1
    order by municipio;

select distinct fase_dia from acidentes_prf_2025
order by fase_dia;

select distinct causa_acidente from acidentes_prf_2025
order by causa_acidente;

select distinct upper(tipo_acidente) from acidentes_prf_2025
order by tipo_acidente;

select uf as "Estados", count(id) as "Total de Acidentes" from acidentes_prf_2025
group by uf
order by uf;

select uf as "Estados", count(id) as "Total de Acidentes" from acidentes_prf_2025
where mortos >= 1
group by uf
order by count(id) desc;

select uf as "Estados", count(id) as "Total de Acidentes Fatais", sum(mortos) as "Total de Mortos" from acidentes_prf_2025
group by uf
order by count(id) desc;


select uf as "Estados", count(id) as "Total de Acidentes Fatais", sum(mortos) as "Total de Mortos" 
from acidentes_prf_2025
group by uf
order by count(id) desc;

select uf as "Estados", count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", sum(mortos) as "Total de Mortos",
from acidentes_prf_2025
group by uf
order by count(id) desc;

select uf as "Estados", 
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
round(((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0, 2) as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by uf
order by count(id) desc;

select uf as "Estados", 
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0) as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by uf
order by count(id) desc;

select uf as "Estados", 
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by uf
order by count(id) desc;

select uf as "Estados", 
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by uf
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

select causa_acidente as "Causa do Acidente", 
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by causa_acidente
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;


select month(data_inversa) as "Mês", 
from acidentes_prf_2025
order by month(data_inversa);

select month(data_inversa) as "Mês",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by month(data_inversa)
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;


select case month(data_inversa) 
when 1 then 'Janeiro'
when 2 then 'Fevereiro'
when 3 then 'Março'
when 4 then 'Abril'
when 5 then 'Maio'
when 6 then 'Junho'
when 7 then 'Julho'
when 8 then 'Agosto'
when 9 then 'Setembro'
when 10 then 'Outubro'
when 11 then 'Novembro'
when 12 then 'Dezembro'
end as "Mês",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by month(data_inversa)
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;



CREATE or replace view vw_acidentes_mensal as
select case month(data_inversa) 
when 1 then 'Janeiro'
when 2 then 'Fevereiro'
when 3 then 'Março'
when 4 then 'Abril'
when 5 then 'Maio'
when 6 then 'Junho'
when 7 then 'Julho'
when 8 then 'Agosto'
when 9 then 'Setembro'
when 10 then 'Outubro'
when 11 then 'Novembro'
when 12 then 'Dezembro'
end as "Mês",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by month(data_inversa)
order by month(data_inversa); 


select*from vw_acidentes_por_uf;

create or replace view vw_acidentes_por_causa as
select causa_acidente as "Causa dos Acidentes",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by causa_acidente
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

select*from vw_acidentes_por_causa;

create or replace view vw_acidentes_por_br as
select br as "BR",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by br
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

SELECT * FROM vw_acidentes_por_br;

create or replace view vw_acidentes_por_UF as
select UF as "UF",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by UF
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

SELECT * FROM vw_acidentes_por_UF;

create or replace view vw_acidentes_por_tipo_de_acidente as
select tipo_acidente as "Tipo de Acidente",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by tipo_acidente
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

SELECT * FROM vw_acidentes_por_tipo_de_acidente;

create or replace view vw_acidentes_por_tipoPista as
select tipo_pista as "Tipo de Pista",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by tipo_pista
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

SELECT * FROM vw_acidentes_por_tipoPista;

create or replace view vw_acidentes_por_condicao_metereologica as   
select condicao_metereologica as "Condição Meteorológica",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by condicao_metereologica
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

SELECT * FROM vw_acidentes_por_condicao_metereologica;

create or replace view vw_acidentes_por_classificação_acidente as   
select classificacao_acidente as "Classificação do Acidente",
count(id) as "Total de Acidentes", 
count(mortos) filter(where mortos >= 1) as "Total de Acidentes Fatais", 
sum(mortos) as "Total de Mortos",
replace(printf('%.2f%%', ((count(mortos) filter(where mortos >= 1)) / count(id)) * 100.0), '.', ',') as "Taxa de acidentes Fatais"
from acidentes_prf_2025
group by classificacao_acidente
order by ((count(mortos) filter(where mortos >= 1)) / count(id)) desc;

SELECT * FROM vw_acidentes_por_classificação_acidente;

select * from acidentes_prf_2025
where classificacao_acidente = 'NA';


UPDATE acidentes_prf_2025
SET classificacao_acidente = 'COM VITIMAS FATAIS'
WHERE classificacao_acidente = 'NA' and mortos >= 1;

ALTER TABLE acidentes_prf_2025
    ADD COLUMN acidentes_fatais boolean;


UPDATE acidentes_prf_2025
SET acidentes_fatais = case when mortos >= 1 then true else false end;


select * from acidentes_prf_2025;
















