create database test;
use test;
create table persona(
	id_persona int unsigned primary key,
    nombre varchar(30),
    saldo int
);

alter table persona modify column saldo int unsigned;
ALTER TABLE persona
ADD CONSTRAINT chk_saldo_non_negative CHECK (saldo >= 0);


insert into persona values (1, 'Bruno', 50000);
insert into persona values (2, 'Laura', 120000);

start transaction;
update persona set saldo = saldo + 15 where id_persona = 1;
update persona set saldo = saldo - 15 where id_persona = 2;
select * from persona;
commit;

start transaction;
update persona set saldo = 10 where id_persona = 1;
update persona set saldo = 5 where id_persona = 2;
commit;



insert into persona values (3, 'Carlos', 1250000);

insert into persona values (4, 'Pepe', -5);

start transaction;
insert into persona values (5, 'cr', 50000);
insert into persona values (6, 'messi', 120000);
commit;




select * from persona;
