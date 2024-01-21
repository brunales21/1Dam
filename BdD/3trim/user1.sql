use test;

show tables;
select * from persona;
start transaction;
update persona set nombre = 'Laurinha' where id_persona = (select id_persona from persona where nombre = 'Laura');
rollback;


insert into persona values (1, 'repe', 5);