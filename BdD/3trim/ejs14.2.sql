/*
1. Crea un procedimiento que reciba un número entero que represente una temperatura y muestre
si el agua se encontraría en estado sólido, líquido o gaseoso a dicha temperatura.*/
delimiter $$
drop procedure if exists getEstadoDeAgua$$
create procedure getEstadoDeAgua(in temperatura int,
out estado varchar(10))
begin
	set estado = 'líquido';
	if temperatura > 100 then
		set estado = 'gaseoso';
	elseif temperatura < 0 then
		set estado = 'sólido';
	end if;
    select estado;
end$$
delimiter ;

call getEstadoDeAgua(-5, @estado);
select @estado;

/*
2. Realiza un procedimiento que reciba dos parámetros, uno con un número del
uno al siete (día de la semana) y otro con un número del uno al doce (mes del
año). Luego con estos dos datos debe componer un cadena que tenga la forma
como ”Un miércoles de marzo” si los valores de los parámetros fueran tres y tres
respectivamente.*/

delimiter $$
drop procedure if exists getDia$$
create procedure getDia(in n1 int, in n2 int)
begin
declare dia, mes varchar(15);
	CASE n1
        WHEN 1 THEN SET dia = 'Lunes';
        WHEN 2 THEN SET dia = 'Martes';
        WHEN 3 THEN SET dia = 'Miércoles';
        WHEN 4 THEN SET dia = 'Jueves';
        WHEN 5 THEN SET dia = 'Viernes';
        WHEN 6 THEN SET dia = 'Sábado';
        WHEN 7 THEN SET dia = 'Domingo';
        ELSE SET dia = 'Error: Día no válido';
    END CASE;
    
    CASE n2
        WHEN 1 THEN SET mes = 'Enero';
        WHEN 2 THEN SET mes = 'Febrero';
        WHEN 3 THEN SET mes = 'Marzo';
        WHEN 4 THEN SET mes = 'Abril';
        WHEN 5 THEN SET mes = 'Mayo';
        WHEN 6 THEN SET mes = 'Junio';
        WHEN 7 THEN SET mes = 'Julio';
        WHEN 8 THEN SET mes = 'Agosto';
        WHEN 9 THEN SET mes = 'Septiembre';
        WHEN 10 THEN SET mes = 'Octubre';
        WHEN 11 THEN SET mes = 'Noviembre';
        WHEN 12 THEN SET mes = 'Diciembre';
        ELSE SET mes = 'Error: Mes no válido';
    END CASE;
    
    SELECT CONCAT('Un ', dia, ' de ', mes) AS resultado;
end$$
delimiter ;

call getDia(5, 7);
	

/*
3. Crea un procedimiento que devuelva, en un parámetro de salida, los números
primos hasta un número entero dado (se recibirá como argumento de entrada).
Dicho número no puede ser mayor de 20 ni menor de 1 y debes comprobarlo al
principio del procedimiento. En caso de no cumplirse devolverás ”PARÁMETROS
INCORRECTOS”.
Utiliza WHILE.*/

-- curiosidad: no me deja hacer las declaraciones dentro del if
-- estuve condicionado ya que no se o no se puede usar un break en un while, solo en un bucle con nombre "leave + nombrebucle"

delimiter $$
drop procedure if exists getPrimos$$
create procedure getPrimos(in n int, out primos varchar(25))
begin
	declare esPrimo BOOLEAN;
    declare i int;

if (n < 20) and (n > 0) then
	set primos = '';
	while n>1 do
		set esPrimo = true;
		set i = n-1;
        bucle: loop
			if i<2 then
				leave bucle;
			end if;
			if n % i = 0 then
				set esPrimo = false;
                leave bucle;
			end if;
            set i = i-1;
		end loop;
        if esPrimo = true then
			set primos = concat(n, ', ', primos);
        end if;
        set n = n-1;
    end while; 
else 
	set primos = 'PARÁMETROS INCORRECTOS';					
end if;
    
end $$
delimiter ;
    
		

call getPrimos(12, @primos);
select @primos;



/*
4. Crea un procedimiento que reciba dos números entre 1 y 50 y cuente hacia atrás
de dos en dos (mostrándolo) desde el mayor al menor (no se sabe si el mayor
será el primero o el segundo).
Utiliza LOOP.*/

delimiter $$
drop procedure if exists backwards$$
create procedure backwards(in a int, in b int)
begin
declare c int;
declare resultado varchar(50);
set resultado = '';
if b>a then
	set c = b;
    set b = a;
	set a = c;
end if;
miBucle:loop
	if b>a then
		leave miBucle;
  	end if;
	set resultado = concat(resultado, ' ', a);
	set a = a - 2;
end loop;
select resultado;
end $$
delimiter ;

call backwards(4, 25);

/*
5. Crea un procedimiento que reciba dos números entre 10 y 100 y muestre todos
los múltiplos de ambos (a la vez) menores de 1000.
Utiliza REPEAT.*/

delimiter $$
drop procedure if exists getMultiplos$$
create procedure getMultiplos(in a int, in b int)
begin
declare i int;
declare resultadoA, resultadoB varchar(100);
declare multiploA, multiploB int;
set resultadoA = ' ';
set resultadoB = ' ';

if (a < 0 or a > 100) or (b < 0 or b > 100) then
	select 'Solo numeros entre 1 y 100';
end if;

set i = 1;
repeat
	set multiploA = a * i;
    set resultadoA = concat(resultadoA, ' ', multiploA);
    
    set multiploB = B * i;
    set resultadoB = concat(resultadoB, ' ', multiploB);
    
    set i = i+1;
until a*i>1000 or b*i>1000
end repeat;
select resultadoA, resultadoB;

end $$
delimiter ;

call getMultiplos(100, 12);


-- 6. Elimina los procedimientos creados.
drop procedure getMultiplos;
drop procedure backwards;
drop procedure getPrimos;
drop procedure getDia;
drop procedure getEstadoDeAgua;