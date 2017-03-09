
-- truncate table proveedores;
drop table proveedores;

create table proveedores (
	nombre_del_proveedor text,
	fecha_de_alta date,
	localidad text,
	cp text,
	provincia text,
	email text,
	web text,
	tel text,
	nombre_del_rubro text
);

insert into proveedores values ('proveedor 1', now(), 'CABA', '1118', 'Buenos Aires', 'tomas@mail.com', 'www.tomas.com', '4555-5555', 'Software');

insert into proveedores 
(	nombre_del_proveedor,
	fecha_de_alta,
	localidad,
	cp,
	provincia,
	email,
	web,
	tel,
	nombre_del_rubro
)
values ('proveedor 2', now(), 'Pilar', '4587', 'Buenos Aires', 'mail@mail.com', 'rotoplast.com', '4555-7899', 'Plasticos');


insert into proveedores 
(	nombre_del_proveedor,
	fecha_de_alta,
	localidad,
	cp,
	provincia,
	email,
	web,
	tel,
	nombre_del_rubro
)
values ('proveedor 3', now(), 'CABA', '6587', 'Buenos Aires', 'mail@mail.com', 'web.com', '4216-1578', 'Comercio');

insert into proveedores 
(	nombre_del_proveedor,
	fecha_de_alta,
	localidad,
	cp,
	provincia,
	email,
	web,
	tel,
	nombre_del_rubro
)
values ('proveedor 4', now(), 'CABA', '6587', 'Buenos Aires', 'otro@otro.com', 'web.com', '4216-7411', 'Bancario');

insert into proveedores 
(	nombre_del_proveedor,
	fecha_de_alta,
	localidad,
	cp,
	provincia,
	email,
	web,
	tel,
	nombre_del_rubro
)
values ('proveedor 5', now(), 'CABA', '6587', 'Buenos Aires', 'otro@otro.com', 'web.com', '4216-7411', 'Plasticos');

insert into proveedores 
(	nombre_del_proveedor,
	fecha_de_alta,
	localidad,
	cp,
	provincia,
	email,
	web,
	tel,
	nombre_del_rubro
)
values ('proveedor 6', now(), 'Pilar', '6587', 'Buenos Aires', 'otro@otro.com', 'web.com', '4216-7411', 'Bancario');

insert into proveedores values ('proveedor x', now(), 'Ramos Mejia', '125835', 'Buenos Aires', 'mail@algo.com', 'otrodom.com', '2526-5025', 'Medicina');
insert into proveedores values ('proveedor x', now(), 'CABA', '1262', 'Buenos Aires', 'mail@algo.com', 'dominio.com', '2526-5025', 'Medicina');

insert into proveedores values ('proveedor pint', now(), 'Ramos Mejia', '1262', 'Buenos Aires', 'mail@algo.com', 'dominio.com', '2526-5025', 'Pintura');

insert into proveedores values ('proveedor electrico', now(), 'Olivos', '1262', 'Buenos Aires', 'mail@algo.com', 'dominio.com', '2526-5025', 'Electrico');

insert into proveedores values ('proveedor sanitario', now(), 'Olivos', '1262', 'Buenos Aires', 'mail@algo.com', 'dominio.com', '2526-5025', 'Sanitario');


select * from proveedores; 

-- delete from proveedores;

select * from proveedores;

-- 1 Listar el nombre y rubro de todos los proveedores.

select nombre_del_proveedor, nombre_del_rubro from proveedores;

--2 Realizar un listado con los datos completos de los proveedores.
select nombre_del_proveedor, 	fecha_de_alta,	localidad, 	cp,	provincia,	email,	web,	tel,	nombre_del_rubro
from proveedores;

select nombre_del_proveedor ||	fecha_de_alta ||	localidad || cp || provincia || email || web || tel || nombre_del_rubro as "datos"
from proveedores;

-- 3 Repetir la consulta 1 pero ordenado por nombre del proveedor.

select nombre_del_proveedor, nombre_del_rubro from proveedores order by nombre_del_proveedor asc;
select nombre_del_proveedor, nombre_del_rubro from proveedores order by nombre_del_proveedor desc;

-- 4 Repetir la consulta 2 pero ordenado por localidad y dentro de ese orden por nombre del proveedor.
select 
	nombre_del_proveedor,
	fecha_de_alta,
	localidad,
	cp,
	provincia,
	email,
	web,
	tel,
	nombre_del_rubro
from proveedores
order by localidad, nombre_del_proveedor;

-- 5 Obtener la lista de los Rubros que tenemos proveedor.
select distinct nombre_del_rubro from proveedores;

-- 6 Listar el nombre y rubro de los proveedores de la ciudad de Buenos Aires.
select nombre_del_proveedor, nombre_del_rubro from proveedores where localidad = 'CABA';
select nombre_del_proveedor, nombre_del_rubro from proveedores where localidad ilike 'caba';

-- 7 Dada una letra o serie de letras, listar todos los proveedores que empiecen con esa letra o que tengan un
-- orden alfabético mayor.
select * from proveedores where nombre_del_proveedor like 'p%';

--buscar provedores que tienen dominio web '.com'
--buscar provedores que tienen dominio web '.com'
select * from proveedores where upper (web) like '%.COM%';
select * from proveedores where upper (web) like '%.ES';


-- 8 Ídem a 6 pero limitar la lista a los 10 primeros.
select nombre_del_proveedor, nombre_del_rubro from proveedores where localidad = 'CABA' limit 10;

-- 9 Ídem a 6 pero que solo empiecen con la letra dada.
select nombre_del_proveedor, nombre_del_rubro from proveedores where localidad like 'C%';

-- 10 Obtener la cantidad de proveedores que tenemos en la Base de datos.
select count(*) as "cantidad de proveedores" from proveedores;
select count(*) as cantidad_de_proveedores from proveedores;

-- 11 Obtener la cantidad de proveedores que hay por localidad.
select localidad, count(*) from proveedores group by localidad ;
select localidad, max(nombre_del_proveedor), count(*) from proveedores group by localidad ;
select localidad, nombre_del_proveedor, count(*) from proveedores group by localidad, nombre_del_proveedor ;


--12 Obtener el promedio de proveedores que hay por localidad.
select localidad, avg(cantidad) from (
	select localidad, count(nombre_del_proveedor) as "cantidad" from proveedores group by localidad
) sub_query
group by sub_query.localidad;


-- 13 Obtener los rubros que hay por localidad.
select distinct localidad, nombre_del_rubro from proveedores order by localidad;

--14 Obtener el promedio de rubros por localidad.

-- 15 Obtener los proveedores que no sean ni de Bs.As. ni de Olivos.
select * from proveedores where upper(provincia) not like 'BUENOS AIRES' and localidad not ilike 'olivos' ;

-- 16. Obtener el promedio de los proveedores por Rubro.

-- 17. Obtener la localidades donde existan proveedores de sanitarios y pinturas.
select distinct localidad from proveedores where nombre_del_rubro  in ('sanitarios', 'pinturas');

-- 18. Obtener los rubros para los cuales no existan proveedores de la ciudad de Bs. As.
select nombre_del_rubro from proveedores 
where localidad not ilike 'CABA' and nombre_del_rubro not in (
	select nombre_del_rubro from proveedores where localidad ilike 'CABA'
);

-- 19. Obtener las localidades donde por lo menos existan proveedores de materiales eléctricos y sanitarios.
select localidad 
from proveedores
where nombre_del_rubro in ('Electrico', 'Sanitario')
group by localidad
having count(1) >= 2;

-- 20. Obtener las localidades donde existan proveedores de todos los rubros.

select localidad
from proveedores
group by localidad 
having count(nombre_del_rubro) = (select count(distinct nombre_del_rubro) from proveedores );

