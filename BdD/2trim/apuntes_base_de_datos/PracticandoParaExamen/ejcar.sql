
select * from cliente;

create table persona as select nombre_cliente as nombre, pais from cliente;

select * from persona;

select pais, count(*) as total from persona group by pais order by total desc;

select * from persona where pais = any ('Spain', 'France');

select * from persona where pais = null;

