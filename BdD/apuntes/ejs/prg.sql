use jardineria;

select count(*) from producto where gama = 'frutales';


select * from gama_producto;

DELIMITER $$
DROP PROCEDURE IF EXISTS contar_productos$$
CREATE PROCEDURE contar_productos(IN gama VARCHAR(50),
OUT total INT UNSIGNED)
BEGIN
SET total = (
SELECT COUNT(*)
FROM producto
WHERE producto.gama = gama);
END
$$
DELIMITER ;
CALL contar_productos('aromaticas', @total);
SELECT @total;

select p.precio_venta from producto p where not exists (select * from producto where precio_venta>p.precio_venta);
select p.precio_venta from producto p where not exists (select * from producto where precio_venta<p.precio_venta);


delimiter $$
create procedure calcular_max_min_media (in gama varchar(50),
out max decimal(15, 2), out min decimal(15, 2), out media decimal(15, 2))
begin
	set max = (select min(precio_venta) from producto where producto.gama = gama);
	set min = (select max(precio_venta) from producto where producto.gama = gama);
	set media = (select avg(precio_venta) from producto where producto.gama = gama);
end $$

DELIMITER ;
CALL calcular_max_min_media('Herramientas', @maximo,
@minimo, @media);
SELECT @maximo, @minimo, @media;

show procedure status;






